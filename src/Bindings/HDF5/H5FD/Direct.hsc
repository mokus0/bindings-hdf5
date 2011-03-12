#include <bindings.h>
#include <H5FDcore.h>

-- |The Direct I/O file driver forces the data to be written to
-- the file directly without being copied into system kernel
-- buffer.  The main system supporting this feature is Linux.
module Bindings.HDF5.H5FD.Direct where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_DIRECT"
#ifdef H5_HAVE_DIRECT
    = unsafePerformIO (#mangle_ident "H5FD_direct_init")
#else
    = (#mangle_datacon "hid_t") (-1)
#endif /* H5_HAVE_DIRECT */

#ifdef H5_HAVE_DIRECT

-- |Default value for memory boundary.  This can be changed via 'h5p_set_fapl_direct'.
#num MBOUNDARY_DEF

-- |Default value for file block size.  This can be changed via 'h5p_set_fapl_direct'.
#num FBSIZE_DEF

-- |Default value for maximal copy buffer size.  This can be changed via 'h5p_set_fapl_direct'.
#num CBSIZE_DEF

-- |Initialize this driver by registering the driver with the library.
-- 
-- > hid_t H5FD_direct_init(void);
#ccall H5FD_direct_init, IO <hid_t>

-- |Shut down the VFD.
-- 
-- > void H5FD_direct_term(void);
#ccall H5FD_direct_term, IO ()

-- TODO: evaluate the claim that "There are no driver-specific properties."  It appears to be patently false.
-- |Modify the file access property list to use the H5FD_DIRECT
-- driver.  There are no driver-specific properties.
--
-- > herr_t H5Pset_fapl_direct(hid_t fapl_id, size_t alignment, size_t block_size,
-- >        size_t cbuf_size);
#ccall H5Pset_fapl_direct, <hid_t> -> <size_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- |Returns information about the direct file access property
-- list though the function arguments.
--
-- > herr_t H5Pget_fapl_direct(hid_t fapl_id, size_t *boundary/*out*/,
-- >        size_t *block_size/*out*/, size_t *cbuf_size/*out*/);
#ccall H5Pget_fapl_direct, <hid_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

#endif /* H5_HAVE_DIRECT */
