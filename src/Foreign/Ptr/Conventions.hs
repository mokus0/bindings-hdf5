module Foreign.Ptr.Conventions where

import Foreign.Marshal
import Foreign.Ptr
import Foreign.Storable

import Control.Monad.IO.Class
import Control.Monad.IO.Peel

-- various common data-passing conventions

-- |In by-ref parameter; memory is allocated and freed by caller
newtype In       a = In       (Ptr a) deriving (Eq, Ord, Show)

-- |In by-ref array; memory is allocated and freed by caller
newtype InArray  a = InArray  (Ptr a) deriving (Eq, Ord, Show)

-- |Out by-ref parameter; memory is allocated and freed by caller
newtype Out      a = Out      (Ptr a) deriving (Eq, Ord, Show)

-- |Out by-ref array; length is specified by caller, memory is allocated
-- and freed by caller
newtype OutArray a = OutArray (Ptr a) deriving (Eq, Ord, Show)

-- |Out by-ref zero-terminated array.  Memory is not allocated or freed
-- by caller.
newtype Out0     a = Out0     (Ptr a) deriving (Eq, Ord, Show)

-- |In-out parameter.  Memory is allocated and freed by caller.
newtype InOut    a = InOut    (Ptr a) deriving (Eq, Ord, Show)

withIn :: (Storable a, MonadPeelIO m) => a -> (In a -> m b) -> m b
withIn x f = liftIOOp (with x) (f . In)

withInArray :: (Storable a, MonadPeelIO m) => [a] -> (InArray a -> m b) -> m b
withInArray xs f = liftIOOp (withArray xs) (f . InArray)

withOut :: (Storable a, MonadPeelIO m) => (Out a -> m b) -> m (b,a)
withOut f = liftIOOp alloca $ \p -> do
    b <- f (Out p)
    a <- liftIO (peek p)
    return (b,a)

withOut_ :: (Storable a, MonadPeelIO m) => (Out a -> m b) -> m a
withOut_ f = liftIOOp alloca $ \p -> do
    f (Out p)
    liftIO (peek p)

withOutArray :: (Storable a, MonadPeelIO m) => Int -> (Out a -> m b) -> m (b,[a])
withOutArray n f = do
    p <- liftIO (mallocArray n)
    b <- f (Out p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return (b,a)

withOutArray_ :: (Storable a, MonadPeelIO m) => Int -> (Out a -> m b) -> m [a]
withOutArray_ n f = do
    p <- liftIO (mallocArray n)
    f (Out p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return a

withOut0 :: (Storable a, Eq a, MonadPeelIO m) => a -> (Out a -> m b) -> m (b,[a])
withOut0 zero f = liftIOOp alloca $ \p -> do
    b <- f (Out p)
    a <- liftIO (peekArray0 zero p)
    return (b,a)

withOut0_ :: (Storable a, Eq a, MonadPeelIO m) => a -> (Out a -> m b) -> m [a]
withOut0_ zero f = liftIOOp alloca $ \p -> do
    f (Out p)
    liftIO (peekArray0 zero p)

withInOut :: (Storable a, MonadPeelIO m) => a -> (InOut a -> m b) -> m (b,a)
withInOut a f = liftIOOp alloca $ \p -> do
    liftIO (poke p a)
    b <- f (InOut p)
    a <- liftIO (peek p)
    return (b,a)

withInOut_ :: (Storable a, MonadPeelIO m) => a -> (InOut a -> m b) -> m a
withInOut_ a f = liftIOOp alloca $ \p -> do
    liftIO (poke p a)
    f (InOut p)
    liftIO (peek p)

