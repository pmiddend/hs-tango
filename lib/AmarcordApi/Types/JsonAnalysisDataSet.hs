-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema JsonAnalysisDataSet
module AmarcordApi.Types.JsonAnalysisDataSet where

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
import {-# SOURCE #-} AmarcordApi.Types.JsonDataSet
import {-# SOURCE #-} AmarcordApi.Types.JsonMergeResult

-- | Defines the object schema located at @components.schemas.JsonAnalysisDataSet@ in the specification.
-- 
-- 
data JsonAnalysisDataSet = JsonAnalysisDataSet {
  -- | data_set
  jsonAnalysisDataSetDataSet :: JsonDataSet
  -- | merge_results
  , jsonAnalysisDataSetMergeResults :: ([JsonMergeResult])
  -- | number_of_indexing_results
  , jsonAnalysisDataSetNumberOfIndexingResults :: GHC.Types.Int
  -- | runs
  , jsonAnalysisDataSetRuns :: ([Data.Text.Internal.Text])
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON JsonAnalysisDataSet
    where {toJSON obj = Data.Aeson.Types.Internal.object (Data.Foldable.concat (["data_set" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetDataSet obj] : ["merge_results" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetMergeResults obj] : ["number_of_indexing_results" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetNumberOfIndexingResults obj] : ["runs" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetRuns obj] : GHC.Base.mempty));
           toEncoding obj = Data.Aeson.Encoding.Internal.pairs (GHC.Base.mconcat (Data.Foldable.concat (["data_set" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetDataSet obj] : ["merge_results" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetMergeResults obj] : ["number_of_indexing_results" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetNumberOfIndexingResults obj] : ["runs" Data.Aeson.Types.ToJSON..= jsonAnalysisDataSetRuns obj] : GHC.Base.mempty)))}
instance Data.Aeson.Types.FromJSON.FromJSON JsonAnalysisDataSet
    where {parseJSON = Data.Aeson.Types.FromJSON.withObject "JsonAnalysisDataSet" (\obj -> (((GHC.Base.pure JsonAnalysisDataSet GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "data_set")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "merge_results")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "number_of_indexing_results")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..: "runs"))}
-- | Create a new 'JsonAnalysisDataSet' with all required fields.
mkJsonAnalysisDataSet :: JsonDataSet -- ^ 'jsonAnalysisDataSetDataSet'
  -> [JsonMergeResult] -- ^ 'jsonAnalysisDataSetMergeResults'
  -> GHC.Types.Int -- ^ 'jsonAnalysisDataSetNumberOfIndexingResults'
  -> [Data.Text.Internal.Text] -- ^ 'jsonAnalysisDataSetRuns'
  -> JsonAnalysisDataSet
mkJsonAnalysisDataSet jsonAnalysisDataSetDataSet jsonAnalysisDataSetMergeResults jsonAnalysisDataSetNumberOfIndexingResults jsonAnalysisDataSetRuns = JsonAnalysisDataSet{jsonAnalysisDataSetDataSet = jsonAnalysisDataSetDataSet,
                                                                                                                                                                          jsonAnalysisDataSetMergeResults = jsonAnalysisDataSetMergeResults,
                                                                                                                                                                          jsonAnalysisDataSetNumberOfIndexingResults = jsonAnalysisDataSetNumberOfIndexingResults,
                                                                                                                                                                          jsonAnalysisDataSetRuns = jsonAnalysisDataSetRuns}
