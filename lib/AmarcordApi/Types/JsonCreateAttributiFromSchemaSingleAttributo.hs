-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonCreateAttributiFromSchemaSingleAttributo
module AmarcordApi.Types.JsonCreateAttributiFromSchemaSingleAttributo where

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
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaArray
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaBoolean
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaInteger
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaNumber
import {-# SOURCE #-} AmarcordApi.Types.JSONSchemaString

-- | Defines the object schema located at @components.schemas.JsonCreateAttributiFromSchemaSingleAttributo@ in the specification.
-- 
-- 
data JsonCreateAttributiFromSchemaSingleAttributo = JsonCreateAttributiFromSchemaSingleAttributo {
  -- | attributo_name
  jsonCreateAttributiFromSchemaSingleAttributoAttributoName :: Data.Text.Internal.Text
  -- | attributo_type
  , jsonCreateAttributiFromSchemaSingleAttributoAttributoType :: JsonCreateAttributiFromSchemaSingleAttributoAttributoType'Variants
  -- | description
  , jsonCreateAttributiFromSchemaSingleAttributoDescription :: (GHC.Maybe.Maybe Data.Text.Internal.Text)
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonCreateAttributiFromSchemaSingleAttributo
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["attributo_name" Data.Aeson.Types.ToJSON..= jsonCreateAttributiFromSchemaSingleAttributoAttributoName obj] : ["attributo_type" Data.Aeson.Types.ToJSON..= jsonCreateAttributiFromSchemaSingleAttributoAttributoType obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("description" Data.Aeson.Types.ToJSON..=)) (jsonCreateAttributiFromSchemaSingleAttributoDescription obj) : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["attributo_name" Data.Aeson.Types.ToJSON..= jsonCreateAttributiFromSchemaSingleAttributoAttributoName obj] : ["attributo_type" Data.Aeson.Types.ToJSON..= jsonCreateAttributiFromSchemaSingleAttributoAttributoType obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("description" Data.Aeson.Types.ToJSON..=)) (jsonCreateAttributiFromSchemaSingleAttributoDescription obj) : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonCreateAttributiFromSchemaSingleAttributo
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonCreateAttributiFromSchemaSingleAttributo" (\obj -> ((GHC.Base.pure JsonCreateAttributiFromSchemaSingleAttributo GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributo_name")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributo_type")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "description"))}
-- | Create a new 'JsonCreateAttributiFromSchemaSingleAttributo' with all required fields.
mkJsonCreateAttributiFromSchemaSingleAttributo :: Data.Text.Internal.Text -- ^ 'jsonCreateAttributiFromSchemaSingleAttributoAttributoName'
  -> JsonCreateAttributiFromSchemaSingleAttributoAttributoType'Variants -- ^ 'jsonCreateAttributiFromSchemaSingleAttributoAttributoType'
  -> JsonCreateAttributiFromSchemaSingleAttributo
mkJsonCreateAttributiFromSchemaSingleAttributo jsonCreateAttributiFromSchemaSingleAttributoAttributoName jsonCreateAttributiFromSchemaSingleAttributoAttributoType = JsonCreateAttributiFromSchemaSingleAttributo{jsonCreateAttributiFromSchemaSingleAttributoAttributoName = jsonCreateAttributiFromSchemaSingleAttributoAttributoName,
                                                                                                                                                                                                                  jsonCreateAttributiFromSchemaSingleAttributoAttributoType = jsonCreateAttributiFromSchemaSingleAttributoAttributoType,
                                                                                                                                                                                                                  jsonCreateAttributiFromSchemaSingleAttributoDescription = GHC.Maybe.Nothing}
-- | Defines the oneOf schema located at @components.schemas.JsonCreateAttributiFromSchemaSingleAttributo.properties.attributo_type.oneOf@ in the specification.
-- 
-- 
data JsonCreateAttributiFromSchemaSingleAttributoAttributoType'Variants =
   JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaInteger JSONSchemaInteger
  | JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaNumber JSONSchemaNumber
  | JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaString JSONSchemaString
  | JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaArray JSONSchemaArray
  | JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaBoolean JSONSchemaBoolean
  deriving (GHC.Show.Show, GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonCreateAttributiFromSchemaSingleAttributoAttributoType'Variants
    where {toJSON (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaInteger a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaNumber a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaString a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaArray a) = Data.Aeson.Types.ToJSON.toJSON a;
           toJSON (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaBoolean a) = Data.Aeson.Types.ToJSON.toJSON a}
instance Data.Aeson.Types.FromJSON.FromJSON JsonCreateAttributiFromSchemaSingleAttributoAttributoType'Variants
    where {parseJSON val = case (JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaInteger Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaNumber Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaString Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaArray Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> ((JsonCreateAttributiFromSchemaSingleAttributoAttributoType'JSONSchemaBoolean Data.Functor.<$> Data.Aeson.Types.FromJSON.fromJSON val) GHC.Base.<|> Data.Aeson.Types.Internal.Error "No variant matched")))) of
                           {Data.Aeson.Types.Internal.Success a -> GHC.Base.pure a;
                            Data.Aeson.Types.Internal.Error a -> Control.Monad.Fail.fail a}}