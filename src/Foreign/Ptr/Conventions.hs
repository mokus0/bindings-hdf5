{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- |various common data-passing conventions
module Foreign.Ptr.Conventions where

-- TODO: make these all exception-safe
-- TODO: reverse order of 'out' returns
-- TODO: bytestring versions?  versions allocating by byte but using vectors?
import Foreign.Marshal
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.Storable

import Control.Monad.IO.Class
import Control.Monad.IO.Peel
import Control.Monad.Primitive (RealWorld)

import qualified Data.Vector.Storable as SV
import qualified Data.Vector.Storable.Mutable as SVM

class WrappedPtr p where
    wrapPtr         :: Ptr a -> p a
    unwrapPtr       :: p a -> Ptr a
    nullWrappedPtr  :: p a
    nullWrappedPtr = wrapPtr nullPtr
    castWrappedPtr  :: p a -> p b
    castWrappedPtr = wrapPtr . castPtr . unwrapPtr

instance WrappedPtr Foreign.Ptr.Ptr where
    wrapPtr         = id
    unwrapPtr       = id
    nullWrappedPtr  = nullPtr
    castWrappedPtr  = castPtr

-- * Input pointers

-- |In by-ref parameter; memory is allocated and freed by caller
newtype In       a = In       (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

-- |In by-ref array; memory is allocated and freed by caller
newtype InArray  a = InArray  (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

withIn :: (Storable a, MonadPeelIO m) => a -> (In a -> m b) -> m b
withIn x f = liftIOOp (with x) (f . In)

withInList :: (Storable a, MonadPeelIO m) => [a] -> (InArray a -> m b) -> m b
withInList xs f = liftIOOp (withArray xs) (f . InArray)

withInVector :: (Storable a, MonadPeelIO m) => SV.Vector a -> (InArray a -> m b) -> m b
withInVector vec f = liftIOOp (SV.unsafeWith vec) (f . InArray)

withInMVector :: (Storable a, MonadPeelIO m) => SVM.IOVector a -> (InArray a -> m b) -> m b
withInMVector vec f = liftIOOp (SVM.unsafeWith vec) (f . InArray)

-- * Output pointers

-- |Out by-ref parameter; memory is allocated and freed by caller
newtype Out      a = Out      (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

-- |Out by-ref array; length is specified by caller, memory is allocated
-- and freed by caller
newtype OutArray a = OutArray (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

withOut :: (Storable a, MonadPeelIO m) => (Out a -> m b) -> m (a,b)
withOut f = liftIOOp alloca $ \p -> do
    b <- f (Out p)
    a <- liftIO (peek p)
    return (a,b)

withMaybeOut :: (Storable a, MonadPeelIO m) => (Out a -> m Bool) -> m (Maybe a)
withMaybeOut f = liftIOOp alloca $ \p -> do
    success <- f (Out p)
    if success
        then do
            a <- liftIO (peek p)
            return (Just a)
        else return Nothing

withOut_ :: (Storable a, MonadPeelIO m) => (Out a -> m b) -> m a
withOut_ f = liftIOOp alloca $ \p -> do
    f (Out p)
    liftIO (peek p)

withOutMVector :: (Storable a, MonadPeelIO m) => SVM.IOVector a -> (Int -> OutArray a -> m b) -> m b
withOutMVector vec f = do
    liftIOOp (SVM.unsafeWith vec) (f (SVM.length vec) . OutArray)

withOutVector :: (Storable a, MonadPeelIO m) => Int -> (OutArray a -> m b) -> m (SV.Vector a, b)
withOutVector n f = do
    p <- liftIO (mallocForeignPtrArray n)
    b <- liftIOOp (withForeignPtr p) (f . OutArray)
    return (SV.unsafeFromForeignPtr p 0 n, b)

withOutVector_ :: (Storable a, MonadPeelIO m) => Int -> (OutArray a -> m b) -> m (SV.Vector a)
withOutVector_ n f = do
    p <- liftIO (mallocForeignPtrArray n)
    b <- liftIOOp (withForeignPtr p) (f . OutArray)
    return (SV.unsafeFromForeignPtr p 0 n)

withOutVector' :: (Storable a, MonadPeelIO m) => Int -> (OutArray a -> m Int) -> m (SV.Vector a)
withOutVector' sz f = do
    p <- liftIO (mallocForeignPtrArray sz)
    n <- liftIOOp (withForeignPtr p) (f . OutArray)
    return (SV.unsafeFromForeignPtr p 0 n)

withOutList :: (Storable a, MonadIO m) => Int -> (OutArray a -> m b) -> m ([a],b)
withOutList n f = do
    p <- liftIO (mallocArray n)
    b <- f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return (a, b)

withOutList_ :: (Storable a, MonadIO m) => Int -> (OutArray a -> m b) -> m [a]
withOutList_ n f = do
    p <- liftIO (mallocArray n)
    f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return a

withOutList' :: (Storable a, MonadIO m) => Int -> (OutArray a -> m Int) -> m ([a], Int)
withOutList' sz f = do
    p <- liftIO (mallocArray sz)
    n <- f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return (a, n)

-- | @withOutList0 zero n f@: allocate an array large enough to hold @n@ elements,
-- plus one extra spot for a terminator.  Calls @f@ with that buffer, which is
-- expected to fill it with up to @n@ elements, followed by @zero@.  The 
-- elements are then read out into a list.
withOutList0 :: (Storable a, Eq a, MonadIO m) => a -> Int -> (OutArray a -> m b) -> m ([a], b)
withOutList0 zero n f = do
    p <- liftIO (mallocArray0 n)
    b <- f (OutArray p)
    a <- liftIO (peekArray0 zero p)
    liftIO (free p)
    return (a, b)

-- * Bidirectional pointers

-- |In-out parameter.  Memory is allocated and freed by caller.
newtype InOut    a = InOut    (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

newtype InOutArray a = InOutArray (Ptr a) deriving (Eq, Ord, Show, Storable, WrappedPtr)

withInOut :: (Storable a, MonadPeelIO m) => a -> (InOut a -> m b) -> m (a,b)
withInOut a f = liftIOOp alloca $ \p -> do
    liftIO (poke p a)
    b <- f (InOut p)
    a <- liftIO (peek p)
    return (a,b)

withInOut_ :: (Storable a, MonadPeelIO m) => a -> (InOut a -> m b) -> m a
withInOut_ a f = liftIOOp alloca $ \p -> do
    liftIO (poke p a)
    f (InOut p)
    liftIO (peek p)

withInOutList :: (Storable a, MonadIO m) => Int -> [a] -> (InOutArray a -> m (Int, b)) -> m ([a], b)
withInOutList sz xs f = do
    p <- liftIO (mallocArray sz)
    liftIO $ sequence_
        [ pokeElemOff p i x
        | (i,x) <- zip [0..] (take sz xs)
        ]
    
    (n, y) <- f (InOutArray p)
    
    xs' <- liftIO $ sequence
        [ peekElemOff p i
        | i <- [0..n-1]
        ]
    
    return (xs', y)

withInOutList_ :: (Storable a, MonadIO m) => Int -> [a] -> (InOutArray a -> m Int) -> m [a]
withInOutList_ sz xs f = do
    p <- liftIO (mallocArray sz)
    liftIO $ sequence_
        [ pokeElemOff p i x
        | (i,x) <- zip [0..] (take sz xs)
        ]
    
    n <- f (InOutArray p)
    
    liftIO $ sequence
        [ peekElemOff p i
        | i <- [0..n-1]
        ]
