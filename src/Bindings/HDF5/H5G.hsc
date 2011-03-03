#include <bindings.h>
#include <H5Gpublic.h>

module Bindings.HDF5.H5G where
#strict_import

import Bindings.HDF5.H5

import Bindings.HDF5.H5I
import Bindings.HDF5.H5L
import Bindings.HDF5.H5O
import Bindings.HDF5.H5T

import Foreign.Ptr.Conventions

-- /* Types of link storage for groups */
#newtype H5G_storage_type_t
    deriving Eq
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_UNKNOWN
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_SYMBOL_TABLE
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_COMPACT
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_DENSE

-- /* Information struct for group (for H5Gget_info/H5Gget_info_by_name/H5Gget_info_by_idx) */
#starttype H5G_info_t
#field storage_type,    <H5G_storage_type_t>
#field nlinks,          <hsize_t>
#field max_corder,      Int64
#field mounted,         <hbool_t>
#stoptype

-- hid_t H5Gcreate2(hid_t loc_id, const char *name, hid_t lcpl_id,
--     hid_t gcpl_id, hid_t gapl_id);
#ccall H5Gcreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t H5Gcreate_anon(hid_t loc_id, hid_t gcpl_id, hid_t gapl_id);
#ccall H5Gcreate_anon, <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t H5Gopen2(hid_t loc_id, const char *name, hid_t gapl_id);
#ccall H5Gopen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- hid_t H5Gget_create_plist(hid_t group_id);
#ccall H5Gget_create_plist, <hid_t> -> IO <hid_t>

-- herr_t H5Gget_info(hid_t loc_id, H5G_info_t *ginfo);
#ccall H5Gget_info, <hid_t> -> Out <H5G_info_t> -> IO <herr_t>

-- herr_t H5Gget_info_by_name(hid_t loc_id, const char *name, H5G_info_t *ginfo,
--     hid_t lapl_id);
#ccall H5Gget_info_by_name, <hid_t> -> CString -> Out <H5G_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Gget_info_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5G_info_t *ginfo,
--     hid_t lapl_id);
#ccall H5Gget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5G_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Gclose(hid_t group_id);
#ccall H5Gclose, <hid_t> -> IO <herr_t>


#ifndef H5_NO_DEPRECATED_SYMBOLS

-- /* Macros */

-- /* Link definitions */
#num H5G_SAME_LOC
#newtype_const H5L_type_t, H5G_LINK_ERROR
#newtype_const H5L_type_t, H5G_LINK_HARD
#newtype_const H5L_type_t, H5G_LINK_SOFT
type H5G_link_t = H5L_type_t

-- /* Macros for types of objects in a group (see H5G_obj_t definition) */
#num H5G_NTYPES
#num H5G_NLIBTYPES
#num H5G_NUSERTYPES
#cinline H5G_USERTYPE, <H5G_obj_t> -> <H5G_obj_t>

-- /* Typedefs */
-- 
-- /*
--  * An object has a certain type. The first few numbers are reserved for use
--  * internally by HDF5. Users may add their own types with higher values.  The
--  * values are never stored in the file -- they only exist while an
--  * application is running.  An object may satisfy the `isa' function for more
--  * than one type.
--  */
#newtype H5G_obj_t
    deriving Eq
#newtype_const H5G_obj_t, H5G_UNKNOWN
#newtype_const H5G_obj_t, H5G_GROUP
#newtype_const H5G_obj_t, H5G_DATASET
#newtype_const H5G_obj_t, H5G_TYPE
#newtype_const H5G_obj_t, H5G_LINK
#newtype_const H5G_obj_t, H5G_UDLINK
#newtype_const H5G_obj_t, H5G_RESERVED_5
#newtype_const H5G_obj_t, H5G_RESERVED_6
#newtype_const H5G_obj_t, H5G_RESERVED_7

-- /* Prototype for H5Giterate() operator */
-- typedef herr_t (*H5G_iterate_t)(hid_t group, const char *name, void *op_data);
type H5G_iterate_t a = FunPtr (HId_t -> CString -> Ptr a -> IO HErr_t)

-- /* Information about an object */
#starttype H5G_stat_t
#array_field fileno,    CULong
#array_field objno,     CULong
#field nlink,           CUInt
#field type,            <H5G_obj_t>
#field mtime,           <time_t>
#field linklen,         <size_t>
#field ohdr,            <H5O_stat_t>
#stoptype

-- /* Function prototypes */
-- hid_t H5Gcreate1(hid_t loc_id, const char *name, size_t size_hint);
#ccall H5Gcreate1, <hid_t> -> CString -> <size_t> -> IO <hid_t>

-- hid_t H5Gopen1(hid_t loc_id, const char *name);
#ccall H5Gopen1, <hid_t> -> CString -> IO <hid_t>

-- herr_t H5Glink(hid_t cur_loc_id, H5G_link_t type, const char *cur_name,
--     const char *new_name);
#ccall H5Glink, <hid_t> -> <H5G_link_t> -> CString -> CString -> IO <herr_t>

-- herr_t H5Glink2(hid_t cur_loc_id, const char *cur_name, H5G_link_t type,
--     hid_t new_loc_id, const char *new_name);
#ccall H5Glink2, <hid_t> -> CString -> <H5G_link_t> -> <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Gmove(hid_t src_loc_id, const char *src_name,
--     const char *dst_name);
#ccall H5Gmove, <hid_t> -> CString -> CString -> IO <herr_t>

-- herr_t H5Gmove2(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
--     const char *dst_name);
#ccall H5Gmove2, <hid_t> -> CString -> <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Gunlink(hid_t loc_id, const char *name);
#ccall H5Gunlink, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Gget_linkval(hid_t loc_id, const char *name, size_t size,
--     char *buf/*out*/);
#ccall H5Gget_linkval, <hid_t> -> CString -> <size_t> -> OutArray a -> IO <herr_t>

-- herr_t H5Gset_comment(hid_t loc_id, const char *name, const char *comment);
#ccall H5Gset_comment, <hid_t> -> CString -> CString -> IO <herr_t>

-- int H5Gget_comment(hid_t loc_id, const char *name, size_t bufsize,
--     char *buf);
#ccall H5Gget_comment, <hid_t> -> CString -> <size_t> -> OutArray CChar -> IO CInt

-- herr_t H5Giterate(hid_t loc_id, const char *name, int *idx,
--         H5G_iterate_t op, void *op_data);
#ccall H5Giterate, <hid_t> -> CString -> Ptr CInt -> H5G_iterate_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Gget_num_objs(hid_t loc_id, hsize_t *num_objs);
#ccall H5Gget_num_objs, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Gget_objinfo(hid_t loc_id, const char *name,
--     hbool_t follow_link, H5G_stat_t *statbuf/*out*/);
#ccall H5Gget_objinfo, <hid_t> -> CString -> <hbool_t> -> Out <H5G_stat_t> -> IO <herr_t>

-- ssize_t H5Gget_objname_by_idx(hid_t loc_id, hsize_t idx, char* name,
--     size_t size);
#ccall H5Gget_objname_by_idx, <hid_t> -> <hsize_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- H5G_obj_t H5Gget_objtype_by_idx(hid_t loc_id, hsize_t idx);
#ccall H5Gget_objtype_by_idx, <hid_t> -> <hsize_t> -> IO <H5G_obj_t>


#endif /* H5_NO_DEPRECATED_SYMBOLS */
