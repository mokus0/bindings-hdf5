#include <bindings.h>
#include <H5FDcore.h>

module Bindings.HDF5.H5FD.Multi where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I
import Bindings.HDF5.H5P
import Bindings.HDF5.H5F
import Bindings.HDF5.H5FD

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_MULTI"
    = unsafePerformIO (#mangle_ident "H5FD_multi_init")

-- hid_t H5FD_multi_init(void);
#ccall H5FD_multi_init, IO <hid_t>

-- void H5FD_multi_term(void);
#ccall H5FD_multi_term, IO ()

-- herr_t H5Pset_fapl_multi(hid_t fapl_id, const H5FD_mem_t *memb_map,
--  	 const hid_t *memb_fapl, const char * const *memb_name,
--  	 const haddr_t *memb_addr, hbool_t relax);
#ccall H5Pset_fapl_multi, <hid_t> -> InArray <H5FD_mem_t> -> InArray <hid_t> -> InArray CString -> InArray <haddr_t> -> <hbool_t> -> IO <herr_t>

-- herr_t H5Pget_fapl_multi(hid_t fapl_id, H5FD_mem_t *memb_map/*out*/,
--  	 hid_t *memb_fapl/*out*/, char **memb_name/*out*/,
--  	 haddr_t *memb_addr/*out*/, hbool_t *relax/*out*/);
#ccall H5Pget_fapl_multi, <hid_t> -> OutArray <H5FD_mem_t> -> OutArray <hid_t> -> OutArray CString -> OutArray <haddr_t> -> Out <hbool_t> -> IO <herr_t>

-- herr_t H5Pset_dxpl_multi(hid_t dxpl_id, const hid_t *memb_dxpl);
#ccall H5Pset_dxpl_multi, <hid_t> -> InArray <hid_t> -> IO <herr_t>

-- herr_t H5Pget_dxpl_multi(hid_t dxpl_id, hid_t *memb_dxpl/*out*/);
#ccall H5Pget_dxpl_multi, <hid_t> -> OutArray <hid_t> -> IO <herr_t>

-- herr_t H5Pset_fapl_split(hid_t fapl, const char *meta_ext,
--  	 hid_t meta_plist_id, const char *raw_ext,
--  	 hid_t raw_plist_id);
#ccall H5Pset_fapl_split, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> IO <herr_t>


