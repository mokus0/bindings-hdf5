{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Foreign.Ptr.Conventions where

-- TODO: make these all exception-safe

import Foreign.Marshal
import Foreign.Ptr
import Foreign.Storable

import Control.Monad.IO.Class
import Control.Monad.IO.Peel

-- various common data-passing conventions

-- |In by-ref parameter; memory is allocated and freed by caller
newtype In       a = In       (Ptr a) deriving (Eq, Ord, Show, Storable)

-- |In by-ref array; memory is allocated and freed by caller
newtype InArray  a = InArray  (Ptr a) deriving (Eq, Ord, Show, Storable)

-- |Out by-ref parameter; memory is allocated and freed by caller
newtype Out      a = Out      (Ptr a) deriving (Eq, Ord, Show, Storable)

-- |Out by-ref array; length is specified by caller, memory is allocated
-- and freed by caller
newtype OutArray a = OutArray (Ptr a) deriving (Eq, Ord, Show, Storable)

-- |In-out parameter.  Memory is allocated and freed by caller.
newtype InOut    a = InOut    (Ptr a) deriving (Eq, Ord, Show, Storable)

newtype InOutArray a = InOutArray (Ptr a) deriving (Eq, Ord, Show, Storable)

withIn :: (Storable a, MonadPeelIO m) => a -> (In a -> m b) -> m b
withIn x f = liftIOOp (with x) (f . In)

withInArray :: (Storable a, MonadPeelIO m) => [a] -> (InArray a -> m b) -> m b
withInArray xs f = liftIOOp (withArray xs) (f . InArray)

withOut :: (Storable a, MonadPeelIO m) => (Out a -> m b) -> m (b,a)
withOut f = liftIOOp alloca $ \p -> do
    b <- f (Out p)
    a <- liftIO (peek p)
    return (b,a)

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

withOutArray :: (Storable a, MonadIO m) => Int -> (OutArray a -> m b) -> m (b,[a])
withOutArray n f = do
    p <- liftIO (mallocArray n)
    b <- f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return (b,a)

withOutArray' :: (Storable a, MonadIO m) => Int -> (OutArray a -> m Int) -> m (Int, [a])
withOutArray' sz f = do
    p <- liftIO (mallocArray sz)
    n <- f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return (n, a)

withOutArray_ :: (Storable a, MonadIO m) => Int -> (OutArray a -> m b) -> m [a]
withOutArray_ n f = do
    p <- liftIO (mallocArray n)
    f (OutArray p)
    a <- liftIO (peekArray n p)
    liftIO (free p)
    return a

-- | @withOut0 zero n f@: allocate an array large enough to hold @n@ elements,
-- plus one extra spot for a terminator.  Calls @f@ with that buffer, which is
-- expected to fill it with up to @n@ elements, followed by @zero@.  The 
-- elements are then read out into a list.
withOut0 :: (Storable a, Eq a, MonadIO m) => a -> Int -> (OutArray a -> m b) -> m (b,[a])
withOut0 zero n f = do
    p <- liftIO (mallocArray0 n)
    b <- f (OutArray p)
    a <- liftIO (peekArray0 zero p)
    liftIO (free p)
    return (b,a)

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

withInOutArray :: (Storable a, MonadIO m) => Int -> [a] -> (InOutArray a -> m (Int, b)) -> m ([a], b)
withInOutArray sz xs f = do
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

withInOutArray_ :: (Storable a, MonadIO m) => Int -> [a] -> (InOutArray a -> m Int) -> m [a]
withInOutArray_ sz xs f = do
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
