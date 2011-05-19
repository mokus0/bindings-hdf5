#include <bindings.h>
#include <H5Dpublic.h>

module Bindings.HDF5.Raw.H5D where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I

import Foreign.Ptr.Conventions

#if H5_VERSION_GE(1,8,3)

#num H5D_CHUNK_CACHE_NSLOTS_DEFAULT
#num H5D_CHUNK_CACHE_NBYTES_DEFAULT
#num H5D_CHUNK_CACHE_W0_DEFAULT

#endif

-- |Values for the H5D_LAYOUT property
#newtype H5D_layout_t, Eq

#newtype_const H5D_layout_t, H5D_LAYOUT_ERROR

-- |raw data is very small
#newtype_const H5D_layout_t, H5D_COMPACT

-- |the default
#newtype_const H5D_layout_t, H5D_CONTIGUOUS

-- |slow and fancy
#newtype_const H5D_layout_t, H5D_CHUNKED

#num H5D_NLAYOUTS

#if H5_VERSION_GE(1,8,3)

-- |Types of chunk index data structures
#newtype H5D_chunk_index_t

-- |v1 B-tree index
#newtype_const H5D_chunk_index_t, H5D_CHUNK_BTREE

#endif

-- |Values for the space allocation time property
#newtype H5D_alloc_time_t, Eq
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_ERROR
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_DEFAULT
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_EARLY
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_LATE
#newtype_const H5D_alloc_time_t, H5D_ALLOC_TIME_INCR

-- |Values for the status of space allocation
#newtype H5D_space_status_t, Eq
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_ERROR
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_NOT_ALLOCATED
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_PART_ALLOCATED
#newtype_const H5D_space_status_t, H5D_SPACE_STATUS_ALLOCATED

-- |Values for time of writing fill value property
#newtype H5D_fill_time_t, Eq
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_ERROR
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_ALLOC
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_NEVER
#newtype_const H5D_fill_time_t, H5D_FILL_TIME_IFSET

-- |Values for fill value status
#newtype H5D_fill_value_t, Eq
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_ERROR
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_UNDEFINED
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_DEFAULT
#newtype_const H5D_fill_value_t, H5D_FILL_VALUE_USER_DEFINED

-- |Operator function type for 'h5d_iterate'
-- 
-- Parameters:
-- 
-- [@ elem          :: 'InOut' a           @]    Pointer to the element in memory containing the current point.
-- 
-- [@ type_id       :: 'HId_t'             @]    Datatype ID for the elements stored in ELEM.
-- 
-- [@ ndim          :: 'CUInt'             @]    Number of dimensions for POINT array
-- 
-- [@ point         :: 'InArray' 'HSize_t' @]    Array containing the location of the element within the original dataspace.
-- 
-- [@ operator_data :: 'InOut' b           @]    Pointer to any user-defined data associated with the operation.
-- 
-- Return Values:
-- 
--  * Zero causes the iterator to continue, returning zero when all
--    elements have been processed.
-- 
--  * Positive causes the iterator to immediately return that positive
--    value, indicating short-circuit success.  The iterator can be
--    restarted at the next element.
-- 
--  * Negative causes the iterator to immediately return that value,
--    indicating failure. The iterator can be restarted at the next
--    element.
-- 
-- > typedef herr_t (*H5D_operator_t)(void *elem, hid_t type_id, unsigned ndim,
-- > 				 const hsize_t *point, void *operator_data);
type H5D_operator_t a b = FunPtr (InOut a -> HId_t -> CUInt -> InArray HSize_t -> InOut b -> IO HErr_t)

-- |Creates a new dataset named 'name' at 'loc_id', opens the
-- dataset for access, and associates with that dataset constant
-- and initial persistent properties including the type of each
-- datapoint as stored in the file ('type_id'), the size of the
-- dataset ('space_id'), and other initial miscellaneous
-- properties ('dcpl_id').
-- 
-- All arguments are copied into the dataset, so the caller is
-- allowed to derive new types, data spaces, and creation
-- parameters from the old ones and reuse them in calls to
-- create other datasets.
-- 
-- On success, returns the object ID of the new dataset.  At this
-- point, the dataset is ready to receive its raw data.  Attempting
-- to read raw data from the dataset will probably return the fill
-- value.  The dataset should be closed when the caller is no longer
-- interested in it.
-- 
-- On failure, returns a negative value.
-- 
-- > hid_t H5Dcreate2(hid_t loc_id, const char *name, hid_t type_id,
-- >     hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id);
#ccall H5Dcreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Creates a new dataset named 'name' at 'loc_id', opens the
-- dataset for access, and associates with that dataset constant
-- and initial persistent properties including the type of each
-- datapoint as stored in the file ('type_id'), the size of the
-- dataset ('space_id'), and other initial miscellaneous
-- properties ('dcpl_id').
-- 
-- All arguments are copied into the dataset, so the caller is
-- allowed to derive new types, data spaces, and creation
-- parameters from the old ones and reuse them in calls to
-- create other datasets.
-- 
-- The resulting ID should be linked into the file with
-- 'h5o_link' or it will be deleted when closed.
-- 
-- On success returns the object ID of the new dataset.  At this
-- point, the dataset is ready to receive its raw data.  Attempting
-- to read raw data from the dataset will probably return the fill
-- value.  The dataset should be linked into the group hierarchy before
-- being closed or it will be deleted.  The dataset should be closed 
-- when the caller is no longer interested in it.
-- 
-- On failure, returns a negative value.
-- 
-- > hid_t H5Dcreate_anon(hid_t file_id, hid_t type_id, hid_t space_id,
-- >     hid_t plist_id, hid_t dapl_id);
#ccall H5Dcreate_anon, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Finds a dataset named 'name' at 'loc_id', opens it, and returns
-- its ID.	 The dataset should be close when the caller is no
-- longer interested in it.
--
-- Takes a dataset access property list
--
-- On success, returns a new dataset ID.
-- On failure, returns a negative value.
--
-- > hid_t H5Dopen2(hid_t file_id, const char *name, hid_t dapl_id);
#ccall H5Dopen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- |Closes access to a dataset ('dset_id') and releases
-- resources used by it. It is illegal to subsequently use that
-- same dataset ID in calls to other dataset functions.
--
-- Returns non-negative on success / negative on failure
--
-- > herr_t H5Dclose(hid_t dset_id);
#ccall H5Dclose, <hid_t> -> IO <herr_t>

-- |Returns a copy of the file data space for a dataset.
--
-- On success, returns a new ID for a copy of the data space.  The data
-- space should be released by calling 'h5s_close'.
--
-- > hid_t H5Dget_space(hid_t dset_id);
#ccall H5Dget_space, <hid_t> -> IO <hid_t>

-- |Gets the status of data space allocation.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Dget_space_status(hid_t dset_id, H5D_space_status_t *allocation);
#ccall H5Dget_space_status, <hid_t> -> Out H5D_space_status_t -> IO <herr_t>

-- |Gets a copy of the file datatype for a dataset.
-- 
-- On success, returns the ID for a copy of the datatype.  The data type 
-- should be released by calling 'h5t_close'.
-- On failure, returns a negative value.
-- 
-- > hid_t H5Dget_type(hid_t dset_id);
#ccall H5Dget_type, <hid_t> -> IO <hid_t>

-- |Gets a copy of the dataset creation property list.
-- 
-- On success, returns the ID for a copy of the dataset creation
-- property list.  The template should be released by calling 'h5p_close'.
-- 
-- > hid_t H5Dget_create_plist(hid_t dset_id);
#ccall H5Dget_create_plist, <hid_t> -> IO <hid_t>

#if H5_VERSION_GE(1,8,3)
-- |Returns a copy of the dataset creation property list of the specified
-- dataset.
--
-- The chunk cache parameters in the returned property lists will be
-- those used by the dataset.  If the properties in the file access
-- property list were used to determine the dataset's chunk cache
-- configuration, then those properties will be present in the
-- returned dataset access property list.  If the dataset does not
-- use a chunked layout, then the chunk cache properties will be set
-- to the default.  The chunk cache properties in the returned list
-- are considered to be \"set\", and any use of this list will override
-- the corresponding properties in the file's file access property
-- list.
--
-- All link access properties in the returned list will be set to the
-- default values.
--
-- On success, returns the ID for a copy of the dataset access
-- property list.  The template should be released by calling 'h5p_close'.
-- On failure, returns a negative value.
--
-- > hid_t H5Dget_access_plist(hid_t dset_id);
#ccall H5Dget_access_plist, <hid_t> -> IO <hid_t>
#endif

-- |Returns the amount of storage that is required for the
-- dataset. For chunked datasets this is the number of allocated
-- chunks times the chunk size.
--
-- On success, returns the amount of storage space allocated for the
-- dataset, not counting meta data. The return value may be zero if 
-- no data has been stored.
--
-- On failure, returns zero.
--
-- > hsize_t H5Dget_storage_size(hid_t dset_id);
#ccall H5Dget_storage_size, <hid_t> -> IO <hsize_t>

-- |Returns the address of dataset in file, or 'hADDR_UNDEF' on failure.
-- 
-- > haddr_t H5Dget_offset(hid_t dset_id);
#ccall H5Dget_offset, <hid_t> -> IO <haddr_t>

-- |Reads (part of) a data set from the file into application
-- memory 'buf'. The part of the dataset to read is defined with
-- 'mem_space_id' and 'file_space_id'. The data points are
-- converted from their file type to the 'mem_type_id' specified.
-- Additional miscellaneous data transfer properties can be
-- passed to this function with the 'plist_id' argument.
-- 
-- The 'file_space_id' can be the constant 'h5s_ALL' which indicates
-- that the entire file data space is to be referenced.
-- 
-- The 'mem_space_id' can be the constant 'h5s_ALL' in which case
-- the memory data space is the same as the file data space
-- defined when the dataset was created.
-- 
-- The number of elements in the memory data space must match
-- the number of elements in the file data space.
-- 
-- The 'plist_id' can be the constant 'h5p_DEFAULT' in which
-- case the default data transfer properties are used.
-- 
-- Returns non-negative on success / negative on failure.
--
-- > herr_t H5Dread(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
-- >        hid_t file_space_id, hid_t plist_id, void *buf/*out*/);
#ccall H5Dread, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> OutArray a -> IO <herr_t>

-- |Writes (part of) a data set from application memory 'buf' to the
-- file.  The part of the dataset to write is defined with the
-- 'mem_space_id' and 'file_space_id' arguments. The data points
-- are converted from their current type ('mem_type_id') to their
-- file datatype.  Additional miscellaneous data transfer
-- properties can be passed to this function with the
-- 'plist_id' argument.
-- 
-- The 'file_space_id' can be the constant 'h5s_ALL' which indicates
-- that the entire file data space is to be referenced.
-- 
-- The 'mem_space_id' can be the constant 'h5s_ALL' in which case
-- the memory data space is the same as the file data space
-- defined when the dataset was created.
-- 
-- The number of elements in the memory data space must match
-- the number of elements in the file data space.
-- 
-- The 'plist_id' can be the constant 'h5p_DEFAULT' in which
-- case the default data transfer properties are used.
-- 
-- Returns non-negative on success / negative on failure.
-- 
-- > herr_t H5Dwrite(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
-- >        hid_t file_space_id, hid_t plist_id, const void *buf);
#ccall H5Dwrite, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> InArray a -> IO <herr_t>

-- TODO: verify that 'buf' is mutable
-- |This routine iterates over all the elements selected in a memory
-- buffer.  The callback function is called once for each element selected
-- in the dataspace.  The selection in the dataspace is modified so
-- that any elements already iterated over are removed from the selection
-- if the iteration is interrupted (by the 'H5D_operator_t' function
-- returning non-zero) in the \"middle\" of the iteration and may be
-- re-started by the user where it left off.
-- 
-- NOTE: Until \"subtracting\" elements from a selection is implemented,
--     the selection is not modified.
--
-- Parameters:
-- 
-- [@ buf           :: 'InOut' a            @]    Pointer to the buffer in memory containing the elements to iterate over.
-- 
-- [@ type_id       :: 'HId_t'              @]    Datatype ID for the elements stored in 'buf'.
-- 
-- [@ space_id      :: 'HId_t'              @]    Dataspace ID for 'buf', also contains the selection to iterate over.
-- 
-- [@ op            :: 'H5D_operator_t' a b @]    Function pointer to the routine to be called for each element in 'buf' iterated over.
-- 
-- [@ operator_data :: 'InOut' b            @]    Pointer to any user-defined data associated with the operation.
--
-- Returns the return value of the last operator if it was non-zero,
-- or zero if all elements were processed. Otherwise returns a
-- negative value.
--
-- > herr_t H5Diterate(void *buf, hid_t type_id, hid_t space_id,
-- >        H5D_operator_t op, void *operator_data);
#ccall H5Diterate, InOutArray a -> <hid_t> -> <hid_t> -> H5D_operator_t a b -> InOut b -> IO <herr_t>

-- |Frees the buffers allocated for storing variable-length data
-- in memory.  Only frees the VL data in the selection defined in the
-- dataspace.  The dataset transfer property list is required to find the
-- correct allocation/free methods for the VL data in the buffer.
--
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Dvlen_reclaim(hid_t type_id, hid_t space_id, hid_t plist_id, void *buf);
#ccall H5Dvlen_reclaim, <hid_t> -> <hid_t> -> <hid_t> -> Ptr a -> IO <herr_t>

-- |This routine checks the number of bytes required to store the VL
-- data from the dataset, using the 'space_id' for the selection in the
-- dataset on disk and the 'type_id' for the memory representation of the
-- VL data, in memory.  The 'size' value is modified according to how many
-- bytes are required to store the VL data in memory.
--
-- This routine actually performs the read with a custom
-- memory manager which basically just counts the bytes requested and
-- uses a temporary memory buffer (through the H5FL API) to make certain
-- enough space is available to perform the read.  Then the temporary
-- buffer is released and the number of bytes allocated is returned.
-- Kinda kludgy, but easier than the other method of trying to figure out
-- the sizes without actually reading the data in... - QAK
--
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Dvlen_get_buf_size(hid_t dataset_id, hid_t type_id, hid_t space_id, hsize_t *size);
#ccall H5Dvlen_get_buf_size, <hid_t> -> <hid_t> -> <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- TODO: this explanation is incomprehensible.  Improve it.
-- |Fill a selection in memory with a value.
-- Use the selection in the dataspace to fill elements in a memory buffer.
-- If "fill" parameter is NULL, uses all zeros as fill value
-- 
-- Parameters:
-- 
-- [@ fill         :: 'In' a    @]  Pointer to fill value to use
-- [@ fill_type_id :: 'HId_t'   @]  Datatype of the fill value
-- [@ buf          :: 'InOut' b @]  Memory buffer to fill selection within
-- [@ buf_type_id  :: 'HId_t'   @]  Datatype of the elements in buffer
-- [@ space_id     :: 'HId_t'   @]  Dataspace describing memory buffer & containing selection to use.
-- 
-- Returns non-negative on success / negative on failure.
-- 
-- > herr_t H5Dfill(const void *fill, hid_t fill_type, void *buf,
-- >         hid_t buf_type, hid_t space);
#ccall H5Dfill, Ptr a -> <hid_t> -> Ptr b -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Modifies the dimensions of a dataset.  Can change to a smaller dimension.
--
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Dset_extent(hid_t dset_id, const hsize_t size[]);
#ccall H5Dset_extent, <hid_t> -> InArray <hsize_t> -> IO <herr_t>

-- |Prints various information about a dataset.  This function is not to be
-- documented in the API at this time.
-- 
-- Returns non-negative on success, negative on failure
-- 
-- > herr_t H5Ddebug(hid_t dset_id);
#ccall H5Ddebug, <hid_t> -> IO <herr_t>


#ifndef H5_NO_DEPRECATED_SYMBOLS

-- |Creates a new dataset named 'name' at 'loc_id', opens the
-- dataset for access, and associates with that dataset constant
-- and initial persistent properties including the type of each
-- datapoint as stored in the file ('type_id'), the size of the
-- dataset ('space_id'), and other initial miscellaneous
-- properties ('dcpl_id').
-- 
-- All arguments are copied into the dataset, so the caller is
-- allowed to derive new types, data spaces, and creation
-- parameters from the old ones and reuse them in calls to
-- create other datasets.
-- 
-- On success, returns the object ID of the new dataset.  At this
-- point, the dataset is ready to receive its raw data.  Attempting
-- to read raw data from the dataset will probably return the fill
-- value.  The dataset should be closed when the caller is no longer
-- interested in it.
-- 
-- On failure, returns a negative value.
-- 
-- Note:  Deprecated in favor of 'h5d_create2'
-- 
-- > hid_t H5Dcreate1(hid_t file_id, const char *name, hid_t type_id,
-- >     hid_t space_id, hid_t dcpl_id);
#ccall H5Dcreate1, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Finds a dataset named 'name' at 'loc_id', opens it, and returns
-- its ID.  The dataset should be closed when the caller is no
-- longer interested in it.
--
-- On success returns a new dataset ID.
-- On failure, returns a negative value.
--
-- Note:  Deprecated in favor of 'h5d_open2'
--
-- > hid_t H5Dopen1(hid_t file_id, const char *name);
#ccall H5Dopen1, <hid_t> -> CString -> IO <hid_t>

-- |This function makes sure that the dataset is at least of size
-- 'size'. The dimensionality of 'size' is the same as the data
-- space of the dataset being changed.
--
-- Note:  Deprecated in favor of 'h5d_set_extent'
--
-- Returns non-negative on success / negative on failure
--
-- > herr_t H5Dextend(hid_t dset_id, const hsize_t size[]);
#ccall H5Dextend, <hid_t> -> InArray <hsize_t> -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
