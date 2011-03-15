#include <bindings.h>
#include <H5Ppublic.h>

module Bindings.HDF5.H5P where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5AC
import Bindings.HDF5.H5D
import Bindings.HDF5.H5F
import Bindings.HDF5.H5FD
import Bindings.HDF5.H5I
import Bindings.HDF5.H5L
import Bindings.HDF5.H5MM
import Bindings.HDF5.H5T
import Bindings.HDF5.H5Z

import Foreign.Ptr.Conventions
import System.Posix.Types (COff)

#cinline H5P_ROOT,                          <hid_t>
#cinline H5P_OBJECT_CREATE,                 <hid_t>
#cinline H5P_FILE_CREATE,                   <hid_t>
#cinline H5P_FILE_ACCESS,                   <hid_t>
#cinline H5P_DATASET_CREATE,                <hid_t>
#cinline H5P_DATASET_ACCESS,                <hid_t>
#cinline H5P_DATASET_XFER,                  <hid_t>
#cinline H5P_FILE_MOUNT,                    <hid_t>
#cinline H5P_GROUP_CREATE,                  <hid_t>
#cinline H5P_GROUP_ACCESS,                  <hid_t>
#cinline H5P_DATATYPE_CREATE,               <hid_t>
#cinline H5P_DATATYPE_ACCESS,               <hid_t>
#cinline H5P_STRING_CREATE,                 <hid_t>
#cinline H5P_ATTRIBUTE_CREATE,              <hid_t>
#cinline H5P_OBJECT_COPY,                   <hid_t>
#cinline H5P_LINK_CREATE,                   <hid_t>
#cinline H5P_LINK_ACCESS,                   <hid_t>

#cinline H5P_FILE_CREATE_DEFAULT,           <hid_t>
#cinline H5P_FILE_ACCESS_DEFAULT,           <hid_t>
#cinline H5P_DATASET_CREATE_DEFAULT,        <hid_t>
#cinline H5P_DATASET_ACCESS_DEFAULT,        <hid_t>
#cinline H5P_DATASET_XFER_DEFAULT,          <hid_t>
#cinline H5P_FILE_MOUNT_DEFAULT,            <hid_t>
#cinline H5P_GROUP_CREATE_DEFAULT,          <hid_t>
#cinline H5P_GROUP_ACCESS_DEFAULT,          <hid_t>
#cinline H5P_DATATYPE_CREATE_DEFAULT,       <hid_t>
#cinline H5P_DATATYPE_ACCESS_DEFAULT,       <hid_t>
#cinline H5P_ATTRIBUTE_CREATE_DEFAULT,      <hid_t>
#cinline H5P_OBJECT_COPY_DEFAULT,           <hid_t>
#cinline H5P_LINK_CREATE_DEFAULT,           <hid_t>
#cinline H5P_LINK_ACCESS_DEFAULT,           <hid_t>

-- |Default value for all property list classes
#newtype_const hid_t, H5P_DEFAULT

#num H5P_CRT_ORDER_TRACKED
#num H5P_CRT_ORDER_INDEXED


-- /* Define property list class callback function pointer types */

-- |
-- > typedef herr_t (*H5P_cls_create_func_t)(hid_t prop_id, void *create_data);
type H5P_cls_create_func_t a = FunPtr (HId_t -> InOut a -> IO HErr_t)

-- |
-- > typedef herr_t (*H5P_cls_copy_func_t)(hid_t new_prop_id, hid_t old_prop_id,
-- >                                       void *copy_data);
type H5P_cls_copy_func_t a = FunPtr (HId_t -> HId_t -> InOut a -> IO HErr_t)

-- |
-- > typedef herr_t (*H5P_cls_close_func_t)(hid_t prop_id, void *close_data);
type H5P_cls_close_func_t a = FunPtr (HId_t -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
-- [@ prop_id       :: 'HId_t'        @]  The ID of the property list being created.
-- 
-- [@ name          :: 'CString'      @]  The name of the property being modified.
-- 
-- [@ size          :: 'CSize'        @]  The size of the property value
-- 
-- [@ initial_value :: 'InOut' a      @]  The initial value for the property being created. (The 'default' value passed to 'h5p_register2')
-- 
-- > typedef herr_t (*H5P_prp_create_func_t)(hid_t prop_id, const char *name,
-- >         size_t size, void *initial_value);
type H5P_prp_create_func_t a = FunPtr (CString -> CSize -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
-- [@ prop_id   :: 'HId_t'   @] The ID of the property list being modified.
-- 
-- [@ name      :: 'CString' @] The name of the property being modified.
-- 
-- [@ size      :: 'CSize'   @] The size of the property value
-- 
-- [@ new_value :: 'InOut' a @] The value being set for the property.
-- 
-- The 'set' routine may modify the value to be set and those changes will be
-- stored as the value of the property.  If the 'set' routine returns a
-- negative value, the new property value is not copied into the property and
-- the property list set routine returns an error value.

-- > typedef herr_t (*H5P_prp_set_func_t)(hid_t prop_id, const char *name,
-- >     size_t size, void *value);
type H5P_prp_set_func_t    a = FunPtr (HId_t -> CString -> CSize -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
-- [@ prop_id :: 'HId_t'   @] The ID of the property list being queried.
-- 
-- [@ name    :: 'CString' @] The name of the property being queried.
-- 
-- [@ size    :: 'CSize'   @] The size of the property value
-- 
-- [@ value   :: 'InOut' a @] The value being retrieved for the property.
-- 
-- The 'get' routine may modify the value to be retrieved and those changes
-- will be returned to the calling function.  If the 'get' routine returns a
-- negative value, the property value is returned and the property list get
-- routine returns an error value.
-- 
-- > typedef herr_t (*H5P_prp_get_func_t)(hid_t prop_id, const char *name,
-- >     size_t size, void *value);
type H5P_prp_get_func_t    a = FunPtr (HId_t -> CString -> CSize -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
-- [@ prop_id :: 'HId_t'   @] The ID of the property list the property is deleted from.
-- [@ name    :: 'CString' @] The name of the property being deleted.
-- [@ size    :: 'CSize'   @] The size of the property value
-- [@ value   :: 'InOut' a @] The value of the property being deleted.
-- 
-- The 'delete' routine may modify the value passed in, but the value is not
-- used by the library when the 'delete' routine returns.  If the
-- 'delete' routine returns a negative value, the property list deletion
-- routine returns an error value but the property is still deleted.
-- 
-- > typedef herr_t (*H5P_prp_del_func_t)(hid_t prop_id, const char *name,
-- >     size_t size, void *value);
type H5P_prp_delete_func_t a = FunPtr (HId_t -> CString -> CSize -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
--     const char *name;   IN: The name of the property being copied.
--     size_t size;        IN: The size of the property value
--     void *value;        IN: The value of the property being copied.
-- 
-- The 'copy' routine may modify the value to be copied and those changes will be
-- stored as the value of the property.  If the 'copy' routine returns a
-- negative value, the new property value is not copied into the property and
-- the property list copy routine returns an error value.
-- 
-- > typedef herr_t (*H5P_prp_copy_func_t)(const char *name, size_t size,
-- >     void *value);
type H5P_prp_copy_func_t   a = FunPtr (CString -> CSize -> InOut a -> IO HErr_t)

-- |Parameters:
-- 
-- [@ value1 :: In a  @]    The value of the first property being compared.
-- 
-- [@ value2 :: In a  @]    The value of the second property being compared.
-- 
-- [@ size   :: CSize @]    The size of the property value
-- 
-- The 'compare' routine may not modify the values to be compared.  The
-- 'compare' routine should return a positive value if 'value1' is greater than
-- 'value2', a negative value if 'value2' is greater than 'value1' and zero if 
-- 'value1' and 'value2' are equal.
--
-- > typedef int (*H5P_prp_compare_func_t)( void *value1, void *value2,
-- >     size_t size);
type H5P_prp_compare_func_t a = FunPtr (In a -> In a -> CSize -> IO CInt)

-- |Parameters:
-- 
-- [@ name  :: 'CString' @] The name of the property being closed.
-- 
-- [@ size  :: 'CSize'   @] The size of the property value
-- 
-- [@ value :: 'In' a    @] The value of the property being closed.
-- 
-- > typedef herr_t (*H5P_prp_close_func_t)(const char *name, size_t size,
-- >     void *value);
type H5P_prp_close_func_t a = FunPtr (CString -> CSize -> InOut a -> IO HErr_t)

-- > typedef herr_t (*H5P_iterate_t)(hid_t id, const char *name, void *iter_data);
type H5P_iterate_t a = FunPtr (HId_t -> CString -> InOut a -> IO HErr_t)

-- /*********************/
-- /* Public Prototypes */
-- /*********************/

-- /* Generic property list routines */


-- |Create a new property list class.  Allocates memory and attaches
-- a class to the property list class hierarchy.
-- 
-- Parameters
--
-- [@ parent      :: 'HId_t'                   @] Property list class ID of parent class
-- 
-- [@ name        :: 'CString'                 @] Name of class we are creating
-- 
-- [@ cls_create  :: 'H5P_cls_create_func_t' a @] The callback function to call when each property list in this class is created.
-- 
-- [@ create_data :: 'InOut' a                 @] Pointer to user data to pass along to class creation callback.
-- 
-- [@ cls_copy    :: 'H5P_cls_copy_func_t' b   @] The callback function to call when each property list in this class is copied.
-- 
-- [@ copy_data   :: 'InOut' b                 @] Pointer to user data to pass along to class copy callback.
-- 
-- [@ cls_close   :: 'H5P_cls_close_func_t' c  @] The callback function to call when each property list in this class is closed.
-- 
-- [@ close_data  :: 'InOut' c                 @] Pointer to user data to pass along to class close callback.
-- 
-- Returns a valid property list class ID on success, NULL on failure.
--
-- > hid_t H5Pcreate_class(hid_t parent, const char *name,
-- >     H5P_cls_create_func_t cls_create, void *create_data,
-- >     H5P_cls_copy_func_t cls_copy, void *copy_data,
-- >     H5P_cls_close_func_t cls_close, void *close_data);
#ccall H5Pcreate_class, <hid_t> -> CString -> H5P_cls_create_func_t a -> Ptr a -> H5P_cls_copy_func_t b -> Ptr b -> H5P_cls_close_func_t c -> Ptr c -> IO <hid_t>

-- |This routine retrieves the name of a generic property list class.
-- The pointer to the name must be 'free'd by the user for successful calls.
-- 
-- Parameters
-- 
-- [@ pclass_id :: 'HId_t' @]   Property class to query
-- 
-- On success, returns a pointer to a malloc'ed string containing the class name
-- On failure, returns NULL.
--
-- > char *H5Pget_class_name(hid_t pclass_id);
#ccall H5Pget_class_name, <hid_t> -> IO CString

-- |Routine to create a new property list of a property list class.
-- 
-- Creates a property list of a given class.  If a 'create' callback
-- exists for the property list class, it is called before the
-- property list is passed back to the user.  If 'create' callbacks exist for
-- any individual properties in the property list, they are called before the
-- class 'create' callback.
--
-- Parameters:
-- 
-- [@ cls_id :: 'HId_t' @]  Property list class create list from
-- 
-- Returns a valid property list ID on success, a negative value on failure.
-- 
-- > hid_t H5Pcreate(hid_t cls_id);
#ccall H5Pcreate, <hid_t> -> IO <hid_t>

-- |Routine to register a new property in a property list class.
-- 
-- Registers a new property with a property list class.  The property will
-- exist in all property list objects of that class after this routine is
-- finished.  The name of the property must not already exist.  The default
-- property value must be provided and all new property lists created with this
-- property will have the property value set to the default provided.  Any of
-- the callback routines may be set to NULL if they are not needed.
-- 
-- Zero-sized properties are allowed and do not store any data in the
-- property list.  These may be used as flags to indicate the presence or
-- absence of a particular piece of information.  The 'default' pointer for a
-- zero-sized property may be set to NULL.  The property 'create' & 'close'
-- callbacks are called for zero-sized properties, but the 'set' and 'get'
-- callbacks are never called.
-- 
-- The 'create' callback is called when a new property list with this
-- property is being created.  'H5P_prp_create_func_t' is defined as:
-- 
-- The 'create' routine may modify the value to be set and those changes will
-- be stored as the initial value of the property.  If the 'create' routine
-- returns a negative value, the new property value is not copied into the
-- property and the property list creation routine returns an error value.
-- 
-- The 'set' callback is called before a new value is copied into the
-- property.  The 'set' routine may modify the value to be set and those 
-- changes will be stored as the value of the property.  If the 'set' routine 
-- returns a negative value, the new property value is not copied into the 
-- property and the property list set routine returns an error value.
-- 
-- The 'get' callback is called before a value is retrieved from the
-- property.  The 'get' routine may modify the value to be retrieved and 
-- those changes will be returned to the calling function.  If the 'get' 
-- routine returns a negative value, the property value is returned and 
-- the property list get routine returns an error value.
-- 
-- The 'delete' callback is called when a property is deleted from a
-- property list.  The 'delete' routine may modify the value passed in, 
-- but the value is not used by the library when the 'delete' routine 
-- returns.  If the 'delete' routine returns a negative value, the 
-- property list deletion routine returns an error value but the property
-- is still deleted.
-- 
-- The 'copy' callback is called when a property list with this property 
-- is copied.  The 'copy' routine may modify the value to be copied and 
-- those changes will be stored as the value of the property.  If the 
-- 'copy' routine returns a negative value, the new property value is not
-- copied into the property and the property list copy routine returns an
-- error value.
-- 
-- The 'compare' callback is called when a property list with this property
-- is compared to another property list.  The 'compare' routine may not
-- modify the values to be compared.  The 'compare' routine should return 
-- a positive value if 'value1' is greater than 'value2', a negative value 
-- if 'value2' is greater than 'value1' and zero if 'value1' and 'value2'
-- are equal.
-- 
-- The 'close' callback is called when a property list with this property
-- is being destroyed.  The 'close' routine may modify the value passed in,
-- but the value is not used by the library when the 'close' routine returns.
-- If the 'close' routine returns a negative value, the property list close
-- routine returns an error value but the property list is still closed.
-- 
-- Parameters:
-- 
-- [@ class       :: HId_t                      @]        IN: Property list class to close
-- 
-- [@ name        :: CString                    @]        IN: Name of property to register
-- 
-- [@ size        :: CSize                      @]        IN: Size of property in bytes
-- 
-- [@ def_value   :: In a                       @]        IN: Pointer to buffer containing default value for property in newly created property lists
-- 
-- [@ prp_create  :: H5P_prp_create_func_t a    @]        IN: Function pointer to property creation callback
-- 
-- [@ prp_set     :: H5P_prp_set_func_t a       @]        IN: Function pointer to property set callback
-- 
-- [@ prp_get     :: H5P_prp_get_func_t a       @]        IN: Function pointer to property get callback
-- 
-- [@ prp_delete  :: H5P_prp_delete_func_t a    @]        IN: Function pointer to property delete callback
-- 
-- [@ prp_copy    :: H5P_prp_copy_func_t a      @]        IN: Function pointer to property copy callback
-- 
-- [@ prp_cmp     :: H5P_prp_compare_func_t a   @]        IN: Function pointer to property compare callback
-- 
-- [@ prp_close   :: H5P_prp_close_func_t a     @]        IN: Function pointer to property close callback
-- 
-- Returns non-negative on success, negative on failure.
-- 
--  COMMENTS, BUGS, ASSUMPTIONS:
-- 
-- The 'set' callback function may be useful to range check the value being
-- set for the property or may perform some tranformation/translation of the
-- value set.  The 'get' callback would then [probably] reverse the
-- transformation, etc.  A single 'get' or 'set' callback could handle
-- multiple properties by performing different actions based on the property
-- name or other properties in the property list.
-- 
-- I would like to say \"the property list is not closed\" when a 'close'
-- routine fails, but I don't think that's possible due to other properties in
-- the list being successfully closed & removed from the property list.  I
-- suppose that it would be possible to just remove the properties which have
-- successful 'close' callbacks, but I'm not happy with the ramifications
-- of a mangled, un-closable property list hanging around...  Any comments? -QAK
-- 
-- > herr_t H5Pregister2(hid_t cls_id, const char *name, size_t size,
-- >     void *def_value, H5P_prp_create_func_t prp_create,
-- >     H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
-- >     H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
-- >     H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
#ccall H5Pregister2, <hid_t> -> CString -> <size_t> -> In a -> H5P_prp_create_func_t a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_compare_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- |Routine to insert a new property in a property list.
-- 
-- Inserts a temporary property into a property list.  The property will
-- exist only in this property list object.  The name of the property must not
-- already exist.  The value must be provided unless the property is zero-
-- sized.  Any of the callback routines may be set to NULL if they are not
-- needed.
--
-- Zero-sized properties are allowed and do not store any data in the
-- property list.  These may be used as flags to indicate the presence or
-- absence of a particular piece of information.  The 'value' pointer for a
-- zero-sized property may be set to NULL.  The property 'close' callback is
-- called for zero-sized properties, but the 'set' and 'get' callbacks are
-- never called.
-- 
-- There is no 'create' callback routine for temporary property list
-- objects, the initial value is assumed to have any necessary setup already
-- performed on it.
-- Aside from that, the callbacks are the same as for 'h5p_register'.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pinsert2(hid_t plist_id, const char *name, size_t size,
-- >     void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
-- >     H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
-- >     H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
#ccall H5Pinsert2, <hid_t> -> CString -> CSize -> In a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_compare_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- |Routine to set a property's value in a property list.
-- 
-- Sets a new value for a property in a property list.  The property name
-- must exist or this routine will fail.  If there is a 'set' callback routine
-- registered for this property, the 'value' will be passed to that routine and
-- any changes to the 'value' will be used when setting the property value.
-- The information pointed at by the 'value' pointer (possibly modified by the
-- 'set' callback) is copied into the property list value and may be changed
-- by the application making the H5Pset call without affecting the property
-- value.
-- 
-- If the 'set' callback routine returns an error, the property value will
-- not be modified.  This routine may not be called for zero-sized properties
-- and will return an error in that case.
-- 
-- Parameters:
-- 
-- [@ plist_id :: HId_t   @]    Property list to find property in
-- 
-- [@ name     :: CString @]    Name of property to set
-- 
-- [@ value    :: In a    @]    Pointer to the value for the property
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset(hid_t plist_id, const char *name, void *value);
#ccall H5Pset, <hid_t> -> CString -> Ptr a -> IO <herr_t>

-- htri_t H5Pexist(hid_t plist_id, const char *name);
#ccall H5Pexist, <hid_t> -> CString -> IO <htri_t>

-- herr_t H5Pget_size(hid_t id, const char *name, size_t *size);
#ccall H5Pget_size, <hid_t> -> CString -> Ptr <size_t> -> IO <herr_t>

-- herr_t H5Pget_nprops(hid_t id, size_t *nprops);
#ccall H5Pget_nprops, <hid_t> -> Ptr <size_t> -> IO <herr_t>

-- hid_t H5Pget_class(hid_t plist_id);
#ccall H5Pget_class, <hid_t> -> IO <hid_t>

-- hid_t H5Pget_class_parent(hid_t pclass_id);
#ccall H5Pget_class_parent, <hid_t> -> IO <hid_t>

-- herr_t H5Pget(hid_t plist_id, const char *name, void * value);
#ccall H5Pget, <hid_t> -> CString -> Ptr a -> IO <herr_t>

-- htri_t H5Pequal(hid_t id1, hid_t id2);
#ccall H5Pequal, <hid_t> -> <hid_t> -> IO <htri_t>

-- htri_t H5Pisa_class(hid_t plist_id, hid_t pclass_id);
#ccall H5Pisa_class, <hid_t> -> <hid_t> -> IO <htri_t>

-- int H5Piterate(hid_t id, int *idx, H5P_iterate_t iter_func,
--             void *iter_data);
#ccall H5Piterate, <hid_t> -> Ptr CInt -> H5P_iterate_t a -> Ptr a -> IO CInt

-- herr_t H5Pcopy_prop(hid_t dst_id, hid_t src_id, const char *name);
#ccall H5Pcopy_prop, <hid_t> -> <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Premove(hid_t plist_id, const char *name);
#ccall H5Premove, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Punregister(hid_t pclass_id, const char *name);
#ccall H5Punregister, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Pclose_class(hid_t plist_id);
#ccall H5Pclose_class, <hid_t> -> IO <herr_t>

-- herr_t H5Pclose(hid_t plist_id);
#ccall H5Pclose, <hid_t> -> IO <herr_t>

-- hid_t H5Pcopy(hid_t plist_id);
#ccall H5Pcopy, <hid_t> -> IO <hid_t>

-- /* Object creation property list (OCPL) routines */
-- herr_t H5Pset_attr_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_attr_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_attr_phase_change(hid_t plist_id, unsigned *max_compact, unsigned *min_dense);
#ccall H5Pget_attr_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_attr_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_attr_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_attr_creation_order(hid_t plist_id, unsigned *crt_order_flags);
#ccall H5Pget_attr_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_obj_track_times(hid_t plist_id, hbool_t track_times);
#ccall H5Pset_obj_track_times, <hid_t> -> <hbool_t> -> IO <herr_t>

-- herr_t H5Pget_obj_track_times(hid_t plist_id, hbool_t *track_times);
#ccall H5Pget_obj_track_times, <hid_t> -> Out <hbool_t> -> IO <herr_t>

-- herr_t H5Pmodify_filter(hid_t plist_id, H5Z_filter_t filter,
--         unsigned int flags, size_t cd_nelmts,
--         const unsigned int cd_values[/*cd_nelmts*/]);
#ccall H5Pmodify_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- herr_t H5Pset_filter(hid_t plist_id, H5Z_filter_t filter,
--         unsigned int flags, size_t cd_nelmts,
--         const unsigned int c_values[]);
#ccall H5Pset_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- int H5Pget_nfilters(hid_t plist_id);
#ccall H5Pget_nfilters, <hid_t> -> IO CInt

-- H5Z_filter_t H5Pget_filter2(hid_t plist_id, unsigned filter,
--        unsigned int *flags/*out*/,
--        size_t *cd_nelmts/*out*/,
--        unsigned cd_values[]/*out*/,
--        size_t namelen, char name[],
--        unsigned *filter_config /*out*/);
#ccall H5Pget_filter2, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> Out CUInt -> IO <H5Z_filter_t>

-- herr_t H5Pget_filter_by_id2(hid_t plist_id, H5Z_filter_t id,
--        unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--        unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/,
--        unsigned *filter_config/*out*/);
#ccall H5Pget_filter_by_id2, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out CSize -> OutArray CUInt -> CSize -> OutArray CChar -> Out CUInt -> IO <herr_t>

-- htri_t H5Pall_filters_avail(hid_t plist_id);
#ccall H5Pall_filters_avail, <hid_t> -> IO <htri_t>

-- herr_t H5Premove_filter(hid_t plist_id, H5Z_filter_t filter);
#ccall H5Premove_filter, <hid_t> -> <H5Z_filter_t> -> IO <herr_t>

-- herr_t H5Pset_deflate(hid_t plist_id, unsigned aggression);
#ccall H5Pset_deflate, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pset_fletcher32(hid_t plist_id);
#ccall H5Pset_fletcher32, <hid_t> -> IO <herr_t>


-- /* File creation property list (FCPL) routines */
-- herr_t H5Pget_version(hid_t plist_id, unsigned *boot/*out*/,
--          unsigned *freelist/*out*/, unsigned *stab/*out*/,
--          unsigned *shhdr/*out*/);
#ccall H5Pget_version, <hid_t> -> Out CUInt -> Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_userblock(hid_t plist_id, hsize_t size);
#ccall H5Pset_userblock, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_userblock(hid_t plist_id, hsize_t *size);
#ccall H5Pget_userblock, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_sizes(hid_t plist_id, size_t sizeof_addr,
--        size_t sizeof_size);
#ccall H5Pset_sizes, <hid_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_sizes(hid_t plist_id, size_t *sizeof_addr/*out*/,
--        size_t *sizeof_size/*out*/);
#ccall H5Pget_sizes, <hid_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_sym_k(hid_t plist_id, unsigned ik, unsigned lk);
#ccall H5Pset_sym_k, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_sym_k(hid_t plist_id, unsigned *ik/*out*/, unsigned *lk/*out*/);
#ccall H5Pget_sym_k, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_istore_k(hid_t plist_id, unsigned ik);
#ccall H5Pset_istore_k, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_istore_k(hid_t plist_id, unsigned *ik/*out*/);
#ccall H5Pget_istore_k, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_nindexes(hid_t plist_id, unsigned nindexes);
#ccall H5Pset_shared_mesg_nindexes, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_nindexes(hid_t plist_id, unsigned *nindexes);
#ccall H5Pget_shared_mesg_nindexes, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned mesg_type_flags, unsigned min_mesg_size);
#ccall H5Pset_shared_mesg_index, <hid_t> -> CUInt -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned *mesg_type_flags, unsigned *min_mesg_size);
#ccall H5Pget_shared_mesg_index, <hid_t> -> CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_phase_change(hid_t plist_id, unsigned max_list, unsigned min_btree);
#ccall H5Pset_shared_mesg_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_phase_change(hid_t plist_id, unsigned *max_list, unsigned *min_btree);
#ccall H5Pget_shared_mesg_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>


-- /* File access property list (FAPL) routines */
-- herr_t H5Pset_alignment(hid_t fapl_id, hsize_t threshold,
--     hsize_t alignment);
#ccall H5Pset_alignment, <hid_t> -> <hsize_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_alignment(hid_t fapl_id, hsize_t *threshold/*out*/,
--     hsize_t *alignment/*out*/);
#ccall H5Pget_alignment, <hid_t> -> Out <hsize_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_driver(hid_t plist_id, hid_t driver_id,
--         const void *driver_info);
#ccall H5Pset_driver, <hid_t> -> <hid_t> -> Ptr a -> IO <herr_t>

-- hid_t H5Pget_driver(hid_t plist_id);
#ccall H5Pget_driver, <hid_t> -> IO <hid_t>

-- void *H5Pget_driver_info(hid_t plist_id);
#ccall H5Pget_driver_info, <hid_t> -> IO (Ptr a)

-- herr_t H5Pset_family_offset(hid_t fapl_id, hsize_t offset);
#ccall H5Pset_family_offset, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_family_offset(hid_t fapl_id, hsize_t *offset);
#ccall H5Pget_family_offset, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_multi_type(hid_t fapl_id, H5FD_mem_t type);
#ccall H5Pset_multi_type, <hid_t> -> <H5FD_mem_t> -> IO <herr_t>

-- herr_t H5Pget_multi_type(hid_t fapl_id, H5FD_mem_t *type);
#ccall H5Pget_multi_type, <hid_t> -> Out <H5FD_mem_t> -> IO <herr_t>

-- herr_t H5Pset_cache(hid_t plist_id, int mdc_nelmts,
--        size_t rdcc_nslots, size_t rdcc_nbytes,
--        double rdcc_w0);
#ccall H5Pset_cache, <hid_t> -> CInt -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- herr_t H5Pget_cache(hid_t plist_id,
--        int *mdc_nelmts, /* out */
--        size_t *rdcc_nslots/*out*/,
--        size_t *rdcc_nbytes/*out*/, double *rdcc_w0);
#ccall H5Pget_cache, <hid_t> -> Out CInt -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>

-- herr_t H5Pset_mdc_config(hid_t    plist_id,
--        H5AC_cache_config_t * config_ptr);
#ccall H5Pset_mdc_config, <hid_t> -> In <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Pget_mdc_config(hid_t     plist_id,
--        H5AC_cache_config_t * config_ptr);	/* out */
#ccall H5Pget_mdc_config, <hid_t> -> Out <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Pset_gc_references(hid_t fapl_id, unsigned gc_ref);
#ccall H5Pset_gc_references, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_gc_references(hid_t fapl_id, unsigned *gc_ref/*out*/);
#ccall H5Pget_gc_references, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_fclose_degree(hid_t fapl_id, H5F_close_degree_t degree);
#ccall H5Pset_fclose_degree, <hid_t> -> <H5F_close_degree_t> -> IO <herr_t>

-- herr_t H5Pget_fclose_degree(hid_t fapl_id, H5F_close_degree_t *degree);
#ccall H5Pget_fclose_degree, <hid_t> -> Out <H5F_close_degree_t> -> IO <herr_t>

-- herr_t H5Pset_meta_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_meta_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_meta_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_meta_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_sieve_buf_size(hid_t fapl_id, size_t size);
#ccall H5Pset_sieve_buf_size, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_sieve_buf_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_sieve_buf_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_small_data_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_small_data_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_small_data_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_small_data_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_libver_bounds(hid_t plist_id, H5F_libver_t low,
--     H5F_libver_t high);
#ccall H5Pset_libver_bounds, <hid_t> -> <H5F_libver_t> -> <H5F_libver_t> -> IO <herr_t>

-- herr_t H5Pget_libver_bounds(hid_t plist_id, H5F_libver_t *low,
--     H5F_libver_t *high);
#ccall H5Pget_libver_bounds, <hid_t> -> Out H5F_libver_t -> Out H5F_libver_t -> IO <herr_t>


-- /* Dataset creation property list (DCPL) routines */
-- herr_t H5Pset_layout(hid_t plist_id, H5D_layout_t layout);
#ccall H5Pset_layout, <hid_t> -> <H5D_layout_t> -> IO <herr_t>

-- H5D_layout_t H5Pget_layout(hid_t plist_id);
#ccall H5Pget_layout, <hid_t> -> IO <H5D_layout_t>

-- herr_t H5Pset_chunk(hid_t plist_id, int ndims, const hsize_t dim[/*ndims*/]);
#ccall H5Pset_chunk, <hid_t> -> CInt -> InArray <hsize_t> -> IO <herr_t>

-- int H5Pget_chunk(hid_t plist_id, int max_ndims, hsize_t dim[]/*out*/);
#ccall H5Pget_chunk, <hid_t> -> CInt -> OutArray <hsize_t> -> IO CInt

-- herr_t H5Pset_external(hid_t plist_id, const char *name, off_t offset,
--           hsize_t size);
#ccall H5Pset_external, <hid_t> -> CString -> <off_t> -> <hsize_t> -> IO <herr_t>

-- int H5Pget_external_count(hid_t plist_id);
#ccall H5Pget_external_count, <hid_t> -> IO CInt

-- herr_t H5Pget_external(hid_t plist_id, unsigned idx, size_t name_size,
--           char *name/*out*/, off_t *offset/*out*/,
--           hsize_t *size/*out*/);
#ccall H5Pget_external, <hid_t> -> CUInt -> <size_t> -> OutArray CChar -> Out <off_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_szip(hid_t plist_id, unsigned options_mask, unsigned pixels_per_block);
#ccall H5Pset_szip, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pset_shuffle(hid_t plist_id);
#ccall H5Pset_shuffle, <hid_t> -> IO <herr_t>

-- herr_t H5Pset_nbit(hid_t plist_id);
#ccall H5Pset_nbit, <hid_t> -> IO <herr_t>

-- herr_t H5Pset_scaleoffset(hid_t plist_id, H5Z_SO_scale_type_t scale_type, int scale_factor);
#ccall H5Pset_scaleoffset, <hid_t> -> <H5Z_SO_scale_type_t> -> CInt -> IO <herr_t>

-- herr_t H5Pset_fill_value(hid_t plist_id, hid_t type_id,
--      const void *value);
#ccall H5Pset_fill_value, <hid_t> -> <hid_t> -> In a -> IO <herr_t>

-- herr_t H5Pget_fill_value(hid_t plist_id, hid_t type_id,
--      void *value/*out*/);
#ccall H5Pget_fill_value, <hid_t> -> <hid_t> -> Out a -> IO <herr_t>

-- herr_t H5Pfill_value_defined(hid_t plist, H5D_fill_value_t *status);
#ccall H5Pfill_value_defined, <hid_t> -> Ptr <H5D_fill_value_t> -> IO <herr_t>

-- herr_t H5Pset_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- 	alloc_time);
#ccall H5Pset_alloc_time, <hid_t> -> <H5D_alloc_time_t> -> IO <herr_t>

-- herr_t H5Pget_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- 	*alloc_time/*out*/);
#ccall H5Pget_alloc_time, <hid_t> -> Out H5D_alloc_time_t -> IO <herr_t>

-- herr_t H5Pset_fill_time(hid_t plist_id, H5D_fill_time_t fill_time);
#ccall H5Pset_fill_time, <hid_t> -> <H5D_fill_time_t> -> IO <herr_t>

-- herr_t H5Pget_fill_time(hid_t plist_id, H5D_fill_time_t
-- 	*fill_time/*out*/);
#ccall H5Pget_fill_time, <hid_t> -> Out <H5D_fill_time_t> -> IO <herr_t>


#if H5_VERSION_ATLEAST(1,8,3)

-- /* Dataset access property list (DAPL) routines */
-- herr_t H5Pset_chunk_cache(hid_t dapl_id, size_t rdcc_nslots,
--        size_t rdcc_nbytes, double rdcc_w0);
#ccall H5Pset_chunk_cache, <hid_t> -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- herr_t H5Pget_chunk_cache(hid_t dapl_id,
--        size_t *rdcc_nslots/*out*/,
--        size_t *rdcc_nbytes/*out*/,
--        double *rdcc_w0/*out*/);
#ccall H5Pget_chunk_cache, <hid_t> -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>

#endif


-- /* Dataset xfer property list (DXPL) routines */
-- herr_t H5Pset_data_transform(hid_t plist_id, const char* expression);
#ccall H5Pset_data_transform, <hid_t> -> CString -> IO <herr_t>

-- ssize_t H5Pget_data_transform(hid_t plist_id, char* expression /*out*/, size_t size);
#ccall H5Pget_data_transform, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- herr_t H5Pset_buffer(hid_t plist_id, size_t size, void *tconv,
--         void *bkg);
#ccall H5Pset_buffer, <hid_t> -> <size_t> -> Ptr a -> Ptr b -> IO <herr_t>

-- size_t H5Pget_buffer(hid_t plist_id, void **tconv/*out*/,
--         void **bkg/*out*/);
#ccall H5Pget_buffer, <hid_t> -> Out (Ptr a) -> Out (Ptr b) -> IO <size_t>

-- herr_t H5Pset_preserve(hid_t plist_id, hbool_t status);
#ccall H5Pset_preserve, <hid_t> -> <hbool_t> -> IO <herr_t>

-- int H5Pget_preserve(hid_t plist_id);
#ccall H5Pget_preserve, <hid_t> -> IO CInt

-- herr_t H5Pset_edc_check(hid_t plist_id, H5Z_EDC_t check);
#ccall H5Pset_edc_check, <hid_t> -> <H5Z_EDC_t> -> IO <herr_t>

-- H5Z_EDC_t H5Pget_edc_check(hid_t plist_id);
#ccall H5Pget_edc_check, <hid_t> -> IO <H5Z_EDC_t>

-- herr_t H5Pset_filter_callback(hid_t plist_id, H5Z_filter_func_t func,
--                                      void* op_data);
#ccall H5Pset_filter_callback, <hid_t> -> H5Z_filter_func_t a b -> Ptr b -> IO <herr_t>

-- herr_t H5Pset_btree_ratios(hid_t plist_id, double left, double middle,
--        double right);
#ccall H5Pset_btree_ratios, <hid_t> -> CDouble -> CDouble -> CDouble -> IO <herr_t>

-- herr_t H5Pget_btree_ratios(hid_t plist_id, double *left/*out*/,
--        double *middle/*out*/,
--        double *right/*out*/);
#ccall H5Pget_btree_ratios, <hid_t> -> Out CDouble -> Out CDouble -> Out CDouble -> IO <herr_t>

-- herr_t H5Pset_vlen_mem_manager(hid_t plist_id,
--                                        H5MM_allocate_t alloc_func,
--                                        void *alloc_info, H5MM_free_t free_func,
--                                        void *free_info);
#ccall H5Pset_vlen_mem_manager, <hid_t> -> H5MM_allocate_t allocInfo mem -> Ptr allocInfo -> H5MM_free_t freeInfo mem -> Ptr freeInfo -> IO <herr_t>

-- herr_t H5Pget_vlen_mem_manager(hid_t plist_id,
--                                        H5MM_allocate_t *alloc_func,
--                                        void **alloc_info,
--                                        H5MM_free_t *free_func,
--                                        void **free_info);
#ccall H5Pget_vlen_mem_manager, <hid_t> -> Out (H5MM_allocate_t allocInfo mem) -> Out (Ptr allocInfo) -> Out (H5MM_free_t freeInfo mem) -> Out (Ptr freeInfo) -> IO <herr_t>

-- herr_t H5Pset_hyper_vector_size(hid_t fapl_id, size_t size);
#ccall H5Pset_hyper_vector_size, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_hyper_vector_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_hyper_vector_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t op, void* operate_data);
#ccall H5Pset_type_conv_cb, <hid_t> -> H5T_conv_except_func_t a b -> Ptr b -> IO <herr_t>

-- herr_t H5Pget_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t *op, void** operate_data);
#ccall H5Pget_type_conv_cb, <hid_t> -> Out (H5T_conv_except_func_t a b) -> Out (Ptr b) -> IO <herr_t>


-- /* Link creation property list (LCPL) routines */
-- herr_t H5Pset_create_intermediate_group(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_create_intermediate_group, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_create_intermediate_group(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_create_intermediate_group, <hid_t> -> Out CUInt -> IO <herr_t>


-- /* Group creation property list (GCPL) routines */
-- herr_t H5Pset_local_heap_size_hint(hid_t plist_id, size_t size_hint);
#ccall H5Pset_local_heap_size_hint, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_local_heap_size_hint(hid_t plist_id, size_t *size_hint /*out*/);
#ccall H5Pget_local_heap_size_hint, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_link_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_link_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_link_phase_change(hid_t plist_id, unsigned *max_compact /*out*/, unsigned *min_dense /*out*/);
#ccall H5Pget_link_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_est_link_info(hid_t plist_id, unsigned est_num_entries, unsigned est_name_len);
#ccall H5Pset_est_link_info, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_est_link_info(hid_t plist_id, unsigned *est_num_entries /* out */, unsigned *est_name_len /* out */);
#ccall H5Pget_est_link_info, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_link_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_link_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_link_creation_order(hid_t plist_id, unsigned *crt_order_flags /* out */);
#ccall H5Pget_link_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>


-- /* String creation property list (STRCPL) routines */
-- herr_t H5Pset_char_encoding(hid_t plist_id, H5T_cset_t encoding);
#ccall H5Pset_char_encoding, <hid_t> -> <H5T_cset_t> -> IO <herr_t>

-- herr_t H5Pget_char_encoding(hid_t plist_id, H5T_cset_t *encoding /*out*/);
#ccall H5Pget_char_encoding, <hid_t> -> Out <H5T_cset_t> -> IO <herr_t>


-- /* Link access property list (LAPL) routines */
-- herr_t H5Pset_nlinks(hid_t plist_id, size_t nlinks);
#ccall H5Pset_nlinks, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_nlinks(hid_t plist_id, size_t *nlinks);
#ccall H5Pget_nlinks, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_elink_prefix(hid_t plist_id, const char *prefix);
#ccall H5Pset_elink_prefix, <hid_t> -> CString -> IO <herr_t>

-- ssize_t H5Pget_elink_prefix(hid_t plist_id, char *prefix, size_t size);
#ccall H5Pget_elink_prefix, <hid_t> -> OutArray CChar -> CString -> IO <ssize_t>

#if H5_VERSION_ATLEAST(1,8,2)

-- hid_t H5Pget_elink_fapl(hid_t lapl_id);
#ccall H5Pget_elink_fapl, <hid_t> -> IO <hid_t>

-- herr_t H5Pset_elink_fapl(hid_t lapl_id, hid_t fapl_id);
#ccall H5Pset_elink_fapl, <hid_t> -> <hid_t> -> IO <herr_t>

#endif

#if H5_VERSION_ATLEAST(1,8,3)

-- herr_t H5Pset_elink_acc_flags(hid_t lapl_id, unsigned flags);
#ccall H5Pset_elink_acc_flags, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_elink_acc_flags(hid_t lapl_id, unsigned *flags);
#ccall H5Pget_elink_acc_flags, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_elink_cb(hid_t lapl_id, H5L_elink_traverse_t func, void *op_data);
#ccall H5Pset_elink_cb, <hid_t> -> H5L_elink_traverse_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Pget_elink_cb(hid_t lapl_id, H5L_elink_traverse_t *func, void **op_data);
#ccall H5Pget_elink_cb, <hid_t> -> Out (H5L_elink_traverse_t a) -> Out (Ptr a) -> IO <herr_t>

#endif


-- /* Object copy property list (OCPYPL) routines */
-- herr_t H5Pset_copy_object(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_copy_object, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_copy_object(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_copy_object, <hid_t> -> Out CUInt -> IO <herr_t>

-- 
-- /* Symbols defined for compatibility with previous versions of the HDF5 API.
--  *
--  * Use of these symbols is deprecated.
--  */
#ifndef H5_NO_DEPRECATED_SYMBOLS

h5p_NO_CLASS = h5p_ROOT

-- /* Function prototypes */
-- herr_t H5Pregister1(hid_t cls_id, const char *name, size_t size,
--     void *def_value, H5P_prp_create_func_t prp_create,
--     H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_close_func_t prp_close);
#ccall H5Pregister1, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_create_func_t a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- herr_t H5Pinsert1(hid_t plist_id, const char *name, size_t size,
--     void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_close_func_t prp_close);
#ccall H5Pinsert1, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- H5Z_filter_t H5Pget_filter1(hid_t plist_id, unsigned filter,
--     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--     unsigned cd_values[]/*out*/, size_t namelen, char name[]);
#ccall H5Pget_filter1, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> Out CChar -> IO <H5Z_filter_t>

-- herr_t H5Pget_filter_by_id1(hid_t plist_id, H5Z_filter_t id,
--     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--     unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/);
#ccall H5Pget_filter_by_id1, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
