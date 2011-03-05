#include <bindings.h>
#include <H5FDfamily.h>

module Bindings.HDF5.H5FD.Family where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_FAMILY"
    = unsafePerformIO (#mangle_ident "H5FD_family_init")

-- hid_t H5FD_family_init(void);
#ccall H5FD_family_init, IO <hid_t>

-- void H5FD_family_term(void);
#ccall H5FD_family_term, IO ()

-- herr_t H5Pset_fapl_family(hid_t fapl_id, hsize_t memb_size,
--  	  hid_t memb_fapl_id);
#ccall H5Pset_fapl_family, <hid_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Pget_fapl_family(hid_t fapl_id, hsize_t *memb_size/*out*/,
--  	  hid_t *memb_fapl_id/*out*/);
#ccall H5Pget_fapl_family, <hid_t> -> Out <hsize_t> -> Out <hid_t> -> IO <herr_t>

