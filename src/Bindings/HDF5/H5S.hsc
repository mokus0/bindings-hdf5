#include <bindings.h>
#include <H5Spublic.h>

module Bindings.HDF5.H5S where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#newtype_const hid_t, H5S_ALL
#num H5S_UNLIMITED

#num H5S_MAX_RANK

#newtype H5S_class_t
#newtype_const H5S_class_t, H5S_NO_CLASS
#newtype_const H5S_class_t, H5S_SCALAR
#newtype_const H5S_class_t, H5S_SIMPLE
#newtype_const H5S_class_t, H5S_NULL

#newtype H5S_seloper_t
#newtype_const H5S_seloper_t, H5S_SELECT_NOOP
#newtype_const H5S_seloper_t, H5S_SELECT_SET
#newtype_const H5S_seloper_t, H5S_SELECT_OR
#newtype_const H5S_seloper_t, H5S_SELECT_AND
#newtype_const H5S_seloper_t, H5S_SELECT_XOR
#newtype_const H5S_seloper_t, H5S_SELECT_NOTB
#newtype_const H5S_seloper_t, H5S_SELECT_NOTA
#newtype_const H5S_seloper_t, H5S_SELECT_APPEND
#newtype_const H5S_seloper_t, H5S_SELECT_PREPEND
#newtype_const H5S_seloper_t, H5S_SELECT_INVALID

#newtype H5S_sel_type
#newtype_const H5S_sel_type, H5S_SEL_ERROR
#newtype_const H5S_sel_type, H5S_SEL_NONE
#newtype_const H5S_sel_type, H5S_SEL_POINTS
#newtype_const H5S_sel_type, H5S_SEL_HYPERSLABS
#newtype_const H5S_sel_type, H5S_SEL_ALL
#newtype_const H5S_sel_type, H5S_SEL_N

-- hid_t H5Screate(H5S_class_t type);
#ccall H5Screate, <H5S_class_t> -> IO <hid_t>

-- hid_t H5Screate_simple(int rank, const hsize_t dims[],
-- 			       const hsize_t maxdims[]);
#ccall H5Screate_simple, CInt -> InArray <hsize_t> -> InArray <hsize_t> -> IO <hid_t>

-- herr_t H5Sset_extent_simple(hid_t space_id, int rank,
-- 				    const hsize_t dims[],
-- 				    const hsize_t max[]);
#ccall H5Sset_extent_simple, <hid_t> -> CInt -> InArray <hsize_t> -> InArray <hsize_t> -> IO <herr_t>

-- hid_t H5Scopy(hid_t space_id);
#ccall H5Scopy, <hid_t> -> IO <hid_t>

-- herr_t H5Sclose(hid_t space_id);
#ccall H5Sclose, <hid_t> -> IO <herr_t>

-- herr_t H5Sencode(hid_t obj_id, void *buf, size_t *nalloc);
#ccall H5Sencode, <hid_t> -> Ptr a -> Ptr <size_t> -> IO <herr_t>

-- hid_t H5Sdecode(const void *buf);
#ccall H5Sdecode, Ptr a -> IO <hid_t>

-- hssize_t H5Sget_simple_extent_npoints(hid_t space_id);
#ccall H5Sget_simple_extent_npoints, <hid_t> -> IO <hssize_t>

-- int H5Sget_simple_extent_ndims(hid_t space_id);
#ccall H5Sget_simple_extent_ndims, <hid_t> -> IO CInt

-- int H5Sget_simple_extent_dims(hid_t space_id, hsize_t dims[],
-- 				      hsize_t maxdims[]);
#ccall H5Sget_simple_extent_dims, <hid_t> -> OutArray <hsize_t> -> OutArray <hsize_t> -> IO CInt

-- htri_t H5Sis_simple(hid_t space_id);
#ccall H5Sis_simple, <hid_t> -> IO <htri_t>

-- hssize_t H5Sget_select_npoints(hid_t spaceid);
#ccall H5Sget_select_npoints, <hid_t> -> IO <hssize_t>

-- herr_t H5Sselect_hyperslab(hid_t space_id, H5S_seloper_t op,
-- 				   const hsize_t start[],
-- 				   const hsize_t _stride[],
-- 				   const hsize_t count[],
-- 				   const hsize_t _block[]);
#ccall H5Sselect_hyperslab, <hid_t> -> <H5S_seloper_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> IO <herr_t>


#ifdef NEW_HYPERSLAB_API
    
-- hid_t H5Scombine_hyperslab(hid_t space_id, H5S_seloper_t op,
-- 				   const hsize_t start[],
-- 				   const hsize_t _stride[],
-- 				   const hsize_t count[],
-- 				   const hsize_t _block[]);
#ccall H5Scombine_hyperslab, <hid_t> -> <H5S_seloper_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> IO <hid_t>

-- herr_t H5Sselect_select(hid_t space1_id, H5S_seloper_t op,
--                                   hid_t space2_id);
#ccall H5Sselect_select, <hid_t> -> <H5S_seloper_t> -> <hid_t> -> IO <herr_t>

-- hid_t H5Scombine_select(hid_t space1_id, H5S_seloper_t op,
--                                   hid_t space2_id);
#ccall H5Scombine_select, <hid_t> -> <H5S_seloper_t> -> <hid_t> -> IO <hid_t>


#endif /* NEW_HYPERSLAB_API */

-- herr_t H5Sselect_elements(hid_t space_id, H5S_seloper_t op,
--     size_t num_elem, const hsize_t *coord);
#ccall H5Sselect_elements, <hid_t> -> <H5S_seloper_t> -> <size_t> -> InArray <hsize_t> -> IO <herr_t>

-- H5S_class_t H5Sget_simple_extent_type(hid_t space_id);
#ccall H5Sget_simple_extent_type, <hid_t> -> IO <H5S_class_t>

-- herr_t H5Sset_extent_none(hid_t space_id);
#ccall H5Sset_extent_none, <hid_t> -> IO <herr_t>

-- herr_t H5Sextent_copy(hid_t dst_id,hid_t src_id);
#ccall H5Sextent_copy, <hid_t> -> <hid_t> -> IO <herr_t>

-- htri_t H5Sextent_equal(hid_t sid1, hid_t sid2);
#ccall H5Sextent_equal, <hid_t> -> <hid_t> -> IO <htri_t>

-- herr_t H5Sselect_all(hid_t spaceid);
#ccall H5Sselect_all, <hid_t> -> IO <herr_t>

-- herr_t H5Sselect_none(hid_t spaceid);
#ccall H5Sselect_none, <hid_t> -> IO <herr_t>

-- herr_t H5Soffset_simple(hid_t space_id, const hssize_t *offset);
#ccall H5Soffset_simple, <hid_t> -> Ptr <hssize_t> -> IO <herr_t>

-- htri_t H5Sselect_valid(hid_t spaceid);
#ccall H5Sselect_valid, <hid_t> -> IO <htri_t>

-- hssize_t H5Sget_select_hyper_nblocks(hid_t spaceid);
#ccall H5Sget_select_hyper_nblocks, <hid_t> -> IO <hssize_t>

-- hssize_t H5Sget_select_elem_npoints(hid_t spaceid);
#ccall H5Sget_select_elem_npoints, <hid_t> -> IO <hssize_t>

-- herr_t H5Sget_select_hyper_blocklist(hid_t spaceid, hsize_t startblock,
--     hsize_t numblocks, hsize_t buf[/*numblocks*/]);
#ccall H5Sget_select_hyper_blocklist, <hid_t> -> <hsize_t> -> <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- herr_t H5Sget_select_elem_pointlist(hid_t spaceid, hsize_t startpoint,
--     hsize_t numpoints, hsize_t buf[/*numpoints*/]);
#ccall H5Sget_select_elem_pointlist, <hid_t> -> <hsize_t> -> <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- herr_t H5Sget_select_bounds(hid_t spaceid, hsize_t start[],
--     hsize_t end[]);
#ccall H5Sget_select_bounds, <hid_t> -> OutArray <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- H5S_sel_type H5Sget_select_type(hid_t spaceid);
#ccall H5Sget_select_type, <hid_t> -> IO <H5S_sel_type>

