#include <bindings.h>
#include <H5Lpublic.h>

module Bindings.HDF5.Raw.H5L where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5T

import Foreign.Ptr.Conventions

-- |Maximum length of a link's name
-- (encoded in a 32-bit unsigned integer)
h5l_MAX_LINK_NAME_LEN :: Word32
h5l_MAX_LINK_NAME_LEN = #const H5L_MAX_LINK_NAME_LEN

-- |Macro to indicate operation occurs on same location
#newtype_const hid_t, H5L_SAME_LOC

-- |Current version of the H5L_class_t struct
#num H5L_LINK_CLASS_T_VERS

-- |Link class types.
-- 
-- Values less than 64 are reserved for the HDF5 library's internal use.
-- Values 64 to 255 are for "user-defined" link class types; these types are
-- defined by HDF5 but their behavior can be overridden by users.
-- Users who want to create new classes of links should contact the HDF5
-- development team at <mailto:hdfhelp@ncsa.uiuc.edu>.
-- 
-- These values can never change because they appear in HDF5 files.
#newtype H5L_type_t, Eq

-- |Invalid link type id
#newtype_const H5L_type_t, H5L_TYPE_ERROR

-- |Hard link id
#newtype_const H5L_type_t, H5L_TYPE_HARD

-- |Soft link id
#newtype_const H5L_type_t, H5L_TYPE_SOFT

-- |External link id
#newtype_const H5L_type_t, H5L_TYPE_EXTERNAL

-- |Maximum link type id
#newtype_const H5L_type_t, H5L_TYPE_MAX

-- |Maximum value link value for \"built-in\" link types
#newtype_const H5L_type_t, H5L_TYPE_BUILTIN_MAX

-- |Link ids at or above this value are \"user-defined\" link types.
#newtype_const H5L_type_t, H5L_TYPE_UD_MIN

-- |Information struct for link (for 'h5l_get_info' / 'h5l_get_info_by_idx')
#starttype H5L_info_t

-- |Type of link
#field type,                <H5L_type_t>

-- |Indicate if creation order is valid
#field corder_valid,        <hbool_t>

-- |Creation order
#field corder,              Int64

-- |Character set of link name
#field cset,                <H5T_cset_t>

-- |Address hard link points to
#union_field u.address,     <haddr_t>

-- |Size of a soft link or UD link value
#union_field u.val_size,    <size_t>
#stoptype


-- /* The H5L_class_t struct can be used to override the behavior of a
--  * "user-defined" link class. Users should populate the struct with callback
--  * functions defined below.
--  */

-- * Callback prototypes for user-defined links

-- |Link creation callback
-- 
-- > typedef herr_t (*H5L_create_func_t)(const char *link_name, hid_t loc_group,
-- >     const void *lnkdata, size_t lnkdata_size, hid_t lcpl_id);
type H5L_create_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> HId_t -> IO HErr_t)

-- |Callback for when the link is moved
-- 
-- > typedef herr_t (*H5L_move_func_t)(const char *new_name, hid_t new_loc,
-- >     const void *lnkdata, size_t lnkdata_size);
type H5L_move_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- |Callback for when the link is copied
-- 
-- > typedef herr_t (*H5L_copy_func_t)(const char *new_name, hid_t new_loc,
-- >     const void *lnkdata, size_t lnkdata_size);
type H5L_copy_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- |Callback during link traversal
-- 
-- > typedef herr_t (*H5L_traverse_func_t)(const char *link_name, hid_t cur_group,
-- >     const void *lnkdata, size_t lnkdata_size, hid_t lapl_id);
type H5L_traverse_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> HId_t -> IO HErr_t)

-- |Callback for when the link is deleted
-- 
-- > typedef herr_t (*H5L_delete_func_t)(const char *link_name, hid_t file,
-- >     const void *lnkdata, size_t lnkdata_size);
type H5L_delete_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- |Callback for querying the link
--
-- Returns the size of the buffer needed
-- 
-- > typedef ssize_t (*H5L_query_func_t)(const char *link_name, const void *lnkdata,
-- >     size_t lnkdata_size, void *buf /*out*/, size_t buf_size);
type H5L_query_func_t a b = FunPtr (CString -> Ptr a -> CSize -> Out b -> CSize -> IO CSSize)

-- |User-defined link types
#starttype H5L_class_t

-- |Version number of this struct
#field version,     CInt

-- |Link type ID
#field id,          <H5L_type_t>

-- |Comment for debugging
#field comment,     CString

-- |Callback during link creation
#field create_func, H5L_create_func_t ()

-- |Callback after moving link
#field move_func,   H5L_move_func_t ()

-- |Callback after copying link
#field copy_func,   H5L_copy_func_t ()

-- |Callback during link traversal
#field trav_func,   H5L_traverse_func_t ()

-- |Callback for link deletion
#field del_func,    H5L_delete_func_t ()

-- |Callback for queries
#field query_func,  H5L_query_func_t () ()
#stoptype


-- |Prototype for 'h5l_iterate' / 'h5l_iterate_by_name' operator
-- 
-- > typedef herr_t (*H5L_iterate_t)(hid_t group, const char *name, const H5L_info_t *info,
-- >     void *op_data);
type H5L_iterate_t a = FunPtr (HId_t -> CString -> In H5L_info_t -> InOut a -> IO HErr_t)

-- |Callback for external link traversal
--
-- > typedef herr_t (*H5L_elink_traverse_t)(const char *parent_file_name,
-- >     const char *parent_group_name, const char *child_file_name,
-- >     const char *child_object_name, unsigned *acc_flags, hid_t fapl_id,
-- >     void *op_data);
type H5L_elink_traverse_t a = FunPtr (CString 
    -> CString -> CString
    -> CString -> Ptr CUInt -> HId_t
    -> InOut a -> IO HErr_t)

-- |Renames an object within an HDF5 file and moves it to a new
-- group.  The original name 'src' is unlinked from the group graph
-- and then inserted with the new name 'dst' (which can specify a
-- new path for the object) as an atomic operation. The names
-- are interpreted relative to 'src_loc_id' and
-- 'dst_loc_id', which are either file IDs or group ID.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lmove(hid_t src_loc, const char *src_name, hid_t dst_loc,
-- >     const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lmove, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Creates an identical copy of a link with the same creation
-- time and target.  The new link can have a different name
-- and be in a different location than the original.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lcopy(hid_t src_loc, const char *src_name, hid_t dst_loc,
-- >     const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcopy, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Creates a hard link from 'new_name' to 'cur_name'.
--
-- 'cur_name' must name an existing object.  'cur_name' and
-- 'new_name' are interpreted relative to 'cur_loc_id' and
-- 'new_loc_id', which are either file IDs or group IDs.
--
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Lcreate_hard(hid_t cur_loc, const char *cur_name,
-- >     hid_t dst_loc, const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_hard, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Creates a soft link from 'link_name' to 'link_target'.
-- 
-- 'link_target' can be anything and is interpreted at lookup
-- time relative to the group which contains the final component
-- of 'link_name'.  For instance, if 'link_target' is \"./foo\" and
-- 'link_name' is \"./x/y/bar\" and a request is made for \"./x/y/bar\"
-- then the actual object looked up is \"./x/y/./foo\".
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Lcreate_soft(const char *link_target, hid_t link_loc_id,
-- >     const char *link_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_soft, CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Removes the specified 'name' from the group graph and
-- decrements the link count for the object to which 'name'
-- points.  If the link count reaches zero then all file-space
-- associated with the object will be reclaimed (but if the
-- object is open, then the reclamation of the file space is
-- delayed until all handles to the object are closed).
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Ldelete(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Ldelete, <hid_t> -> CString -> <hid_t> -> IO <herr_t>

-- |Removes the specified link from the group graph and
-- decrements the link count for the object to which it
-- points, according to the order within an index.
-- 
-- If the link count reaches zero then all file-space
-- associated with the object will be reclaimed (but if the
-- object is open, then the reclamation of the file space is
-- delayed until all handles to the object are closed).
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Ldelete_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Ldelete_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- |Returns the link value of a link whose name is 'name'.  For
-- symbolic links, this is the path to which the link points,
-- including the null terminator.  For user-defined links, it
-- is the link buffer.
-- 
-- At most 'size' bytes are copied to the 'buf' result buffer.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Lget_val(hid_t loc_id, const char *name, void *buf/*out*/,
-- >     size_t size, hid_t lapl_id);
#ccall H5Lget_val, <hid_t> -> CString -> Ptr a -> <size_t> -> <hid_t> -> IO <herr_t>

-- |Returns the link value of a link, according to the order of
-- an index.  For symbolic links, this is the path to which the
-- link points, including the null terminator.  For user-defined
-- links, it is the link buffer.
-- 
-- At most 'size' bytes are copied to the 'buf' result buffer.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Lget_val_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
-- >     void *buf/*out*/, size_t size, hid_t lapl_id);
#ccall H5Lget_val_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Ptr a -> CSize -> <hid_t> -> IO <herr_t>

-- |Checks if a link of a given name exists in a group
-- 
-- > htri_t H5Lexists(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Lexists, <hid_t> -> CString -> <hid_t> -> IO <htri_t>

-- |Gets metadata for a link.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Lget_info(hid_t loc_id, const char *name,
-- >     H5L_info_t *linfo /*out*/, hid_t lapl_id);
#ccall H5Lget_info, <hid_t> -> CString -> Out <H5L_info_t> -> <hid_t> -> IO <herr_t>

-- |Gets metadata for a link, according to the order within an index.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Lget_info_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
-- >     H5L_info_t *linfo /*out*/, hid_t lapl_id);
#ccall H5Lget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5L_info_t> -> <hid_t> -> IO <herr_t>

-- |Gets name for a link, according to the order within an index.
--
-- Same pattern of behavior as 'h5i_get_name'.
--
-- On success, returns non-negative length of name, with information
-- in 'name' buffer
-- On failure,returns a negative value.
--
-- > ssize_t H5Lget_name_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
-- >     char *name /*out*/, size_t size, hid_t lapl_id);
#ccall H5Lget_name_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> OutArray CChar -> <ssize_t> -> <hid_t> -> IO <ssize_t>

-- |Iterates over links in a group, with user callback routine,
-- according to the order within an index.
--
-- Same pattern of behavior as 'h5g_iterate'.
--
-- Returns the return value of the first operator that returns non-zero, 
-- or zero if all members were processed with no operator returning non-zero.
--
-- Returns negative if something goes wrong within the library, or the
-- negative value returned by one of the operators.
--
-- > herr_t H5Literate(hid_t grp_id, H5_index_t idx_type,
-- >     H5_iter_order_t order, hsize_t *idx, H5L_iterate_t op, void *op_data);
#ccall H5Literate, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> InOut <hsize_t> -> H5L_iterate_t a -> InOut a -> IO <herr_t>

-- |Iterates over links in a group, with user callback routine,
-- according to the order within an index.
--
-- Same pattern of behavior as 'h5g_iterate'.
--
-- Returns the return value of the first operator that returns non-zero, 
-- or zero if all members were processed with no operator returning non-zero.
--
-- Returns negative if something goes wrong within the library, or the
-- negative value returned by one of the operators.
--
-- > herr_t H5Literate_by_name(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t *idx,
-- >     H5L_iterate_t op, void *op_data, hid_t lapl_id);
#ccall H5Literate_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> InOut <hsize_t> -> H5L_iterate_t a -> InOut a -> <hid_t> -> IO <herr_t>

-- |Recursively visit all the links in a group and all
-- the groups that are linked to from that group.  Links within
-- each group are visited according to the order within the
-- specified index (unless the specified index does not exist for
-- a particular group, then the \"name\" index is used).
-- 
-- NOTE: Each _link_ reachable from the initial group will only be
-- visited once.  However, because an object may be reached from
-- more than one link, the visitation may call the application's
-- callback with more than one link that points to a particular
-- _object_.
--
-- Returns the return value of the first operator that
-- returns non-zero, or zero if all members were
-- processed with no operator returning non-zero.
--
-- Returns negative if something goes wrong within the
-- library, or the negative value returned by one
-- of the operators.
--
-- > herr_t H5Lvisit(hid_t grp_id, H5_index_t idx_type, H5_iter_order_t order,
-- >     H5L_iterate_t op, void *op_data);
#ccall H5Lvisit, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> H5L_iterate_t a -> Ptr a -> IO <herr_t>

-- |Recursively visit all the links in a group and all
-- the groups that are linked to from that group.  Links within
-- each group are visited according to the order within the
-- specified index (unless the specified index does not exist for
-- a particular group, then the \"name\" index is used).
-- 
-- NOTE: Each _link_ reachable from the initial group will only be
-- visited once.  However, because an object may be reached from
-- more than one link, the visitation may call the application's
-- callback with more than one link that points to a particular
-- _object_.
--
-- Returns the return value of the first operator that
-- returns non-zero, or zero if all members were
-- processed with no operator returning non-zero.
--
-- Returns negative if something goes wrong within the
-- library, or the negative value returned by one
-- of the operators.
--
-- > herr_t H5Lvisit_by_name(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, H5L_iterate_t op,
-- >     void *op_data, hid_t lapl_id);
#ccall H5Lvisit_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> H5L_iterate_t a -> InOut a -> <hid_t> -> IO <herr_t>

-- |Creates a user-defined link of type 'link_type' named 'link_name'
-- with user-specified data 'udata'.
--
-- The format of the information pointed to by 'udata' is
-- defined by the user. 'udata_size' holds the size of this buffer.
-- 
-- 'link_name' is interpreted relative to 'link_loc_id'.
-- 
-- The property list specified by 'lcpl_id' holds properties used
-- to create the link.
-- 
-- The link class of the new link must already be registered
-- with the library.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lcreate_ud(hid_t link_loc_id, const char *link_name,
-- >     H5L_type_t link_type, const void *udata, size_t udata_size, hid_t lcpl_id,
-- >     hid_t lapl_id);
#ccall H5Lcreate_ud, <hid_t> -> CString -> <H5L_type_t> -> In a -> <size_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Registers a class of user-defined links, or changes the
-- behavior of an existing class.
-- 
-- The link class passed in will override any existing link
-- class for the specified link class ID. It must at least
-- include a 'H5L_class_t' version (which should be
-- 'h5l_LINK_CLASS_T_VERS'), a link class ID, and a traversal
-- function.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lregister(const H5L_class_t *cls);
#ccall H5Lregister, In <H5L_class_t> -> IO <herr_t>

-- |Unregisters a class of user-defined links, preventing them
-- from being traversed, queried, moved, etc.
-- 
-- A link class can be re-registered using 'h5l_register'.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lunregister(H5L_type_t id);
#ccall H5Lunregister, <H5L_type_t> -> IO <herr_t>

-- |Tests whether a user-defined link class has been registered
-- or not.
--
-- > htri_t H5Lis_registered(H5L_type_t id);
#ccall H5Lis_registered, <H5L_type_t> -> IO <htri_t>

-- |Given a buffer holding the \"link value\" from an external link,
-- gets pointers to the information within the link value buffer.
-- 
-- External link link values contain some flags and
-- two NULL-terminated strings, one after the other.
-- 
-- The 'flags' value will be filled in and 'filename' and
-- 'obj_path' will be set to pointers within 'ext_linkval' (unless
-- any of these values is NULL).
-- 
-- Using this function on strings that aren't external link
-- 'udata' buffers can result in segmentation faults.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lunpack_elink_val(const void *ext_linkval/*in*/, size_t link_size,
-- >    unsigned *flags, const char **filename/*out*/, const char **obj_path /*out*/);
#ccall H5Lunpack_elink_val, In a -> <size_t> -> Ptr CUInt -> Out CString -> Out CString -> IO <herr_t>

-- |Creates an external link from 'link_name' to 'obj_name'.
--
-- External links are links to objects in other HDF5 files.  They
-- are allowed to \"dangle\" like soft links internal to a file.
-- 'file_name' is the name of the file that 'obj_name' is is contained
-- within.  If 'obj_name' is given as a relative path name, the
-- path will be relative to the root group of 'file_name'.
-- 'link_name' is interpreted relative to 'link_loc_id', which is
-- either a file ID or a group ID.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Lcreate_external(const char *file_name, const char *obj_name,
-- >     hid_t link_loc_id, const char *link_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_external, CString -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

