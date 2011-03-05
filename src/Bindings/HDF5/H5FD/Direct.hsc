#include <bindings.h>
#include <H5FDcore.h>

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

#num MBOUNDARY_DEF
#num FBSIZE_DEF
#num CBSIZE_DEF

-- hid_t H5FD_direct_init(void);
#ccall H5FD_direct_init, IO <hid_t>

-- void H5FD_direct_term(void);
#ccall H5FD_direct_term, IO ()

-- herr_t H5Pset_fapl_direct(hid_t fapl_id, size_t alignment, size_t block_size,
--  	size_t cbuf_size);
#ccall H5Pset_fapl_direct, <hid_t> -> <size_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_fapl_direct(hid_t fapl_id, size_t *boundary/*out*/,
--  	size_t *block_size/*out*/, size_t *cbuf_size/*out*/);
#ccall H5Pget_fapl_direct, <hid_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

#endif /* H5_HAVE_DIRECT */
