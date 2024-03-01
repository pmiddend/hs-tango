-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonMergeResultStateDone
module AmarcordApi.Types.JsonMergeResultStateDone where

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
import {-# SOURCE #-} AmarcordApi.Types.MergeResult

-- | Defines the object schema located at @components.schemas.JsonMergeResultStateDone@ in the specification.
-- 
-- 
data JsonMergeResultStateDone = JsonMergeResultStateDone {
  -- | result
  jsonMergeResultStateDoneResult :: MergeResult
  -- | started
  , jsonMergeResultStateDoneStarted :: GHC.Types.Int
  -- | stopped
  , jsonMergeResultStateDoneStopped :: GHC.Types.Int
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonMergeResultStateDone
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["result" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneResult obj] : ["started" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneStarted obj] : ["stopped" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneStopped obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["result" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneResult obj] : ["started" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneStarted obj] : ["stopped" Data.Aeson.Types.ToJSON..= jsonMergeResultStateDoneStopped obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonMergeResultStateDone
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonMergeResultStateDone" (\obj -> ((GHC.Base.pure JsonMergeResultStateDone GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "result")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "started")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "stopped"))}
-- | Create a new 'JsonMergeResultStateDone' with all required fields.
mkJsonMergeResultStateDone :: MergeResult -- ^ 'jsonMergeResultStateDoneResult'
  -> GHC.Types.Int -- ^ 'jsonMergeResultStateDoneStarted'
  -> GHC.Types.Int -- ^ 'jsonMergeResultStateDoneStopped'
  -> JsonMergeResultStateDone
mkJsonMergeResultStateDone jsonMergeResultStateDoneResult jsonMergeResultStateDoneStarted jsonMergeResultStateDoneStopped = JsonMergeResultStateDone{jsonMergeResultStateDoneResult = jsonMergeResultStateDoneResult,
                                                                                                                                                     jsonMergeResultStateDoneStarted = jsonMergeResultStateDoneStarted,
                                                                                                                                                     jsonMergeResultStateDoneStopped = jsonMergeResultStateDoneStopped}