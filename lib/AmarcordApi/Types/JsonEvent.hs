-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonEvent
module AmarcordApi.Types.JsonEvent where

import qualified Prelude as GHC.Integer.Type
import qualified Prelude as GHC.Maybe
import qualified Control.Monad.Fail
import qualified Data.Aeson
import qualified Data.Aeson as Data.Aeson.Encoding.Internal
import qualified Data.Aeson as Data.Aeson.Types
import qualified Data.Aeson as Data.Aeson.Types.FromJSON
import qualified Data.Aeson as Data.Aeson.Types.ToJSON
import qualified Data.Aeson as Data.Aeson.Types.Internal
import qualified Data.ByteString
import qualified Data.ByteString as Data.ByteString.Internal
import qualified Data.Foldable
import qualified Data.Functor
import qualified Data.Maybe
import qualified Data.Scientific
import qualified Data.Text
import qualified Data.Text as Data.Text.Internal
import qualified Data.Time.Calendar as Data.Time.Calendar.Days
import qualified Data.Time.LocalTime as Data.Time.LocalTime.Internal.ZonedTime
import qualified GHC.Base
import qualified GHC.Classes
import qualified GHC.Int
import qualified GHC.Show
import qualified GHC.Types
import qualified AmarcordApi.Common
import AmarcordApi.TypeAlias
import {-# SOURCE #-} AmarcordApi.Types.JsonFileOutput

-- | Defines the object schema located at @components.schemas.JsonEvent@ in the specification.
-- 
-- 
data JsonEvent = JsonEvent {
  -- | created
  jsonEventCreated :: GHC.Types.Int
  -- | files
  , jsonEventFiles :: ([JsonFileOutput])
  -- | id
  , jsonEventId :: GHC.Types.Int
  -- | level
  , jsonEventLevel :: Data.Text.Internal.Text
  -- | source
  , jsonEventSource :: Data.Text.Internal.Text
  -- | text
  , jsonEventText :: Data.Text.Internal.Text
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonEvent
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["created" Data.Aeson.Types.ToJSON..= jsonEventCreated obj] : ["files" Data.Aeson.Types.ToJSON..= jsonEventFiles obj] : ["id" Data.Aeson.Types.ToJSON..= jsonEventId obj] : ["level" Data.Aeson.Types.ToJSON..= jsonEventLevel obj] : ["source" Data.Aeson.Types.ToJSON..= jsonEventSource obj] : ["text" Data.Aeson.Types.ToJSON..= jsonEventText obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["created" Data.Aeson.Types.ToJSON..= jsonEventCreated obj] : ["files" Data.Aeson.Types.ToJSON..= jsonEventFiles obj] : ["id" Data.Aeson.Types.ToJSON..= jsonEventId obj] : ["level" Data.Aeson.Types.ToJSON..= jsonEventLevel obj] : ["source" Data.Aeson.Types.ToJSON..= jsonEventSource obj] : ["text" Data.Aeson.Types.ToJSON..= jsonEventText obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonEvent
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonEvent" (\obj -> (((((GHC.Base.pure JsonEvent GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "created")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "files")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "level")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "source")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "text"))}
-- | Create a new 'JsonEvent' with all required fields.
mkJsonEvent :: GHC.Types.Int -- ^ 'jsonEventCreated'
  -> [JsonFileOutput] -- ^ 'jsonEventFiles'
  -> GHC.Types.Int -- ^ 'jsonEventId'
  -> Data.Text.Internal.Text -- ^ 'jsonEventLevel'
  -> Data.Text.Internal.Text -- ^ 'jsonEventSource'
  -> Data.Text.Internal.Text -- ^ 'jsonEventText'
  -> JsonEvent
mkJsonEvent jsonEventCreated jsonEventFiles jsonEventId jsonEventLevel jsonEventSource jsonEventText = JsonEvent{jsonEventCreated = jsonEventCreated,
                                                                                                                 jsonEventFiles = jsonEventFiles,
                                                                                                                 jsonEventId = jsonEventId,
                                                                                                                 jsonEventLevel = jsonEventLevel,
                                                                                                                 jsonEventSource = jsonEventSource,
                                                                                                                 jsonEventText = jsonEventText}
