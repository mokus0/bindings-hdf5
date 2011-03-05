#include <bindings.h>
#include <H5FDcore.h>

module Bindings.HDF5.H5FD.Core where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_CORE"
    = unsafePerformIO (#mangle_ident "H5FD_core_init")

-- hid_t H5FD_core_init(void);
#ccall H5FD_core_init, IO <hid_t>

-- void H5FD_core_term(void);
#ccall H5FD_core_term, IO ()

-- herr_t H5Pset_fapl_core(hid_t fapl_id, size_t increment,
--  		hbool_t backing_store);
#ccall H5Pset_fapl_core, <hid_t> -> <size_t> -> <hbool_t> -> IO <herr_t>

-- herr_t H5Pget_fapl_core(hid_t fapl_id, size_t *increment/*out*/,
--  		hbool_t *backing_store/*out*/);
#ccall H5Pget_fapl_core, <hid_t> -> Out <size_t> -> Out <hbool_t> -> IO <herr_t>

