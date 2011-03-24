#include <bindings.h>
#include <H5Spublic.h>

module Bindings.HDF5.Raw.H5S where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I

import Foreign.Ptr.Conventions

#newtype_const hid_t, H5S_ALL
#num H5S_UNLIMITED

-- |Maximum number of dimensions
#num H5S_MAX_RANK

-- |Different types of dataspaces
#newtype H5S_class_t

-- |error
#newtype_const H5S_class_t, H5S_NO_CLASS

-- |scalar variable
#newtype_const H5S_class_t, H5S_SCALAR

-- |simple data space
#newtype_const H5S_class_t, H5S_SIMPLE

-- |null data space
#newtype_const H5S_class_t, H5S_NULL

-- |Different ways of combining selections
#newtype H5S_seloper_t

-- |error
#newtype_const H5S_seloper_t, H5S_SELECT_NOOP

-- |Select "set" operation
#newtype_const H5S_seloper_t, H5S_SELECT_SET

-- |Binary "or" operation for hyperslabs
-- (add new selection to existing selection)
-- Original region:  AAAAAAAAAA
-- New region:             BBBBBBBBBB
-- A or B:           CCCCCCCCCCCCCCCC
#newtype_const H5S_seloper_t, H5S_SELECT_OR

-- |Binary "and" operation for hyperslabs
-- (only leave overlapped regions in selection)
-- Original region:  AAAAAAAAAA
-- New region:             BBBBBBBBBB
-- A and B:                CCCC
#newtype_const H5S_seloper_t, H5S_SELECT_AND

-- |Binary "xor" operation for hyperslabs
-- (only leave non-overlapped regions in selection)
-- Original region:  AAAAAAAAAA
-- New region:             BBBBBBBBBB
-- A xor B:          CCCCCC    CCCCCC
#newtype_const H5S_seloper_t, H5S_SELECT_XOR

-- |Binary "not" operation for hyperslabs
-- (only leave non-overlapped regions in original selection)
-- Original region:  AAAAAAAAAA
-- New region:             BBBBBBBBBB
-- A not B:          CCCCCC
#newtype_const H5S_seloper_t, H5S_SELECT_NOTB

-- |Binary "not" operation for hyperslabs
-- (only leave non-overlapped regions in new selection)
-- Original region:  AAAAAAAAAA
-- New region:             BBBBBBBBBB
-- B not A:                    CCCCCC
#newtype_const H5S_seloper_t, H5S_SELECT_NOTA

-- |Append elements to end of point selection
#newtype_const H5S_seloper_t, H5S_SELECT_APPEND

-- |Prepend elements to beginning of point selection
#newtype_const H5S_seloper_t, H5S_SELECT_PREPEND

-- |Invalid upper bound on selection operations
#newtype_const H5S_seloper_t, H5S_SELECT_INVALID

-- |Enumerated type for the type of selection
#newtype H5S_sel_type

-- |Error
#newtype_const H5S_sel_type, H5S_SEL_ERROR

-- |Nothing selected
#newtype_const H5S_sel_type, H5S_SEL_NONE

-- |Sequence of points selected
#newtype_const H5S_sel_type, H5S_SEL_POINTS

-- |"New-style" hyperslab selection defined
#newtype_const H5S_sel_type, H5S_SEL_HYPERSLABS

-- |Entire extent selected
#newtype_const H5S_sel_type, H5S_SEL_ALL

-- |Number of selection types
#num H5S_SEL_N

-- |Creates a new dataspace of a given type.  The extent & selection are
-- undefined
-- 
-- Parameters:
-- 
-- [@ type :: 'H5S_type_t' @]   Dataspace type to create
-- 
-- Returns valid dataspace ID on success, negative on failure
-- 
-- > hid_t H5Screate(H5S_class_t type);
#ccall H5Screate, <H5S_class_t> -> IO <hid_t>

-- |Creates a new simple dataspace object and opens it for
-- access. The 'dims' argument is the size of the simple dataset
-- and the 'maxdims' argument is the upper limit on the size of
-- the dataset.  'maxdims' may be the null pointer in which case
-- the upper limit is the same as 'dims'.  If an element of
-- 'maxdims' is 'h5s_UNLIMITED' then the corresponding dimension is
-- unlimited, otherwise no element of 'maxdims' should be smaller
-- than the corresponding element of 'dims'.
-- 
-- On success, returns the ID for the new simple dataspace object.
-- Returns negative on failure.
-- 
-- > hid_t H5Screate_simple(int rank, const hsize_t dims[],
-- >        const hsize_t maxdims[]);
#ccall H5Screate_simple, CInt -> InArray <hsize_t> -> InArray <hsize_t> -> IO <hid_t>

-- |Determines if a simple dataspace's extent has been set (e.g.,
-- by 'h5s_set_extent_simple').  Helps avoid write errors.
--
-- Returns TRUE (C macro) if dataspace has extent set, FALSE (C macro)
-- if dataspace's extent is uninitialized.
--
-- > herr_t H5Sset_extent_simple(hid_t space_id, int rank,
-- >        const hsize_t dims[],
-- >        const hsize_t max[]);
#ccall H5Sset_extent_simple, <hid_t> -> CInt -> InArray <hsize_t> -> InArray <hsize_t> -> IO <herr_t>

-- |Copies a dataspace.
--
-- On success, returns the ID of the new dataspace.  Returns negative on
-- failure.
-- 
-- > hid_t H5Scopy(hid_t space_id);
#ccall H5Scopy, <hid_t> -> IO <hid_t>

-- |Release access to a dataspace object.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sclose(hid_t space_id);
#ccall H5Sclose, <hid_t> -> IO <herr_t>

-- |Given a dataspace ID, converts the object description
-- (including selection) into binary in a buffer.
-- 
-- 'nalloc' is the size of the buffer on input, the size of the encoded
-- data on output.  If the buffer is not big enough, no data is written
-- to it (but nalloc is still updated with the size needed).
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sencode(hid_t obj_id, void *buf, size_t *nalloc);
#ccall H5Sencode, <hid_t> -> Ptr a -> InOut <size_t> -> IO <herr_t>

-- |Decode a binary object description of dataspace and
-- return a new object handle.
-- 
-- On success, returns the ID of the new dataspace.  Returns negative on
-- failure.
-- 
-- > hid_t H5Sdecode(const void *buf);
#ccall H5Sdecode, Ptr a -> IO <hid_t>

-- |Determines how many data points a dataset extent has.
-- 
-- On success, returns the number of data points in the dataset.  On
-- failure, returns a negative value.
-- 
-- > hssize_t H5Sget_simple_extent_npoints(hid_t space_id);
#ccall H5Sget_simple_extent_npoints, <hid_t> -> IO <hssize_t>

-- |Determines the dimensionality of a dataspace.
-- 
-- On success, returns the number of dimensions in the dataset.  On
-- failure, returns a negative value.
-- 
-- > int H5Sget_simple_extent_ndims(hid_t space_id);
#ccall H5Sget_simple_extent_ndims, <hid_t> -> IO CInt

-- |Returns the size and maximum sizes in each dimension of
-- a dataspace DS through	the DIMS and MAXDIMS arguments.
-- 
-- Returns the number of dimensions, the same value as returned
-- by 'h5s_get_simple_extent_ndims', or a negative value on failure..
-- 
-- > int H5Sget_simple_extent_dims(hid_t space_id, hsize_t dims[],
-- >        hsize_t maxdims[]);
#ccall H5Sget_simple_extent_dims, <hid_t> -> OutArray <hsize_t> -> OutArray <hsize_t> -> IO CInt

-- |Check if a dataspace is simple
--
-- Parameters:
--
-- [@ space_id :: 'HId_t' @]    ID of dataspace object to query
-- 
-- > htri_t H5Sis_simple(hid_t space_id);
#ccall H5Sis_simple, <hid_t> -> IO <htri_t>

-- |Returns the number of elements in current selection for dataspace.
-- 
-- Parameters:
-- [@ dsid :: 'HId_t' @]    Dataspace ID of selection to query
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > hssize_t H5Sget_select_npoints(hid_t spaceid);
#ccall H5Sget_select_npoints, <hid_t> -> IO <hssize_t>

-- |Combines a hyperslab selection with the current selection for a dataspace.
-- If the current selection is not a hyperslab, it is freed and the hyperslab
-- parameters passed in are combined with the 'h5s_SEL_ALL' hyperslab (ie. a
-- selection composing the entire current extent).  If 'stride' or 'block' is
-- NULL, they are assumed to be set to all '1'.
-- 
-- Parameters:
-- 
-- [@ dsid   :: 'HId_t'                   @]  Dataspace ID of selection to modify
-- 
-- [@ op     :: 'H5S_seloper_t'           @]  Operation to perform on current selection
-- 
-- [@ start  :: 'InArray' 'HSize_t'       @]  Offset of start of hyperslab
-- 
-- [@ stride :: 'InArray' 'HSize_t'       @]  Hyperslab stride
-- 
-- [@ count  :: 'InArray' 'HSize_t'       @]  Number of blocks included in hyperslab
-- 
-- [@ block  :: 'InArray' 'HSize_t'       @]  Size of block in hyperslab
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sselect_hyperslab(hid_t space_id, H5S_seloper_t op,
-- >        const hsize_t start[],
-- >        const hsize_t _stride[],
-- >        const hsize_t count[],
-- >        const hsize_t _block[]);
#ccall H5Sselect_hyperslab, <hid_t> -> <H5S_seloper_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> IO <herr_t>


#ifdef NEW_HYPERSLAB_API

-- |Specify a hyperslab to combine with the current hyperslab selection and
-- return a new dataspace with the combined selection as the selection in the
-- new dataspace.
-- 
-- Combines a hyperslab selection with the current selection for a dataspace,
-- creating a new dataspace to return the generated selection.
-- If the current selection is not a hyperslab, it is freed and the hyperslab
-- parameters passed in are combined with the H5S_SEL_ALL hyperslab (ie. a
-- selection composing the entire current extent).  If STRIDE or BLOCK is
-- NULL, they are assumed to be set to all '1'.
-- 
-- Parameters:
-- 
-- [@ dsid   :: 'HId_t'             @]  Dataspace ID of selection to use
-- 
-- [@ op     :: 'H5S_seloper_t'     @]  Operation to perform on current selection
-- 
-- [@ start  :: 'InArray' 'HSize_t' @]  Offset of start of hyperslab
-- 
-- [@ stride :: 'InArray' 'HSize_t' @]  Hyperslab stride
-- 
-- [@ count  :: 'InArray' 'HSize_t' @]  Number of blocks included in hyperslab
-- 
-- [@ block  :: 'InArray' 'HSize_t' @]  Size of block in hyperslab
-- 
-- Returns dataspace ID on success, negative on failure
-- 
-- > hid_t H5Scombine_hyperslab(hid_t space_id, H5S_seloper_t op,
-- >        const hsize_t start[],
-- >        const hsize_t _stride[],
-- >        const hsize_t count[],
-- >        const hsize_t _block[]);
#ccall H5Scombine_hyperslab, <hid_t> -> <H5S_seloper_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> InArray <hsize_t> -> IO <hid_t>

-- |Refine an existing hyperslab selection with an operation, using a second
-- hyperslab.  The first selection is modified to contain the result of
-- 'space1' operated on by 'space2'.
-- 
-- Parameters:
-- 
-- [@ space1 :: 'HId_t'         @]  First Dataspace ID
-- 
-- [@ op     :: 'H5S_seloper_t' @]  Selection operation
-- 
-- [@ space2 :: 'HId_t'         @]  Second Dataspace ID
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sselect_select(hid_t space1_id, H5S_seloper_t op,
-- >        hid_t space2_id);
#ccall H5Sselect_select, <hid_t> -> <H5S_seloper_t> -> <hid_t> -> IO <herr_t>

-- |Combine two existing hyperslab selections with an operation, returning
-- a new dataspace with the resulting selection.  The dataspace extent from
-- space1 is copied for the dataspace extent of the newly created dataspace.
-- 
-- Parameters:
-- 
-- [@ space1 :: 'HId_t'         @]   First Dataspace ID
-- 
-- [@ op     :: 'H5S_seloper_t' @]   Selection operation
-- 
-- [@ space2 :: 'HId_t'         @]   Second Dataspace ID
-- 
-- Returns dataspace ID on success, negative on failure
-- 
-- > hid_t H5Scombine_select(hid_t space1_id, H5S_seloper_t op,
-- >        hid_t space2_id);
#ccall H5Scombine_select, <hid_t> -> <H5S_seloper_t> -> <hid_t> -> IO <hid_t>

#endif /* NEW_HYPERSLAB_API */

-- |This function selects array elements to be included in the selection for
-- the dataspace.  The 'coord' array is a 2-D array of size \<dataspace rank\>
-- by 'num_elem' (ie. a list of coordinates in the dataspace).  The order of
-- the element coordinates in the 'coord' array specifies the order that the
-- array elements are iterated through when I/O is performed.  Duplicate
-- coordinates are not checked for.  The selection operator, 'op', determines
-- how the new selection is to be combined with the existing selection for
-- the dataspace.  Currently, only 'h5s_SELECT_SET' is supported, which replaces
-- the existing selection with the one defined in this call.  When operators
-- other than 'h5s_SELECT_SET' are used to combine a new selection with an
-- existing selection, the selection ordering is reset to 'C' array ordering.
-- 
-- Parameters:
-- 
-- [@ dsid     :: 'HId_t'             @]    Dataspace ID of selection to modify
-- 
-- [@ op       :: 'H5S_seloper_t'     @]    Operation to perform on current selection
-- 
-- [@ num_elem :: 'CSize'             @]    Number of elements in COORD array.
-- 
-- [@ coord    :: 'InArray' 'HSize_t' @]    The location of each element selected
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Sselect_elements(hid_t space_id, H5S_seloper_t op,
-- >     size_t num_elem, const hsize_t *coord);
#ccall H5Sselect_elements, <hid_t> -> <H5S_seloper_t> -> <size_t> -> InArray <hsize_t> -> IO <herr_t>

-- |Retrieves the type of extent for a dataspace object
-- 
-- Returns the class of the dataspace object on success, 'n5s_NO_CLASS'
-- on failure.
-- 
-- > H5S_class_t H5Sget_simple_extent_type(hid_t space_id);
#ccall H5Sget_simple_extent_type, <hid_t> -> IO <H5S_class_t>

-- |Resets the extent of a dataspace back to \"none\"
-- 
-- This function resets the type of a dataspace back to \"none\" with no
-- extent information stored for the dataspace.
--
-- > herr_t H5Sset_extent_none(hid_t space_id);
#ccall H5Sset_extent_none, <hid_t> -> IO <herr_t>

-- |
-- > herr_t H5Sextent_copy(hid_t dst_id,hid_t src_id);
#ccall H5Sextent_copy, <hid_t> -> <hid_t> -> IO <herr_t>

-- |Determines if two dataspace extents are equal.
-- 
-- > htri_t H5Sextent_equal(hid_t sid1, hid_t sid2);
#ccall H5Sextent_equal, <hid_t> -> <hid_t> -> IO <htri_t>

-- |This function selects the entire extent for a dataspace.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sselect_all(hid_t spaceid);
#ccall H5Sselect_all, <hid_t> -> IO <herr_t>

-- |This function de-selects the entire extent for a dataspace.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sselect_none(hid_t spaceid);
#ccall H5Sselect_none, <hid_t> -> IO <herr_t>

-- |Changes the offset of a selection within a simple dataspace extent
-- 
-- Parameters:
-- 
-- [@ space_id :: 'HId_t'              @]   Dataspace object to reset
-- 
-- [@ offset   :: 'InArray' 'HSsize_t' @]   Offset to position the selection at
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Soffset_simple(hid_t space_id, const hssize_t *offset);
#ccall H5Soffset_simple, <hid_t> -> InArray <hssize_t> -> IO <herr_t>

-- |Check whether the selection fits within the extent, with the current
-- offset defined.
-- 
-- Determines if the current selection at the current offet fits within the
-- extent for the dataspace.
-- 
-- > htri_t H5Sselect_valid(hid_t spaceid);
#ccall H5Sselect_valid, <hid_t> -> IO <htri_t>

-- |Get the number of hyperslab blocks in current hyperslab selection
-- 
-- Returns negative on failure
--
-- > hssize_t H5Sget_select_hyper_nblocks(hid_t spaceid);
#ccall H5Sget_select_hyper_nblocks, <hid_t> -> IO <hssize_t>

-- |Get the number of points in current element selection
-- 
-- Returns negative on failure
-- 
-- > hssize_t H5Sget_select_elem_npoints(hid_t spaceid);
#ccall H5Sget_select_elem_npoints, <hid_t> -> IO <hssize_t>

-- |Puts a list of the hyperslab blocks into the user's buffer.  The blocks
-- start with the 'startblock'th block in the list of blocks and put
-- 'numblocks' number of blocks into the user's buffer (or until the end of
-- the list of blocks, whichever happen first)
-- 
-- The block coordinates have the same dimensionality (rank) as the
-- dataspace they are located within.  The list of blocks is formatted as
-- follows: \<\"start\" coordinate\> immediately followed by \<\"opposite\" 
-- corner coordinate\>, followed by the next \"start\" and \"opposite\"
-- coordinate, etc.  until all the block information requested has been
-- put into the user's buffer.
-- 
-- No guarantee of any order of the blocks is implied.
-- 
-- Parameters:
--
-- [@ dsid       :: 'HId_t'               @]    Dataspace ID of selection to query
--
-- [@ startblock :: 'HSsize_t'            @]    Hyperslab block to start with
--
-- [@ numblocks  :: 'HSsize_t'            @]    Number of hyperslab blocks to get
--
-- [@ buf        :: 'OutArray' 'HSsize_t' @]    List of hyperslab blocks selected
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Sget_select_hyper_blocklist(hid_t spaceid, hsize_t startblock,
-- >     hsize_t numblocks, hsize_t buf[/*numblocks*/]);
#ccall H5Sget_select_hyper_blocklist, <hid_t> -> <hsize_t> -> <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- |Puts a list of the element points into the user's buffer.  The points
-- start with the 'startpoint'th block in the list of points and put
-- 'numpoints' number of points into the user's buffer (or until the end of
-- the list of points, whichever happen first)
-- 
-- The point coordinates have the same dimensionality (rank) as the
-- dataspace they are located within.  The list of points is formatted as
-- follows: <coordinate> followed by the next coordinate, etc. until all the
-- point information in the selection have been put into the user's buffer.
-- 
-- The points are returned in the order they will be interated through
-- when a selection is read/written from/to disk.
--
-- Parameters:
-- 
-- [@ dsid       :: 'HId_t'   @]    Dataspace ID of selection to query
-- 
-- [@ startpoint :: 'HSize_t' @]    Element point to start with
-- 
-- [@ numpoints  :: 'HSize_t' @]    Number of element points to get
-- 
-- [@ buf        :: 'HSize_t' @]    List of element points selected
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Sget_select_elem_pointlist(hid_t spaceid, hsize_t startpoint,
-- >     hsize_t numpoints, hsize_t buf[/*numpoints*/]);
#ccall H5Sget_select_elem_pointlist, <hid_t> -> <hsize_t> -> <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- |Retrieves the bounding box containing the current selection and places
-- it into the user's buffers.  The start and end buffers must be large
-- enough to hold the dataspace rank number of coordinates.  The bounding box
-- exactly contains the selection, ie. if a 2-D element selection is currently
-- defined with the following points: (4,5), (6,8) (10,7), the bounding box
-- with be (4, 5), (10, 8).  Calling this function on a \"none\" selection
-- returns fail.
--
-- The bounding box calculations _does_ include the current offset of the
-- selection within the dataspace extent.
-- 
-- Parameters:
-- 
-- [@ dsid  :: 'HId_t'              @]  Dataspace ID of selection to query
-- 
-- [@ start :: 'OutArray' 'HSize_t' @]  Starting coordinate of bounding box
-- 
-- [@ end   :: 'OutArray' 'HSize_t' @]  Opposite coordinate of bounding box
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- Weird warning in source: This routine participates in the
-- \"Inlining C function pointers\" pattern, don't call it directly,
-- use the appropriate macro defined in H5Sprivate.h.
-- 
-- > herr_t H5Sget_select_bounds(hid_t spaceid, hsize_t start[],
-- >     hsize_t end[]);
#ccall H5Sget_select_bounds, <hid_t> -> OutArray <hsize_t> -> OutArray <hsize_t> -> IO <herr_t>

-- H5S_sel_type H5Sget_select_type(hid_t spaceid);
#ccall H5Sget_select_type, <hid_t> -> IO <H5S_sel_type>

