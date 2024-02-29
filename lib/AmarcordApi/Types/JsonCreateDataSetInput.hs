-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonCreateDataSetInput
module AmarcordApi.Types.JsonCreateDataSetInput where

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
import {-# SOURCE #-} AmarcordApi.Types.JsonAttributoValue

-- | Defines the object schema located at @components.schemas.JsonCreateDataSetInput@ in the specification.
-- 
-- 
data JsonCreateDataSetInput = JsonCreateDataSetInput {
  -- | attributi
  jsonCreateDataSetInputAttributi :: ([JsonAttributoValue])
  -- | beamtime_id
  , jsonCreateDataSetInputBeamtimeId :: GHC.Types.Int
  -- | experiment_type_id
  , jsonCreateDataSetInputExperimentTypeId :: GHC.Types.Int
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonCreateDataSetInput
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputBeamtimeId obj] : ["experiment_type_id" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputExperimentTypeId obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputBeamtimeId obj] : ["experiment_type_id" Data.Aeson.Types.ToJSON..= jsonCreateDataSetInputExperimentTypeId obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonCreateDataSetInput
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonCreateDataSetInput" (\obj -> ((GHC.Base.pure JsonCreateDataSetInput GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributi")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "beamtime_id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "experiment_type_id"))}
-- | Create a new 'JsonCreateDataSetInput' with all required fields.
mkJsonCreateDataSetInput :: [JsonAttributoValue] -- ^ 'jsonCreateDataSetInputAttributi'
  -> GHC.Types.Int -- ^ 'jsonCreateDataSetInputBeamtimeId'
  -> GHC.Types.Int -- ^ 'jsonCreateDataSetInputExperimentTypeId'
  -> JsonCreateDataSetInput
mkJsonCreateDataSetInput jsonCreateDataSetInputAttributi jsonCreateDataSetInputBeamtimeId jsonCreateDataSetInputExperimentTypeId = JsonCreateDataSetInput{jsonCreateDataSetInputAttributi = jsonCreateDataSetInputAttributi,
                                                                                                                                                          jsonCreateDataSetInputBeamtimeId = jsonCreateDataSetInputBeamtimeId,
                                                                                                                                                          jsonCreateDataSetInputExperimentTypeId = jsonCreateDataSetInputExperimentTypeId}
