{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Concurrent (newChan, readChan, writeChan)
import Control.Monad (forM_)
import Control.Monad.IO.Class (liftIO)
import Data.Int (Int16)
import Data.Text.IO qualified as TIO
import Tango.Client

data ScalarEnum = Label0 | Label1 | Label2 deriving (Enum, Show)

main =
  case parseTangoUrl "sys/tg_test/1" of
    Left e -> error "couldn't resolve tango URL"
    Right deviceAddress -> withDeviceProxy deviceAddress \proxy -> do
      aconfig <- getConfigForAttribute proxy (AttributeName "boolean_scalar")
      print aconfig

main3 =
  case parseTangoUrl "sys/tg_test/1" of
    Left e -> error "couldn't resolve tango URL"
    Right deviceAddress -> withDeviceProxy deviceAddress \proxy -> do
      timeout <- getTimeout proxy

      chan <- newChan

      let attributeName = AttributeName "boolean_scalar"
          eventCallback attribute bool = liftIO do
            boolValue <- readBoolAttribute proxy attributeName
            putStrLn $ "got a change: " <> show boolValue
            writeChan chan True

      pollAttribute proxy attributeName (Milliseconds 2000)

      withSubscribedEvent proxy attributeName ChangeEvent False eventCallback do
        forM_ [0 .. 2] \_ -> do
          putStrLn "waiting for change"
          _ <- readChan chan
          putStrLn "received change"

main2 =
  case parseTangoUrl "sys/tg_test/1" of
    Left e -> error "couldn't resolve tango URL"
    Right deviceAddress -> withDeviceProxy deviceAddress \proxy -> do
      timeout <- getTimeout proxy

      putStrLn $ "proxy timeout is " <> show timeout

      booleanResultBetter <- readBoolAttribute proxy (AttributeName "boolean_scalar")
      putStrLn $ "boolean_scalar better is " <> show booleanResultBetter

      -- booleanSpectrumResult <- readBoolSpectrumAttribute proxy (AttributeName "boolean_spectrum")
      -- putStrLn $ "boolean_spectrum is " <> show booleanSpectrumResult
      booleanSpectrumResultBetter <- readBoolSpectrumAttribute proxy (AttributeName "boolean_spectrum")
      putStrLn $ "boolean_spectrum is " <> show booleanSpectrumResultBetter

      -- booleanImageResult <- readBoolImageAttribute proxy (AttributeName "boolean_image")
      -- putStrLn $ "boolean_image is " <> show booleanImageResult

      enumResult :: TangoValue Int16 <- readEnumAttribute proxy (AttributeName "enum_scalar")
      putStrLn $ "enum_scalar is " <> show enumResult

      integralResult :: TangoValue Int <- readIntegralAttribute proxy (AttributeName "long_scalar")
      putStrLn $ "long_scalar as integral attribute is " <> show integralResult

      attributeList <- getConfigsForAttributes proxy [AttributeName "enum_scalar_ro"]
      putStrLn $ "attribute description for \"enum_scalar_ro\": " <> show attributeList

      (TangoValue enumResultRead' enumResultWrite') <- readEnumAttribute proxy (AttributeName "enum_scalar")
      putStrLn $ "enum_scalar (as Haskell enum) is " <> show (enumResultRead' :: ScalarEnum)

      stringScalar <- readStringAttribute proxy (AttributeName "string_scalar")
      TIO.putStrLn $ "string scalar: " <> tangoValueRead stringScalar

      floatResultAsReal <- readRealAttribute proxy (AttributeName "float_scalar")
      doubleResultAsReal <- readRealAttribute proxy (AttributeName "double_scalar")

      putStrLn $ "float result " <> show floatResultAsReal <> ", double result: " <> show doubleResultAsReal

      writeLong64Attribute proxy (AttributeName "long64_scalar") 1337

      result <- commandInOutGeneric proxy (CommandName "DevVoid") CommandVoid
      putStrLn $ "result of DevVoid command: " <> show result

      result' <- commandInOutGeneric proxy (CommandName "DevBoolean") (CommandBool True)
      putStrLn $ "result of DevBoolean True command: " <> show result'

      result'' <- commandInOutGeneric proxy (CommandName "DevDouble") (CommandDouble 3.5)
      putStrLn $ "result of DevDouble 3.5 command: " <> show result''

      result''' <- commandInOutGeneric proxy (CommandName "DevVarDoubleArray") (CommandListDouble [3.5, 4.0])
      putStrLn $ "result of DevVarDoubleArray [3.5, 4.0] command: " <> show result'''

      putDeviceProperties proxy [(PropertyName "testproperty", ["x", "y"])]

      prop <- getDeviceProperties proxy [PropertyName "testproperty"]
      putStrLn $ "properties " <> show prop

      commandList <- commandListQuery proxy

      putStrLn "got the following commands:"
      forM_ commandList \commandInfo ->
        print commandInfo

      singleCommand <- commandQuery proxy (CommandName "DevString")

      attributeNames <- getAttributeNames proxy
      putStrLn "got the following attribute names:"
      forM_ attributeNames \attributeName ->
        print attributeName

      print singleCommand

      withDatabaseProxy \dbProxy -> do
        byName <- databaseSearchByDeviceName dbProxy "*"
        putStrLn $ "device sys/tg_test/1: " <> show byName

        byClass <- databaseSearchByClass dbProxy "TangoTest"
        putStrLn $ "device TangoTest: " <> show byClass

        objectsByName <- databaseSearchObjectsByName dbProxy "*"
        putStrLn $ "objects *: " <> show objectsByName
