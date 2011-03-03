#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.H5O where
#strict_import

import Bindings.HDF5.H5     -- Generic Functions
import Bindings.HDF5.H5I    -- IDs
import Bindings.HDF5.H5L    -- Links

import Foreign.Ptr.Conventions

#num H5O_COPY_SHALLOW_HIERARCHY_FLAG
#num H5O_COPY_EXPAND_SOFT_LINK_FLAG
#num H5O_COPY_EXPAND_EXT_LINK_FLAG
#num H5O_COPY_EXPAND_REFERENCE_FLAG
#num H5O_COPY_WITHOUT_ATTR_FLAG
#num H5O_COPY_PRESERVE_NULL_FLAG
#num H5O_COPY_ALL

#num H5O_SHMESG_NONE_FLAG
#num H5O_SHMESG_SDSPACE_FLAG
#num H5O_SHMESG_DTYPE_FLAG
#num H5O_SHMESG_FILL_FLAG
#num H5O_SHMESG_PLINE_FLAG
#num H5O_SHMESG_ATTR_FLAG
#num H5O_SHMESG_ALL_FLAG

#num H5O_HDR_CHUNK0_SIZE
#num H5O_HDR_ATTR_CRT_ORDER_TRACKED
#num H5O_HDR_ATTR_CRT_ORDER_INDEXED
#num H5O_HDR_ATTR_STORE_PHASE_CHANGE
#num H5O_HDR_STORE_TIMES
#num H5O_HDR_ALL_FLAGS

#num H5O_SHMESG_MAX_NINDEXES
#num H5O_SHMESG_MAX_LIST_SIZE

#newtype H5O_type_t
    deriving Eq
#newtype_const H5O_type_t, H5O_TYPE_UNKNOWN
#newtype_const H5O_type_t, H5O_TYPE_GROUP	       
#newtype_const H5O_type_t, H5O_TYPE_DATASET
#newtype_const H5O_type_t, H5O_TYPE_NAMED_DATATYPE
#num H5O_TYPE_NTYPES

#starttype H5O_hdr_info_t
#field version,         CUInt
#field nmesgs,          CUInt
#field nchunks,         CUInt
#field flags,           CUInt
#field space.total,     <hsize_t>
#field space.meta,      <hsize_t>
#field space.mesg,      <hsize_t>
#field space.free,      <hsize_t>
#field mesg.present,    Word64
#field mesg.shared,     Word64
#stoptype

#starttype H5O_info_t
#field fileno,          CULong
#field addr,            <haddr_t>
#field type,            <H5O_type_t>
#field rc,              CUInt
#field atime,           <time_t>
#field mtime,           <time_t>
#field ctime,           <time_t>
#field btime,           <time_t>
#field num_attrs,       <hsize_t>
#field hdr,             <H5O_hdr_info_t>
#field meta_size.obj,   <H5_ih_info_t>
#field meta_size.attr,  <H5_ih_info_t>
#stoptype

#newtype H5O_msg_crt_idx_t
    deriving Eq

type H5O_iterate_t a = FunPtr (HId_t -> CString -> In H5O_info_t -> Ptr a -> IO HErr_t)

-- /*********************/
-- /* Public Prototypes */
-- /*********************/
-- hid_t H5Oopen(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Oopen, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- hid_t H5Oopen_by_addr(hid_t loc_id, haddr_t addr);
#ccall H5Oopen_by_addr, <hid_t> -> <haddr_t> -> IO <hid_t>

-- hid_t H5Oopen_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Oopen_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <hid_t>

-- htri_t H5Oexists_by_name(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Oexists_by_name, <hid_t> -> CString -> <hid_t> -> IO <htri_t>

-- herr_t H5Oget_info(hid_t loc_id, H5O_info_t *oinfo);
#ccall H5Oget_info, <hid_t> -> Out <H5O_info_t> -> IO <herr_t>

-- herr_t H5Oget_info_by_name(hid_t loc_id, const char *name, H5O_info_t *oinfo,
--     hid_t lapl_id);
#ccall H5Oget_info_by_name, <hid_t> -> CString -> Out <H5O_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Oget_info_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5O_info_t *oinfo,
--     hid_t lapl_id);
#ccall H5Oget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5O_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Olink(hid_t obj_id, hid_t new_loc_id, const char *new_name,
--     hid_t lcpl_id, hid_t lapl_id);
#ccall H5Olink, <hid_t> -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Oincr_refcount(hid_t object_id);
#ccall H5Oincr_refcount, <hid_t> -> IO <herr_t>

-- herr_t H5Odecr_refcount(hid_t object_id);
#ccall H5Odecr_refcount, <hid_t> -> IO <herr_t>

-- herr_t H5Ocopy(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
--     const char *dst_name, hid_t ocpypl_id, hid_t lcpl_id);
#ccall H5Ocopy, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Oset_comment(hid_t obj_id, const char *comment);
#ccall H5Oset_comment, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Oset_comment_by_name(hid_t loc_id, const char *name,
--     const char *comment, hid_t lapl_id);
#ccall H5Oset_comment_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <herr_t>

-- ssize_t H5Oget_comment(hid_t obj_id, char *comment, size_t bufsize);
#ccall H5Oget_comment, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- ssize_t H5Oget_comment_by_name(hid_t loc_id, const char *name,
--     char *comment, size_t bufsize, hid_t lapl_id);
#ccall H5Oget_comment_by_name, <hid_t> -> CString -> OutArray CChar -> <size_t> -> <hid_t> -> IO <ssize_t>

-- herr_t H5Ovisit(hid_t obj_id, H5_index_t idx_type, H5_iter_order_t order,
--     H5O_iterate_t op, void *op_data);
#ccall H5Ovisit, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> H5O_iterate_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Ovisit_by_name(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, H5O_iterate_t op,
--     void *op_data, hid_t lapl_id);
#ccall H5Ovisit_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> H5O_iterate_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- herr_t H5Oclose(hid_t object_id);
#ccall H5Oclose, <hid_t> -> IO <herr_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS
-- 
-- /* Macros */
-- 
-- /* Typedefs */
-- 
-- /* A struct that's part of the H5G_stat_t routine (deprecated) */
#starttype H5O_stat_t
#field size,    <hsize_t>
#field free,    <hsize_t>
#field nmesgs,  CUInt
#field nchunks, CUInt
#stoptype
-- 
-- /* Function prototypes */
-- 
#endif /* H5_NO_DEPRECATED_SYMBOLS */

