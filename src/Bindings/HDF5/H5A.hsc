#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.H5A where
#strict_import

import Bindings.HDF5.H5

import Bindings.HDF5.H5I -- IDs
import Bindings.HDF5.H5O -- Object Headers
import Bindings.HDF5.H5T -- Datatypes

import Foreign.Ptr.Conventions

#starttype H5A_info_t
#field corder_valid,    <hbool_t>
#field corder,          <H5O_msg_crt_idx_t>
#field cset,            <H5T_cset_t>
#field data_size,       <hsize_t>
#stoptype

type H5A_operator2_t a = FunPtr (HId_t -> CString -> In H5A_info_t -> InOut a -> IO HErr_t)

-- /* Public function prototypes */
-- hid_t   H5Acreate2(hid_t loc_id, const char *attr_name, hid_t type_id,
--     hid_t space_id, hid_t acpl_id, hid_t aapl_id);
#ccall H5Acreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t   H5Acreate_by_name(hid_t loc_id, const char *obj_name, const char *attr_name,
--     hid_t type_id, hid_t space_id, hid_t acpl_id, hid_t aapl_id, hid_t lapl_id);
#ccall H5Acreate_by_name, <hid_t> -> CString -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t   H5Aopen(hid_t obj_id, const char *attr_name, hid_t aapl_id);
#ccall H5Aopen, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- hid_t   H5Aopen_by_name(hid_t loc_id, const char *obj_name,
--     const char *attr_name, hid_t aapl_id, hid_t lapl_id);
#ccall H5Aopen_by_name, <hid_t> -> CString -> CString -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t   H5Aopen_by_idx(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t aapl_id,
--     hid_t lapl_id);
#ccall H5Aopen_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- herr_t  H5Awrite(hid_t attr_id, hid_t type_id, const void *buf);
#ccall H5Awrite, <hid_t> -> <hid_t> -> InArray a -> IO <herr_t>

-- herr_t  H5Aread(hid_t attr_id, hid_t type_id, void *buf);
#ccall H5Aread, <hid_t> -> <hid_t> -> OutArray a -> IO <herr_t>

-- herr_t  H5Aclose(hid_t attr_id);
#ccall H5Aclose, <hid_t> -> IO <herr_t>

-- hid_t   H5Aget_space(hid_t attr_id);
#ccall H5Aget_space, <hid_t> -> IO <hid_t>

-- hid_t   H5Aget_type(hid_t attr_id);
#ccall H5Aget_type, <hid_t> -> IO <hid_t>

-- hid_t   H5Aget_create_plist(hid_t attr_id);
#ccall H5Aget_create_plist, <hid_t> -> IO <hid_t>

-- TODO: check semantics of returned strings (null terminated and/or returns size?)
-- ssize_t H5Aget_name(hid_t attr_id, size_t buf_size, char *buf);
#ccall H5Aget_name, <hid_t> -> <size_t> -> Out0 CChar -> IO <ssize_t>

-- ssize_t H5Aget_name_by_idx(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
--     char *name /*out*/, size_t size, hid_t lapl_id);
#ccall H5Aget_name_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out0 CChar -> <size_t> -> <hid_t> -> IO <ssize_t>

-- hsize_t H5Aget_storage_size(hid_t attr_id);
#ccall H5Aget_storage_size, <hid_t> -> IO <hsize_t>

-- herr_t  H5Aget_info(hid_t attr_id, H5A_info_t *ainfo /*out*/);
#ccall H5Aget_info, <hid_t> -> Out <H5A_info_t> -> IO <herr_t>

-- herr_t  H5Aget_info_by_name(hid_t loc_id, const char *obj_name,
--     const char *attr_name, H5A_info_t *ainfo /*out*/, hid_t lapl_id);
#ccall H5Aget_info_by_name, <hid_t> -> CString -> CString -> Out H5A_info_t -> <hid_t> -> IO <herr_t>

-- herr_t  H5Aget_info_by_idx(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
--     H5A_info_t *ainfo /*out*/, hid_t lapl_id);
#ccall H5Aget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5A_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t  H5Arename(hid_t loc_id, const char *old_name, const char *new_name);
#ccall H5Arename, <hid_t> -> CString -> CString -> IO <herr_t>

-- herr_t  H5Arename_by_name(hid_t loc_id, const char *obj_name,
--     const char *old_attr_name, const char *new_attr_name, hid_t lapl_id);
#ccall H5Arename_by_name, <hid_t> -> CString -> CString -> CString -> <hid_t> -> IO <herr_t>

-- herr_t  H5Aiterate2(hid_t loc_id, H5_index_t idx_type,
--     H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data);
#ccall H5Aiterate2, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> Ptr <hsize_t> -> H5A_operator2_t a -> Ptr a -> IO <herr_t>

-- herr_t  H5Aiterate_by_name(hid_t loc_id, const char *obj_name, H5_index_t idx_type,
--     H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data,
--     hid_t lapd_id);
#ccall H5Aiterate_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> Ptr <hsize_t> -> H5A_operator2_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- herr_t  H5Adelete(hid_t loc_id, const char *name);
#ccall H5Adelete, <hid_t> -> CString -> IO <herr_t>

-- herr_t  H5Adelete_by_name(hid_t loc_id, const char *obj_name,
--     const char *attr_name, hid_t lapl_id);
#ccall H5Adelete_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <herr_t>

-- herr_t  H5Adelete_by_idx(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Adelete_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- htri_t H5Aexists(hid_t obj_id, const char *attr_name);
#ccall H5Aexists, <hid_t> -> CString -> IO <htri_t>

-- htri_t H5Aexists_by_name(hid_t obj_id, const char *obj_name,
--     const char *attr_name, hid_t lapl_id);
#ccall H5Aexists_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <htri_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS
-- /* Macros */
-- 
-- 
-- /* Typedefs */
-- 
-- /* Typedef for H5Aiterate1() callbacks */
-- typedef herr_t (*H5A_operator1_t)(hid_t location_id/*in*/,
--     const char *attr_name/*in*/, void *operator_data/*in,out*/);
type H5A_operator1_t a = FunPtr (HId_t -> CString -> InOut a -> IO HErr_t)

-- 
-- 
-- /* Function prototypes */
-- hid_t   H5Acreate1(hid_t loc_id, const char *name, hid_t type_id,
--     hid_t space_id, hid_t acpl_id);
#ccall H5Acreate1, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t   H5Aopen_name(hid_t loc_id, const char *name);
#ccall H5Aopen_name, <hid_t> -> CString -> IO <hid_t>

-- hid_t   H5Aopen_idx(hid_t loc_id, unsigned idx);
#ccall H5Aopen_idx, <hid_t> -> CUInt -> IO <hid_t>

-- int     H5Aget_num_attrs(hid_t loc_id);
#ccall H5Aget_num_attrs, <hid_t> -> IO CInt

-- herr_t  H5Aiterate1(hid_t loc_id, unsigned *attr_num, H5A_operator1_t op,
--     void *op_data);
#ccall H5Aiterate1, <hid_t> -> Ptr CUInt -> H5A_operator1_t a -> Ptr a -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
