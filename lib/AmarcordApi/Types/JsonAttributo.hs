-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonAttributo
module AmarcordApi.Types.JsonAttributo where

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
import {-# SOURCE #-} AmarcordApi.Types.AssociatedTable
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaArray
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaBoolean
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaInteger
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaNumber
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaString

-- | Defines the object schema located at @components.schemas.JsonAttributo@ in the specification.
-- 
-- 
data JsonAttributo = JsonAttributo {
  -- | associated_table: An enumeration.
  jsonAttributoAssociatedTable :: AssociatedTable
  -- | attributo_type
  , jsonAttributoAttributoType :: JsonAttributoAttributoType'Variants
  -- | description
  , jsonAttributoDescription :: Data.Text.Internal.Text
  -- | group
  , jsonAttributoGroup :: Data.Text.Internal.Text
  -- | id
  , jsonAttributoId :: GHC.Types.Int
  -- | name
  , jsonAttributoName :: Data.Text.Internal.Text
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonAttributo
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["associated_table" Data.Aeson.Types.ToJSON..= jsonAttributoAssociatedTable obj] : ["attributo_type" Data.Aeson.Types.ToJSON..= jsonAttributoAttributoType obj] : ["description" Data.Aeson.Types.ToJSON..= jsonAttributoDescription obj] : ["group" Data.Aeson.Types.ToJSON..= jsonAttributoGroup obj] : ["id" Data.Aeson.Types.ToJSON..= jsonAttributoId obj] : ["name" Data.Aeson.Types.ToJSON..= jsonAttributoName obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["associated_table" Data.Aeson.Types.ToJSON..= jsonAttributoAssociatedTable obj] : ["attributo_type" Data.Aeson.Types.ToJSON..= jsonAttributoAttributoType obj] : ["description" Data.Aeson.Types.ToJSON..= jsonAttributoDescription obj] : ["group" Data.Aeson.Types.ToJSON..= jsonAttributoGroup obj] : ["id" Data.Aeson.Types.ToJSON..= jsonAttributoId obj] : ["name" Data.Aeson.Types.ToJSON..= jsonAttributoName obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonAttributo
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonAttributo" (\obj -> (((((GHC.Base.pure JsonAttributo GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "associated_table")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributo_type")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "description")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "group")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "name"))}
-- | Create a new 'JsonAttributo' with all required fields.
mkJsonAttributo :: AssociatedTable -- ^ 'jsonAttributoAssociatedTable'
  -> JsonAttributoAttributoType'Variants -- ^ 'jsonAttributoAttributoType'
  -> Data.Text.Internal.Text -- ^ 'jsonAttributoDescription'
  -> Data.Text.Internal.Text -- ^ 'jsonAttributoGroup'
  -> GHC.Types.Int -- ^ 'jsonAttributoId'
  -> Data.Text.Internal.Text -- ^ 'jsonAttributoName'
  -> JsonAttributo
mkJsonAttributo jsonAttributoAssociatedTable jsonAttributoAttributoType jsonAttributoDescription jsonAttributoGroup jsonAttributoId jsonAttributoName = JsonAttributo{jsonAttributoAssociatedTable = jsonAttributoAssociatedTable,
                                                                                                                                                                      jsonAttributoAttributoType = jsonAttributoAttributoType,
                                                                                                                                                                      jsonAttributoDescription = jsonAttributoDescription,
                                                                                                                                                                      jsonAttributoGroup = jsonAttributoGroup,
                                                                                                                                                                      jsonAttributoId = jsonAttributoId,
                                                                                                                                                                      jsonAttributoName = jsonAttributoName}
-- | Defines the oneOf schema located at @components.schemas.JsonAttributo.properties.attributo_type.oneOf@ in the specification.
-- 
-- 
data JsonAttributoAttributoType'Variants =
   JsonAttributoAttributoType'JSONSchemaInteger JSONSchemaInteger
  | JsonAttributoAttributoType'JSONSchemaNumber JSONSchemaNumber
  | JsonAttributoAttributoType'JSONSchemaString JSONSchemaString
  | JsonAttributoAttributoType'JSONSchemaArray JSONSchemaArray
  | JsonAttributoAttributoType'JSONSchemaBoolean JSONSchemaBoolean
  deriving (GHC.Show.Show, GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonAttributoAttributoType'Variants
    where {toJSON (JsonAttributoAttributoType'JSONSchemaInteger a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonAttributoAttributoType'JSONSchemaNumber a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonAttributoAttributoType'JSONSchemaString a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonAttributoAttributoType'JSONSchemaArray a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonAttributoAttributoType'JSONSchemaBoolean a) = Data.Aeson.Types.ToJSON.toJSON a}
instance Data.Aeson.Types.FromJSON.FromJSON JsonAttributoAttributoType'Variants
    where {parseJSON val = case (JsonAttributoAttributoType'JSONSchemaInteger Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonAttributoAttributoType'JSONSchemaNumber Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonAttributoAttributoType'JSONSchemaString Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonAttributoAttributoType'JSONSchemaArray Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonAttributoAttributoType'JSONSchemaBoolean Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> Data.Aeson.Types.Internal.Error "No variant matched")))) of
                           {Data.Aeson.Types.Internal.Success a -> GHC.Base.pure a;
                            Data.Aeson.Types.Internal.Error a -> Control.Monad.Fail.fail a}}