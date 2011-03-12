#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.H5A where
#strict_import

import Bindings.HDF5.H5

import Bindings.HDF5.H5I -- IDs
import Bindings.HDF5.H5O -- Object Headers
import Bindings.HDF5.H5T -- Datatypes

import Foreign.Ptr.Conventions

-- |Information struct for attribute (for 'h5a_get_info'/'h5a_get_info_by_idx')
#starttype H5A_info_t
-- |Indicate if creation order is valid
#field corder_valid,    <hbool_t>
-- |Creation order
#field corder,          <H5O_msg_crt_idx_t>
-- |Character set of attribute name
#field cset,            <H5T_cset_t>
-- |Size of raw data
#field data_size,       <hsize_t>
#stoptype


-- | Typedef for 'h5a_iterate2' callbacks.
-- 
-- @
--  typedef herr_t (*H5A_operator2_t)(hid_t location_id/*in*/,
--     const char *attr_name/*in*/, const H5A_info_t *ainfo/*in*/, void *op_data/*in,out*/);
-- @
type H5A_operator2_t a = FunPtr (HId_t -> CString -> In H5A_info_t -> InOut a -> IO HErr_t)

-- * Public function prototypes

-- |Creates an attribute on an object
-- 
-- Parameters:
-- 
-- [@ loc_id    :: HId_t    @]  Object (dataset or group) to be attached to
--
-- [@ attr_name :: CString  @]  Name of attribute to locate and open
--
-- [@ type_id   :: HId_t    @]  ID of datatype for attribute
--
-- [@ space_id  :: HId_t    @]  ID of dataspace for attribute
--
-- [@ acpl_id   :: HId_t    @]  ID of creation property list (currently not used)
--
-- [@ aapl_id   :: HId_t    @]  Attribute access property list
-- 
-- Returns non-negative on success / negative on failure
--
-- This function creates an attribute which is attached to the object
-- specified with 'loc_id'.  The name specified with 'attr_name' for
-- each attribute for an object must be unique for that object.  The 'type_id'
-- and 'space_id' are created with the H5T and H5S interfaces respectively.
-- The 'aapl_id' property list is currently unused, but will be used in the
-- future for optional attribute access properties.  The attribute ID returned
-- from this function must be released with 'h5a_close' or resource leaks will
-- develop.
-- 
-- > hid_t   H5Acreate2(hid_t loc_id, const char *attr_name, hid_t type_id,
-- >     hid_t space_id, hid_t acpl_id, hid_t aapl_id);
#ccall H5Acreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Creates an attribute on an object
-- 
-- Parameters:
-- 
-- [@ loc_id    :: HId_t    @]  Object (dataset or group) to be attached to
-- [@ obj_name  :: CString  @]  Name of object relative to location
-- [@ attr_name :: CString  @]  Name of attribute to locate and open
-- [@ type_id   :: HId_t    @]  ID of datatype for attribute
-- [@ space_id  :: HId_t    @]  ID of dataspace for attribute
-- [@ acpl_id   :: HId_t    @]  ID of creation property list (currently not used)
-- [@ aapl_id   :: HId_t    @]  Attribute access property list
-- [@ lapl_id   :: HId_t    @]  Link access property list
-- 
-- Returns non-negative on success / negative on failure
--
-- This function creates an attribute which is attached to the object
-- specified with 'loc_id/obj_name'.  The name specified with 'attr_name' for
-- each attribute for an object must be unique for that object.  The 'type_id'
-- and 'space_id' are created with the H5T and H5S interfaces respectively.
-- The 'aapl_id' property list is currently unused, but will be used in the
-- future for optional attribute access properties.  The attribute ID returned
-- from this function must be released with h5a_close or resource leaks will
-- develop.
--
-- > hid_t   H5Acreate_by_name(hid_t loc_id, const char *obj_name, const char *attr_name,
-- >     hid_t type_id, hid_t space_id, hid_t acpl_id, hid_t aapl_id, hid_t lapl_id);
#ccall H5Acreate_by_name, <hid_t> -> CString -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Opens an attribute for an object by looking up the attribute name
--
-- Parameters:
-- 
-- [@ loc_id    :: HId_t   @]   Object that attribute is attached to
-- 
-- [@ attr_name :: CString @]   Name of attribute to locate and open
-- 
-- [@ aapl_id   :: HId_t   @]   Attribute access property list
-- 
-- Returns ID of attribute on success, negative on failure
--
-- This function opens an existing attribute for access.  The attribute
-- name specified is used to look up the corresponding attribute for the
-- object.  The attribute ID returned from this function must be released with
-- 'h5a_close' or resource leaks will develop.
--
-- > hid_t   H5Aopen(hid_t obj_id, const char *attr_name, hid_t aapl_id);
#ccall H5Aopen, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- |Opens an attribute for an object by looking up the attribute name
-- 
-- Parameters:
-- 
-- [@ loc_id    :: HId_t   @]   Object that attribute is attached to
-- 
-- [@ obj_name  :: CString @]   Name of object relative to location
-- 
-- [@ attr_name :: CString @]   Name of attribute to locate and open
-- 
-- [@ aapl_id   :: HId_t   @]   Attribute access property list
-- 
-- [@ lapl_id   :: HId_t   @]   Link access property list
-- 
-- Returns ID of attribute on success, negative on failure
--
-- This function opens an existing attribute for access.  The attribute
-- name specified is used to look up the corresponding attribute for the
-- object.  The attribute ID returned from this function must be released with
-- 'h5a_close' or resource leaks will develop.
-- 
-- > hid_t   H5Aopen_by_name(hid_t loc_id, const char *obj_name,
-- >     const char *attr_name, hid_t aapl_id, hid_t lapl_id);
#ccall H5Aopen_by_name, <hid_t> -> CString -> CString -> <hid_t> -> <hid_t> -> IO <hid_t>

-- hid_t   H5Aopen_by_idx(hid_t loc_id, const char *obj_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t aapl_id,
--     hid_t lapl_id);
#ccall H5Aopen_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- TODO: Figure out how many elements elements 'buf' is expected to contain, and why
-- |Write out data to an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id  :: HId_t      @] Attribute to write
-- 
-- [@ dtype_id :: HId_t      @] Memory datatype of buffer
-- 
-- [@ buf      :: InArray a  @] Buffer of data to write
-- 
-- Returns non-negative on success / negative on failure
--
-- This function writes a complete attribute to disk.
--
-- > herr_t  H5Awrite(hid_t attr_id, hid_t type_id, const void *buf);
#ccall H5Awrite, <hid_t> -> <hid_t> -> InArray a -> IO <herr_t>

-- |Read in data from an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id  :: HId_t      @] Attribute to read
-- 
-- [@ dtype_id :: HId_t      @] Memory datatype of buffer
-- 
-- [@ buf      :: OutArray a @] Buffer for data to read
-- 
-- Returns non-negative on success / negative on failure
--
-- This function reads a complete attribute from disk.
--
-- > herr_t  H5Aread(hid_t attr_id, hid_t type_id, void *buf);
#ccall H5Aread, <hid_t> -> <hid_t> -> OutArray a -> IO <herr_t>

-- |Close an attribute ID
-- 
-- Parameters:
-- 
-- [@ attr_id :: HId_t @]   Attribute to release access to
-- 
-- Returns non-negative on success / negative on failure
--
-- This function releases an attribute from use.  Further use of the
-- attribute ID will result in undefined behavior.
-- 
-- > herr_t  H5Aclose(hid_t attr_id);
#ccall H5Aclose, <hid_t> -> IO <herr_t>

-- |Gets a copy of the dataspace for an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id :: HId_t @]   Attribute to get dataspace of
-- 
-- Returns a dataspace ID on success, negative on failure
--
-- This function retrieves a copy of the dataspace for an attribute.
-- The dataspace ID returned from this function must be released with
-- 'h5s_close' or resource leaks will develop.
--
-- > hid_t   H5Aget_space(hid_t attr_id);
#ccall H5Aget_space, <hid_t> -> IO <hid_t>

-- |Gets a copy of the datatype for an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id :: HId_t @]   Attribute to get datatype of
-- 
-- Returns a datatype ID on success, negative on failure
--
-- This function retrieves a copy of the datatype for an attribute.
-- The datatype ID returned from this function must be released with
-- 'h5t_close' or resource leaks will develop.
--
-- > hid_t   H5Aget_type(hid_t attr_id);
#ccall H5Aget_type, <hid_t> -> IO <hid_t>

-- |Gets a copy of the creation property list for an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id :: HId_t @]   Attribute to get name of
-- 
-- This function returns the ID of a copy of the attribute's creation
-- property list, or negative on failure. The resulting ID must be closed
-- with 'h5p_close' or resource leaks will occur.
-- 
-- > hid_t   H5Aget_create_plist(hid_t attr_id);
#ccall H5Aget_create_plist, <hid_t> -> IO <hid_t>

-- TODO: check semantics of returned strings (null terminated and/or returns size?)
-- |Gets a copy of the name for an attribute
-- 
-- Parameters:
-- 
-- [@ attr_id  :: HId_t          @] Attribute to get name of
-- 
-- [@ buf_size :: CSize          @] The size of the buffer to store the string in.
-- 
-- [@ buf      :: OutArray CChar @] Buffer to store name in
-- 
-- This function returns the length of the attribute's name (which may be
-- longer than 'buf_size') on success or negative for failure.
--
-- This function retrieves the name of an attribute for an attribute ID.
-- Up to 'buf_size' characters are stored in 'buf' followed by a '\0' string
-- terminator.  If the name of the attribute is longer than 'buf_size'-1,
-- the string terminator is stored in the last position of the buffer to
-- properly terminate the string.
--
-- > ssize_t H5Aget_name(hid_t attr_id, size_t buf_size, char *buf);
#ccall H5Aget_name, <hid_t> -> <size_t> -> OutArray CChar -> IO <ssize_t>

-- |Retrieve name of an attribute, according to the order within an index.
--
-- Same pattern of behavior as 'h5i_get_name'
--
-- Returns non-negative length of name, with information in @name@ buffer 
-- on success / negative on failure
--
-- > ssize_t H5Aget_name_by_idx(hid_t loc_id, const char *obj_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
-- >     char *name /*out*/, size_t size, hid_t lapl_id);
#ccall H5Aget_name_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> OutArray CChar -> <size_t> -> <hid_t> -> IO <ssize_t>

-- |Returns the amount of storage size that is allocated for this attribute.
-- The return value may be zero if no data has been stored.
-- 
-- > hsize_t H5Aget_storage_size(hid_t attr_id);
#ccall H5Aget_storage_size, <hid_t> -> IO <hsize_t>

-- |Retrieve information about an attribute.
--
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t  H5Aget_info(hid_t attr_id, H5A_info_t *ainfo /*out*/);
#ccall H5Aget_info, <hid_t> -> Out <H5A_info_t> -> IO <herr_t>

-- |Retrieve information about an attribute by name.
--
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t  H5Aget_info_by_name(hid_t loc_id, const char *obj_name,
-- >     const char *attr_name, H5A_info_t *ainfo /*out*/, hid_t lapl_id);
#ccall H5Aget_info_by_name, <hid_t> -> CString -> CString -> Out H5A_info_t -> <hid_t> -> IO <herr_t>

-- |Retrieve information about an attribute, according to the order within an index.
--
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t  H5Aget_info_by_idx(hid_t loc_id, const char *obj_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
-- >     H5A_info_t *ainfo /*out*/, hid_t lapl_id);
#ccall H5Aget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5A_info_t> -> <hid_t> -> IO <herr_t>

-- |Rename an attribute
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t  H5Arename(hid_t loc_id, const char *old_name, const char *new_name);
#ccall H5Arename, <hid_t> -> CString -> CString -> IO <herr_t>

-- |Rename an attribute
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t  H5Arename_by_name(hid_t loc_id, const char *obj_name,
-- >     const char *old_attr_name, const char *new_attr_name, hid_t lapl_id);
#ccall H5Arename_by_name, <hid_t> -> CString -> CString -> CString -> <hid_t> -> IO <herr_t>

-- |Calls a user's function for each attribute on an object.
-- 
-- Parameters:
-- 
--  [@ loc_id :: HId_t          @]  Base location for object
-- 
--  [@ idx_type :: H5_index_t   @]  Type of index to use
-- 
--  [@ order :: H5_iter_order_t @]  Order to iterate over index
-- 
--  [@ idx :: InOut HSize_t     @]  Starting (IN) & Ending (OUT) attribute in index & order
-- 
--  [@ op :: H5A_operator2_t a  @]  User's function to pass each attribute to
-- 
--  [@ op_data :: InOut a       @]  User's data to pass through to iterator operator function
-- 
-- Returns a negative value if an error occurs, the return value of the
-- last operator if it was non-zero (which can be a negative value), or zero
-- if all attributes were processed.
--
-- This function interates over the attributes of dataset or group
-- specified with 'loc_id' & 'obj_name'.  For each attribute of the object,
-- the 'op_data' and some additional information (specified below) are passed
-- to the 'op' function.  The iteration begins with the '*idx'
-- object in the group and the next attribute to be processed by the operator
-- is returned in '*idx'.
-- 
-- The operation receives the ID for the group or dataset being iterated
-- over ('loc_id'), the name of the current attribute about the object
-- ('attr_name'), the attribute's \"info\" struct ('ainfo') and the pointer to
-- the operator data passed in to H5Aiterate2 ('op_data').  The return values
-- from an operator are:
-- 
--  * Zero causes the iterator to continue, returning zero when all
--    attributes have been processed.
--  
--  * Positive causes the iterator to immediately return that positive
--    value, indicating short-circuit success.  The iterator can be
--    restarted at the next attribute.
--  
--  * Negative causes the iterator to immediately return that value,
--    indicating failure.  The iterator can be restarted at the next
--    attribute.
-- 
-- > herr_t  H5Aiterate2(hid_t loc_id, H5_index_t idx_type,
-- >     H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data);
#ccall H5Aiterate2, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> InOut <hsize_t> -> H5A_operator2_t a -> InOut a -> IO <herr_t>

-- |Calls a user's function for each attribute on an object
-- 
-- Parameters:
-- 
-- [@ loc_id   :: HId_t             @]  Base location for object
-- 
-- [@ obj_name :: CString           @]  Name of object relative to location
-- 
-- [@ idx_type :: H5_index_t        @]  Type of index to use
-- 
-- [@ order    :: H5_iter_order_t   @]  Order to iterate over index
-- 
-- [@ idx      :: InOut HSize_t     @]  Starting (IN) & Ending (OUT) attribute in index & order
-- 
-- [@ op       :: H5A_operator2_t a @]  H5A_operator2_t IN: User's function to pass each attribute to
-- 
-- [@ op_data  :: InOut a           @]  User's data to pass through to iterator operator function
-- 
-- [@ lapl_id  :: HId_t             @]  Link access property list
-- 
-- Returns a negative value if an error occurs, the return value of the
-- last operator if it was non-zero (which can be a negative value), or zero
-- if all attributes were processed.
--
-- This function interates over the attributes of dataset or group
-- specified with 'loc_id' & 'obj_name'.  For each attribute of the object,
-- the 'op_data' and some additional information (specified below) are passed
-- to the 'op' function.  The iteration begins with the '*idx'
-- object in the group and the next attribute to be processed by the operator
-- is returned in '*idx'.
-- 
-- The operation receives the ID for the group or dataset being iterated
-- over ('loc_id'), the name of the current attribute about the object
-- ('attr_name'), the attribute's \"info\" struct ('ainfo') and the pointer to
-- the operator data passed in to H5Aiterate_by_name ('op_data').  The return values
-- from an operator are:
-- 
--  * Zero causes the iterator to continue, returning zero when all
--    attributes have been processed.
-- 
--  * Positive causes the iterator to immediately return that positive
--    value, indicating short-circuit success.  The iterator can be
--    restarted at the next attribute.
-- 
--  * Negative causes the iterator to immediately return that value,
--    indicating failure.  The iterator can be restarted at the next
--    attribute.
--
-- > herr_t  H5Aiterate_by_name(hid_t loc_id, const char *obj_name, H5_index_t idx_type,
-- >     H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data,
-- >     hid_t lapd_id);
#ccall H5Aiterate_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> Ptr <hsize_t> -> H5A_operator2_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- |Deletes an attribute from a location
-- 
-- Parameters:
-- 
-- [@ loc_id :: HId_t   @] Object (dataset or group) to have attribute deleted from
-- 
-- [@ name   :: CString @] Name of attribute to delete
-- 
-- Returns non-negative on success / negative on failure
-- 
-- This function removes the named attribute from a dataset or group.
--
-- > herr_t  H5Adelete(hid_t loc_id, const char *name);
#ccall H5Adelete, <hid_t> -> CString -> IO <herr_t>

-- |Deletes an attribute from a location
-- 
-- Parameters:
-- 
-- [@ loc_id    :: HId_t   @]   Object (dataset or group) to have attribute deleted from
-- 
-- [@ obj_name  :: CString @]   Name of object relative to location
-- 
-- [@ attr_name :: CString @]   Name of attribute to delete
-- 
-- [@ lapl_id   :: HId_t   @]   Link access property list
-- 
-- Returns non-negative on success / negative on failure
-- 
-- This function removes the named attribute from a dataset or group.
--
-- > herr_t  H5Adelete_by_name(hid_t loc_id, const char *obj_name,
-- >     const char *attr_name, hid_t lapl_id);
#ccall H5Adelete_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <herr_t>

-- |Deletes an attribute from a location, according to the order within an index
-- 
-- Parameters:
-- 
-- [@ loc_id   :: HId_t           @]    Base location for object
-- 
-- [@ obj_name :: CString         @]    Name of object relative to location
-- 
-- [@ idx_type :: H5_index_t      @]    Type of index to use
-- 
-- [@ order    :: H5_iter_order_t @]    Order to iterate over index
-- 
-- [@ n        :: HSize_t         @]    Offset within index
-- 
-- [@ lapl_id  :: HId_t           @]    Link access property list
-- 
-- Returns non-negative on success / negative on failure
-- 
-- This function removes an attribute from an object, using the 'idx_type'
-- index to delete the 'n'th attribute in 'order' direction in the index.  The
-- object is specified relative to the 'loc_id' with the 'obj_name' path.  To
-- remove an attribute on the object specified by 'loc_id', pass in @"."@ for
-- 'obj_name'.  The link access property list, 'lapl_id', controls aspects of
-- the group hierarchy traversal when using the 'obj_name' to locate the final
-- object to operate on.
--
-- > herr_t  H5Adelete_by_idx(hid_t loc_id, const char *obj_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Adelete_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- |Checks if an attribute with a given name exists on an opened object.
--
-- > htri_t H5Aexists(hid_t obj_id, const char *attr_name);
#ccall H5Aexists, <hid_t> -> CString -> IO <htri_t>

-- |Checks if an attribute with a given name exists on an object.
--
-- > htri_t H5Aexists_by_name(hid_t obj_id, const char *obj_name,
-- >     const char *attr_name, hid_t lapl_id);
#ccall H5Aexists_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <htri_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS
-- |Typedef for 'h5a_iterate1' callbacks
-- 
-- > typedef herr_t (*H5A_operator1_t)(hid_t location_id/*in*/,
-- >     const char *attr_name/*in*/, void *operator_data/*in,out*/);
type H5A_operator1_t a = FunPtr (HId_t -> CString -> InOut a -> IO HErr_t)

-- |Creates an attribute on an object
-- 
-- Parameters:
-- 
-- [@ loc_id   :: HId_t   @]    Object (dataset or group) to be attached to
-- 
-- [@ name     :: CString @]    Name of attribute to create
-- 
-- [@ type_id  :: HId_t   @]    ID of datatype for attribute
-- 
-- [@ space_id :: HId_t   @]    ID of dataspace for attribute
-- 
-- [@ plist_id :: HId_t   @]    ID of creation property list (currently not used)
-- 
-- Returns non-negative on success / negative on failure
--
-- This function creates an attribute which is attached to the object
-- specified with 'location_id'.  The name specified with 'name' for each
-- attribute for an object must be unique for that object.  The 'type_id'
-- and 'space_id' are created with the H5T and H5S interfaces respectively.
-- The attribute ID returned from this function must be released with
-- 'h5a_close' or resource leaks will develop.
--
-- Note: Deprecated in favor of 'h5a_create2'
-- 
-- > hid_t   H5Acreate1(hid_t loc_id, const char *name, hid_t type_id,
-- >     hid_t space_id, hid_t acpl_id);
#ccall H5Acreate1, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Opens an attribute for an object by looking up the attribute name
-- 
-- Parameters:
-- 
-- [@ loc_id :: HId_t   @]  Object (dataset or group) to be attached to
-- 
-- [@ name   :: CString @]  Name of attribute to locate and open
-- 
-- Returns ID of attribute on success, negative on failure
--
-- This function opens an existing attribute for access.  The attribute
-- name specified is used to look up the corresponding attribute for the
-- object.  The attribute ID returned from this function must be released with
-- H5Aclose or resource leaks will develop.
-- 
-- The location object may be either a group or a dataset, both of
-- which may have any sort of attribute.
-- 
-- Note: Deprecated in favor of 'h5a_open'
-- 
-- > hid_t   H5Aopen_name(hid_t loc_id, const char *name);
#ccall H5Aopen_name, <hid_t> -> CString -> IO <hid_t>

-- |Opens the n'th attribute for an object
-- 
-- Parameters:
-- 
-- [@ loc_id :: HId_t @]   Object that attribute is attached to
-- 
-- [@ idx    :: CUInt @]   Index (0-based) attribute to open
-- 
-- Returns ID of attribute on success, negative on failure
--
-- This function opens an existing attribute for access.  The attribute
-- index specified is used to look up the corresponding attribute for the
-- object.  The attribute ID returned from this function must be released with
-- 'h5a_close' or resource leaks will develop.
-- 
-- The location object may be either a group or a dataset, both of
-- which may have any sort of attribute.
-- 
-- Note: Deprecated in favor of 'h5a_open_by_idx'
--
-- > hid_t   H5Aopen_idx(hid_t loc_id, unsigned idx);
#ccall H5Aopen_idx, <hid_t> -> CUInt -> IO <hid_t>

-- |Determines the number of attributes attached to an object
-- 
-- Parameters:
-- 
-- [@ loc_id :: HId_t @]    Object (dataset or group) to be queried
-- 
-- Returns number of attributes on success, negative on failure
-- 
-- This function returns the number of attributes attached to a dataset or
-- group, 'location_id'.
-- 
-- Note: Deprecated in favor of 'h5o_get_info'
-- 
-- > int H5Aget_num_attrs(hid_t loc_id);
#ccall H5Aget_num_attrs, <hid_t> -> IO CInt

-- |Calls a user's function for each attribute on an object
-- 
-- Parameters:
-- 
-- [@ loc_id   :: HId_t             @]  Object (dataset or group) to be iterated over
-- 
-- [@ attr_num :: InOut CUInt       @]  Starting (IN) & Ending (OUT) attribute number
-- 
-- [@ op       :: H5A_operator1_t a @]  User's function to pass each attribute to
-- 
-- [@ op_data  :: InOut a           @]  User's data to pass through to iterator operator function
-- 
-- Returns a negative value if something is wrong, the return value of the
-- last operator if it was non-zero, or zero if all attributes were processed.
--
-- This function interates over the attributes of dataset or group
-- specified with 'loc_id'.  For each attribute of the object, the
-- 'op_data' and some additional information (specified below) are passed
-- to the 'op' function.  The iteration begins with the 'attr_num'
-- object in the group and the next attribute to be processed by the operator
-- is returned in 'attr_num'.
-- 
-- The operation receives the ID for the group or dataset being iterated
-- over ('loc_id'), the name of the current attribute about the object
-- ('attr_name') and the pointer to the operator data passed in to 'h5a_iterate1'
-- ('op_data').  The return values from an operator are:
-- 
--  * Zero causes the iterator to continue, returning zero when all
--    attributes have been processed.
-- 
--  * Positive causes the iterator to immediately return that positive
--    value, indicating short-circuit success.  The iterator can be
--    restarted at the next attribute.
-- 
--  * Negative causes the iterator to immediately return that value,
--    indicating failure.  The iterator can be restarted at the next
--    attribute.
-- 
-- Note: Deprecated in favor of 'h5a_iterate2'
--
-- > herr_t  H5Aiterate1(hid_t loc_id, unsigned *attr_num, H5A_operator1_t op,
-- >     void *op_data);
#ccall H5Aiterate1, <hid_t> -> Ptr CUInt -> H5A_operator1_t a -> Ptr a -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
