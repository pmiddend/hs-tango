{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Control.Concurrent (forkIO, threadDelay)
import Foreign.C (CInt, CLong)
import Foreign.C.String (CString, newCString, peekCString, withCString)
import Foreign.Marshal (free, peekArray, with)
import Foreign.Marshal.Alloc (free, malloc)
import Foreign.Marshal.Array (withArray)
import Foreign.Marshal.Utils (new)
import Foreign.Ptr (FunPtr, Ptr, castPtr)
import Foreign.Storable (peek, poke)
import Tango.Common
  ( HaskellAttrWriteType (Read, ReadWrite),
    HaskellTangoDataType (HaskellDevBoolean, HaskellDevLong64, HaskellDevString),
    HaskellTangoDevState (Moving),
  )
import Tango.Server
  ( HaskellAttributeDefinition (..),
    createFnWrapper,
    tango_server_add_attribute_definition,
    tango_server_init,
    tango_server_set_status,
    tango_server_start,
  )

attributeStringGetter :: Ptr () -> IO ()
attributeStringGetter ptr = do
  cstr <- newCString "test string 123"
  poke (castPtr ptr) cstr

attributeStringSetter :: Ptr () -> IO ()
attributeStringSetter ptr = do
  putStrLn "in setter"
  cstr :: CString <- peek (castPtr ptr)
  putStrLn "peeked"
  mycstring <- peekCString cstr
  putStrLn $ "string was |" <> mycstring <> "|"

attributeLongGetter :: Ptr () -> IO ()
attributeLongGetter ptr = do
  putStrLn "reading long"
  poke (castPtr ptr) (1339 :: CLong)

attributeLongSetter :: Ptr () -> IO ()
attributeLongSetter ptr = do
  newValue :: CLong <- peek (castPtr ptr)
  putStrLn $ "new long value " <> show newValue

attributeBoolGetter :: Ptr () -> IO ()
attributeBoolGetter ptr = do
  putStrLn "reading bool"
  poke (castPtr ptr) True

attributeBoolSetter :: Ptr () -> IO ()
attributeBoolSetter ptr = do
  newValue :: Bool <- peek (castPtr ptr)
  putStrLn $ "new bool value " <> show newValue

main :: IO ()
main = do
  withCString "JustOneAttribute" \first -> withCString "testdevice" \second -> do
    withArray [first, second] \a -> do
      withCString "long_attribute" \longAttributeName -> withCString "string_attribute" \stringAttributeName -> do
        longGetterWrapped <- createFnWrapper attributeLongGetter
        longSetterWrapped <- createFnWrapper attributeLongSetter
        dummyFinalizerWrapped <- createFnWrapper (const $ pure ())
        with (HaskellAttributeDefinition longAttributeName HaskellDevLong64 ReadWrite longSetterWrapped longGetterWrapped dummyFinalizerWrapped) \attributeDefinition -> do
          tango_server_add_attribute_definition attributeDefinition
        stringGetterWrapped <- createFnWrapper attributeStringGetter
        stringSetterWrapped <- createFnWrapper attributeStringSetter
        freeFinalizerWrapped <- createFnWrapper free
        with (HaskellAttributeDefinition stringAttributeName HaskellDevString ReadWrite stringSetterWrapped stringGetterWrapped freeFinalizerWrapped) \attributeDefinition -> do
          tango_server_add_attribute_definition attributeDefinition
        withCString "initial status hihihi" \initialStatus -> do
          tango_server_init 2 a initialStatus (fromIntegral $ fromEnum $ Moving)
          forkIO do
            putStrLn "sleeping"
            threadDelay (5 * 1000 * 1000)
            putStrLn "setting status"
            withCString "new status" tango_server_set_status
            putStrLn "setting status done"
          tango_server_start
