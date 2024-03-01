-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonChemicalWithId
module AmarcordApi.Types.JsonChemicalWithId where

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

-- | Defines the object schema located at @components.schemas.JsonChemicalWithId@ in the specification.
-- 
-- 
data JsonChemicalWithId = JsonChemicalWithId {
  -- | attributi
  jsonChemicalWithIdAttributi :: ([JsonAttributoValue])
  -- | beamtime_id
  , jsonChemicalWithIdBeamtimeId :: GHC.Types.Int
  -- | chemical_type: An enumeration.
  , jsonChemicalWithIdChemicalType :: ChemicalType
  -- | file_ids
  , jsonChemicalWithIdFileIds :: ([GHC.Types.Int])
  -- | id
  , jsonChemicalWithIdId :: GHC.Types.Int
  -- | name
  , jsonChemicalWithIdName :: Data.Text.Internal.Text
  -- | responsible_person
  , jsonChemicalWithIdResponsiblePerson :: Data.Text.Internal.Text
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonChemicalWithId
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdBeamtimeId obj] : ["chemical_type" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdChemicalType obj] : ["file_ids" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdFileIds obj] : ["id" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdId obj] : ["name" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdName obj] : ["responsible_person" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdResponsiblePerson obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["attributi" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdAttributi obj] : ["beamtime_id" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdBeamtimeId obj] : ["chemical_type" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdChemicalType obj] : ["file_ids" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdFileIds obj] : ["id" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdId obj] : ["name" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdName obj] : ["responsible_person" Data.Aeson.Types.ToJSON..= jsonChemicalWithIdResponsiblePerson obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonChemicalWithId
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonChemicalWithId" (\obj -> ((((((GHC.Base.pure JsonChemicalWithId GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributi")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "beamtime_id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "chemical_type")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "file_ids")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "name")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "responsible_person"))}
-- | Create a new 'JsonChemicalWithId' with all required fields.
mkJsonChemicalWithId :: [JsonAttributoValue] -- ^ 'jsonChemicalWithIdAttributi'
  -> GHC.Types.Int -- ^ 'jsonChemicalWithIdBeamtimeId'
  -> ChemicalType -- ^ 'jsonChemicalWithIdChemicalType'
  -> [GHC.Types.Int] -- ^ 'jsonChemicalWithIdFileIds'
  -> GHC.Types.Int -- ^ 'jsonChemicalWithIdId'
  -> Data.Text.Internal.Text -- ^ 'jsonChemicalWithIdName'
  -> Data.Text.Internal.Text -- ^ 'jsonChemicalWithIdResponsiblePerson'
  -> JsonChemicalWithId
mkJsonChemicalWithId jsonChemicalWithIdAttributi jsonChemicalWithIdBeamtimeId jsonChemicalWithIdChemicalType jsonChemicalWithIdFileIds jsonChemicalWithIdId jsonChemicalWithIdName jsonChemicalWithIdResponsiblePerson = JsonChemicalWithId{jsonChemicalWithIdAttributi = jsonChemicalWithIdAttributi,
                                                                                                                                                                                                                                            jsonChemicalWithIdBeamtimeId = jsonChemicalWithIdBeamtimeId,
                                                                                                                                                                                                                                            jsonChemicalWithIdChemicalType = jsonChemicalWithIdChemicalType,
                                                                                                                                                                                                                                            jsonChemicalWithIdFileIds = jsonChemicalWithIdFileIds,
                                                                                                                                                                                                                                            jsonChemicalWithIdId = jsonChemicalWithIdId,
                                                                                                                                                                                                                                            jsonChemicalWithIdName = jsonChemicalWithIdName,
                                                                                                                                                                                                                                            jsonChemicalWithIdResponsiblePerson = jsonChemicalWithIdResponsiblePerson}