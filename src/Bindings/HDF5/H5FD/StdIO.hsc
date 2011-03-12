#include <bindings.h>
#include <H5FDcore.h>

module Bindings.HDF5.H5FD.StdIO where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_STDIO"
    = unsafePerformIO (#mangle_ident "H5FD_stdio_init")

-- |Initialize this driver by registering the driver with the library.
-- 
-- > hid_t H5FD_stdio_init(void);
#ccall H5FD_stdio_init, IO <hid_t>

-- |Shut down the VFD.
-- 
-- > void H5FD_stdio_term(void);
#ccall H5FD_stdio_term, IO ()

-- |Modify the file access property list to use the H5FD_STDIO
-- driver.  There are no driver-specific properties.
--
-- herr_t H5Pset_fapl_stdio(hid_t fapl_id);
#ccall H5Pset_fapl_stdio, <hid_t> -> IO <herr_t>

