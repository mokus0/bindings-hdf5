{-

  This example shows how to read and write data to a
  dataset.  The program first writes integers to a dataset
  with dataspace dimensions of DIM0xDIM1, then closes the
  file.  Next, it reopens the file, reads back the data, and
  outputs it to the screen.

  This file is intended for use with HDF5 Library version 1.8

-}

import Bindings.HDF5.H5F
import Bindings.HDF5.H5S
import Bindings.HDF5.H5D
import Bindings.HDF5.H5P
import Bindings.HDF5.H5T
import Bindings.HDF5.H5
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr.Conventions
import Foreign.Ptr
import Foreign.Marshal.Alloc
import Foreign.Marshal.Array
import Data.Int

filename = "h5ex_d_rdwr.h5"
dataset = "DS1"
dim0 = 4
dim1 = 7

main = do
    -- Initialize data.

    let wdata = [ i * j - j | i <- [0..dim0-1], j <- [0..dim1-1]] :: [CInt]
    putStrLn $ "wdata = " ++ show wdata

    -- Create a new file using the default properties.
    
    file <- withCString filename $ \file' -> h5f_create file' h5f_ACC_TRUNC h5p_DEFAULT h5p_DEFAULT

    -- Create dataspace.  Setting maximum size to NULL sets the
    -- maximum size to be the current size.

    let dims = [HSize_t (fromIntegral dim0), HSize_t (fromIntegral dim1)]
    space <- withInArray dims $ \dims' -> h5s_create_simple 2 dims' (InArray nullPtr)

    -- Create the dataset.  We will use all default properties for
    -- this example.

    dset <- withCString dataset $ \dataset' -> h5d_create2 file dataset' h5t_STD_I32LE space h5p_DEFAULT h5p_DEFAULT h5p_DEFAULT

    -- Write the data to the dataset.

    status <- withInArray wdata (\wdata' -> h5d_write dset h5t_NATIVE_INT h5s_ALL h5s_ALL h5p_DEFAULT wdata')

    -- Close and release resources.

    status <- h5d_close dset
    status <- h5s_close space
    status <- h5f_close file

    -- Now we begin the read section of this example.

    -- Open file and dataset using the default properties.

    file <- withCString filename $ \file' -> h5f_open file' h5f_ACC_RDONLY h5p_DEFAULT
    dset <- withCString dataset $ \dataset' -> h5d_open2 file dataset' h5p_DEFAULT

    -- Read the data using the default properties.

    let n = dim0 * dim1
    (err_code, rdata) <- withOutArray (fromIntegral n) $ \rdata' -> h5d_read dset h5t_NATIVE_INT h5s_ALL h5s_ALL h5p_DEFAULT (rdata' :: OutArray CInt)

    -- Output the data to the screen.

    putStrLn $ "rdata " ++ show rdata

    --  Close and release resources.

    status <- h5d_close dset
    status <- h5f_close file

    return ()