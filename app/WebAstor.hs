{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Control.Applicative (pure)
import Control.Exception (handle)
import Control.Monad (Monad, forM_, (>>=))
import Control.Monad.IO.Class (liftIO)
import Data.Bool (not)
import Data.Either (Either (Left, Right))
import Data.Function (flip, ($), (.))
import Data.Functor (void, (<$>))
import Data.Int (Int)
import Data.List (sortOn)
import Data.List.NonEmpty qualified as NE
import Data.Maybe (Maybe (Just, Nothing), fromMaybe)
import Data.Monoid (mempty)
import Data.Semigroup ((<>))
import Data.Text (Text, breakOn, breakOnAll, drop, isPrefixOf, lines, pack, strip, unlines, words)
import Data.Text.Read (decimal)
import Data.Traversable (for, traverse)
import Data.Typeable (Typeable)
import Lucid (ToHtml (toHtml, toHtmlRaw))
import Lucid qualified as L
import Lucid.Base (renderBS)
import Lucid.Html5 (h1_)
import Network.HTTP.Media qualified as M
import Network.Wai.Handler.Warp (run)
import Servant (Get, Handler, Proxy (Proxy), QueryParam, (:>))
import Servant.API (Accept (..), JSON, MimeRender (..), Post, ReqBody, (:<|>) ((:<|>)))
import Servant.API.Generic (Generic)
import Servant.Server (Application, Server, serve)
import System.Environment (getArgs)
import System.IO (IO, putStrLn)
import Tango.Client (AttributeName (AttributeName), CommandData (CommandString), CommandName (CommandName), TangoException (TangoException), commandInOutGeneric, parseTangoUrl, readStringSpectrumAttribute, tangoValueRead, withDeviceProxy)
import Text.Show (show)
import Prelude (undefined)

-- | HTML type which uses lucid2 to output the bytes. lucid1 would have been simpler, but lucid2 is cleaner.
data HTML deriving stock (Typeable)

instance Accept HTML where
  contentTypes _ =
    "text" M.// "html" M./: ("charset", "utf-8")
      NE.:| ["text" M.// "html"]

instance (ToHtml a) => MimeRender HTML a where
  mimeRender _ = renderBS . toHtml

-- | A Tango device server description that is parsed from the Astor server output
data AstorServer = AstorServer
  { serverDevice :: Text,
    serverStatus :: Text,
    serverControlled :: Int,
    serverLevel :: Int,
    serverNbInstances :: Int
  }
  deriving (Generic)

-- | Message to display after an action (start server, stop server)
data Message = MessageError Text | MessageSuccess Text

-- | Main type holding information about what to output
data RefreshOutput = RefreshOutput
  { refreshOutputServers :: Either Text [AstorServer],
    refreshOutputHost :: Text,
    refreshOutputMessage :: Maybe Message
  }
  deriving (Generic)

viewServerStatus :: (Monad m) => Text -> L.HtmlT m ()
viewServerStatus "ON" = L.span_ [L.class_ "badge text-bg-success"] "ON"
viewServerStatus "MOVING" = L.span_ [L.class_ "spinner-border spinner-border-sm text-secondary"] mempty
viewServerStatus "FAULT" = L.span_ [L.class_ "badge text-bg-danger"] "FAULT"
viewServerStatus t = L.span_ [L.class_ "badge text-bg-secondary"] (L.toHtml t)

instance ToHtml RefreshOutput where
  toHtml (RefreshOutput servers host message) = viewHtmlSkeleton do
    L.form_ [L.action_ "servers"] do
      L.div_ [L.class_ "form-floating mb-3"] do
        L.input_
          [ L.type_ "text",
            L.class_ "form-control",
            L.id_ "host",
            L.placeholder_ "localhost:10000",
            L.name_ "host",
            L.value_ host
          ]
        L.label_ [L.for_ "host"] "Tango Host:Port"
      L.button_ [L.class_ "btn btn-primary mb-3", L.type_ "submit"] "Refresh"
    case servers of
      Left e ->
        L.div_ [L.class_ "alert alert-danger"] (L.toHtml ("Something went wrong: " <> e))
      Right serverList -> do
        case message of
          Just (MessageError e) -> L.div_ [L.class_ "alert alert-danger"] (L.toHtml ("Something went wrong: " <> e))
          Just (MessageSuccess s) -> L.div_ [L.class_ "alert alert-success"] (L.toHtml s)
          Nothing -> mempty
        L.table_ [L.class_ "table"] do
          L.thead_ do
            L.tr_ do
              L.th_ "Lvl"
              L.th_ "Device"
              L.th_ "Status"
              L.th_ "Actions"
          L.tbody_
            ( forM_ (sortOn serverLevel serverList) \(AstorServer {serverDevice, serverStatus, serverLevel}) ->
                L.tr_ do
                  L.td_ (L.toHtml (pack (show serverLevel)))
                  L.td_ (L.code_ (L.toHtml serverDevice))
                  L.td_ do
                    viewServerStatus serverStatus
                  L.td_ do
                    L.div_ [L.class_ "hstack gap-1"] do
                      L.a_
                        [ L.href_ ("servers?host=" <> host <> "&action=stop&device=" <> serverDevice),
                          L.class_ "btn btn-sm btn-primary rounded-circle"
                        ]
                        do
                          L.i_ [L.class_ "bi-stop"] mempty
                      L.a_
                        [ L.href_ ("servers?host=" <> host <> "&action=start&device=" <> serverDevice),
                          L.class_ "btn btn-sm btn-primary rounded-circle"
                        ]
                        do
                          L.i_ [L.class_ "bi-play"] mempty
            )
  toHtmlRaw = toHtml

type AstorAPI =
  "servers"
    :> QueryParam "host" Text
    :> QueryParam "action" Text
    :> QueryParam "device" Text
    :> Get '[HTML] RefreshOutput

parseServersOutput :: Text -> Either Text [AstorServer]
parseServersOutput l = for (lines l) \line -> case words line of
  [device, status, controlledStr, levelStr, nbInstancesStr] ->
    case (decimal controlledStr, decimal levelStr, decimal nbInstancesStr) of
      (Right (controlled, _), Right (level, _), Right (nbInstances, _)) ->
        Right (AstorServer {serverDevice = device, serverStatus = status, serverControlled = controlled, serverLevel = level, serverNbInstances = nbInstances})
      _ -> Left ("one of controlled, level, nbInstances is not a number: " <> line)
  _ -> Left ("expected whitespace-separated list of 5 values, got: " <> line)

data HostWithPort = HostWithPort Text Int

parseHostWithPort :: Text -> Maybe HostWithPort
parseHostWithPort hostAndPort =
  case breakOn ":" hostAndPort of
    (host, maybePort) ->
      if not (":" `isPrefixOf` maybePort)
        then Nothing
        else case decimal (drop 1 maybePort) of
          Right (port, _) -> Just (HostWithPort host port)
          _ -> Nothing

astorServer :: Server AstorAPI
astorServer = astorEndpointServers

astorEndpointServers :: Maybe Text -> Maybe Text -> Maybe Text -> Handler RefreshOutput
astorEndpointServers inputHost action devicename =
  case inputHost >>= parseHostWithPort of
    Nothing ->
      pure
        ( RefreshOutput
            { refreshOutputHost = "",
              refreshOutputServers = Right [],
              refreshOutputMessage = Nothing
            }
        )
    Just (HostWithPort inputHost' inputPort) -> do
      let inputHostAndPortStr = inputHost' <> ":" <> pack (show inputPort)
       in case parseTangoUrl ("tango://" <> inputHostAndPortStr <> "/tango/admin/" <> inputHost') of
            Left e ->
              pure
                ( RefreshOutput
                    { refreshOutputHost = inputHostAndPortStr,
                      refreshOutputServers = Left ("error parsing host: " <> e),
                      refreshOutputMessage = Nothing
                    }
                )
            Right deviceAddress -> liftIO
              $ handle
                ( \e@(TangoException _) ->
                    pure
                      ( RefreshOutput
                          { refreshOutputHost = inputHostAndPortStr,
                            refreshOutputServers = Left ("error in tango: " <> pack (show e)),
                            refreshOutputMessage = Nothing
                          }
                      )
                )
              $ withDeviceProxy deviceAddress \proxy -> do
                outputMessage <- case (action, devicename) of
                  (Just "stop", Just deviceName) -> do
                    void (commandInOutGeneric proxy (CommandName "DevStop") (CommandString deviceName))
                    pure (Just (MessageSuccess "stopping!"))
                  (Just "start", Just deviceName) -> do
                    void (commandInOutGeneric proxy (CommandName "DevStart") (CommandString deviceName))
                    pure (Just (MessageSuccess "starting!"))
                  _ -> pure Nothing

                servers <- readStringSpectrumAttribute proxy (AttributeName "Servers")
                case parseServersOutput (unlines (tangoValueRead servers)) of
                  Left e ->
                    pure
                      ( RefreshOutput
                          { refreshOutputHost = inputHostAndPortStr,
                            refreshOutputServers = Left ("error parsing servers output: " <> e),
                            refreshOutputMessage = outputMessage
                          }
                      )
                  Right serversParsed ->
                    pure
                      ( RefreshOutput
                          { refreshOutputHost = inputHostAndPortStr,
                            refreshOutputServers = Right serversParsed,
                            refreshOutputMessage = outputMessage
                          }
                      )

astorAPI :: Proxy AstorAPI
astorAPI = Proxy

app :: Application
app = serve astorAPI astorServer

viewHtmlSkeleton content = do
  L.doctypehtml_ do
    L.head_ do
      L.meta_ [L.charset_ "utf-8"]
      L.meta_ [L.name_ "viewport", L.content_ "width=device-width, initial-scale=1"]
      L.title_ "Astor on the Web"
      L.link_ [L.href_ "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css", L.rel_ "stylesheet"]
      L.link_ [L.href_ "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css", L.rel_ "stylesheet"]
    L.body_ do
      L.div_ [L.class_ "container"] do
        L.header_ do
          L.h1_ "Astor on the Web"
        L.main_ do
          content
      -- Not sure if we need the bootstrap JS, and it must save some bandwidth, so leave it out maybe
      L.script_ [L.src_ "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"] ("" :: Text)

main :: IO ()
main = do
  putStrLn "listening on port 8081..."
  run 8081 app
