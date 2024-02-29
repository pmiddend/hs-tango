-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonAttributoValue
module AmarcordApi.Types.JsonAttributoValue where

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

-- | Defines the object schema located at @components.schemas.JsonAttributoValue@ in the specification.
-- 
-- 
data JsonAttributoValue = JsonAttributoValue {
  -- | attributo_id
  jsonAttributoValueAttributoId :: GHC.Types.Int
  -- | attributo_value_bool
  , jsonAttributoValueAttributoValueBool :: (GHC.Maybe.Maybe GHC.Types.Bool)
  -- | attributo_value_float
  , jsonAttributoValueAttributoValueFloat :: (GHC.Maybe.Maybe GHC.Types.Double)
  -- | attributo_value_int
  , jsonAttributoValueAttributoValueInt :: (GHC.Maybe.Maybe GHC.Types.Int)
  -- | attributo_value_list_bool
  , jsonAttributoValueAttributoValueListBool :: (GHC.Maybe.Maybe ([GHC.Types.Bool]))
  -- | attributo_value_list_float
  , jsonAttributoValueAttributoValueListFloat :: (GHC.Maybe.Maybe ([GHC.Types.Double]))
  -- | attributo_value_list_str
  , jsonAttributoValueAttributoValueListStr :: (GHC.Maybe.Maybe ([Data.Text.Internal.Text]))
  -- | attributo_value_str
  , jsonAttributoValueAttributoValueStr :: (GHC.Maybe.Maybe Data.Text.Internal.Text)
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonAttributoValue
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["attributo_id" Data.Aeson.Types.ToJSON..= jsonAttributoValueAttributoId obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_bool" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueBool obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_float" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueFloat obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_int" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueInt obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_bool" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListBool obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_float" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListFloat obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_str" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListStr obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_str" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueStr obj) : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["attributo_id" Data.Aeson.Types.ToJSON..= jsonAttributoValueAttributoId obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_bool" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueBool obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_float" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueFloat obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_int" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueInt obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_bool" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListBool obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_float" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListFloat obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_list_str" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueListStr obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("attributo_value_str" Data.Aeson.Types.ToJSON..=)) (jsonAttributoValueAttributoValueStr obj) : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonAttributoValue
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonAttributoValue" (\obj -> (((((((GHC.Base.pure JsonAttributoValue GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "attributo_id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_bool")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_float")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_int")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_list_bool")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_list_float")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_list_str")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "attributo_value_str"))}
-- | Create a new 'JsonAttributoValue' with all required fields.
mkJsonAttributoValue :: GHC.Types.Int -- ^ 'jsonAttributoValueAttributoId'
  -> JsonAttributoValue
mkJsonAttributoValue jsonAttributoValueAttributoId = JsonAttributoValue{jsonAttributoValueAttributoId = jsonAttributoValueAttributoId,
                                                                        jsonAttributoValueAttributoValueBool = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueFloat = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueInt = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueListBool = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueListFloat = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueListStr = GHC.Maybe.Nothing,
                                                                        jsonAttributoValueAttributoValueStr = GHC.Maybe.Nothing}
