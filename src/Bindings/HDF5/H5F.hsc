#include <bindings.h>
#include <H5Fpublic.h>

module Bindings.HDF5.H5F where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5AC
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#num H5F_ACC_RDONLY
#num H5F_ACC_RDWR
#num H5F_ACC_TRUNC
#num H5F_ACC_EXCL
#num H5F_ACC_DEBUG
#num H5F_ACC_CREAT

#num H5F_ACC_DEFAULT

#num H5F_OBJ_FILE
#num H5F_OBJ_DATASET
#num H5F_OBJ_GROUP
#num H5F_OBJ_DATATYPE
#num H5F_OBJ_ATTR
#num H5F_OBJ_ALL
#num H5F_OBJ_LOCAL

#newtype_const hsize_t, H5F_FAMILY_DEFAULT

#ifdef H5_HAVE_PARALLEL
#str H5F_MPIO_DEBUG_KEY
#endif /* H5_HAVE_PARALLEL */

#newtype H5F_scope_t
#newtype_const H5F_scope_t, H5F_SCOPE_LOCAL
#newtype_const H5F_scope_t, H5F_SCOPE_GLOBAL

#newtype_const hsize_t, H5F_UNLIMITED

#newtype H5F_close_degree_t, Eq
#newtype_const H5F_close_degree_t, H5F_CLOSE_DEFAULT
#newtype_const H5F_close_degree_t, H5F_CLOSE_WEAK
#newtype_const H5F_close_degree_t, H5F_CLOSE_SEMI
#newtype_const H5F_close_degree_t, H5F_CLOSE_STRONG

#starttype H5F_info_t
#field super_ext_size,  <hsize_t>
#field sohm.hdr_size,   <hsize_t>
#field sohm.msgs_info,  <H5_ih_info_t>
#stoptype

#newtype H5F_mem_t, Eq
#newtype_const H5F_mem_t, H5FD_MEM_NOLIST
#newtype_const H5F_mem_t, H5FD_MEM_DEFAULT
#newtype_const H5F_mem_t, H5FD_MEM_SUPER
#newtype_const H5F_mem_t, H5FD_MEM_BTREE
#newtype_const H5F_mem_t, H5FD_MEM_DRAW
#newtype_const H5F_mem_t, H5FD_MEM_GHEAP
#newtype_const H5F_mem_t, H5FD_MEM_LHEAP
#newtype_const H5F_mem_t, H5FD_MEM_OHDR
#num H5FD_MEM_NTYPES

#newtype H5F_libver_t
#newtype_const H5F_libver_t, H5F_LIBVER_EARLIEST
#newtype_const H5F_libver_t, H5F_LIBVER_LATEST

#newtype_const H5F_libver_t, H5F_LIBVER_18

-- htri_t H5Fis_hdf5(const char *filename);
#ccall H5Fis_hdf5, CString -> IO <htri_t>

-- hid_t  H5Fcreate(const char *filename, unsigned flags,
-- 		  	  hid_t create_plist, hid_t access_plist);
#ccall H5Fcreate, CString -> CUInt -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t  H5Fopen(const char *filename, unsigned flags,
-- 		        hid_t access_plist);
#ccall H5Fopen, CString -> CUInt -> <hid_t> -> IO <hid_t>

-- hid_t  H5Freopen(hid_t file_id);
#ccall H5Freopen, <hid_t> -> IO <hid_t>

-- herr_t H5Fflush(hid_t object_id, H5F_scope_t scope);
#ccall H5Fflush, <hid_t> -> <H5F_scope_t> -> IO <herr_t>

-- herr_t H5Fclose(hid_t file_id);
#ccall H5Fclose, <hid_t> -> IO <herr_t>

-- hid_t  H5Fget_create_plist(hid_t file_id);
#ccall H5Fget_create_plist, <hid_t> -> IO <hid_t>

-- hid_t  H5Fget_access_plist(hid_t file_id);
#ccall H5Fget_access_plist, <hid_t> -> IO <hid_t>

-- herr_t H5Fget_intent(hid_t file_id, unsigned * intent);
#ccall H5Fget_intent, <hid_t> -> Out CUInt -> IO <herr_t>

-- ssize_t H5Fget_obj_count(hid_t file_id, unsigned types);
#ccall H5Fget_obj_count, <hid_t> -> CUInt -> IO <ssize_t>

-- ssize_t H5Fget_obj_ids(hid_t file_id, unsigned types, size_t max_objs, hid_t *obj_id_list);
#ccall H5Fget_obj_ids, <hid_t> -> CUInt -> <size_t> -> Ptr <hid_t>

-- herr_t H5Fget_vfd_handle(hid_t file_id, hid_t fapl, void **file_handle);
#ccall H5Fget_vfd_handle, <hid_t> -> <hid_t> -> Ptr (Ptr a) -> IO <herr_t>

-- herr_t H5Fmount(hid_t loc, const char *name, hid_t child, hid_t plist);
#ccall H5Fmount, <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Funmount(hid_t loc, const char *name);
#ccall H5Funmount, <hid_t> -> CString -> IO <herr_t>

-- hssize_t H5Fget_freespace(hid_t file_id);
#ccall H5Fget_freespace, <hid_t> -> IO <hssize_t>

-- herr_t H5Fget_filesize(hid_t file_id, hsize_t *size);
#ccall H5Fget_filesize, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Fget_mdc_config(hid_t file_id,
-- 				H5AC_cache_config_t * config_ptr);
#ccall H5Fget_mdc_config, <hid_t> -> Out <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Fset_mdc_config(hid_t file_id,
-- 				H5AC_cache_config_t * config_ptr);
#ccall H5Fset_mdc_config, <hid_t> -> In <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Fget_mdc_hit_rate(hid_t file_id, double * hit_rate_ptr);
#ccall H5Fget_mdc_hit_rate, <hid_t> -> Out CDouble -> IO <herr_t>

-- herr_t H5Fget_mdc_size(hid_t file_id,
--                               size_t * max_size_ptr,
--                               size_t * min_clean_size_ptr,
--                               size_t * cur_size_ptr,
--                               int * cur_num_entries_ptr);
#ccall H5Fget_mdc_size, <hid_t> -> Ptr <size_t> -> Ptr <size_t> -> Ptr <size_t> -> Ptr CInt -> IO <herr_t>

-- herr_t H5Freset_mdc_hit_rate_stats(hid_t file_id);
#ccall H5Freset_mdc_hit_rate_stats, <hid_t> -> IO <herr_t>

-- ssize_t H5Fget_name(hid_t obj_id, char *name, size_t size);
#ccall H5Fget_name, <hid_t> -> CString -> <size_t> -> IO <ssize_t>

-- herr_t H5Fget_info(hid_t obj_id, H5F_info_t *bh_info);
#ccall H5Fget_info, <hid_t> -> Out H5F_info_t -> IO <herr_t>

