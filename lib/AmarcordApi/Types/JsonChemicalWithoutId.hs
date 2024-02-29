-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonChemicalWithoutId
module AmarcordApi.Types.JsonChemicalWithoutId where

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
import {-# SOURCE #-} AmarcordApi.Types.ChemicalType
import {-# SOURCE #-} AmarcordApi.Types.JsonAttributoValue

-- | Defines the object schema located at @components.schemas.JsonChemicalWithoutId@ in the specification.
-- 
-- 
data JsonChemicalWithoutId = JsonChemicalWithoutId {
  -- | attributi
  jsonChemicalWithoutIdAttributi :: ([JsonAttributoValue])
  -- | beamtime_id
  , jsonChemicalWithoutIdBeamtimeId :: GHC.Types.Int
  -- | chemical_type: An enumeration.
  , jsonChemicalWithoutIdChemicalType :: ChemicalType
  -- | file_ids
  , jsonChemicalWithoutIdFileIds :: ([GHC.Types.Int])
  -- | name
  , jsonChemicalWithoutIdName :: Data.Text.Internal.Text
  -- | responsible_person
  , jsonChemicalWithoutIdResponsiblePerson :: Data.Text.Internal.Text
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonChemicalWithoutId
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdBeamtimeId obj] : ["chemical_type" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdChemicalType obj] : ["file_ids" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdFileIds obj] : ["name" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdName obj] : ["responsible_person" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdResponsiblePerson obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdBeamtimeId obj] : ["chemical_type" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdChemicalType obj] : ["file_ids" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdFileIds obj] : ["name" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdName obj] : ["responsible_person" Data.Aeson.Types.ToJSON..= jsonChemicalWithoutIdResponsiblePerson obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonChemicalWithoutId
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonChemicalWithoutId" (\obj -> (((((GHC.Base.pure JsonChemicalWithoutId GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributi")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "beamtime_id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "chemical_type")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "file_ids")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "name")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "responsible_person"))}
-- | Create a new 'JsonChemicalWithoutId' with all required fields.
mkJsonChemicalWithoutId :: [JsonAttributoValue] -- ^ 'jsonChemicalWithoutIdAttributi'
  -> GHC.Types.Int -- ^ 'jsonChemicalWithoutIdBeamtimeId'
  -> ChemicalType -- ^ 'jsonChemicalWithoutIdChemicalType'
  -> [GHC.Types.Int] -- ^ 'jsonChemicalWithoutIdFileIds'
  -> Data.Text.Internal.Text -- ^ 'jsonChemicalWithoutIdName'
  -> Data.Text.Internal.Text -- ^ 'jsonChemicalWithoutIdResponsiblePerson'
  -> JsonChemicalWithoutId
mkJsonChemicalWithoutId jsonChemicalWithoutIdAttributi jsonChemicalWithoutIdBeamtimeId jsonChemicalWithoutIdChemicalType jsonChemicalWithoutIdFileIds jsonChemicalWithoutIdName jsonChemicalWithoutIdResponsiblePerson = JsonChemicalWithoutId{jsonChemicalWithoutIdAttributi = jsonChemicalWithoutIdAttributi,
                                                                                                                                                                                                                                               jsonChemicalWithoutIdBeamtimeId = jsonChemicalWithoutIdBeamtimeId,
                                                                                                                                                                                                                                               jsonChemicalWithoutIdChemicalType = jsonChemicalWithoutIdChemicalType,
                                                                                                                                                                                                                                               jsonChemicalWithoutIdFileIds = jsonChemicalWithoutIdFileIds,
                                                                                                                                                                                                                                               jsonChemicalWithoutIdName = jsonChemicalWithoutIdName,
                                                                                                                                                                                                                                               jsonChemicalWithoutIdResponsiblePerson = jsonChemicalWithoutIdResponsiblePerson}
