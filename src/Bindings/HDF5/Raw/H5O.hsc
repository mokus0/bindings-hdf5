#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.Raw.H5O where
#strict_import

import Bindings.HDF5.Raw.H5     -- Generic Functions
import Bindings.HDF5.Raw.H5I    -- IDs
import Bindings.HDF5.Raw.H5L    -- Links

import Foreign.Ptr.Conventions

-- * Constants

-- ** Flags for object copy ('h5o_copy')

-- |Copy only immediate members
#num H5O_COPY_SHALLOW_HIERARCHY_FLAG

-- |Expand soft links into new objects
#num H5O_COPY_EXPAND_SOFT_LINK_FLAG

-- |Expand external links into new objects
#num H5O_COPY_EXPAND_EXT_LINK_FLAG

-- |Copy objects that are pointed by references
#num H5O_COPY_EXPAND_REFERENCE_FLAG

-- |Copy object without copying attributes
#num H5O_COPY_WITHOUT_ATTR_FLAG

-- |Copy NULL messages (empty space)
#num H5O_COPY_PRESERVE_NULL_FLAG

-- |All object copying flags (for internal checking)
#num H5O_COPY_ALL

-- ** Flags for shared message indexes
-- Pass these flags in using the mesg_type_flags parameter in
-- H5P_set_shared_mesg_index.


-- | No shared messages
#num H5O_SHMESG_NONE_FLAG

-- | Simple Dataspace Message
#num H5O_SHMESG_SDSPACE_FLAG

-- | Datatype Message
#num H5O_SHMESG_DTYPE_FLAG

-- | Fill Value Message
#num H5O_SHMESG_FILL_FLAG

-- | Filter pipeline message
#num H5O_SHMESG_PLINE_FLAG

-- | Attribute Message
#num H5O_SHMESG_ATTR_FLAG

#num H5O_SHMESG_ALL_FLAG

-- ** Object header status flag definitions

-- |2-bit field indicating # of bytes to store the size of chunk 0's data
#num H5O_HDR_CHUNK0_SIZE

-- |Attribute creation order is tracked
#num H5O_HDR_ATTR_CRT_ORDER_TRACKED

-- |Attribute creation order has index
#num H5O_HDR_ATTR_CRT_ORDER_INDEXED

-- |Non-default attribute storage phase change values stored
#num H5O_HDR_ATTR_STORE_PHASE_CHANGE

-- |Store access, modification, change & birth times for object
#num H5O_HDR_STORE_TIMES

#num H5O_HDR_ALL_FLAGS

-- ** Maximum shared message values

#num H5O_SHMESG_MAX_NINDEXES
#num H5O_SHMESG_MAX_LIST_SIZE

-- * Types

-- |Types of objects in file
#newtype H5O_type_t, Eq

-- |Unknown object type
#newtype_const H5O_type_t, H5O_TYPE_UNKNOWN

-- |Object is a group
#newtype_const H5O_type_t, H5O_TYPE_GROUP	       

-- |Object is a dataset
#newtype_const H5O_type_t, H5O_TYPE_DATASET

-- |Object is a named data type
#newtype_const H5O_type_t, H5O_TYPE_NAMED_DATATYPE

-- |Number of different object types
#num H5O_TYPE_NTYPES

#if H5_VERSION_ATLEAST(1,8,4)

-- |Information struct for object header metadata 
-- (for 'h5o_get_info'/ 'h5o_get_info_by_name' / 'h5o_get_info_by_idx')
#starttype H5O_hdr_info_t

-- |Version number of header format in file
#field version,         CUInt

-- |Number of object header messages
#field nmesgs,          CUInt

-- |Number of object header chunks
#field nchunks,         CUInt

-- |Object header status flags
#field flags,           CUInt

-- |Total space for storing object header in file
#field space.total,     <hsize_t>

-- |Space within header for object header metadata information
#field space.meta,      <hsize_t>

-- |Space within header for actual message information
#field space.mesg,      <hsize_t>

-- |Free space within object header
#field space.free,      <hsize_t>

-- |Flags to indicate presence of message type in header
#field mesg.present,    Word64

-- |Flags to indicate message type is shared in header
#field mesg.shared,     Word64

#stoptype

#endif

-- |Information struct for object
-- (for 'h5o_get_info'/ 'h5o_get_info_by_name' / 'h5o_get_info_by_idx')
#starttype H5O_info_t

-- |File number that object is located in
#field fileno,          CULong

-- |Object address in file
#field addr,            <haddr_t>

-- |Basic object type (group, dataset, etc.)
#field type,            <H5O_type_t>

-- |Reference count of object
#field rc,              CUInt

-- |Access time
#field atime,           <time_t>

-- |Modification time
#field mtime,           <time_t>

-- |Change time
#field ctime,           <time_t>

-- |Birth time
#field btime,           <time_t>

-- |# of attributes attached to object
#field num_attrs,       <hsize_t>

#if H5_VERSION_ATLEAST(1,8,4)

-- |Object header information
#field hdr,             <H5O_hdr_info_t>

#else

-- |Version number of header format in file
#field hdr.version,      CUInt

-- |Number of object header messages
#field hdr.nmesgs,       CUInt

-- |Number of object header chunks
#field hdr.nchunks,      CUInt

-- |Object header status flags
#field hdr.flags,        CUInt

-- |Total space for storing object header in file
#field hdr.space.total,  <hsize_t>

-- |Space within header for object header metadata information
#field hdr.space.meta,   <hsize_t>

-- |Space within header for actual message information
#field hdr.space.mesg,   <hsize_t>

-- |Free space within object header
#field hdr.space.free,   <hsize_t>

-- |Flags to indicate presence of message type in header
#field hdr.mesg.present, Word64

-- |Flags to indicate message type is shared in header
#field hdr.mesg.shared,  Word64

#endif

-- |v1/v2 B-tree & local/fractal heap for groups, B-tree for chunked datasets
#field meta_size.obj,   <H5_ih_info_t>

-- |v2 B-tree & heap for attributes
#field meta_size.attr,  <H5_ih_info_t>

#stoptype


-- |Typedef for message creation indexes
#newtype H5O_msg_crt_idx_t, Eq

-- |Prototype for 'h5o_visit' / 'h5o_visit_by_name' operator
type H5O_iterate_t a = FunPtr (HId_t -> CString -> In H5O_info_t -> Ptr a -> IO HErr_t)

-- * Functions

-- |Opens an object within an HDF5 file.
-- 
-- This function opens an object in the same way that 'h5g_open2',
-- 'h5t_open2', and 'h5d_open2' do. However, 'h5o_open' doesn't require
-- the type of object to be known beforehand. This can be
-- useful in user-defined links, for instance, when only a
-- path is known.
-- 
-- The opened object should be closed again with 'h5o_close'
-- or 'h5g_close', 'h5t_close', or 'h5d_close'.
-- 
-- On success, returns an open object identifier
-- On failure, returns a negative value.
--
-- > hid_t H5Oopen(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Oopen, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- |Warning! This function is EXTREMELY DANGEROUS!
-- 
-- Improper use can lead to FILE CORRUPTION, INACCESSIBLE DATA,
-- and other VERY BAD THINGS!
-- 
-- This function opens an object using its address within the
-- HDF5 file, similar to an HDF5 hard link. The open object
-- is identical to an object opened with 'h5o_open' and should
-- be closed with 'h5o_close' or a type-specific closing
-- function (such as 'h5g_close').
-- 
-- This function is very dangerous if called on an invalid
-- address. For this reason, 'h5o_incr_refcount' should be
-- used to prevent HDF5 from deleting any object that is
-- referenced by address (e.g. by a user-defined link).
-- 'h5o_decr_refcount' should be used when the object is
-- no longer being referenced by address (e.g. when the UD link
-- is deleted).
-- 
-- The address of the HDF5 file on disk has no effect on
-- 'h5o_open_by_addr', nor does the use of any unusual file
-- drivers. The \"address\" is really the offset within the
-- HDF5 file, and HDF5's file drivers will transparently
-- map this to an address on disk for the filesystem.
-- 
-- On success, returns an open object identifier
-- On failure, returns a negative value.
-- 
-- > hid_t H5Oopen_by_addr(hid_t loc_id, haddr_t addr);
#ccall H5Oopen_by_addr, <hid_t> -> <haddr_t> -> IO <hid_t>

-- |Opens an object within an HDF5 file, according to the offset
-- within an index.
-- 
-- This function opens an object in the same way that 'h5g_open',
-- 'h5t_open', and 'h5d_open' do. However, 'h5o_open' doesn't require
-- the type of object to be known beforehand. This can be
-- useful in user-defined links, for instance, when only a
-- path is known.
-- 
-- The opened object should be closed again with 'h5o_close'
-- or 'h5g_close', 'h5t_close', or 'h5d_close'.
-- 
-- On success, returns an open object identifier
-- On failure, returns a negative value.
-- 
-- > hid_t H5Oopen_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Oopen_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <hid_t>

#if H5_VERSION_ATLEAST(1,8,5)

-- |Determine if a linked-to object exists
-- 
-- > htri_t H5Oexists_by_name(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Oexists_by_name, <hid_t> -> CString -> <hid_t> -> IO <htri_t>

#endif

-- |Retrieve information about an object.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oget_info(hid_t loc_id, H5O_info_t *oinfo);
#ccall H5Oget_info, <hid_t> -> Out <H5O_info_t> -> IO <herr_t>

-- |Retrieve information about an object.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oget_info_by_name(hid_t loc_id, const char *name, H5O_info_t *oinfo,
-- >     hid_t lapl_id);
#ccall H5Oget_info_by_name, <hid_t> -> CString -> Out <H5O_info_t> -> <hid_t> -> IO <herr_t>

-- |Retrieve information about an object, according to the order
-- of an index.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oget_info_by_idx(hid_t loc_id, const char *group_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5O_info_t *oinfo,
-- >     hid_t lapl_id);
#ccall H5Oget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5O_info_t> -> <hid_t> -> IO <herr_t>

-- |Creates a hard link from 'new_name' to the object specified
-- by 'obj_id' using properties defined in the Link Creation
-- Property List 'lcpl'.
-- 
-- This function should be used to link objects that have just
-- been created.
-- 
-- 'new_name' is interpreted relative to 'new_loc_id', which
-- is either a file ID or a group ID.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Olink(hid_t obj_id, hid_t new_loc_id, const char *new_name,
-- >     hid_t lcpl_id, hid_t lapl_id);
#ccall H5Olink, <hid_t> -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Warning! This function is EXTREMELY DANGEROUS!
-- Improper use can lead to FILE CORRUPTION, INACCESSIBLE DATA,
-- and other VERY BAD THINGS!
-- 
-- This function increments the \"hard link\" reference count
-- for an object. It should be used when a user-defined link
-- that references an object by address is created. When the
-- link is deleted, 'h5o_decr_refcount' should be used.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oincr_refcount(hid_t object_id);
#ccall H5Oincr_refcount, <hid_t> -> IO <herr_t>

-- |Warning! This function is EXTREMELY DANGEROUS!
-- Improper use can lead to FILE CORRUPTION, INACCESSIBLE DATA,
-- and other VERY BAD THINGS!
-- 
-- This function decrements the \"hard link\" reference count
-- for an object. It should be used when user-defined links
-- that reference an object by address are deleted, and only
-- after 'h5o_incr_refcount' has already been used.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Odecr_refcount(hid_t object_id);
#ccall H5Odecr_refcount, <hid_t> -> IO <herr_t>

-- |Copy an object (group or dataset) to destination location
-- within a file or cross files. 'plist_id' is a property list
-- which is used to pass user options and properties to the
-- copy. The name, 'dst_name', must not already be taken by some
-- other object in the destination group.
-- 
-- 'h5o_copy' will fail if the name of the destination object
--     exists in the destination group.  For example,
--     @H5Ocopy(fid_src, \"/dset\", fid_dst, \"/dset\", ...)@
--     will fail if \"/dset\" exists in the destination file
-- 
-- OPTIONS THAT HAVE BEEN IMPLEMENTED:
-- 
--     ['h5o_COPY_SHALLOW_HIERARCHY_FLAG']
--         If this flag is specified, only immediate members of
--         the group are copied. Otherwise (default), it will
--         recursively copy all objects below the group
-- 
--     ['h5o_COPY_EXPAND_SOFT_LINK_FLAG']
--         If this flag is specified, it will copy the objects
--         pointed by the soft links. Otherwise (default), it
--         will copy the soft link as they are
-- 
--     ['h5o_COPY_WITHOUT_ATTR_FLAG']
--         If this flag is specified, it will copy object without
--         copying attributes. Otherwise (default), it will
--         copy object along with all its attributes
-- 
--     ['h5o_COPY_EXPAND_REFERENCE_FLAG']
--         1. Copy object between two different files:
--             When this flag is specified, it will copy objects that
--             are pointed by the references and update the values of
--             references in the destination file.  Otherwise (default)
--             the values of references in the destination will set to
--             zero
--             The current implementation does not handle references
--             inside of other datatype structure. For example, if
--             a member of compound datatype is reference, H5Ocopy()
--             will copy that field as it is. It will not set the
--             value to zero as default is used nor copy the object
--             pointed by that field the flag is set
--         2. Copy object within the same file:
--             This flag does not have any effect to the 'h5o_copy'.
--             Datasets or attributes of references are copied as they
--             are, i.e. values of references of the destination object
--             are the same as the values of the source object
-- 
-- OPTIONS THAT MAY APPLY TO COPY IN THE FUTURE:
-- 
--     ['h5o_COPY_EXPAND_EXT_LINK_FLAG']
--         If this flag is specified, it will expand the external links
--         into new objects, Otherwise (default), it will keep external
--         links as they are (default)
-- 
-- PROPERTIES THAT MAY APPLY TO COPY IN FUTURE:
-- 
--   * Change data layout such as chunk size
-- 
--   * Add filter such as data compression.
-- 
--   * Add an attribute to the copied object(s) that say the date/time
--     for the copy or other information about the source file.
-- 
-- The intermediate group creation property should be passed in
-- using the lcpl instead of the ocpypl.
-- 
-- Parameters:
-- 
-- [@ src_loc_id :: HId_t   @]  Source file or group identifier.
-- 
-- [@ src_name   :: CString @]  Name of the source object to be copied
-- 
-- [@ dst_loc_id :: HId_t   @]  Destination file or group identifier
-- 
-- [@ dst_name   :: CString @]  Name of the destination object
-- 
-- [@ ocpypl_id  :: HId_t   @]  Properties which apply to the copy
-- 
-- [@ lcpl_id    :: HId_t   @]  Properties which apply to the new hard link
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Ocopy(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
-- >     const char *dst_name, hid_t ocpypl_id, hid_t lcpl_id);
#ccall H5Ocopy, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Gives the specified object a comment.  The 'comment' string
-- should be a null terminated string.  An object can have only
-- one comment at a time.  Passing NULL for the 'comment' argument
-- will remove the comment property from the object.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oset_comment(hid_t obj_id, const char *comment);
#ccall H5Oset_comment, <hid_t> -> CString -> IO <herr_t>

-- |Gives the specified object a comment.  The 'comment' string
-- should be a null terminated string.  An object can have only
-- one comment at a time.  Passing NULL for the 'comment' argument
-- will remove the comment property from the object.
-- 
-- Note:  Deprecated in favor of using attributes on objects.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oset_comment_by_name(hid_t loc_id, const char *name,
-- >     const char *comment, hid_t lapl_id);
#ccall H5Oset_comment_by_name, <hid_t> -> CString -> CString -> <hid_t> -> IO <herr_t>

-- |Retrieve comment for an object.
--
-- On success, returns the number of bytes in the comment including the
-- null terminator, or zero if the object has no comment.  On failure
-- returns a negative value.
--
-- > ssize_t H5Oget_comment(hid_t obj_id, char *comment, size_t bufsize);
#ccall H5Oget_comment, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Retrieve comment for an object.
--
-- On success, returns the number of bytes in the comment including the
-- null terminator, or zero if the object has no comment.  On failure
-- returns a negative value.
--
-- > ssize_t H5Oget_comment_by_name(hid_t loc_id, const char *name,
-- >     char *comment, size_t bufsize, hid_t lapl_id);
#ccall H5Oget_comment_by_name, <hid_t> -> CString -> OutArray CChar -> <size_t> -> <hid_t> -> IO <ssize_t>

-- |Recursively visit an object and all the objects reachable
-- from it.  If the starting object is a group, all the objects
-- linked to from that group will be visited.  Links within
-- each group are visited according to the order within the
-- specified index (unless the specified index does not exist for
-- a particular group, then the "name" index is used).
-- 
-- NOTE: Soft links and user-defined links are ignored during
-- this operation.
-- 
-- NOTE: Each _object_ reachable from the initial group will only
-- be visited once.  If multiple hard links point to the same
-- object, the first link to the object's path (according to the
-- iteration index and iteration order given) will be used to in
-- the callback about the object.
-- 
-- On success, returns the return value of the first operator that
-- returns non-zero, or zero if all members were processed with no
-- operator returning non-zero.
-- 
-- Returns negative if something goes wrong within the library, or
-- the negative value returned by one of the operators.
-- 
-- > herr_t H5Ovisit(hid_t obj_id, H5_index_t idx_type, H5_iter_order_t order,
-- >     H5O_iterate_t op, void *op_data);
#ccall H5Ovisit, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> H5O_iterate_t a -> Ptr a -> IO <herr_t>

-- |Recursively visit an object and all the objects reachable
-- from it.  If the starting object is a group, all the objects
-- linked to from that group will be visited.  Links within
-- each group are visited according to the order within the
-- specified index (unless the specified index does not exist for
-- a particular group, then the "name" index is used).
-- 
-- NOTE: Soft links and user-defined links are ignored during
-- this operation.
-- 
-- NOTE: Each _object_ reachable from the initial group will only
-- be visited once.  If multiple hard links point to the same
-- object, the first link to the object's path (according to the
-- iteration index and iteration order given) will be used to in
-- the callback about the object.
-- 
-- On success, returns the return value of the first operator that
-- returns non-zero, or zero if all members were processed with no
-- operator returning non-zero.
-- 
-- Returns negative if something goes wrong within the library, or
-- the negative value returned by one of the operators.
-- 
-- > herr_t H5Ovisit_by_name(hid_t loc_id, const char *obj_name,
-- >     H5_index_t idx_type, H5_iter_order_t order, H5O_iterate_t op,
-- >     void *op_data, hid_t lapl_id);
#ccall H5Ovisit_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> H5O_iterate_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- |Close an open file object.
-- 
-- This is the companion to 'h5o_open'. It is used to close any
-- open object in an HDF5 file (but not IDs are that not file
-- objects, such as property lists and dataspaces). It has
-- the same effect as calling 'h5g_close', 'h5d_close', or 'h5t_close'.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Oclose(hid_t object_id);
#ccall H5Oclose, <hid_t> -> IO <herr_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- * Deprecated types

-- |A struct that's part of the 'h5g_stat_t' routine (deprecated)
#starttype H5O_stat_t

-- |Total size of object header in file
#field size,    <hsize_t>

-- |Free space within object header
#field free,    <hsize_t>

-- |Number of object header messages
#field nmesgs,  CUInt

-- |Number of object header chunks
#field nchunks, CUInt

#stoptype

#endif /* H5_NO_DEPRECATED_SYMBOLS */

