{-

This example shows how to create and extend an unlimited dataset.

The program first writes integers to a dataset with dataspace
dimensions of DIM0xDIM1, then closes the file.  Next, it reopens the
file, reads back the data, outputs it to the screen, extends the
dataset, and writes new data to the extended portions of the dataset.
Finally it reopens the file again, reads back the data, and outputs it
to the screen.

This file is intended for use with HDF5 Library version 1.8

-}

import Bindings.HDF5.Raw.H5F
import Bindings.HDF5.Raw.H5G
import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5S
import Bindings.HDF5.Raw.H5D
import Bindings.HDF5.Raw.H5P
import Bindings.HDF5.Raw.H5T
import Bindings.HDF5.Raw.H5
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr.Conventions
import Foreign.Ptr
import Foreign.Marshal.Alloc
import Foreign.Marshal.Array
import Data.Int

filename = "h5ex_d_unlimadd.h5"
dataset = "DS1"
dim0 = 4
dim1 = 7
edim0 = 6
edim1 = 10
chunk0 = 4
chunk1 = 4

{-

Some things of interest

using CInt and HDF - NATIVE should always do the right thing.

NULL can be used as an argument for a lot of functions in place of a
pointer to data.  Using nullPtr will not work, it will need to be
wrapped with an InArray typecast, e.g.

(InArray nullPtr)

-}

main = do
  -- Initialize data.

  let wdata = [ i * j - j | i <- [0..dim0-1], j <- [0..dim1-1]] :: [CInt]
  putStrLn "dim0, dim1"
  putStrLn $ show dim0 ++ " " ++ show dim1
  putStrLn "wdata"
  putStrLn $ show wdata

  -- Create a new file using the default properties.
          
  file <- withCString filename (\filename' -> h5f_create filename' h5f_ACC_TRUNC h5p_DEFAULT h5p_DEFAULT)

  -- Create dataspace with unlimited dimensions.

  -- notice annoying conversion from Integral to Word64, otherwise
  -- typecast to HSize_t fails

  space <- withInArray [h5s_UNLIMITED, h5s_UNLIMITED ] (\maxdims -> withInArray [HSize_t (fromIntegral dim0), HSize_t (fromIntegral dim1)] (\dims -> h5s_create_simple 2 dims maxdims))

  -- Create the dataset creation property list, and set the chunk
  -- size.

  putStrLn $ "chunk0,chunk1 " ++ show chunk0 ++ "," ++ show chunk1
  dcpl <- h5p_create h5p_DATASET_CREATE
  status <- withInArray [ chunk0, chunk1 ] (\chunk -> h5p_set_chunk dcpl 2 chunk)

  -- Create the unlimited dataset.

  dset <- withCString dataset (\dataset -> h5d_create2 file dataset h5t_NATIVE_INT space h5p_DEFAULT dcpl h5p_DEFAULT)

  -- Write the data to the dataset.

  status <- withInArray wdata (\wdata' -> h5d_write dset h5t_NATIVE_INT h5s_ALL h5s_ALL h5p_DEFAULT wdata')

  -- Close and release resources.

  status <- h5p_close dcpl
  status <- h5d_close dset
  status <- h5s_close space
  status <- h5f_close file

  -- In this next section we read back the data, extend the dataset,
  -- and write new data to the extended portions.

  -- Open file and dataset using the default properties.

  file <- withCString filename (\file -> h5f_open file h5f_ACC_RDWR h5p_DEFAULT)
  dset <- withCString dataset (\dataset -> h5d_open2 file dataset h5p_DEFAULT)

  -- Get dataspace and allocate memory for read buffer.  This is a
  -- two dimensional dataset so the dynamic allocation must be done
  -- in steps.

  space <- h5d_get_space dset

  (ndims, dims) <- withOutArray 2 $ \a1 -> withOutArray 2 $ \a2 -> h5s_get_simple_extent_dims space a1 a2

  let n = (dims !! 0) * (dims !! 1)

  putStrLn $ "n = " ++ show n

  -- Read the data using the default properties.

  (err_code, rdata) <- withOutArray (fromIntegral n) $ \a1 -> h5d_read dset h5t_NATIVE_INT h5s_ALL h5s_ALL h5p_DEFAULT (a1 :: OutArray CInt)

  -- Output the data to the screen.

  putStrLn  "Dataset before extension:\n"
  putStrLn $ show rdata

  status <- h5s_close (space)

  -- Extend the dataset.

  status <- withInArray [ edim0, edim1 ] (\extdims -> h5d_set_extent dset extdims)
    
  -- Retrieve the dataspace for the newly extended dataset.

  space <- h5d_get_space dset

  -- Initialize data for writing to the extended dataset.

  let wdata2 = [ j | i <- [0..fromIntegral(edim0)-1], j <- [0..fromIntegral(edim1)-1]] :: [CInt]

  putStrLn "wdata2"
  putStrLn $ show wdata2

  -- Select the entire dataspace.

  status <- h5s_select_all space
              
  -- Subtract a hyperslab reflecting the original dimensions from the
  -- selection.  The selection now contains only the newly extended
  -- portions of the dataset.

  status <- do _start <- newArray [0, 0]
               let start = InArray _start
               _count <- newArray [dims !! 0, dims !! 1]
               let count = InArray _count
               h5s_select_hyperslab space h5s_SELECT_NOTB start (InArray nullPtr) count (InArray nullPtr)

  -- Write the data to the selected portion of the dataset.

  status <- withInArray wdata2 (\wdata2' -> h5d_write dset h5t_NATIVE_INT h5s_ALL space h5p_DEFAULT wdata2')

  -- Close and release resources.

  status <- h5d_close (dset)
  status <- h5s_close (space)
  status <- h5f_close (file)

  -- Now we simply read back the data and output it to the screen.

  -- Open file and dataset using the default properties.

  file <- withCString filename (\file -> h5f_open file h5f_ACC_RDONLY h5p_DEFAULT)
  dset <- withCString dataset (\dataset -> h5d_open2 file dataset h5p_DEFAULT)

  -- Get dataspace and allocate memory for the read buffer as before.

  space <- h5d_get_space dset

  (ndims, dims) <- withOutArray 2 $ \a1 -> withOutArray 2 $ \a2 -> h5s_get_simple_extent_dims space a1 a2

  let n = (dims !! 0) * (dims !! 1)

  putStrLn $ "n : " ++ show n

  -- Read the data using the default properties.

  (err_code, rdata) <- withOutArray (fromIntegral n) $ \a1 -> h5d_read dset h5t_NATIVE_INT h5s_ALL h5s_ALL h5p_DEFAULT (a1 :: OutArray CInt)

  -- Output the data to the screen.

  putStrLn "\nDataset after extension:\n"
  putStrLn $ show rdata

  -- Close and release resources.

  status <- h5d_close (dset)
  status <- h5s_close (space)
  status <- h5f_close (file)

  return ()
