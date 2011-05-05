{-

  This example shows how to read and write integer datatypes to a
dataset.  The program first writes integers to a dataset with a
dataspace of DIM0xDIM1, then closes the file.  Next, it reopens the
file, reads back the data, and outputs it to the screen.

This file is intended for use with HDF5 Library version 1.8

-}

import Bindings.HDF5.Raw.H5F
import Bindings.HDF5.Raw.H5P
import Bindings.HDF5.Raw.H5D
import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5S
import Bindings.HDF5.Raw.H5T
import Bindings.HDF5.Raw.H5
import Foreign.C.Types
-- import Foreign.Ptr
import Foreign.C.String
import Foreign.Marshal.Array
import Foreign.Ptr.Conventions

filename = "h5ex_t_float.h5"
dataset = "DS1"
dim0 = 4
dim1 = 7

main = do
  -- Initialize data to be stored.

  let wdata = [(fromIntegral i)/((fromIntegral j) + 0.5) | i <- [0..dim0-1], j <- [0..dim1-1]] :: [Double]

  -- Create a new file using the default properties.
                        
  file <- withCString filename $ \s -> h5f_create s h5f_ACC_TRUNC h5p_DEFAULT h5p_DEFAULT

  -- Create dataspace.  Setting maximum size to NULL sets the

  -- maximum size to be the current size.  For the haskell example we
  -- pass the same dims twice.

  space <- withInList [ HSize_t dim0, HSize_t dim1 ] $ \a -> h5s_create_simple 2 a a

{-

Create the dataset and write the floating point data to it.  In this
example we will save the data as 64 bit little endian IEEE floating
point numbers, regardless of the native type.  The HDF5 library
automatically converts between different floating point types.

-}

  putStrLn $ "dataset : " ++ dataset
  putStrLn $ "space : " ++ show space

  dset <- withCString dataset $ \s -> do
              h5d_create2 file s h5t_IEEE_F64LE space h5p_DEFAULT h5p_DEFAULT h5p_DEFAULT

  status <- withInList wdata $ \a -> h5d_write dset h5t_NATIVE_DOUBLE h5s_ALL h5s_ALL h5p_DEFAULT a

  -- Close and release resources.

  status <- h5d_close dset
  status <- h5s_close space
  status <- h5f_close file

{-

Now we begin the read section of this example.  Here we assume the
dataset has the same name and rank, but can have any size.  Therefore
we must allocate a new array to read in data using malloc().  

-}

  -- Open file and dataset.

  file <- withCString filename $ \s -> h5f_open s h5f_ACC_RDONLY h5p_DEFAULT
  dset <- withCString dataset $ \s -> h5d_open2 file s h5p_DEFAULT

{- 

Get dataspace and allocate memory for read buffer.  This is a two
dimensional dataset so the dynamic allocation must be done in steps.

-}

  space <- h5d_get_space dset

  (dims, ndims) <- withOutList 2 $ \a1 -> withOutList 2 $ \a2 -> h5s_get_simple_extent_dims space a1 a2

  putStrLn $ "ndims : " ++ show ndims ++ " dims : " ++ show dims

  -- Read the data.

  -- calculate the number of elements based on the dimensions read
  -- from the simple extents call.

  let n = (dims !! 0) * (dims !! 1)

  putStrLn $ "n : " ++ show n

  -- rdata <- mallocArray (fromIntegral n) :: IO (Ptr CDouble)

  -- notice the explicit typing of the return array.  Obviously it's
  -- important that it match the format of the data file.  The ideal
  -- situation is that this determination is made automagically and
  -- the appropriate tagged data is returned.

  (err_code, arr) <- withOutList (fromIntegral n) $ \a1 -> h5d_read dset h5t_NATIVE_DOUBLE h5s_ALL h5s_ALL h5p_DEFAULT (a1 :: OutArray CDouble)

  -- Output the data to the screen.

  putStrLn $ "err code : " ++ show err_code

  putStrLn $ show arr

  -- Close and release resources.

  status <- h5d_close dset
  status <- h5s_close space
  status <- h5f_close file

  return ()

