{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

-- |
-- Description : Low-level interface to all Tango functions
module Tango.Raw.Common
  ( DeviceState (..),
    DisplayLevel (..),
    HaskellTangoPropertyData (..),
    HaskellTangoDevEncoded (..),
    EventType (..),
    AttrWriteType (..),
    ErrSeverity (..),
    DatabaseProxyPtr,
    HaskellDataQuality (..),
    HaskellDbData (..),
    HaskellDbDatum (..),
    HaskellAttributeInfoList (..),
    HaskellAttributeDataList (..),
    HaskellAttributeInfo (..),
    DataFormat (..),
    HaskellTangoVarArray (..),
    Timeval (..),
    DeviceProxyPtr,
    HaskellDevSource (..),
    HaskellErrorStack (..),
    DevFailed (..),
    TangoAttrMemorizedType (..),
    HaskellAttributeData (..),
    HaskellCommandData (..),
    TangoDataType (..),
    HaskellTangoCommandData (..),
    HaskellCommandInfoList (..),
    HaskellCommandInfo (..),
    HaskellTangoAttributeData (..),
    tango_create_device_proxy,
    tango_delete_device_proxy,
    tango_read_attribute,
    tango_write_attribute,
    tango_poll_command,
    tango_stop_poll_command,
    tango_free_AttributeInfoList,
    tango_poll_attribute,
    -- tango_throw_exception,
    tango_stop_poll_attribute,
    tango_command_inout,
    tango_free_AttributeData,
    createEventCallbackWrapper,
    tango_free_CommandData,
    tango_get_timeout_millis,
    tango_set_timeout_millis,
    tango_create_database_proxy,
    tango_delete_database_proxy,
    tango_get_property,
    tango_command_query,
    tango_free_DbData,
    tango_free_DbDatum,
    tango_put_property,
    tango_delete_property,
    tango_get_device_property,
    tango_delete_device_property,
    tango_get_object_list,
    tango_write_attributes,
    tango_get_object_property_list,
    tango_free_VarStringArray,
    tango_get_attribute_list,
    tango_read_attributes,
    tango_get_device_exported,
    tango_put_device_property,
    tango_set_source,
    tango_command_list_query,
    tango_free_CommandInfoList,
    tango_free_CommandInfo,
    -- tango_get_source,
    tango_lock,
    tango_get_device_exported_for_class,
    haskellDisplayLevelExpert,
    tango_get_attribute_config,
    haskellDisplayLevelOperator,
    tango_unlock,
    -- tango_is_locked,
    tango_locking_status,
    -- tango_is_locked_by_me,
    devSourceToInt,
    devSourceFromInt,
    tango_create_event_callback,
    tango_free_event_callback,
    tango_subscribe_event,
    tango_unsubscribe_event,
  )
where

import Control.Applicative (pure)
import Data.Bool (Bool)
import Data.Eq (Eq, (==))
import Data.Foldable (Foldable)
import Data.Function ((.))
import Data.Functor (Functor, (<$>))
import Data.Int (Int32)
import Data.List (find, zip)
import Data.Maybe (Maybe (Just, Nothing))
import Data.Ord (Ord)
import Data.Semigroup ((<>))
import Data.String (String)
import Data.Traversable (Traversable)
import Data.Tuple (fst, snd)
import Data.Word (Word16, Word32, Word64, Word8)
import Foreign (Storable (alignment, peek, poke, sizeOf), peekByteOff, pokeByteOff)
import Foreign.C.String (CString, peekCString)
import Foreign.C.Types (CBool (CBool), CChar, CDouble, CFloat, CInt (CInt), CLong, CShort, CUInt, CULong, CUShort)
import Foreign.Ptr (FunPtr, Ptr, castPtr)
import Foreign.Storable.Generic (GStorable)
import GHC.Generics (Generic)
import System.IO (IO)
import Text.Show (Show, show)
import Prelude (Bounded, Enum, error, maxBound, minBound)

#include <c_tango.h>
-- for timeval
#include <sys/time.h>

peekBounded :: (Enum a, Bounded a) => String -> Ptr a -> IO a
peekBounded desc ptr = do
  value :: CInt <- peek (castPtr ptr)
  case snd <$> find ((== value) . fst) (zip [0 ..] [minBound .. maxBound]) of
    Nothing -> error ("invalid constant (" <> desc <> "): " <> show value)
    Just v -> pure v

pokeBounded :: (Show a, Eq a, Enum a, Bounded a) => String -> Ptr a -> a -> IO ()
pokeBounded desc ptr x =
  case fst <$> (find ((== x) . snd) (zip [0 ..] [minBound .. maxBound])) of
    Nothing -> error ("invalid constant (" <> desc <> "): " <> show x)
    Just v -> poke @CInt (castPtr ptr) v

-- | List of all states that Tango knows about for device servers
data DeviceState
  = StateOn
  | StateOff
  | StateClose
  | StateOpen
  | StateInsert
  | StateExtract
  | StateMoving
  | StateStandby
  | StateFault
  | StateInit
  | StateRunning
  | StateAlarm
  | StateDisable
  | StateUnknown
  deriving (Show, Eq, Bounded, Enum)

instance Storable DeviceState where
  sizeOf _ = (# size TangoDevState)
  alignment _ = (# alignment TangoDevState)
  peek = peekBounded "dev state"
  poke = pokeBounded "dev state"

data TangoAttrMemorizedType
  = NotKnown
  | None
  | Memorized
  | MemorizedWriteInit
  deriving (Show, Eq, Bounded, Enum)

instance Storable TangoAttrMemorizedType where
  sizeOf _ = (# size TangoAttrMemorizedType)
  alignment _ = (# alignment TangoAttrMemorizedType)
  peek = peekBounded "TangoAttrMemorizedType"
  poke = pokeBounded "TangoAttrMemorizedType"

data HaskellDevSource
  = Dev
  | Cache
  | CacheDev
  deriving (Show, Eq, Bounded, Enum)

devSourceToInt :: HaskellDevSource -> CInt
devSourceToInt Dev = 0
devSourceToInt Cache = 1
devSourceToInt CacheDev = 2

devSourceFromInt :: CInt -> HaskellDevSource
devSourceFromInt 0 = Dev
devSourceFromInt 1 = Cache
devSourceFromInt _ = CacheDev

-- Whatever type Tango reserves for enumerations
type CTangoEnum = CShort

data HaskellTangoVarArray a = HaskellTangoVarArray
  { varArrayLength :: Word32,
    varArrayValues :: Ptr a
  }
  deriving (Show, Generic)

instance (Storable a) => GStorable (HaskellTangoVarArray a)

data HaskellTangoCommandData
  = HaskellCommandVoid
  | HaskellCommandBool !CBool
  | HaskellCommandShort !CShort
  | HaskellCommandUShort !CUShort
  | HaskellCommandInt32 !CInt
  | HaskellCommandUInt32 !CUInt
  | HaskellCommandFloat !CFloat
  | HaskellCommandDouble !CDouble
  | HaskellCommandCString !CString
  | HaskellCommandLong64 !CLong
  | HaskellCommandDevState !DeviceState
  | HaskellCommandULong64 !CULong
  | HaskellCommandDevEncoded !HaskellTangoDevEncoded
  | HaskellCommandDevEnum !CTangoEnum
  | HaskellCommandVarBool !(HaskellTangoVarArray CBool)
  | HaskellCommandVarChar !(HaskellTangoVarArray CChar)
  | HaskellCommandVarShort !(HaskellTangoVarArray CShort)
  | HaskellCommandVarUShort !(HaskellTangoVarArray CUShort)
  | HaskellCommandVarLong !(HaskellTangoVarArray CLong)
  | HaskellCommandVarULong !(HaskellTangoVarArray CULong)
  | HaskellCommandVarLong64 !(HaskellTangoVarArray CLong)
  | HaskellCommandVarULong64 !(HaskellTangoVarArray CULong)
  | HaskellCommandVarFloat !(HaskellTangoVarArray CFloat)
  | HaskellCommandVarDouble !(HaskellTangoVarArray CDouble)
  | HaskellCommandVarCString !(HaskellTangoVarArray CString)
  | HaskellCommandVarDevState !(HaskellTangoVarArray DeviceState)
  | HaskellCommandLongStringArray !HaskellVarLongStringArray
  | HaskellCommandDoubleStringArray !HaskellVarDoubleStringArray
  deriving (Show)

data HaskellTangoAttributeData
  = HaskellAttributeDataBoolArray !(HaskellTangoVarArray CBool)
  | HaskellAttributeDataCharArray !(HaskellTangoVarArray CChar)
  | HaskellAttributeDataShortArray !(HaskellTangoVarArray CShort)
  | HaskellAttributeDataUShortArray !(HaskellTangoVarArray CUShort)
  | HaskellAttributeDataLongArray !(HaskellTangoVarArray CLong)
  | HaskellAttributeDataULongArray !(HaskellTangoVarArray CULong)
  | -- Long is defined as Word64 in Haskell, so...
    HaskellAttributeDataLong64Array !(HaskellTangoVarArray CLong)
  | HaskellAttributeDataULong64Array !(HaskellTangoVarArray CULong)
  | HaskellAttributeDataFloatArray !(HaskellTangoVarArray CFloat)
  | HaskellAttributeDataDoubleArray !(HaskellTangoVarArray CDouble)
  | HaskellAttributeDataStringArray !(HaskellTangoVarArray CString)
  | HaskellAttributeDataStateArray !(HaskellTangoVarArray DeviceState)
  | HaskellAttributeDataEncodedArray !(HaskellTangoVarArray HaskellTangoDevEncoded)
  deriving (Show)

data HaskellTangoPropertyData
  = HaskellPropBool !CBool
  | HaskellPropChar !CChar
  | HaskellPropShort !CShort
  | HaskellPropUShort !CUShort
  | -- Yes, I know. But it says long in the C struct
    HaskellPropLong !CInt
  | HaskellPropULong !CUInt
  | HaskellPropFloat !CFloat
  | HaskellPropDouble !CDouble
  | HaskellPropString !CString
  | HaskellPropLong64 !CLong
  | HaskellPropULong64 !CULong
  | HaskellPropShortArray !(HaskellTangoVarArray CShort)
  | HaskellPropUShortArray !(HaskellTangoVarArray CUShort)
  | HaskellPropLongArray !(HaskellTangoVarArray CLong)
  | HaskellPropULongArray !(HaskellTangoVarArray CULong)
  | HaskellPropLong64Array !(HaskellTangoVarArray CLong)
  | HaskellPropULong64Array !(HaskellTangoVarArray CULong)
  | HaskellPropFloatArray !(HaskellTangoVarArray CFloat)
  | HaskellPropDoubleArray !(HaskellTangoVarArray CDouble)
  | HaskellPropStringArray !(HaskellTangoVarArray CString)
  deriving (Show)

-- | Haskell mapping for the C type TangoDataType
-- Beware: this is encoded positionally!
data TangoDataType
  = HaskellDevVoid
  | HaskellDevBoolean
  | HaskellDevShort
  | HaskellDevLong
  | HaskellDevFloat
  | HaskellDevDouble
  | HaskellDevUShort
  | HaskellDevULong
  | HaskellDevString
  | HaskellDevVarCharArray
  | HaskellDevVarShortArray
  | HaskellDevVarLongArray
  | HaskellDevVarFloatArray
  | HaskellDevVarDoubleArray
  | HaskellDevVarUShortArray
  | HaskellDevVarULongArray
  | HaskellDevVarStringArray
  | HaskellDevVarLongStringArray
  | HaskellDevVarDoubleStringArray
  | HaskellDevState
  | HaskellConstDevString
  | HaskellDevVarBooleanArray
  | HaskellDevUChar
  | HaskellDevLong64
  | HaskellDevULong64
  | HaskellDevVarLong64Array
  | HaskellDevVarULong64Array
  | HaskellDevInt
  | HaskellDevEncoded
  | HaskellDevEnum
  | -- We explicitly have a type with index 29 and I don't know what that's supposed to be
    HaskellDevUnknown
  | HaskellDevVarStateArray
  | HaskellDevVarEncodedArray
  deriving (Show, Eq, Ord, Bounded, Enum)

instance Storable TangoDataType where
  sizeOf _ = (# size TangoDataType)
  alignment _ = (# alignment TangoDataType)
  peek = peekBounded "data type"
  poke = pokeBounded "data type"

-- | Event type if you want to subscribe to events. The events are losely described [in the Tango docs](https://tango-controls.readthedocs.io/en/latest/development/client-api/cpp-client-programmers-guide.html#events-tangoclient)
data EventType
  = -- | It is a type of event that gets fired when the associated attribute changes its value according to its configuration specified in system specific attribute properties (@abs_change@ and @rel_change@).
    ChangeEvent
  | -- | An “alarming” (or quality) subset of change events to allow clients to monitor when attributes’ quality factors are either Tango::ATTR_WARNING or Tango::ATTR_ALARM, without receiving unneeded events relating to value changes.
    QualityEvent
  | -- | It is a type of event that gets fired at a fixed periodic interval.
    PeriodicEvent
  | -- | An event is sent if one of the archiving conditions is satisfied. Archiving conditions are defined via properties in the database. These can be a mixture of delta_change and periodic. Archive events can be send from the polling thread or can be manually pushed from the device server code (@DeviceImpl::push_archive_event()@).
    ArchiveEvent
  | -- | The criteria and configuration of these user events are managed by the device server programmer who uses a specific method of one of the Tango device server class to fire the event (@DeviceImpl::push_event()@).
    UserEvent
  | -- | An event is sent if the attribute configuration is changed.
    AttrConfEvent
  | -- | This event is sent when coded by the device server programmer who uses a specific method of one of the Tango device server class to fire the event (@DeviceImpl::push_data_ready_event()@). The rule of this event is to inform a client that it is now possible to read an attribute. This could be useful in case of attribute with many data.
    DataReadyEvent
  | -- | This event is sent when the device interface changes. Using Tango, it is possible to dynamically add/remove attribute/command to a device. This event is the way to inform client(s) that attribute/command has been added/removed from a device.
    InterfaceChangeEvent
  | -- | This is the kind of event which has to be used when the user want to push data through a pipe. This kind of event is only sent by the user code by using a specific method (@DeviceImpl::push_pipe_event()@).
    PipeEvent
  deriving (Show, Eq, Ord, Bounded, Enum)

instance Storable EventType where
  sizeOf _ = (# size TangoEventType)
  alignment _ = (# alignment TangoEventType)
  peek = peekBounded "event type"
  poke = pokeBounded "event type"

data DataFormat
  = FormatScalar
  | FormatSpectrum
  | FormatImage
  deriving (Show)

instance Storable DataFormat where
  sizeOf _ = (# size AttrDataFormat)
  alignment _ = (# alignment AttrDataFormat)
  peek ptr = do
    value :: CInt <- peek (castPtr ptr)
    case value of
      0 -> pure FormatScalar
      1 -> pure FormatSpectrum
      _ -> pure FormatImage
  poke ptr x =
    poke @CInt
      (castPtr ptr)
      ( case x of
          FormatScalar -> 0
          FormatSpectrum -> 1
          FormatImage -> 2
      )

data HaskellDataQuality
  = HaskellValid
  | HaskellInvalid
  | HaskellAlarm
  | HaskellChanging
  | HaskellWarning
  deriving (Show)

data Timeval = Timeval
  { -- Guesswork, not sure how to type it
    tvSec :: !CLong,
    tvUsec :: !CLong
  }
  deriving (Show)

instance Storable Timeval where
  sizeOf _ = (# size struct timeval)
  alignment _ = (# alignment struct timeval)
  peek ptr = do
    tvSec' <- (# peek struct timeval, tv_sec) ptr
    tvUsec' <- (# peek struct timeval, tv_usec) ptr
    pure (Timeval tvSec' tvUsec')
  poke ptr (Timeval tvSec' tvUsec') = do
    (# poke struct timeval, tv_sec) ptr tvSec'
    (# poke struct timeval, tv_usec) ptr tvUsec'

data AttrWriteType = Read | ReadWithWrite | Write | ReadWrite deriving (Show)

instance Storable AttrWriteType where
  sizeOf _ = (# size AttrWriteType)
  alignment _ = (# alignment AttrWriteType)
  peek ptr = do
    value :: CInt <- peek (castPtr ptr)
    case value of
      0 -> pure Read
      1 -> pure ReadWithWrite
      2 -> pure Write
      _ -> pure ReadWrite
  poke ptr x =
    poke @CInt
      (castPtr ptr)
      ( case x of
          Read -> 0
          ReadWithWrite -> 1
          Write -> 2
          ReadWrite -> 3
      )

data DisplayLevel = Operator | Expert deriving (Show, Eq, Enum)

instance Storable DisplayLevel where
  sizeOf _ = (# size DispLevel)
  alignment _ = (# alignment DispLevel)
  peek ptr = do
    value :: CInt <- peek (castPtr ptr)
    case value of
      0 -> pure Operator
      _ -> pure Expert
  poke ptr x = poke @CInt (castPtr ptr) (if x == Operator then 0 else 1)

data HaskellVarLongStringArray = HaskellVarLongStringArray
  { longLength :: !Word32,
    longSequence :: !(Ptr Word64),
    longStringLength :: !Word32,
    longStringSequence :: !(Ptr CString)
  }
  deriving (Show)

instance Storable HaskellVarLongStringArray where
  sizeOf _ = (# size VarLongStringArray)
  alignment _ = (# alignment VarLongStringArray)
  peek ptr = do
    long_length' <- ((# peek VarLongStringArray, long_length) ptr)
    long_sequence' <- ((# peek VarLongStringArray, long_sequence) ptr)
    string_length' <- ((# peek VarLongStringArray, string_length) ptr)
    string_sequence' <- ((# peek VarLongStringArray, string_sequence) ptr)
    pure (HaskellVarLongStringArray long_length' long_sequence' string_length' string_sequence')
  poke ptr (HaskellVarLongStringArray longLength' longSequence' stringLength' stringSequence') = do
    (# poke VarLongStringArray, long_length) ptr longLength'
    (# poke VarLongStringArray, long_sequence) ptr longSequence'
    (# poke VarLongStringArray, string_length) ptr stringLength'
    (# poke VarLongStringArray, string_sequence) ptr stringSequence'

data HaskellVarDoubleStringArray = HaskellVarDoubleStringArray
  { doubleLength :: !Word32,
    doubleSequence :: !(Ptr CDouble),
    doubleStringLength :: !Word32,
    doubleStringSequence :: !(Ptr CString)
  }
  deriving (Show)

instance Storable HaskellVarDoubleStringArray where
  sizeOf _ = (# size VarDoubleStringArray)
  alignment _ = (# alignment VarDoubleStringArray)
  peek ptr = do
    double_length' <- ((# peek VarDoubleStringArray, double_length) ptr)
    double_sequence' <- ((# peek VarDoubleStringArray, double_sequence) ptr)
    string_length' <- ((# peek VarDoubleStringArray, string_length) ptr)
    string_sequence' <- ((# peek VarDoubleStringArray, string_sequence) ptr)
    pure (HaskellVarDoubleStringArray double_length' double_sequence' string_length' string_sequence')
  poke ptr (HaskellVarDoubleStringArray doubleLength' doubleSequence' stringLength' stringSequence') = do
    (# poke VarDoubleStringArray, double_length) ptr doubleLength'
    (# poke VarDoubleStringArray, double_sequence) ptr doubleSequence'
    (# poke VarDoubleStringArray, string_length) ptr stringLength'
    (# poke VarDoubleStringArray, string_sequence) ptr stringSequence'

data HaskellTangoDevEncoded = HaskellTangoDevEncoded
  { devEncodedFormat :: !CString,
    devEncodedLength :: !Word32,
    devEncodedData :: !(Ptr Word8)
  }
  deriving (Show, Generic)

instance GStorable HaskellTangoDevEncoded

data HaskellAttributeInfo = HaskellAttributeInfo
  { attributeInfoName :: !CString,
    attributeInfoWritable :: !AttrWriteType,
    attributeInfoDataFormat :: !DataFormat,
    attributeInfoDataType :: !TangoDataType,
    attributeInfoMaxDimX :: !Int32,
    attributeInfoMaxDimY :: !Int32,
    attributeInfoDescription :: !CString,
    attributeInfoLabel :: !CString,
    attributeInfoUnit :: !CString,
    attributeInfoStandardUnit :: !CString,
    attributeInfoDisplayUnit :: !CString,
    attributeInfoFormat :: !CString,
    attributeInfoMinValue :: !CString,
    attributeInfoMaxValue :: !CString,
    attributeInfoMinAlarm :: !CString,
    attributeInfoMaxAlarm :: !CString,
    attributeInfoWritableAttrName :: !CString,
    attributeInfoDispLevel :: !DisplayLevel,
    attributeInfoEnumLabels :: !(Ptr CString),
    attributeInfoEnumLabelsCount :: !Word16,
    attributeInfoRootAttrName :: !CString,
    attributeInfoMemorized :: !TangoAttrMemorizedType
  }
  deriving (Show, Generic)

instance GStorable HaskellAttributeInfo

data HaskellDbDatum = HaskellDbDatum
  { dbDatumPropertyName :: !CString,
    dbDatumIsEmpty :: !Bool,
    dbDatumWrongDataType :: !Bool,
    dbDatumDataType :: !TangoDataType,
    dbDatumPropData :: !HaskellTangoPropertyData
  }
  deriving (Show)

data HaskellAttributeData = HaskellAttributeData
  { dataFormat :: !DataFormat,
    dataQuality :: !HaskellDataQuality,
    nbRead :: !CLong,
    name :: !CString,
    dimX :: !Int32,
    dimY :: !Int32,
    timeStamp :: !Timeval,
    dataType :: !TangoDataType,
    tangoAttributeData :: !HaskellTangoAttributeData
  }
  deriving (Show)

data HaskellCommandData = HaskellCommandData
  { argType :: !TangoDataType,
    tangoCommandData :: !HaskellTangoCommandData
  }
  deriving (Show)

haskellDisplayLevelOperator :: CInt
haskellDisplayLevelOperator = 0

haskellDisplayLevelExpert :: CInt
haskellDisplayLevelExpert = 1

data HaskellCommandInfo = HaskellCommandInfo
  { cmdName :: !CString,
    cmdTag :: !Int32,
    cmdInType :: !Int32,
    cmdOutType :: !Int32,
    cmdInTypeDesc :: !CString,
    cmdOutTypeDesc :: !CString,
    cmdDisplayLevel :: !CInt
  }
  deriving (Show)

instance Storable HaskellCommandInfo where
  sizeOf _ = (# size CommandInfo)
  alignment _ = (# alignment CommandInfo)
  peek ptr = do
    cmd_name' <- (# peek CommandInfo, cmd_name) ptr
    cmd_tag' <- (# peek CommandInfo, cmd_tag) ptr
    in_type' <- (# peek CommandInfo, in_type) ptr
    out_type' <- (# peek CommandInfo, out_type) ptr
    in_type_desc' <- (# peek CommandInfo, in_type_desc) ptr
    out_type_desc' <- (# peek CommandInfo, out_type_desc) ptr
    disp_level' <- (# peek CommandInfo, disp_level) ptr
    pure (HaskellCommandInfo cmd_name' cmd_tag' in_type' out_type' in_type_desc' out_type_desc' disp_level')

  -- I see no reason why we'd ever poke this (i.e. write an info struct)
  poke ptr (HaskellCommandInfo cmd_name' cmd_tag' in_type' out_type' in_type_desc' out_type_desc' disp_level') = do
    (# poke CommandInfo, cmd_name) ptr cmd_name'
    (# poke CommandInfo, cmd_tag) ptr cmd_tag'
    (# poke CommandInfo, in_type) ptr in_type'
    (# poke CommandInfo, out_type) ptr out_type'
    (# poke CommandInfo, in_type_desc) ptr in_type_desc'
    (# poke CommandInfo, out_type_desc) ptr out_type_desc'
    (# poke CommandInfo, disp_level) ptr disp_level'

qualityToHaskell :: CInt -> HaskellDataQuality
qualityToHaskell 0 = HaskellValid
qualityToHaskell 1 = HaskellInvalid
qualityToHaskell 2 = HaskellAlarm
qualityToHaskell 3 = HaskellChanging
qualityToHaskell _ = HaskellWarning

instance Storable HaskellDbDatum where
  sizeOf _ = (# size DbDatum)
  alignment _ = (# alignment DbDatum)
  peek ptr = do
    property_name' <- (# peek DbDatum, property_name) ptr
    data_type' <- (# peek DbDatum, data_type) ptr
    is_empty' <- (# peek DbDatum, is_empty) ptr
    wrong_data_type' <- (# peek DbDatum, wrong_data_type) ptr
    let withoutType =
          HaskellDbDatum
            property_name'
            is_empty'
            wrong_data_type'
            data_type'
    case data_type' of
      HaskellDevVoid -> error "encountered void type in DbDatum"
      HaskellDevUnknown -> error "encountered unknown type in DbDatum"
      HaskellDevEnum -> error "encountered enum in DbDatum"
      HaskellDevBoolean -> (withoutType . HaskellPropBool) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevShort -> (withoutType . HaskellPropShort) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevLong -> (withoutType . HaskellPropLong) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevFloat -> (withoutType . HaskellPropFloat) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevDouble -> (withoutType . HaskellPropDouble) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevUShort -> (withoutType . HaskellPropUShort) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevULong -> (withoutType . HaskellPropULong) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevString -> (withoutType . HaskellPropString) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarCharArray -> error "type var char array not supported in dbdatum"
      HaskellDevVarShortArray -> (withoutType . HaskellPropShortArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarStateArray -> error "type var state array not supported in dbdatum"
      HaskellDevVarLongArray -> (withoutType . HaskellPropLongArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarFloatArray -> (withoutType . HaskellPropFloatArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarDoubleArray -> (withoutType . HaskellPropDoubleArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarUShortArray -> (withoutType . HaskellPropUShortArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarULongArray -> (withoutType . HaskellPropULongArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarStringArray -> (withoutType . HaskellPropStringArray) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarLongStringArray -> error "type long string array not supported in dbdatum"
      HaskellDevVarDoubleStringArray -> error "type double string array not supported in dbdatum"
      HaskellDevState -> error "type state not supported in dbdatum"
      HaskellConstDevString -> error "type const dev string not supported in dbdatum"
      HaskellDevVarBooleanArray -> do
        propertyName <- peekCString property_name'
        error ("encountered a property " <> show propertyName <> " with type boolean array -- this is not supported (yet)")
      HaskellDevUChar -> error "type unsigned char not supported in dbdatum"
      HaskellDevLong64 -> (withoutType . HaskellPropLong64) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevULong64 -> (withoutType . HaskellPropULong64) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevInt -> error "type int not supported in dbdatum"
      HaskellDevEncoded -> error "type encoded not supported in dbdatum"
      HaskellDevVarEncodedArray -> error "type encoded array not supported in dbdatum"
      HaskellDevVarLong64Array -> (withoutType . HaskellPropLong64Array) <$> ((# peek DbDatum, prop_data) ptr)
      HaskellDevVarULong64Array -> (withoutType . HaskellPropULong64Array) <$> ((# peek DbDatum, prop_data) ptr)
  poke ptr haskellDbDatum = do
    (# poke DbDatum, property_name) ptr (dbDatumPropertyName haskellDbDatum)
    (# poke DbDatum, is_empty) ptr (dbDatumIsEmpty haskellDbDatum)
    (# poke DbDatum, wrong_data_type) ptr (dbDatumWrongDataType haskellDbDatum)
    (# poke DbDatum, data_type) ptr (dbDatumDataType haskellDbDatum)
    case dbDatumPropData haskellDbDatum of
      HaskellPropDoubleArray doubles' -> do
        (# poke DbDatum, prop_data) ptr doubles'
      HaskellPropStringArray strings' -> do
        (# poke DbDatum, prop_data) ptr strings'
      -- FIXME?
      _ -> pure ()

instance Storable HaskellAttributeData where
  sizeOf _ = (# size AttributeData)
  alignment _ = (# alignment AttributeData)
  peek ptr = do
    data_type' <- (# peek AttributeData, data_type) ptr
    dim_x' <- (# peek AttributeData, dim_x) ptr
    dim_y' <- (# peek AttributeData, dim_y) ptr
    name' <- (# peek AttributeData, name) ptr
    nb_read' <- (# peek AttributeData, nb_read) ptr
    quality' <- (# peek AttributeData, quality) ptr
    data_format' <- (# peek AttributeData, data_format) ptr
    time_stamp' <- (# peek AttributeData, time_stamp) ptr
    let withoutType =
          HaskellAttributeData
            data_format'
            (qualityToHaskell quality')
            nb_read'
            name'
            dim_x'
            dim_y'
            time_stamp'
            data_type'
    case data_type' of
      HaskellDevUnknown -> error "encountered DevUnknown data type"
      HaskellDevVoid -> error "encountered DevVoid data type"
      HaskellDevVarEncodedArray -> error "encountered DevVarEncodedArray data type"
      HaskellDevBoolean -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataBoolArray attr_data'))
      HaskellDevShort -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataShortArray attr_data'))
      HaskellDevLong -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataLongArray attr_data'))
      HaskellDevFloat -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataFloatArray attr_data'))
      HaskellDevDouble -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataDoubleArray attr_data'))
      HaskellDevUShort -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataUShortArray attr_data'))
      HaskellDevULong -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataULongArray attr_data'))
      HaskellDevString -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataStringArray attr_data'))
      HaskellDevVarCharArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataCharArray attr_data'))
      HaskellDevVarStateArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataStateArray attr_data'))
      HaskellDevVarShortArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataShortArray attr_data'))
      HaskellDevVarLongArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataLongArray attr_data'))
      HaskellDevVarFloatArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataFloatArray attr_data'))
      HaskellDevVarDoubleArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataDoubleArray attr_data'))
      HaskellDevVarUShortArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataUShortArray attr_data'))
      HaskellDevVarULongArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataULongArray attr_data'))
      HaskellDevVarStringArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataStringArray attr_data'))
      HaskellDevVarLongStringArray -> error "long string arrays are not supported right now"
      HaskellDevVarDoubleStringArray -> error "double string arrays are not supported right now"
      HaskellDevState -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataStateArray attr_data'))
      HaskellConstDevString -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataStringArray attr_data'))
      HaskellDevUChar -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataCharArray attr_data'))
      HaskellDevVarBooleanArray -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataBoolArray attr_data'))
      HaskellDevLong64 -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataLong64Array attr_data'))
      HaskellDevULong64 -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataULong64Array attr_data'))
      HaskellDevVarLong64Array -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataLong64Array attr_data'))
      HaskellDevVarULong64Array -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataULong64Array attr_data'))
      HaskellDevInt -> error "int arrays are not supported right now"
      HaskellDevEncoded -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataEncodedArray attr_data'))
      HaskellDevEnum -> do
        attr_data' <- (# peek AttributeData, attr_data) ptr
        pure (withoutType (HaskellAttributeDataShortArray attr_data'))
  poke ptr haskellAttributeData = do
    (# poke AttributeData, dim_x) ptr (dimX haskellAttributeData)
    (# poke AttributeData, dim_y) ptr (dimY haskellAttributeData)
    (# poke AttributeData, name) ptr (name haskellAttributeData)
    (# poke AttributeData, data_type) ptr (dataType haskellAttributeData)
    case tangoAttributeData haskellAttributeData of
      HaskellAttributeDataBoolArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataCharArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataShortArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataUShortArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataLongArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataULongArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataLong64Array v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataULong64Array v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataFloatArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataDoubleArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataStringArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataStateArray v -> (# poke AttributeData, attr_data) ptr v
      HaskellAttributeDataEncodedArray v -> (# poke AttributeData, attr_data) ptr v

instance Storable HaskellCommandData where
  sizeOf _ = (# size CommandData)
  alignment _ = (# alignment CommandData)
  peek ptr = do
    data_type' <- (# peek CommandData, arg_type) ptr
    case data_type' of
      HaskellDevVoid -> pure (HaskellCommandData data_type' HaskellCommandVoid)
      HaskellDevBoolean -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandBool cmd_data'))
      HaskellDevShort -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandShort cmd_data'))
      HaskellDevUShort -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandUShort cmd_data'))
      -- There seems to be no "UInt" for some reason
      HaskellDevInt -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandInt32 cmd_data'))
      HaskellDevFloat -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandFloat cmd_data'))
      HaskellDevDouble -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandDouble cmd_data'))
      HaskellDevString -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandCString cmd_data'))
      HaskellDevLong64 -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandLong64 cmd_data'))
      HaskellDevState -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandDevState cmd_data'))
      HaskellDevULong64 -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandULong64 cmd_data'))
      HaskellDevEncoded -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandDevEncoded cmd_data'))
      HaskellDevEnum -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandDevEnum cmd_data'))
      HaskellDevVarBooleanArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarBool cmd_data'))
      HaskellDevVarCharArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarChar cmd_data'))
      HaskellDevVarShortArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarShort cmd_data'))
      HaskellDevVarUShortArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarUShort cmd_data'))
      HaskellDevVarLongArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarLong cmd_data'))
      HaskellDevVarULongArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarULong cmd_data'))
      HaskellDevVarLong64Array -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarLong64 cmd_data'))
      HaskellDevVarULong64Array -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarULong64 cmd_data'))
      HaskellDevVarFloatArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarFloat cmd_data'))
      HaskellDevVarDoubleArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarDouble cmd_data'))
      HaskellDevVarStringArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandVarCString cmd_data'))
      -- Also curiously, no type for this exists
      -- HaskellDevVarDevStateArray -> do
      --   cmd_data' <- (#peek CommandData, cmd_data) ptr
      --   pure (HaskellCommandData data_type' (HaskellCommandVarDevState cmd_data'))
      HaskellDevVarLongStringArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandLongStringArray cmd_data'))
      HaskellDevVarDoubleStringArray -> do
        cmd_data' <- (# peek CommandData, cmd_data) ptr
        pure (HaskellCommandData data_type' (HaskellCommandDoubleStringArray cmd_data'))
      _ -> error "shit"
  poke ptr (HaskellCommandData argType' tangoCommandData') = do
    (# poke CommandData, arg_type) ptr argType'
    case tangoCommandData' of
      HaskellCommandVoid -> pure ()
      HaskellCommandBool v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandShort v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandUShort v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandInt32 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandUInt32 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandFloat v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandDouble v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandCString v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandLong64 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandDevState v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandULong64 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandDevEncoded v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarBool v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarChar v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarShort v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarUShort v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarLong v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarULong v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarLong64 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarULong64 v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarFloat v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarDouble v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarCString v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandVarDevState v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandLongStringArray v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandDoubleStringArray v -> (# poke CommandData, cmd_data) ptr v
      HaskellCommandDevEnum v -> (# poke CommandData, cmd_data) ptr v

-- | How severe is the error (used in the Tango error types)
data ErrSeverity
  = Warn
  | Err
  | Panic
  deriving (Show, Eq, Bounded, Enum)

instance Storable ErrSeverity where
  sizeOf _ = (# size TangoDevState)
  alignment _ = (# alignment TangoDevState)
  peek = peekBounded "ErrSeverity"
  poke = pokeBounded "ErrSeverity"

-- | Wraps one piece of a Tango error trace (usually you will have lists of @DevFailed@ records). This is a generic to make treating its fields easier with respect to 'Text' and 'CString' (it's also a 'Functor' and 'Traversable' and all that for that reason)
data DevFailed a = DevFailed
  { -- | Failure description; this will usually be the actual error message you're interested in and will be human-readable
    devFailedDesc :: !a,
    -- | Failure reason; this is usually an error code string, like @API_AttrNotFound@
    devFailedReason :: !a,
    -- | Failure origin: this is usually the C++ function that caused the error
    devFailedOrigin :: !a,
    -- | Severity: not sure what the consequences of the individual severities are
    devFailedSeverity :: !ErrSeverity
  }
  deriving (Functor, Foldable, Traversable, Generic, Show)

instance (Storable a) => GStorable (DevFailed a)

data HaskellErrorStack = HaskellErrorStack
  { errorStackLength :: !Word32,
    errorStackSequence :: !(Ptr (DevFailed CString))
  }
  deriving (Generic)

instance GStorable HaskellErrorStack

data HaskellDbData = HaskellDbData
  { dbDataLength :: Word32,
    dbDataSequence :: Ptr HaskellDbDatum
  }
  deriving (Show, Generic)

instance GStorable HaskellDbData

data HaskellCommandInfoList = HaskellCommandInfoList
  { commandInfoLength :: Word32,
    commandInfoSequence :: Ptr HaskellCommandInfo
  }
  deriving (Show, Generic)

instance GStorable HaskellCommandInfoList

data HaskellAttributeInfoList = HaskellAttributeInfoList
  { attributeInfoListLength :: Word32,
    attributeInfoListSequence :: Ptr HaskellAttributeInfo
  }
  deriving (Show, Generic)

instance GStorable HaskellAttributeInfoList

data HaskellAttributeDataList = HaskellAttributeDataList
  { attributeDataListLength :: Word32,
    attributeDataListSequence :: Ptr HaskellAttributeData
  }
  deriving (Show, Generic)

instance GStorable HaskellAttributeDataList

type DeviceProxyPtr = Ptr ()

type DatabaseProxyPtr = Ptr ()

type TangoError = Ptr HaskellErrorStack

foreign import capi "c_tango.h tango_create_device_proxy"
  tango_create_device_proxy :: CString -> Ptr DeviceProxyPtr -> IO TangoError

foreign import capi "c_tango.h tango_delete_device_proxy"
  tango_delete_device_proxy :: DeviceProxyPtr -> IO TangoError

foreign import capi "c_tango.h tango_read_attribute"
  tango_read_attribute :: DeviceProxyPtr -> CString -> Ptr HaskellAttributeData -> IO TangoError

foreign import capi "c_tango.h tango_write_attribute"
  tango_write_attribute :: DeviceProxyPtr -> Ptr HaskellAttributeData -> IO TangoError

foreign import capi "c_tango.h tango_command_inout"
  tango_command_inout :: DeviceProxyPtr -> CString -> Ptr HaskellCommandData -> Ptr HaskellCommandData -> IO TangoError

foreign import capi "c_tango.h tango_free_AttributeData"
  tango_free_AttributeData :: Ptr HaskellAttributeData -> IO ()

foreign import capi "c_tango.h tango_free_AttributeInfoList"
  tango_free_AttributeInfoList :: Ptr HaskellAttributeInfoList -> IO ()

foreign import capi "c_tango.h tango_free_CommandData"
  tango_free_CommandData :: Ptr HaskellCommandData -> IO ()

foreign import capi "c_tango.h tango_free_VarStringArray"
  tango_free_VarStringArray :: Ptr (HaskellTangoVarArray CString) -> IO ()

foreign import capi "c_tango.h tango_set_timeout_millis"
  tango_set_timeout_millis :: DeviceProxyPtr -> CInt -> IO TangoError

foreign import capi "c_tango.h tango_get_timeout_millis"
  tango_get_timeout_millis :: DeviceProxyPtr -> Ptr CInt -> IO TangoError

foreign import capi "c_tango.h tango_set_source"
  tango_set_source :: DeviceProxyPtr -> CInt -> IO TangoError

-- comment out for now: it has some incompatible pointer error in capi
-- foreign import capi "c_tango.h tango_get_source"
--      tango_get_source :: DeviceProxyPtr -> Ptr CInt -> IO TangoError

foreign import capi "c_tango.h tango_lock"
  tango_lock :: DeviceProxyPtr -> IO TangoError

foreign import capi "c_tango.h tango_unlock"
  tango_unlock :: DeviceProxyPtr -> IO TangoError

-- comment out for now: it has some incompatible pointer error in capi
-- foreign import capi "c_tango.h tango_is_locked"
--      tango_is_locked :: DeviceProxyPtr -> Ptr Bool -> IO TangoError

-- comment out for now: it has some incompatible pointer error in capi
-- foreign import capi "c_tango.h tango_is_locked_by_me"
--      tango_is_locked_by_me :: DeviceProxyPtr -> Ptr Bool -> IO TangoError

foreign import capi "c_tango.h tango_locking_status"
  tango_locking_status :: DeviceProxyPtr -> Ptr CString -> IO TangoError

foreign import capi "c_tango.h tango_command_list_query"
  tango_command_list_query :: DeviceProxyPtr -> Ptr HaskellCommandInfoList -> IO TangoError

foreign import capi "c_tango.h tango_command_query"
  tango_command_query :: DeviceProxyPtr -> CString -> Ptr HaskellCommandInfo -> IO TangoError

foreign import capi "c_tango.h tango_free_CommandInfo"
  tango_free_CommandInfo :: Ptr HaskellCommandInfo -> IO ()

foreign import capi "c_tango.h tango_free_CommandInfoList"
  tango_free_CommandInfoList :: Ptr HaskellCommandInfoList -> IO ()

foreign import capi "c_tango.h tango_get_attribute_list"
  tango_get_attribute_list :: DeviceProxyPtr -> Ptr (HaskellTangoVarArray CString) -> IO TangoError

foreign import capi "c_tango.h tango_get_attribute_config"
  tango_get_attribute_config :: DeviceProxyPtr -> Ptr (HaskellTangoVarArray CString) -> Ptr HaskellAttributeInfoList -> IO TangoError

foreign import capi "c_tango.h tango_read_attributes"
  tango_read_attributes :: DeviceProxyPtr -> Ptr (HaskellTangoVarArray CString) -> Ptr HaskellAttributeDataList -> IO TangoError

foreign import capi "c_tango.h tango_write_attributes"
  tango_write_attributes :: DeviceProxyPtr -> Ptr HaskellAttributeDataList -> IO TangoError

foreign import capi "c_tango.h tango_create_database_proxy"
  tango_create_database_proxy :: Ptr DatabaseProxyPtr -> IO TangoError

foreign import capi "c_tango.h tango_delete_database_proxy"
  tango_delete_database_proxy :: DatabaseProxyPtr -> IO TangoError

foreign import capi "c_tango.h tango_get_device_exported"
  tango_get_device_exported :: DatabaseProxyPtr -> CString -> Ptr HaskellDbDatum -> IO TangoError

foreign import capi "c_tango.h tango_get_device_exported_for_class"
  tango_get_device_exported_for_class :: DatabaseProxyPtr -> CString -> Ptr HaskellDbDatum -> IO TangoError

foreign import capi "c_tango.h tango_get_object_list"
  tango_get_object_list :: DatabaseProxyPtr -> CString -> Ptr HaskellDbDatum -> IO TangoError

foreign import capi "c_tango.h tango_get_object_property_list"
  tango_get_object_property_list :: DatabaseProxyPtr -> CString -> CString -> Ptr HaskellDbDatum -> IO TangoError

foreign import capi "c_tango.h tango_get_property"
  tango_get_property :: DatabaseProxyPtr -> CString -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_put_property"
  tango_put_property :: DatabaseProxyPtr -> CString -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_delete_property"
  tango_delete_property :: DatabaseProxyPtr -> CString -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_get_device_property"
  tango_get_device_property :: DeviceProxyPtr -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_put_device_property"
  tango_put_device_property :: DeviceProxyPtr -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_delete_device_property"
  tango_delete_device_property :: DeviceProxyPtr -> Ptr HaskellDbData -> IO TangoError

foreign import capi "c_tango.h tango_free_DbDatum"
  tango_free_DbDatum :: Ptr HaskellDbDatum -> IO ()

foreign import capi "c_tango.h tango_free_DbData"
  tango_free_DbData :: Ptr HaskellDbData -> IO ()

type EventCallback = Ptr () -> CString -> Bool -> IO ()

foreign import ccall "wrapper" createEventCallbackWrapper :: EventCallback -> IO (FunPtr EventCallback)

foreign import capi "c_tango.h tango_create_event_callback"
  tango_create_event_callback :: FunPtr EventCallback -> IO (Ptr ())

foreign import capi "c_tango.h tango_free_event_callback"
  tango_free_event_callback :: Ptr () -> IO ()

foreign import capi "c_tango.h tango_subscribe_event"
  tango_subscribe_event :: DeviceProxyPtr -> CString -> CInt -> Ptr () -> CBool -> IO CInt

foreign import capi "c_tango.h tango_unsubscribe_event"
  tango_unsubscribe_event :: DeviceProxyPtr -> CInt -> IO ()

foreign import capi "c_tango.h tango_poll_command"
  tango_poll_command :: DeviceProxyPtr -> CString -> CInt -> IO TangoError

foreign import capi "c_tango.h tango_stop_poll_command"
  tango_stop_poll_command :: DeviceProxyPtr -> CString -> IO TangoError

foreign import capi "c_tango.h tango_poll_attribute"
  tango_poll_attribute :: DeviceProxyPtr -> CString -> CInt -> IO TangoError

foreign import capi "c_tango.h tango_stop_poll_attribute"
  tango_stop_poll_attribute :: DeviceProxyPtr -> CString -> IO TangoError

-- FIXME: This function is not memory-safe!
-- foreign import capi "c_tango.h tango_throw_exception"
--   tango_throw_exception :: CString -> IO ()
