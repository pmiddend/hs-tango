-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonCreateOrUpdateRunOutput
module AmarcordApi.Types.JsonCreateOrUpdateRunOutput where

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

-- | Defines the object schema located at @components.schemas.JsonCreateOrUpdateRunOutput@ in the specification.
-- 
-- 
data JsonCreateOrUpdateRunOutput = JsonCreateOrUpdateRunOutput {
  -- | error_message
  jsonCreateOrUpdateRunOutputErrorMessage :: (GHC.Maybe.Maybe Data.Text.Internal.Text)
  -- | indexing_result_id
  , jsonCreateOrUpdateRunOutputIndexingResultId :: (GHC.Maybe.Maybe GHC.Types.Int)
  -- | run_created
  , jsonCreateOrUpdateRunOutputRunCreated :: GHC.Types.Bool
  -- | run_internal_id
  , jsonCreateOrUpdateRunOutputRunInternalId :: (GHC.Maybe.Maybe GHC.Types.Int)
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonCreateOrUpdateRunOutput
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("error_message" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputErrorMessage obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("indexing_result_id" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputIndexingResultId obj) : ["run_created" Data.Aeson.Types.ToJSON..= jsonCreateOrUpdateRunOutputRunCreated obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("run_internal_id" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputRunInternalId obj) : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("error_message" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputErrorMessage obj) : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("indexing_result_id" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputIndexingResultId obj) : ["run_created" Data.Aeson.Types.ToJSON..= jsonCreateOrUpdateRunOutputRunCreated obj] : Data.Maybe.maybe GHC.Base.mempty (GHC.Base.pure GHC.Base.. ("run_internal_id" Data.Aeson.Types.ToJSON..=)) (jsonCreateOrUpdateRunOutputRunInternalId obj) : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonCreateOrUpdateRunOutput
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonCreateOrUpdateRunOutput" (\obj -> (((GHC.Base.pure JsonCreateOrUpdateRunOutput GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "error_message")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "indexing_result_id")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "run_created")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:! "run_internal_id"))}
-- | Create a new 'JsonCreateOrUpdateRunOutput' with all required fields.
mkJsonCreateOrUpdateRunOutput :: GHC.Types.Bool -- ^ 'jsonCreateOrUpdateRunOutputRunCreated'
  -> JsonCreateOrUpdateRunOutput
mkJsonCreateOrUpdateRunOutput jsonCreateOrUpdateRunOutputRunCreated = JsonCreateOrUpdateRunOutput{jsonCreateOrUpdateRunOutputErrorMessage = GHC.Maybe.Nothing,
                                                                                                  jsonCreateOrUpdateRunOutputIndexingResultId = GHC.Maybe.Nothing,
                                                                                                  jsonCreateOrUpdateRunOutputRunCreated = jsonCreateOrUpdateRunOutputRunCreated,
                                                                                                  jsonCreateOrUpdateRunOutputRunInternalId = GHC.Maybe.Nothing}