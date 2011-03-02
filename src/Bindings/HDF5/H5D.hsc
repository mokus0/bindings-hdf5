#include <bindings.h>
#include <H5Dpublic.h>

module Bindings.HDF5.H5D where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#num H5D_CHUNK_CACHE_NSLOTS_DEFAULT
#num H5D_CHUNK_CACHE_NBYTES_DEFAULT
#num H5D_CHUNK_CACHE_W0_DEFAULT

#newtype H5D_layout_t
#newtype_const H5D_layout_t, H5D_LAYOUT_ERROR
#newtype_const H5D_layout_t, H5D_COMPACT
#newtype_const H5D_layout_t, H5D_CONTIGUOUS
#newtype_const H5D_layout_t, H5D_CHUNKED
#num H5D_NLAYOUTS

#newtype H5D_chunk_index_t
#newtype_const H5D_chunk_index_t, H5D_CHUNK_BTREE

#newtype H5D_alloc_time_t
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_ERROR
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_DEFAULT
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_EARLY
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_LATE
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_INCR

#newtype H5D_space_status_t
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_ERROR
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_NOT_ALLOCATED
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_PART_ALLOCATED
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_ALLOCATED

#newtype H5D_fill_time_t
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_ERROR
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_ALLOC
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_NEVER
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_IFSET

#newtype H5D_fill_value_t
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_ERROR
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_UNDEFINED
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_DEFAULT
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_USER_DEFINED

-- /*********************/
-- /* Public Prototypes */
-- /*********************/

-- /* Define the operator function pointer for H5Diterate() */
-- typedef herr_t (*H5D_operator_t)(void *elem, hid_t type_id, unsigned ndim,
-- 				 const hsize_t *point, void *operator_data);
type H5D_operator_t a b = FunPtr (Ptr a -> HId_t -> CUInt -> In HSize_t -> Ptr b -> IO HErr_t)

-- hid_t H5Dcreate2(hid_t loc_id, const char *name, hid_t type_id,
--     hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id);
#ccall H5Dcreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t H5Dcreate_anon(hid_t file_id, hid_t type_id, hid_t space_id,
--     hid_t plist_id, hid_t dapl_id);
#ccall H5Dcreate_anon, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t H5Dopen2(hid_t file_id, const char *name, hid_t dapl_id);
#ccall H5Dopen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- herr_t H5Dclose(hid_t dset_id);
#ccall H5Dclose, <hid_t> -> IO <herr_t>

-- hid_t H5Dget_space(hid_t dset_id);
#ccall H5Dget_space, <hid_t> -> IO <hid_t>

-- herr_t H5Dget_space_status(hid_t dset_id, H5D_space_status_t *allocation);
#ccall H5Dget_space_status, <hid_t> -> Out H5D_space_status_t -> IO <herr_t>

-- hid_t H5Dget_type(hid_t dset_id);
#ccall H5Dget_type, <hid_t> -> IO <hid_t>

-- hid_t H5Dget_create_plist(hid_t dset_id);
#ccall H5Dget_create_plist, <hid_t> -> IO <hid_t>

-- hid_t H5Dget_access_plist(hid_t dset_id);
-- hsize_t H5Dget_storage_size(hid_t dset_id);
-- haddr_t H5Dget_offset(hid_t dset_id);
-- herr_t H5Dread(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
-- 			hid_t file_space_id, hid_t plist_id, void *buf/*out*/);
-- herr_t H5Dwrite(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
-- 			 hid_t file_space_id, hid_t plist_id, const void *buf);
-- herr_t H5Diterate(void *buf, hid_t type_id, hid_t space_id,
--             H5D_operator_t op, void *operator_data);
-- herr_t H5Dvlen_reclaim(hid_t type_id, hid_t space_id, hid_t plist_id, void *buf);
-- herr_t H5Dvlen_get_buf_size(hid_t dataset_id, hid_t type_id, hid_t space_id, hsize_t *size);
-- herr_t H5Dfill(const void *fill, hid_t fill_type, void *buf,
--         hid_t buf_type, hid_t space);
-- herr_t H5Dset_extent(hid_t dset_id, const hsize_t size[]);
-- herr_t H5Ddebug(hid_t dset_id);

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- /* Function prototypes */
-- hid_t H5Dcreate1(hid_t file_id, const char *name, hid_t type_id,
--     hid_t space_id, hid_t dcpl_id);
-- hid_t H5Dopen1(hid_t file_id, const char *name);
-- herr_t H5Dextend(hid_t dset_id, const hsize_t size[]);

#endif /* H5_NO_DEPRECATED_SYMBOLS */
