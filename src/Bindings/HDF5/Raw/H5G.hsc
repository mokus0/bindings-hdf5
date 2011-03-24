#include <bindings.h>
#include <H5Gpublic.h>

module Bindings.HDF5.Raw.H5G where
#strict_import

import Bindings.HDF5.Raw.H5

import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5L
import Bindings.HDF5.Raw.H5O
import Bindings.HDF5.Raw.H5T

import Foreign.Ptr.Conventions

-- |Types of link storage for groups
#newtype H5G_storage_type_t, Eq

-- |Unknown link storage type
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_UNKNOWN

-- |Links in group are stored with a \"symbol table\"
-- (this is sometimes called \"old-style\" groups)
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_SYMBOL_TABLE

-- |Links are stored in object header
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_COMPACT

-- |Links are stored in fractal heap & indexed with v2 B-tree
#newtype_const H5G_storage_type_t, H5G_STORAGE_TYPE_DENSE

-- |Information struct for group (for 'h5g_get_info' / 'h5g_get_info_by_name' / 'h5g_get_info_by_idx')
#starttype H5G_info_t

-- |Type of storage for links in group
#field storage_type,    <H5G_storage_type_t>

-- |Number of links in group
#field nlinks,          <hsize_t>

-- |Current max. creation order value for group
#field max_corder,      Int64

#if H5_VERSION_ATLEAST(1,8,2)
-- |Whether group has a file mounted on it
#field mounted,         <hbool_t>
#endif

#stoptype


-- |Creates a new group relative to 'loc_id', giving it the
-- specified creation property list 'gcpl_id' and access
-- property list 'gapl_id'.  The link to the new group is
-- created with the 'lcpl_id'.
--
-- Parameters:
-- 
-- [@ loc_id  :: 'HId_t'   @]   File or group identifier
-- 
-- [@ name    :: 'CString' @]   Absolute or relative name of the new group
-- 
-- [@ lcpl_id :: 'HId_t'   @]   Property list for link creation
-- 
-- [@ gcpl_id :: 'HId_t'   @]   Property list for group creation
-- 
-- [@ gapl_id :: 'HId_t'   @]   Property list for group access
--
-- On success, returns the object ID of a new, empty group open for
-- writing.  Call 'h5g_close' when finished with the group.
-- Returns a negative value on failure.
--
-- > hid_t H5Gcreate2(hid_t loc_id, const char *name, hid_t lcpl_id,
-- >     hid_t gcpl_id, hid_t gapl_id);
#ccall H5Gcreate2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Creates a new group relative to 'loc_id', giving it the
-- specified creation property list 'gcpl_id' and access
-- property list 'gapl_id'.
-- 
-- The resulting ID should be linked into the file with
-- 'h5o_link' or it will be deleted when closed.
-- 
-- Given the default setting, 'h5g_create_anon' followed by
-- 'h5o_link' will have the same function as 'h5g_create2'.
-- 
-- Parameters: 
-- 
-- [@ loc_id  :: 'HId_t'   @] File or group identifier
-- 
-- [@ name    :: 'CString' @] Absolute or relative name of the new group
-- 
-- [@ gcpl_id :: 'HId_t'   @] Property list for group creation
-- 
-- [@ gapl_id :: 'HId_t'   @] Property list for group access
--
-- Example:  To create missing groups \"A\" and \"B01\" along the given path
-- \"/A/B01/grp\" (TODO: translate to Haskell):
-- 
-- > hid_t create_id = H5Pcreate(H5P_GROUP_CREATE);
-- > int   status = H5Pset_create_intermediate_group(create_id, TRUE);
-- > hid_t gid = H5Gcreate_anon(file_id, "/A/B01/grp", create_id, H5P_DEFAULT);
--
-- On success, returns the object ID of a new, empty group open for
-- writing.  Call 'h5g_close' when finished with the group.
-- On failure, returns a negative value.
--
-- > hid_t H5Gcreate_anon(hid_t loc_id, hid_t gcpl_id, hid_t gapl_id);
#ccall H5Gcreate_anon, <hid_t> -> <hid_t> -> <hid_t> -> IO <hid_t>

-- |Opens an existing group for modification.  When finished,
-- call 'h5g_close' to close it and release resources.
--
-- This function allows the user the pass in a Group Access
-- Property List, which 'h5g_open1' does not.
--
-- On success, returns the object ID of the group.
-- On failure, returns a negative value.
--
-- > hid_t H5Gopen2(hid_t loc_id, const char *name, hid_t gapl_id);
#ccall H5Gopen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- |Returns a copy of the group creation property list.
-- 
-- On success, returns the ID for a copy of the group creation
-- property list.  The property list ID should be released by
-- calling 'h5p_close'.
-- 
-- > hid_t H5Gget_create_plist(hid_t group_id);
#ccall H5Gget_create_plist, <hid_t> -> IO <hid_t>

-- |Retrieve information about a group.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Gget_info(hid_t loc_id, H5G_info_t *ginfo);
#ccall H5Gget_info, <hid_t> -> Out <H5G_info_t> -> IO <herr_t>

-- |Retrieve information about a group.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Gget_info_by_name(hid_t loc_id, const char *name, H5G_info_t *ginfo,
-- >     hid_t lapl_id);
#ccall H5Gget_info_by_name, <hid_t> -> CString -> Out <H5G_info_t> -> <hid_t> -> IO <herr_t>

-- |Retrieve information about a group, according to the order of an index.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Gget_info_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5G_info_t *ginfo,
-- >     hid_t lapl_id);
#ccall H5Gget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5G_info_t> -> <hid_t> -> IO <herr_t>

-- |Closes the specified group.  The group ID will no longer be
-- valid for accessing the group.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Gclose(hid_t group_id);
#ccall H5Gclose, <hid_t> -> IO <herr_t>


#ifndef H5_NO_DEPRECATED_SYMBOLS

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

-- |An object has a certain type. The first few numbers are reserved for use
-- internally by HDF5. Users may add their own types with higher values.  The
-- values are never stored in the file - they only exist while an application
-- is running.  An object may satisfy the 'isa' function for more than one type.
#newtype H5G_obj_t, Eq

-- |Unknown object type
#newtype_const H5G_obj_t, H5G_UNKNOWN

-- |Object is a group
#newtype_const H5G_obj_t, H5G_GROUP

-- |Object is a dataset
#newtype_const H5G_obj_t, H5G_DATASET

-- |Object is a named data type
#newtype_const H5G_obj_t, H5G_TYPE

-- |Object is a symbolic link
#newtype_const H5G_obj_t, H5G_LINK

-- |Object is a user-defined link
#newtype_const H5G_obj_t, H5G_UDLINK

-- |Reserved for future use
#newtype_const H5G_obj_t, H5G_RESERVED_5

-- |Reserved for future use
#newtype_const H5G_obj_t, H5G_RESERVED_6

-- |Reserved for future use
#newtype_const H5G_obj_t, H5G_RESERVED_7

-- |Type of 'h5g_iterate' operator
-- 
-- > typedef herr_t (*H5G_iterate_t)(hid_t group, const char *name, void *op_data);
type H5G_iterate_t a = FunPtr (HId_t -> CString -> InOut a -> IO HErr_t)

-- |Information about an object
#starttype H5G_stat_t

-- |file number
#array_field fileno,    CULong

-- |object number
#array_field objno,     CULong

-- |number of hard links to object
#field nlink,           CUInt

-- |basic object type
#field type,            <H5G_obj_t>

-- |modification time
#field mtime,           <time_t>

-- |symbolic link value length
#field linklen,         <size_t>

-- |Object header information
#field ohdr,            <H5O_stat_t>
#stoptype


-- |Creates a new group relative to 'loc_id' and gives it the
-- specified 'name'.  The group is opened for write access
-- and it's object ID is returned.
-- 
-- The optional 'size_hint' specifies how much file space to
-- reserve to store the names that will appear in this
-- group. If a non-positive value is supplied for the 'size_hint'
-- then a default size is chosen.
--
-- Note:  Deprecated in favor of 'h5g_create2'
--
-- On success, returns the object ID of a new, empty group open for
-- writing.  Call 'h5g_close' when finished with the group.
-- On failure, returns a negative value.
--
-- > hid_t H5Gcreate1(hid_t loc_id, const char *name, size_t size_hint);
#ccall H5Gcreate1, <hid_t> -> CString -> <size_t> -> IO <hid_t>

-- |Opens an existing group for modification.  When finished,
-- call 'h5g_close' to close it and release resources.
-- 
-- Note:  Deprecated in favor of 'h5g_open2'
-- 
-- On success, returns the Object ID of the group.
-- On failure, returns a negative value.
-- 
-- > hid_t H5Gopen1(hid_t loc_id, const char *name);
#ccall H5Gopen1, <hid_t> -> CString -> IO <hid_t>

-- |Creates a link between two existing objects.  The new
-- APIs to do this are 'h5l_create_hard' and 'h5l_create_soft'.
-- 
-- > herr_t H5Glink(hid_t cur_loc_id, H5G_link_t type, const char *cur_name,
-- >     const char *new_name);
#ccall H5Glink, <hid_t> -> <H5G_link_t> -> CString -> CString -> IO <herr_t>

-- |Creates a link between two existing objects.  The new
-- APIs to do this are 'h5l_create_hard' and 'h5l_create_soft'.
-- 
-- herr_t H5Glink2(hid_t cur_loc_id, const char *cur_name, H5G_link_t type,
--     hid_t new_loc_id, const char *new_name);
#ccall H5Glink2, <hid_t> -> CString -> <H5G_link_t> -> <hid_t> -> CString -> IO <herr_t>

-- |Moves and renames a link.  The new API to do this is 'h5l_move'.
-- 
-- > herr_t H5Gmove(hid_t src_loc_id, const char *src_name,
-- >     const char *dst_name);
#ccall H5Gmove, <hid_t> -> CString -> CString -> IO <herr_t>

-- |Moves and renames a link.  The new API to do this is 'h5l_move'.
-- 
-- > herr_t H5Gmove2(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
-- >     const char *dst_name);
#ccall H5Gmove2, <hid_t> -> CString -> <hid_t> -> CString -> IO <herr_t>

-- |Removes a link.  The new API is 'h5l_delete' / 'h5l_delete_by_idx'.
-- 
-- > herr_t H5Gunlink(hid_t loc_id, const char *name);
#ccall H5Gunlink, <hid_t> -> CString -> IO <herr_t>

-- |Retrieve's a soft link's data.  The new API is 'h5l_get_val' / 'h5l_get_val_by_idx'.
-- 
-- > herr_t H5Gget_linkval(hid_t loc_id, const char *name, size_t size,
-- >     char *buf/*out*/);
#ccall H5Gget_linkval, <hid_t> -> CString -> <size_t> -> OutArray a -> IO <herr_t>

-- |Gives the specified object a comment.  The 'comment' string
-- should be a null terminated string.  An object can have only
-- one comment at a time.  Passing 'nullPtr' for the 'comment' argument
-- will remove the comment property from the object.
-- 
-- Note:  Deprecated in favor of 'h5o_set_comment' / 'h5o_set_comment_by_name'
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Gset_comment(hid_t loc_id, const char *name, const char *comment);
#ccall H5Gset_comment, <hid_t> -> CString -> CString -> IO <herr_t>

-- |Return at most 'bufsize' characters of the comment for the
-- specified object.  If 'bufsize' is large enough to hold the
-- entire comment then the comment string will be null
-- terminated, otherwise it will not.  If the object does not
-- have a comment value then no bytes are copied to the BUF
-- buffer.
--
-- Note:  Deprecated in favor of 'h5o_get_comment' / 'h5o_get_comment_by_name'
--
-- On success, returns the number of characters in the comment counting
-- the null terminator.  The value returned may be larger than the 'bufsize'
-- argument.
--
-- > int H5Gget_comment(hid_t loc_id, const char *name, size_t bufsize,
-- >     char *buf);
#ccall H5Gget_comment, <hid_t> -> CString -> <size_t> -> OutArray CChar -> IO CInt

-- |Iterates over the entries of a group.  The 'loc_id' and 'name'
-- identify the group over which to iterate and 'idx' indicates
-- where to start iterating (zero means at the beginning).	 The
-- 'operator' is called for each member and the iteration
-- continues until the operator returns non-zero or all members
-- are processed. The operator is passed a group ID for the
-- group being iterated, a member name, and 'op_data' for each
-- member.
-- 
-- Note:	Deprecated in favor of 'h5l_iterate'
-- 
-- Returns the return value of the first operator that
-- returns non-zero, or zero if all members were
-- processed with no operator returning non-zero.
-- 
-- Returns negative if something goes wrong within the
-- library, or the negative value returned by one
-- of the operators.
-- 
-- > herr_t H5Giterate(hid_t loc_id, const char *name, int *idx,
-- >         H5G_iterate_t op, void *op_data);
#ccall H5Giterate, <hid_t> -> CString -> InOut CInt -> H5G_iterate_t a -> InOut a -> IO <herr_t>

-- |Returns the number of objects in the group.  It iterates
-- all B-tree leaves and sum up total number of group members.
--
-- Note:  Deprecated in favor of 'h5g_get_info'
-- 
-- Returns non-negative on success, negative on failure
-- 
-- > herr_t H5Gget_num_objs(hid_t loc_id, hsize_t *num_objs);
#ccall H5Gget_num_objs, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- |Returns information about an object.  If 'follow_link' is
-- non-zero then all symbolic links are followed; otherwise all
-- links except the last component of the name are followed.
--
-- Note:  Deprecated in favor of 'h5l_get_info' / 'h5o_get_info'
--
-- Returns non-negative on success, with the fields of 'statbuf' (if
-- non-null) initialized. Negative on failure.
--
-- > herr_t H5Gget_objinfo(hid_t loc_id, const char *name,
-- >     hbool_t follow_link, H5G_stat_t *statbuf/*out*/);
#ccall H5Gget_objinfo, <hid_t> -> CString -> <hbool_t> -> Out <H5G_stat_t> -> IO <herr_t>

-- |Returns the name of objects in the group by giving index.
-- If 'name' is non-NULL then write up to 'size' bytes into that
-- buffer and always return the length of the entry name.
-- Otherwise 'size' is ignored and the function does not store the name,
-- just returning the number of characters required to store the name.
-- If an error occurs then the buffer pointed to by 'name' (NULL or non-NULL)
-- is unchanged and the function returns a negative value.
-- If a zero is returned for the name's length, then there is no name
-- associated with the ID.
-- 
-- Note:  Deprecated in favor of 'h5l_get_name_by_idx'
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > ssize_t H5Gget_objname_by_idx(hid_t loc_id, hsize_t idx, char* name,
-- >     size_t size);
#ccall H5Gget_objname_by_idx, <hid_t> -> <hsize_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Returns the type of objects in the group by giving index.
-- 
-- Note:  Deprecated in favor of 'h5l_get_info' / 'h5o_get_info'
-- 
-- Returns 'h5g_GROUP', 'h5g_DATASET', or 'h5g_TYPE' on success, or
-- 'h5g_UNKNOWN' on failure.
-- 
-- > H5G_obj_t H5Gget_objtype_by_idx(hid_t loc_id, hsize_t idx);
#ccall H5Gget_objtype_by_idx, <hid_t> -> <hsize_t> -> IO <H5G_obj_t>


#endif /* H5_NO_DEPRECATED_SYMBOLS */
