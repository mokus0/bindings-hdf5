#include <bindings.h>
#include <H5Ppublic.h>

module Bindings.HDF5.Raw.H5P where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5AC
import Bindings.HDF5.Raw.H5D
import Bindings.HDF5.Raw.H5F
import Bindings.HDF5.Raw.H5FD
import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5L
import Bindings.HDF5.Raw.H5MM
import Bindings.HDF5.Raw.H5O
import Bindings.HDF5.Raw.H5T
import Bindings.HDF5.Raw.H5Z

import Foreign.Ptr.Conventions
import System.Posix.Types (COff(..))

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
type H5P_cls_create_func_t a = FunPtr (HId_t -> Ptr a -> IO HErr_t)

-- |
-- > typedef herr_t (*H5P_cls_copy_func_t)(hid_t new_prop_id, hid_t old_prop_id,
-- >                                       void *copy_data);
type H5P_cls_copy_func_t a = FunPtr (HId_t -> HId_t -> Ptr a -> IO HErr_t)

-- |
-- > typedef herr_t (*H5P_cls_close_func_t)(hid_t prop_id, void *close_data);
type H5P_cls_close_func_t a = FunPtr (HId_t -> Ptr a -> IO HErr_t)

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
-- [@ name  :: 'CString' @] The name of the property being copied.
-- 
-- [@ size  :: 'CSize'   @] The size of the property value
-- 
-- [@ value :: 'InOut' a @] The value of the property being copied.
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
-- [@ value1 :: 'In' a  @]    The value of the first property being compared.
-- 
-- [@ value2 :: 'In' a  @]    The value of the second property being compared.
-- 
-- [@ size   :: 'CSize' @]    The size of the property value
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

-- |Type of operator callback for 'h5p_iterate'.
-- 
-- The operation receives the property list or class identifier for the object
-- being iterated over, 'id', the name of the current property within the object,
-- 'name', and the pointer to the operator data passed in to H5Piterate, 'iter_data'.
-- 
-- The return values from an operator are:
-- 
-- * Zero causes the iterator to continue, returning zero when all properties
--   have been processed.
-- 
-- * Positive causes the iterator to immediately return that positive value,
--   indicating short-circuit success. The iterator can be restarted at the
--   index of the next property.
-- 
-- * Negative causes the iterator to immediately return that value, indicating
--   failure. The iterator can be restarted at the index of the next
--   property.
-- 
-- > typedef herr_t (*H5P_iterate_t)(hid_t id, const char *name, void *iter_data);
type H5P_iterate_t a = FunPtr (HId_t -> CString -> InOut a -> IO HErr_t)

#if H5_VERSION_GE(1,8,8)

-- |Actual IO mode property
#newtype H5D_mpio_actual_chunk_opt_mode_t

-- |The default value, H5D_MPIO_NO_CHUNK_OPTIMIZATION, is used for all I/O
-- operations that do not use chunk optimizations, including non-collective
-- I/O and contiguous collective I/O.
#newtype_const H5D_mpio_actual_chunk_opt_mode_t, H5D_MPIO_NO_CHUNK_OPTIMIZATION
#newtype_const H5D_mpio_actual_chunk_opt_mode_t, H5D_MPIO_LINK_CHUNK
#newtype_const H5D_mpio_actual_chunk_opt_mode_t, H5D_MPIO_MULTI_CHUNK

#if H5_VERSION_LE(1,8,10)
#newtype_const H5D_mpio_actual_chunk_opt_mode_t, H5D_MPIO_MULTI_CHUNK_NO_OPT
#endif

-- |The following four values are conveniently defined as a bit field so that
-- we can switch from the default to indpendent or collective and then to
-- mixed without having to check the original value. 
#newtype H5D_mpio_actual_io_mode_t

-- |NO_COLLECTIVE means that either collective I/O wasn't requested or that 
-- no I/O took place.
#newtype_const H5D_mpio_actual_io_mode_t, H5D_MPIO_NO_COLLECTIVE

-- |CHUNK_INDEPENDENT means that collective I/O was requested, but the
-- chunk optimization scheme chose independent I/O for each chunk.
#newtype_const H5D_mpio_actual_io_mode_t, H5D_MPIO_CHUNK_INDEPENDENT
#newtype_const H5D_mpio_actual_io_mode_t, H5D_MPIO_CHUNK_COLLECTIVE
#newtype_const H5D_mpio_actual_io_mode_t, H5D_MPIO_CHUNK_MIXED

-- |The contiguous case is separate from the bit field.
#newtype_const H5D_mpio_actual_io_mode_t, H5D_MPIO_CONTIGUOUS_COLLECTIVE

#endif

#if H5_VERSION_GE(1,8,10)

-- | Broken collective IO property
#newtype H5D_mpio_no_collective_cause_t

#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_COLLECTIVE
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_SET_INDEPENDENT
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_DATATYPE_CONVERSION
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_DATA_TRANSFORMS
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_SET_MPIPOSIX
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_POINT_SELECTIONS
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET
#newtype_const H5D_mpio_no_collective_cause_t, H5D_MPIO_FILTERS

#endif

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
-- [@ plist_id :: 'HId_t'   @]    Property list to find property in
-- 
-- [@ name     :: 'CString' @]    Name of property to set
-- 
-- [@ value    :: 'In' a    @]    Pointer to the value for the property
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset(hid_t plist_id, const char *name, void *value);
#ccall H5Pset, <hid_t> -> CString -> In a -> IO <herr_t>

-- |Routine to query the existence of a property in a property object.
-- 
-- Parameters:
-- 
-- [@ id   :: 'HId_t'   @]    Property object ID to check
-- 
-- [@ name :: 'CString' @]    Name of property to check for
-- 
-- > htri_t H5Pexist(hid_t plist_id, const char *name);
#ccall H5Pexist, <hid_t> -> CString -> IO <htri_t>

-- |Routine to query the size of a property in a property list or class.
-- 
-- This routine retrieves the size of a property's value in bytes.  Zero-
-- sized properties are allowed and return a value of 0.  This function works
-- for both property lists and classes.
-- 
-- Parameters:
-- 
-- [@ id   :: 'HId_t'       @]  ID of property list or class to check
-- 
-- [@ name :: 'CString'     @]  Name of property to query
-- 
-- [@ size :: 'Out' 'CSize' @]  Size of property
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_size(hid_t id, const char *name, size_t *size);
#ccall H5Pget_size, <hid_t> -> CString -> Out <size_t> -> IO <herr_t>

-- |Routine to query the size of a property in a property list or class.
-- 
-- This routine retrieves the number of properties in a property list or
-- class.  If a property class ID is given, the number of registered properties
-- in the class is returned in 'nprops'.  If a property list ID is given, the
-- current number of properties in the list is returned in 'nprops'.
-- 
-- Parameters:
-- 
-- [@ id     'HId_t'       @]   ID of Property list or class to check
-- 
-- [@ nprops 'Out' 'CSize' @]   Number of properties in the property object
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_nprops(hid_t id, size_t *nprops);
#ccall H5Pget_nprops, <hid_t> -> Out <size_t> -> IO <herr_t>

-- |Routine to query the name of a generic property list class
-- 
-- This routine retrieves the name of a generic property list class.
-- The pointer to the name must be free'd by the user for successful calls.
-- 
-- Parameters:
-- 
-- [@ pclass_id :: 'HId_t' @] Property class to query
-- 
-- Returns a pointer to a malloc'ed string containing the class name, or
-- NULL on failure.
-- 
-- > hid_t H5Pget_class(hid_t plist_id);
#ccall H5Pget_class, <hid_t> -> IO <hid_t>

-- |This routine retrieves an ID for the parent class of a property class.
-- 
-- Parameters:
-- 
-- [@ pclass_id :: 'HId_t' @] Property class to query
-- 
-- Returns the ID of the parent class object or NULL on failure.
-- 
-- > hid_t H5Pget_class_parent(hid_t pclass_id);
#ccall H5Pget_class_parent, <hid_t> -> IO <hid_t>

-- |Routine to query the value of a property in a property list.
-- 
-- Retrieves a copy of the value for a property in a property list.  The
-- property name must exist or this routine will fail.  If there is a
-- 'get' callback routine registered for this property, the copy of the
-- value of the property will first be passed to that routine and any changes
-- to the copy of the value will be used when returning the property value
-- from this routine.
-- 
-- If the 'get' callback routine returns an error, 'value' will not be
-- modified and this routine will return an error.  This routine may not be
-- called for zero-sized properties.
-- 
-- Parameters:
-- 
-- [@ plist_id :: 'HId_t'   @]  Property list to check
-- 
-- [@ name     :: 'CString' @]  Name of property to query
-- 
-- [@ value    :: 'Out' a   @]  Pointer to the buffer for the property value
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget(hid_t plist_id, const char *name, void * value);
#ccall H5Pget, <hid_t> -> CString -> Out a -> IO <herr_t>

-- |Determines whether two property lists or two property classes are equal.
-- 
-- Parameters:
-- 
-- [@ id1 :: 'HId_t' @] Property list or class ID to compare
-- 
-- [@ id2 :: 'HId_t' @] Property list or class ID to compare
-- 
-- > htri_t H5Pequal(hid_t id1, hid_t id2);
#ccall H5Pequal, <hid_t> -> <hid_t> -> IO <htri_t>

-- |This routine queries whether a property list is a member of the property
-- list class.
-- 
-- Parameters:
-- 
-- [@ plist_id  :: 'HId_t' @] Property list to query
-- 
-- [@ pclass_id :: 'HId_t' @] Property class to query
-- 
-- > htri_t H5Pisa_class(hid_t plist_id, hid_t pclass_id);
#ccall H5Pisa_class, <hid_t> -> <hid_t> -> IO <htri_t>

-- |This routine iterates over the properties in the property object specified
-- with ID.  The properties in both property lists and classes may be iterated
-- over with this function.  For each property in the object, the 'iter_data' and
-- some additional information, specified below, are passed to the 'iter_func'
-- function.  The iteration begins with the 'idx' property in the object and the
-- next element to be processed by the operator is returned in 'idx'.  If 'idx' is
-- NULL, then the iterator starts at the first property; since no stopping point
-- is returned in this case, the iterator cannot be restarted if one of the calls
-- to its operator returns non-zero.  The 'idx' value is 0-based (ie. to start at
-- the "first" property, the 'idx' value should be 0).
-- 
-- 'h5p_iterate' assumes that the properties in the object identified by ID remains
-- unchanged through the iteration.  If the membership changes during the
-- iteration, the function's behavior is undefined.
-- 
-- Parameters:
--
-- [@ id        :: 'HId_t'           @] ID of property object to iterate over
--
-- [@ idx       :: 'InOut' 'CInt'    @] Index of the property to begin with
--
-- [@ iter_func :: 'H5P_iterate_t' a @] Function pointer to function to be called with each property iterated over.
--
-- [@ iter_data :: 'InOut' a         @] Pointer to iteration data from user
--
-- Returns the return value of the last call to 'iter_func' if it was
-- non-zero, or zero if all properties have been processed.  Returns a
-- negative value on failure.
-- 
-- > int H5Piterate(hid_t id, int *idx, H5P_iterate_t iter_func,
-- >             void *iter_data);
#ccall H5Piterate, <hid_t> -> InOut CInt -> H5P_iterate_t a -> InOut a -> IO CInt

-- |Copies a property from one property list or class to another.
-- 
-- If a property is copied from one class to another, all the property
-- information will be first deleted from the destination class and then the
-- property information will be copied from the source class into the
-- destination class.
-- 
-- If a property is copied from one list to another, the property will be
-- first deleted from the destination list (generating a call to the 'close'
-- callback for the property, if one exists) and then the property is copied
-- from the source list to the destination list (generating a call to the
-- 'copy' callback for the property, if one exists).
-- 
-- If the property does not exist in the destination class or list, this call
-- is equivalent to calling H5Pregister2 or H5Pinsert2 (for a class or list, as
-- appropriate) and the 'create' callback will be called in the case of the
-- property being copied into a list (if such a callback exists for the
-- property).
-- 
-- Parameters:
-- 
-- [@ dst_id :: 'HId_t'   @]    ID of destination property list or class
-- 
-- [@ src_id :: 'HId_t'   @]    ID of source property list or class
-- 
-- [@ name   :: 'CString' @]    Name of property to copy
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pcopy_prop(hid_t dst_id, hid_t src_id, const char *name);
#ccall H5Pcopy_prop, <hid_t> -> <hid_t> -> CString -> IO <herr_t>

-- |Removes a property from a property list.  Both properties which were
-- in existance when the property list was created (i.e. properties registered
-- with 'h5p_register2') and properties added to the list after it was created
-- (i.e. added with 'h5p_insert2') may be removed from a property list.
-- Properties do not need to be removed a property list before the list itself
-- is closed, they will be released automatically when 'h5p_close' is called.
-- The 'close' callback for this property is called before the property is
-- release, if the callback exists.
-- 
-- Parameters:
-- 
-- [@ plist_id :: 'HId_t'   @]  Property list to modify
-- 
-- [@ name     :: 'CString' @]  Name of property to remove
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Premove(hid_t plist_id, const char *name);
#ccall H5Premove, <hid_t> -> CString -> IO <herr_t>

-- |Removes a property from a property list class.  Future property lists
-- created of that class will not contain this property.  Existing property
-- lists containing this property are not affected.
-- 
-- Parameters:
-- [@ pclass_id :: 'HId_t'   @] Property list class to modify
-- [@ name      :: 'CString' @] Name of property to remove
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Punregister(hid_t pclass_id, const char *name);
#ccall H5Punregister, <hid_t> -> CString -> IO <herr_t>

-- |Release memory and de-attach a class from the property list class hierarchy.
-- 
-- Parameters:
-- 
-- [@ cls_id :: 'HId_t' @]  Property list class ID to class
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pclose_class(hid_t plist_id);
#ccall H5Pclose_class, <hid_t> -> IO <herr_t>

-- |Closes a property list.  If a 'close' callback exists for the property
-- list class, it is called before the property list is destroyed.  If 'close'
-- callbacks exist for any individual properties in the property list, they are
-- called after the class 'close' callback.
-- 
-- Parameters:
-- [@ plist_id :: 'HId_t' @]    Property list to close
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pclose(hid_t plist_id);
#ccall H5Pclose, <hid_t> -> IO <herr_t>

-- |Copy a property list or class and return the ID.  This routine calls the
-- class 'copy' callback after any property 'copy' callbacks are called
-- (assuming all property 'copy' callbacks return successfully).
-- 
-- Parameters:
--     hid_t id;           IN: Property list or class ID to copy
-- 
-- Returns a valid (non-negative) property list ID on success, negative on failure.
-- 
-- > hid_t H5Pcopy(hid_t plist_id);
#ccall H5Pcopy, <hid_t> -> IO <hid_t>

-- * Object creation property list (OCPL) routines

-- |Sets the cutoff values for indexes storing attributes
-- in object headers for this file.  If more than 'max_compact'
-- attributes are in an object header, the attributes will be
-- moved to a heap and indexed with a B-tree.
--
-- Likewise, an object header containing fewer than 'min_dense'
-- attributes will be converted back to storing the attributes
-- directly in the object header.
-- 
-- If the 'max_compact' is zero then attributes for this object will
-- never be stored in the object header but will be always be
-- stored in a heap.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_attr_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_attr_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Gets the phase change values for attribute storage
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_attr_phase_change(hid_t plist_id, unsigned *max_compact, unsigned *min_dense);
#ccall H5Pget_attr_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Set the flags for creation order of attributes on an object
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_attr_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_attr_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- |Returns the flags indicating creation order is tracked/indexed
-- for attributes on an object.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_attr_creation_order(hid_t plist_id, unsigned *crt_order_flags);
#ccall H5Pget_attr_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Set whether the birth, access, modification & change times for
-- an object are stored.
-- 
-- Birth time is the time the object was created.  Access time is
-- the last time that metadata or raw data was read from this
-- object.  Modification time is the last time the data for
-- this object was changed (either writing raw data to a dataset
-- or inserting/modifying/deleting a link in a group).  Change
-- time is the last time the metadata for this object was written
-- (adding/modifying/deleting an attribute on an object, extending
-- the size of a dataset, etc).
-- 
-- If these times are not tracked, they will be reported as
-- 12:00 AM UDT, Jan. 1, 1970 (i.e. 0 seconds past the UNIX
-- epoch) when queried.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_obj_track_times(hid_t plist_id, hbool_t track_times);
#ccall H5Pset_obj_track_times, <hid_t> -> <hbool_t> -> IO <herr_t>

-- |Returns whether times are tracked for an object.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_obj_track_times(hid_t plist_id, hbool_t *track_times);
#ccall H5Pget_obj_track_times, <hid_t> -> Out <hbool_t> -> IO <herr_t>

-- |Modifies the specified 'filter' in the transient or permanent
-- output filter pipeline depending on whether 'plist' is a dataset
-- creation or dataset transfer property list.  The 'flags' argument
-- specifies certain general properties of the filter and is 
-- documented below.  The 'cd_values' is an array of 'cd_nelmts'
-- integers which are auxiliary data for the filter.  The integer
-- values will be stored in the dataset object header as part of 
-- the filter information.
-- 
-- The 'flags' argument is a bit vector of the following fields:
-- 
-- ['h5z_FLAG_OPTIONAL']
-- If this bit is set then the filter is optional.  If the
-- filter fails during an 'h5d_write' operation then the filter
-- is just excluded from the pipeline for the chunk for which it
-- failed; the filter will not participate in the pipeline
-- during an 'h5d_read' of the chunk.  If this bit is clear and
-- the filter fails then the entire I/O operation fails.
-- If this bit is set but encoding is disabled for a filter,
-- attempting to write will generate an error.
-- 
-- Note:  This function currently supports only the permanent filter
-- pipeline.  That is, 'plist_id' must be a dataset creation
-- property list.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pmodify_filter(hid_t plist_id, H5Z_filter_t filter,
-- >         unsigned int flags, size_t cd_nelmts,
-- >         const unsigned int cd_values[/*cd_nelmts*/]);
#ccall H5Pmodify_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- |Adds the specified 'filter' and corresponding properties to the
-- end of the data or link output filter pipeline
-- depending on whether 'plist' is a dataset creation or group
-- creation property list.  The 'flags' argument specifies certain
-- general properties of the filter and is documented below.
-- The 'cd_values' is an array of 'cd_nelmts' integers which are
-- auxiliary data for the filter.  The integer vlues will be
-- stored in the dataset object header as part of the filter
-- information.
-- 
-- The 'flags' argument is a bit vector of the following fields:
-- 
-- ['h5z_FLAG_OPTIONAL']
-- If this bit is set then the filter is optional.  If the
-- filter fails during an 'h5d_write' operation then the filter
-- is just excluded from the pipeline for the chunk for which it
-- failed; the filter will not participate in the pipeline
-- during an 'h5d_read' of the chunk.  If this bit is clear and
-- the filter fails then the entire I/O operation fails.
-- If this bit is set but encoding is disabled for a filter,
-- attempting to write will generate an error.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_filter(hid_t plist_id, H5Z_filter_t filter,
-- >         unsigned int flags, size_t cd_nelmts,
-- >         const unsigned int c_values[]);
#ccall H5Pset_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- |Returns the number of filters in the data or link
-- pipeline depending on whether 'plist_id' is a dataset creation
-- or group creation property list.  In each pipeline the
-- filters are numbered from zero through N-1 where N is the
-- value returned by this function.  During output to the file
-- the filters of a pipeline are applied in increasing order
-- (the inverse is true for input).
-- 
-- Returns the number of filters or negative on failure.
-- 
-- > int H5Pget_nfilters(hid_t plist_id);
#ccall H5Pget_nfilters, <hid_t> -> IO CInt

-- |This is the query counterpart of 'h5p_set_filter' and returns
-- information about a particular filter number in a permanent
-- or transient pipeline depending on whether 'plist_id' is a
-- dataset creation or transfer property list.  On input,
-- 'cd_nelmts' indicates the number of entries in the 'cd_values'
-- array allocated by the caller while on exit it contains the
-- number of values defined by the filter.  'filter_config' is a bit
-- field contaning encode/decode flags from "Bindings.HDF5.Raw.H5Z".  The
-- 'idx' should be a value between zero and N-1 as described for
-- 'h5p_get_nfilters' and the function will return failure if the
-- filter number is out of range.
-- 
-- Returns the filter identification number or 'h5z_FILTER_ERROR' on
-- failure (which is negative).
-- 
-- > H5Z_filter_t H5Pget_filter2(hid_t plist_id, unsigned filter,
-- >        unsigned int *flags/*out*/,
-- >        size_t *cd_nelmts/*out*/,
-- >        unsigned cd_values[]/*out*/,
-- >        size_t namelen, char name[],
-- >        unsigned *filter_config /*out*/);
#ccall H5Pget_filter2, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> Out CUInt -> IO <H5Z_filter_t>

-- |This is an additional query counterpart of 'h5p_set_filter' and
-- returns information about a particular filter in a permanent
-- or transient pipeline depending on whether 'plist_id' is a
-- dataset creation or transfer property list.  On input,
-- 'cd_nelmts' indicates the number of entries in the 'cd_values'
-- array allocated by the caller while on exit it contains the
-- number of values defined by the filter.  'filter_config' is a bit
-- field contaning encode/decode flags from "Bindings.HDF5.Raw.H5Z".  The 
-- ID should be the filter ID to retrieve the parameters for.  If the
-- filter is not set for the property list, an error will be returned.
--
-- Returns the number of filters or negative on failure.
-- 
-- > herr_t H5Pget_filter_by_id2(hid_t plist_id, H5Z_filter_t id,
-- >        unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
-- >        unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/,
-- >        unsigned *filter_config/*out*/);
#ccall H5Pget_filter_by_id2, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out CSize -> OutArray CUInt -> CSize -> OutArray CChar -> Out CUInt -> IO <herr_t>

-- |This is a query routine to verify that all the filters set
-- in the dataset creation property list are available currently.
-- 
-- > htri_t H5Pall_filters_avail(hid_t plist_id);
#ccall H5Pall_filters_avail, <hid_t> -> IO <htri_t>

-- |Deletes a filter from the dataset creation property list;
-- deletes all filters if 'filter' is 'h5z_FILTER_NONE'
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Premove_filter(hid_t plist_id, H5Z_filter_t filter);
#ccall H5Premove_filter, <hid_t> -> <H5Z_filter_t> -> IO <herr_t>

-- |Sets the compression method for a dataset or group link
-- filter pipeline (depending on whether 'plist_id' is a dataset
-- creation or group creation property list) to 'h5z_FILTER_DEFLATE'
-- and the compression level to 'level' which should be a value
-- between zero and nine, inclusive.  Lower compression levels
-- are faster but result in less compression.  This is the same
-- algorithm as used by the GNU gzip program.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_deflate(hid_t plist_id, unsigned aggression);
#ccall H5Pset_deflate, <hid_t> -> CUInt -> IO <herr_t>

-- |Sets Fletcher32 checksum of EDC for a dataset creation
-- property list or group creation property list.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_fletcher32(hid_t plist_id);
#ccall H5Pset_fletcher32, <hid_t> -> IO <herr_t>


-- * File creation property list (FCPL) routines

-- |Retrieves version information for various parts of a file.
--
-- Any (or even all) of the output arguments can be null
-- pointers.
--
-- Parameters:
--
-- [@ plist_id :: 'HId_t'       @]  The file creation property list ID
--
-- [@ boot	   :: 'Out' 'CUInt' @]  The file super block.
--
-- [@ freelist :: 'Out' 'CUInt' @]  The global free list.
--
-- [@ stab	   :: 'Out' 'CUInt' @]  The root symbol table entry.
--
-- [@ shhdr    :: 'Out' 'CUInt' @]  Shared object headers.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_version(hid_t plist_id, unsigned *boot/*out*/,
-- >          unsigned *freelist/*out*/, unsigned *stab/*out*/,
-- >          unsigned *shhdr/*out*/);
#ccall H5Pget_version, <hid_t> -> Out CUInt -> Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Sets the userblock size field of a file creation property list.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_userblock(hid_t plist_id, hsize_t size);
#ccall H5Pset_userblock, <hid_t> -> <hsize_t> -> IO <herr_t>

-- |Queries the size of a user block in a file creation property list.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_userblock(hid_t plist_id, hsize_t *size);
#ccall H5Pget_userblock, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- |Sets file size-of addresses and sizes.  'plist_id' should be a
-- file creation property list.  A value of zero causes the
-- property to not change.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_sizes(hid_t plist_id, size_t sizeof_addr,
-- >        size_t sizeof_size);
#ccall H5Pset_sizes, <hid_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- |Returns the size of address and size quantities stored in a
-- file according to a file creation property list.  Either (or
-- even both) 'sizeof_addr' and 'sizeof_size' may be null pointers.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_sizes(hid_t plist_id, size_t *sizeof_addr/*out*/,
-- >        size_t *sizeof_size/*out*/);
#ccall H5Pget_sizes, <hid_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

-- |IK is one half the rank of a tree that stores a symbol
-- table for a group.  Internal nodes of the symbol table are on
-- average 75% full.  That is, the average rank of the tree is
-- 1.5 times the value of IK.
-- 
-- LK is one half of the number of symbols that can be stored in
-- a symbol table node.  A symbol table node is the leaf of a
-- symbol table tree which is used to store a group.  When
-- symbols are inserted randomly into a group, the group's
-- symbol table nodes are 75% full on average.  That is, they
-- contain 1.5 times the number of symbols specified by LK.
-- 
-- Either (or even both) of IK and LK can be zero in which case
-- that value is left unchanged.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_sym_k(hid_t plist_id, unsigned ik, unsigned lk);
#ccall H5Pset_sym_k, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Retrieves the symbol table B-tree 1/2 rank (IK) and the
-- symbol table leaf node 1/2 size (LK).  See 'h5p_set_sym_k' for
-- details. Either (or even both) IK and LK may be null
-- pointers.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_sym_k(hid_t plist_id, unsigned *ik/*out*/, unsigned *lk/*out*/);
#ccall H5Pget_sym_k, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |IK is one half the rank of a tree that stores chunked raw
-- data.  On average, such a tree will be 75% full, or have an
-- average rank of 1.5 times the value of IK.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_istore_k(hid_t plist_id, unsigned ik);
#ccall H5Pset_istore_k, <hid_t> -> CUInt -> IO <herr_t>

-- |Queries the 1/2 rank of an indexed storage B-tree.  See
-- 'h5p_set_istore_k' for details.  The argument IK may be the
-- null pointer.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_istore_k(hid_t plist_id, unsigned *ik/*out*/);
#ccall H5Pget_istore_k, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Set the number of Shared Object Header Message (SOHM)
-- indexes specified in this property list.  If this is
-- zero then shared object header messages are disabled
-- for this file.
-- 
-- These indexes can then be configured with
-- H5Pset_shared_mesg_index.  'h5p_set_shared_mesg_phase_chage'
-- also controls settings for all indexes.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_shared_mesg_nindexes(hid_t plist_id, unsigned nindexes);
#ccall H5Pset_shared_mesg_nindexes, <hid_t> -> CUInt -> IO <herr_t>

-- |Get the number of Shared Object Header Message (SOHM)
-- indexes specified in this property list.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_shared_mesg_nindexes(hid_t plist_id, unsigned *nindexes);
#ccall H5Pget_shared_mesg_nindexes, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Configure a given shared message index.  Sets the types of
-- message that should be stored in this index and the minimum
-- size of a message in the index.
-- 
-- 'index_num' is zero-indexed (in a file with three indexes,
-- they are numbered 0, 1, and 2).
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned mesg_type_flags, unsigned min_mesg_size);
#ccall H5Pset_shared_mesg_index, <hid_t> -> CUInt -> CUInt -> CUInt -> IO <herr_t>

-- |Get information about a given shared message index.  Gets
-- the types of message that are stored in the index and the
-- minimum size of a message in the index.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned *mesg_type_flags, unsigned *min_mesg_size);
#ccall H5Pget_shared_mesg_index, <hid_t> -> CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Sets the cutoff values for indexes storing shared object
-- header messages in this file.  If more than 'max_list'
-- messages are in an index, that index will become a B-tree.
-- Likewise, a B-tree index containing fewer than 'min_btree'
-- messages will be converted to a list.
-- 
-- If the 'max_list' is zero then SOHM indexes in this file will
-- never be lists but will be created as B-trees.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_shared_mesg_phase_change(hid_t plist_id, unsigned max_list, unsigned min_btree);
#ccall H5Pset_shared_mesg_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Gets the maximum size of a SOHM list index before it becomes
-- a B-tree.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_shared_mesg_phase_change(hid_t plist_id, unsigned *max_list, unsigned *min_btree);
#ccall H5Pget_shared_mesg_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- * File access property list (FAPL) routines

-- |Sets the alignment properties of a file access property list
-- so that any file object >= 'threshold' bytes will be aligned on
-- an address which is a multiple of 'alignment'.  The addresses
-- are relative to the end of the user block; the alignment is
-- calculated by subtracting the user block size from the
-- absolute file address and then adjusting the address to be a
-- multiple of 'alignment'.
-- 
-- Default values for 'threshold' and 'alignment' are one, implying
-- no alignment.  Generally the default values will result in
-- the best performance for single-process access to the file.
-- For MPI-IO and other parallel systems, choose an alignment
-- which is a multiple of the disk block size.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_alignment(hid_t fapl_id, hsize_t threshold,
-- >     hsize_t alignment);
#ccall H5Pset_alignment, <hid_t> -> <hsize_t> -> <hsize_t> -> IO <herr_t>

-- |Returns the current settings for alignment properties from a
-- file access property list.  The 'threshold' and/or 'alignment'
-- pointers may be null pointers.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_alignment(hid_t fapl_id, hsize_t *threshold/*out*/,
-- >     hsize_t *alignment/*out*/);
#ccall H5Pget_alignment, <hid_t> -> Out <hsize_t> -> Out <hsize_t> -> IO <herr_t>

-- |Set the file driver ('driver_id') for a file access or data
-- transfer property list ('plist_id') and supply an optional
-- struct containing the driver-specific properites
-- ('driver_info').  The driver properties will be copied into the
-- property list and the reference count on the driver will be
-- incremented, allowing the caller to close the driver ID but
-- still use the property list.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_driver(hid_t plist_id, hid_t driver_id,
-- >         const void *driver_info);
#ccall H5Pset_driver, <hid_t> -> <hid_t> -> In a -> IO <herr_t>

-- |Return the ID of the low-level file driver.  'plist_id' should
-- be a file access property list or data transfer propert list.
-- 
-- Returns a low-level driver ID which is the same ID
-- used when the driver was set for the property
-- list. The driver ID is only valid as long as
-- the file driver remains registered.
-- 
-- Returns a negative value on failure.
-- 
-- > hid_t H5Pget_driver(hid_t plist_id);
#ccall H5Pget_driver, <hid_t> -> IO <hid_t>

-- |Returns a pointer directly to the file driver-specific
-- information of a file access or data transfer property list.
-- 
-- On success, returns a pointer to *uncopied* driver specific data
-- structure if any.
-- 
-- On failure, returns NULL. Null is also returned if the driver has
-- not registered any driver-specific properties although no error is
-- pushed on the stack in this case.
-- 
-- > void *H5Pget_driver_info(hid_t plist_id);
#ccall H5Pget_driver_info, <hid_t> -> IO (Ptr a)

-- |Set offset for family driver.  This file access property
-- list will be passed to H5Fget_vfd_handle or 'h5fd_get_vfd_handle'
-- to retrieve VFD file handle.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_family_offset(hid_t fapl_id, hsize_t offset);
#ccall H5Pset_family_offset, <hid_t> -> <hsize_t> -> IO <herr_t>

-- |Get offset for family driver.  This file access property
-- list will be passed to H5Fget_vfd_handle or 'h5fd_get_vfd_handle'
-- to retrieve VFD file handle.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_family_offset(hid_t fapl_id, hsize_t *offset);
#ccall H5Pget_family_offset, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- |Set data type for multi driver.  This file access property
-- list will be passed to 'h5f_get_vfd_handle' or 'h5fd_get_vfd_handle'
-- to retrieve VFD file handle.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_multi_type(hid_t fapl_id, H5FD_mem_t type);
#ccall H5Pset_multi_type, <hid_t> -> <H5FD_mem_t> -> IO <herr_t>

-- |Get data type for multi driver.  This file access property
-- list will be passed to H5Fget_vfd_handle or 'h5fd_get_vfd_handle'
-- to retrieve VFD file handle.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_multi_type(hid_t fapl_id, H5FD_mem_t *type);
#ccall H5Pget_multi_type, <hid_t> -> Out <H5FD_mem_t> -> IO <herr_t>

-- |Set the number of objects in the meta data cache and the
-- maximum number of chunks and bytes in the raw data chunk
-- cache.
-- 
-- The 'rdcc_w0' value should be between 0 and 1 inclusive and
-- indicates how much chunks that have been fully read or fully
-- written are favored for preemption.  A value of zero means
-- fully read or written chunks are treated no differently than
-- other chunks (the preemption is strictly LRU) while a value
-- of one means fully read chunks are always preempted before
-- other chunks.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_cache(hid_t plist_id, int mdc_nelmts,
-- >        size_t rdcc_nslots, size_t rdcc_nbytes,
-- >        double rdcc_w0);
#ccall H5Pset_cache, <hid_t> -> CInt -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- |Retrieves the maximum possible number of elements in the meta
-- data cache and the maximum possible number of elements and
-- bytes and the 'rdcc_w0' value in the raw data chunk cache.  Any
-- (or all) arguments may be null pointers in which case the
-- corresponding datum is not returned.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_cache(hid_t plist_id,
-- >        int *mdc_nelmts, /* out */
-- >        size_t *rdcc_nslots/*out*/,
-- >        size_t *rdcc_nbytes/*out*/, double *rdcc_w0);
#ccall H5Pget_cache, <hid_t> -> Out CInt -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>

-- |Set the initial metadata cache resize configuration in the
-- target FAPL.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_mdc_config(hid_t    plist_id,
-- >        H5AC_cache_config_t * config_ptr);
#ccall H5Pset_mdc_config, <hid_t> -> In <H5AC_cache_config_t> -> IO <herr_t>

-- |Retrieve the metadata cache initial resize configuration
-- from the target FAPL.
-- 
-- Observe that the function will fail if 'config_ptr' is
-- NULL, or if 'config_ptr'->'version' specifies an unknown
-- version of 'H5AC_cache_config_t'.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_mdc_config(hid_t     plist_id,
-- >        H5AC_cache_config_t * config_ptr);	/* out */
#ccall H5Pget_mdc_config, <hid_t> -> Out <H5AC_cache_config_t> -> IO <herr_t>

-- |Sets the flag for garbage collecting references for the file.
-- Dataset region references (and other reference types
-- probably) use space in the file heap.  If garbage collection
-- is on and the user passes in an uninitialized value in a
-- reference structure, the heap might get corrupted.  When
-- garbage collection is off however and the user re-uses a
-- reference, the previous heap block will be orphaned and not
-- returned to the free heap space.  When garbage collection is
-- on, the user must initialize the reference structures to 0 or
-- risk heap corruption.
--
-- Default value for garbage collecting references is off, just
-- to be on the safe side.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_gc_references(hid_t fapl_id, unsigned gc_ref);
#ccall H5Pset_gc_references, <hid_t> -> CUInt -> IO <herr_t>

-- |Returns the current setting for the garbage collection
-- references property from a file access property list.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_gc_references(hid_t fapl_id, unsigned *gc_ref/*out*/);
#ccall H5Pget_gc_references, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Sets the degree for the file close behavior.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_fclose_degree(hid_t fapl_id, H5F_close_degree_t degree);
#ccall H5Pset_fclose_degree, <hid_t> -> <H5F_close_degree_t> -> IO <herr_t>

-- |Gets the degree for the file close behavior.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_fclose_degree(hid_t fapl_id, H5F_close_degree_t *degree);
#ccall H5Pget_fclose_degree, <hid_t> -> Out <H5F_close_degree_t> -> IO <herr_t>

-- |Sets the minimum size of metadata block allocations when
-- the 'h5fd_FEAT_AGGREGATE_METADATA' is set by a VFL driver.
-- Each \"raw\" metadata block is allocated to be this size and then
-- specific pieces of metadata (object headers, local heaps, B-trees, etc)
-- are sub-allocated from this block.
-- 
-- The default value is set to 2048 (bytes), indicating that metadata
-- will be attempted to be bunched together in (at least) 2K blocks in
-- the file.  Setting the value to 0 with this API function will
-- turn off the metadata aggregation, even if the VFL driver attempts to
-- use that strategy.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_meta_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_meta_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- |Returns the current settings for the metadata block allocation
-- property from a file access property list.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_meta_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_meta_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- |Sets the maximum size of the data seive buffer used for file
-- drivers which are capable of using data sieving.  The data sieve
-- buffer is used when performing I/O on datasets in the file.  Using a
-- buffer which is large anough to hold several pieces of the dataset
-- being read in for hyperslab selections boosts performance by quite a
-- bit.
--
-- The default value is set to 64KB, indicating that file I/O for raw data
-- reads and writes will occur in at least 64KB blocks.
-- Setting the value to 0 with this API function will turn off the
-- data sieving, even if the VFL driver attempts to use that strategy.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_sieve_buf_size(hid_t fapl_id, size_t size);
#ccall H5Pset_sieve_buf_size, <hid_t> -> <size_t> -> IO <herr_t>

-- |Returns the current settings for the data sieve buffer size
-- property from a file access property list.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_sieve_buf_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_sieve_buf_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- |Sets the minimum size of \"small\" raw data block allocations
-- when the 'h5fd_FEAT_AGGREGATE_SMALLDATA' is set by a VFL driver.
-- Each \"small\" raw data block is allocated to be this size and then
-- pieces of raw data which are small enough to fit are sub-allocated from
-- this block.
-- 
-- The default value is set to 2048 (bytes), indicating that raw data
-- smaller than this value will be attempted to be bunched together in (at
-- least) 2K blocks in the file.  Setting the value to 0 with this API
-- function will turn off the \"small\" raw data aggregation, even if the
-- VFL driver attempts to use that strategy.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_small_data_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_small_data_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- |Returns the current settings for the \"small\" raw data block
-- allocation property from a file access property list.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_small_data_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_small_data_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- |Indicates which versions of the file format the library should
-- use when creating objects.  'low' is the earliest version of the HDF5
-- library that is guaranteed to be able to access the objects created
-- (the format of some objects in an HDF5 file may not have changed between
-- versions of the HDF5 library, possibly allowing earlier versions of the
-- HDF5 library to access those objects) and 'high' is the latest version
-- of the library required to access the objects created (later versions
-- of the HDF5 library will also be able to access those objects).
-- 
-- 'low' is used to require that objects use a more modern format and 'high'
-- is used to restrict objects from using a more modern format.
-- 
-- The special values of 'h5f_FORMAT_EARLIEST' and 'h5f_FORMAT_LATEST' can be
-- used in the following manner:  Setting 'low' and 'high' to 'h5f_FORMAT_LATEST'
-- will produce files whose objects use the latest version of the file
-- format available in the current HDF5 library for each object created.
-- Setting 'low' and 'high' to 'h5f_FORMAT_EARLIEST' will produce files that that
-- always require the use of the earliest version of the file format for
-- each object created. [NOTE!  'low'='high'='h5f_FORMAT_EARLIEST' is not
-- implemented as of version 1.8.0 and setting 'low' and 'high' to
-- 'h5f_FORMAT_EARLIEST' will produce an error currently].
-- 
-- Currently, the only two valid combinations for this routine are:
-- 'low' = 'h5f_FORMAT_EARLIEST' and 'high' = 'h5f_FORMAT_LATEST' (the default
-- setting, which creates objects with the ealiest version possible for
-- each object, but no upper limit on the version allowed to be created if
-- a newer version of an object's format is required to support a feature
-- requested with an HDF5 library API routine), and 'low' = 'h5f_FORMAT_LATEST'
-- and 'high' = 'h5f_FORMAT_LATEST' (which is described above).
--
-- The 'low' and 'high' values set with this routine at imposed with each
-- HDF5 library API call that creates objects in the file.  API calls that
-- would violate the 'low' or 'high' format bound will fail.
-- 
-- Setting the 'low' and 'high' values will not affect reading / writing existing
-- objects, only the creation of new objects.
--
-- Note:  Eventually we want to add more values to the 'H5F_libver_t'
-- enumerated type that indicate library release values where the file
-- format was changed (like 'h5f_FORMAT_1_2_0' for the file format changes
-- in the 1.2.x release branch and possily even 'h5f_FORMAT_1_4_2' for
-- a change mid-way through the 1.4.x release branch, etc).
-- 
-- Adding more values will allow applications to make settings like the
-- following:
-- 
-- ['low' = 'h5f_FORMAT_EARLIEST', 'high' = 'h5f_FORMAT_1_2_0']
--      Create objects with the earliest possible format and don't allow
--      any objects to be created that require a library version greater
--      than 1.2.x (This is the \"make certain that \<application\> linked 
--      with v1.2.x of the library can read the file produced\" use case)
-- 
-- ['low' = 'h5f_FORMAT_1_4_2', 'high' = 'h5f_FORMAT_LATEST']
--      Create objects with at least the version of their format that
--      the 1.4.2 library uses and allow any later version of the object's
--      format necessary to represent features used.
--      (This is the \"make certain to take advantage of \<new feature\>
--      in the file format\" use case (maybe \<new feature\> is smaller
--      or scales better than an ealier version, which would otherwise
--      be used))
-- 
-- ['low' = 'h5f_FORMAT_1_2_0', 'high' = 'h5f_FORMAT_1_6_0']
--      Creates objects with at least the version of their format that 
--      the 1.2.x library uses and don't allow any objects to be created 
--      that require a library version greater than 1.6.x.
--      (Not certain of a particular use case for these settings,
--      although its probably just the logical combination of the
--      previous two; it just falls out as possible/logical (if it turns
--      out to be hard to implement in some way, we can always disallow
--      it))
--
-- Note #2:  We talked about whether to include enum values for only library
-- versions where the format changed and decided it would be less confusing
-- for application developers if we include enum values for _all_ library
-- releases and then map down to the previous actual library release which
-- had a format change.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_libver_bounds(hid_t plist_id, H5F_libver_t low,
-- >     H5F_libver_t high);
#ccall H5Pset_libver_bounds, <hid_t> -> <H5F_libver_t> -> <H5F_libver_t> -> IO <herr_t>

-- |Returns the current settings for the library version format bounds
-- from a file access property list.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_libver_bounds(hid_t plist_id, H5F_libver_t *low,
-- >     H5F_libver_t *high);
#ccall H5Pget_libver_bounds, <hid_t> -> Out H5F_libver_t -> Out H5F_libver_t -> IO <herr_t>

#if H5_VERSION_GE(1,8,7)

-- |Sets the number of files opened through external links
-- from the file associated with this fapl to be held open
-- in that file's external file cache.  When the maximum
-- number of files is reached, the least recently used file
-- is closed (unless it is opened from somewhere else).
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_elink_file_cache_size(hid_t plist_id, unsigned efc_size);
#ccall H5Pset_elink_file_cache_size, <hid_t> -> CUInt -> IO <herr_t>

-- |Gets the number of files opened through external links
-- from the file associated with this fapl to be held open
-- in that file's external file cache.  When the maximum
-- number of files is reached, the least recently used file
-- is closed (unless it is opened from somewhere else).
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_elink_file_cache_size(hid_t plist_id, unsigned *efc_size);
#ccall H5Pget_elink_file_cache_size, <hid_t> -> Out CUInt -> IO <herr_t>

#endif

#if H5_VERSION_GE(1,8,9)

-- |Sets the initial file image. Some file drivers can initialize 
-- the starting data in a file from a buffer. 
-- 
-- Returns non-negative on success, negative on failure
-- 
-- > herr_t H5Pset_file_image(hid_t fapl_id, void *buf_ptr, size_t buf_len);
#ccall H5Pset_file_image, <hid_t> -> Ptr a -> <size_t> -> IO <herr_t>

-- |If the file image exists and buf_ptr_ptr is not NULL, 
-- allocate a buffer of the correct size, copy the image into 
-- the new buffer, and return the buffer to the caller in 
-- *buf_ptr_ptr.  Do this using the file image callbacks
-- if defined.  
-- 
-- NB: It is the responsibility of the caller to free the 
-- buffer whose address is returned in *buf_ptr_ptr.  Do
-- this using free if the file image callbacks are not 
-- defined, or with whatever method is appropriate if 
-- the callbacks are defined.
-- 
-- If buf_ptr_ptr is not NULL, and no image exists, set 
-- *buf_ptr_ptr to NULL.
-- 
-- If buf_len_ptr is not NULL, set *buf_len_ptr equal
-- to the length of the file image if it exists, and 
-- to 0 if it does not.
-- 
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Pget_file_image(hid_t fapl_id, void **buf_ptr_ptr, size_t *buf_len_ptr);
#ccall H5Pget_file_image, <hid_t> -> Ptr (Ptr a) -> <size_t> -> IO <herr_t>

-- |Sets the callbacks for file images. Some file drivers allow
-- the use of user-defined callbacks for allocating, freeing and
-- copying the drivers internal buffer, potentially allowing a 
-- clever user to do optimizations such as avoiding large mallocs
-- and memcpys or to perform detailed logging.
--
-- Returns non-negative on success, negative on failure
--
-- > herr_t H5Pset_file_image_callbacks(hid_t fapl_id,
-- >    H5FD_file_image_callbacks_t *callbacks_ptr);
#ccall H5Pset_file_image_callbacks, <hid_t> -> In H5FD_file_image_callbacks_t -> IO <herr_t>

-- |Sets the callbacks for file images. Some file drivers allow
-- the use of user-defined callbacks for allocating, freeing and
-- copying the drivers internal buffer, potentially allowing a 
-- clever user to do optimizations such as avoiding large mallocs
--
-- Returns non-negative on success, negative on failure
-- 
-- > herr_t H5Pget_file_image_callbacks(hid_t fapl_id,
-- >    H5FD_file_image_callbacks_t *callbacks_ptr);
#ccall H5Pget_file_image_callbacks, <hid_t> -> Out H5FD_file_image_callbacks_t -> IO <herr_t>

#endif

-- * Dataset creation property list (DCPL) routines

-- |Sets the layout of raw data in the file.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_layout(hid_t plist_id, H5D_layout_t layout);
#ccall H5Pset_layout, <hid_t> -> <H5D_layout_t> -> IO <herr_t>

-- |Retrieves layout type of a dataset creation property list.
-- 
-- Returns the layout type on success, negative on failure.
-- 
-- > H5D_layout_t H5Pget_layout(hid_t plist_id);
#ccall H5Pget_layout, <hid_t> -> IO <H5D_layout_t>

-- |Sets the number of dimensions and the size of each chunk to
-- the values specified.  The dimensionality of the chunk should
-- match the dimensionality of the dataspace.
-- 
-- As a side effect, the layout method is changed to
-- 'h5d_CHUNKED'.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_chunk(hid_t plist_id, int ndims, const hsize_t dim[/*ndims*/]);
#ccall H5Pset_chunk, <hid_t> -> CInt -> InArray <hsize_t> -> IO <herr_t>

-- |Retrieves the chunk size of chunked layout.  The chunk
-- dimensionality is returned and the chunk size in each
-- dimension is returned through the DIM argument.  At most
-- 'max_ndims' elements of 'dim' will be initialized.
--
-- Returns a negative value on failure.
--
-- > int H5Pget_chunk(hid_t plist_id, int max_ndims, hsize_t dim[]/*out*/);
#ccall H5Pget_chunk, <hid_t> -> CInt -> OutArray <hsize_t> -> IO CInt

-- |Adds an external file to the list of external files. 'plist_id'
-- should be an object ID for a dataset creation property list.
-- 'name' is the name of an external file, 'offset' is the location
-- where the data starts in that file, and 'size' is the number of
-- bytes reserved in the file for the data.
-- 
-- If a dataset is split across multiple files then the files
-- should be defined in order. The total size of the dataset is
-- the sum of the 'size' arguments for all the external files.  If
-- the total size is larger than the size of a dataset then the
-- dataset can be extended (provided the dataspace also allows
-- the extending).
--
-- > herr_t H5Pset_external(hid_t plist_id, const char *name, off_t offset,
-- >           hsize_t size);
#ccall H5Pset_external, <hid_t> -> CString -> <off_t> -> <hsize_t> -> IO <herr_t>

-- |Returns the number of external files for this dataset, or negative
-- on failure.
-- 
-- > int H5Pget_external_count(hid_t plist_id);
#ccall H5Pget_external_count, <hid_t> -> IO CInt

-- |Returns information about an external file.  External files
-- are numbered from zero to N-1 where N is the value returned
-- by 'h5p_get_external_count'.  At most 'name_size' characters are
-- copied into the 'name' array.  If the external file name is
-- longer than 'name_size' with the null terminator, then the
-- return value is not null terminated (similar to strncpy()).
-- 
-- If 'name_size' is zero or 'name' is the null pointer then the
-- external file name is not returned.  If 'offset' or 'size' are
-- null pointers then the corresponding information is not
-- returned.
-- 
-- See Also:  'h5p_set_external'
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_external(hid_t plist_id, unsigned idx, size_t name_size,
-- >           char *name/*out*/, off_t *offset/*out*/,
-- >           hsize_t *size/*out*/);
#ccall H5Pget_external, <hid_t> -> CUInt -> <size_t> -> OutArray CChar -> Out <off_t> -> Out <hsize_t> -> IO <herr_t>

-- |Sets the compression method for a permanent or transient
-- filter pipeline (depending on whether 'plist_id' is a dataset
-- creation or transfer property list) to 'h5z_FILTER_SZIP'.
-- Szip is a special compression package that is said to be good
-- for scientific data.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_szip(hid_t plist_id, unsigned options_mask, unsigned pixels_per_block);
#ccall H5Pset_szip, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Sets the shuffling method for a permanent
-- filter to 'h5z_FILTER_SHUFFLE'
-- and bytes of the datatype of the array to be shuffled
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_shuffle(hid_t plist_id);
#ccall H5Pset_shuffle, <hid_t> -> IO <herr_t>

-- |Sets nbit filter for a dataset creation property list
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_nbit(hid_t plist_id);
#ccall H5Pset_nbit, <hid_t> -> IO <herr_t>

-- |Sets scaleoffset filter for a dataset creation property list
-- and user-supplied parameters
-- 
-- Parameters:
--
-- [@ scale_factor :: 'CInt' @]
--   For integer datatypes, this parameter will be
--   minimum-bits, if this value is set to 0,
--   scaleoffset filter will calculate the minimum-bits.
--   For floating-point datatype,
--   For variable-minimum-bits method, this will be
--   the decimal precision of the filter,
--   For fixed-minimum-bits method, this will be
--   the minimum-bit of the filter.
-- 
-- [@ scale_type :: 'H5Z_SO_scale_type_t' @]
--  0 for floating-point variable-minimum-bits,
--  1 for floating-point fixed-minimum-bits,
--  other values, for integer datatype
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_scaleoffset(hid_t plist_id, H5Z_SO_scale_type_t scale_type, int scale_factor);
#ccall H5Pset_scaleoffset, <hid_t> -> <H5Z_SO_scale_type_t> -> CInt -> IO <herr_t>

-- |Set the fill value for a dataset creation property list. The
-- 'value' is interpretted as being of type 'type', which need not
-- be the same type as the dataset but the library must be able
-- to convert 'value' to the dataset type when the dataset is
-- created.  If 'value' is NULL, it will be interpreted as
-- undefining fill value.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_fill_value(hid_t plist_id, hid_t type_id,
-- >      const void *value);
#ccall H5Pset_fill_value, <hid_t> -> <hid_t> -> In a -> IO <herr_t>

-- |Queries the fill value property of a dataset creation
-- property list.  The fill value is returned through the 'value'
-- pointer and the memory is allocated by the caller.  The fill
-- value will be converted from its current datatype to the
-- specified 'type'.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_fill_value(hid_t plist_id, hid_t type_id,
-- >      void *value/*out*/);
#ccall H5Pget_fill_value, <hid_t> -> <hid_t> -> Out a -> IO <herr_t>

-- |Check if fill value is defined.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pfill_value_defined(hid_t plist, H5D_fill_value_t *status);
#ccall H5Pfill_value_defined, <hid_t> -> Out <H5D_fill_value_t> -> IO <herr_t>

-- |Set space allocation time for dataset during creation.
-- Valid values are 'h5d_ALLOC_TIME_DEFAULT', 'h5d_ALLOC_TIME_EARLY',
-- 'h5d_ALLOC_TIME_LATE', 'h5d_ALLOC_TIME_INCR'
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- >    alloc_time);
#ccall H5Pset_alloc_time, <hid_t> -> <H5D_alloc_time_t> -> IO <herr_t>

-- |Get space allocation time for dataset creation.
-- Valid values are 'h5d_ALLOC_TIME_DEFAULT', 'h5d_ALLOC_TIME_EARLY',
-- 'h5d_ALLOC_TIME_LATE', 'h5d_ALLOC_TIME_INCR'
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- >    *alloc_time/*out*/);
#ccall H5Pget_alloc_time, <hid_t> -> Out H5D_alloc_time_t -> IO <herr_t>

-- |Set fill value writing time for dataset.  Valid values are
-- 'h5d_FILL_TIME_ALLOC' and 'h5d_FILL_TIME_NEVER'.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_fill_time(hid_t plist_id, H5D_fill_time_t fill_time);
#ccall H5Pset_fill_time, <hid_t> -> <H5D_fill_time_t> -> IO <herr_t>

-- |Get fill value writing time.  Valid values are 'h5d_NEVER'
-- and 'h5d_ALLOC'.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_fill_time(hid_t plist_id, H5D_fill_time_t
-- >    *fill_time/*out*/);
#ccall H5Pget_fill_time, <hid_t> -> Out <H5D_fill_time_t> -> IO <herr_t>


#if H5_VERSION_GE(1,8,3)

-- * Dataset access property list (DAPL) routines

-- |Set the number of objects in the meta data cache and the
-- maximum number of chunks and bytes in the raw data chunk cache.
-- Once set, these values will override the values in the file access
-- property list.  Each of these values can be individually unset
-- (or not set at all) by passing the macros:
-- 'h5d_CHUNK_CACHE_NCHUNKS_DEFAULT',
-- 'h5d_CHUNK_CACHE_NSLOTS_DEFAULT', and/or
-- 'h5d_CHUNK_CACHE_W0_DEFAULT'
-- as appropriate.
-- 
-- The 'rdcc_w0' value should be between 0 and 1 inclusive and
-- indicates how much chunks that have been fully read or fully
-- written are favored for preemption.  A value of zero means
-- fully read or written chunks are treated no differently than
-- other chunks (the preemption is strictly LRU) while a value
-- of one means fully read chunks are always preempted before
-- other chunks.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_chunk_cache(hid_t dapl_id, size_t rdcc_nslots,
-- >        size_t rdcc_nbytes, double rdcc_w0);
#ccall H5Pset_chunk_cache, <hid_t> -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- |Retrieves the maximum possible number of elements in the meta
-- data cache and the maximum possible number of elements and
-- bytes and the 'rdcc_w0' value in the raw data chunk cache.  Any
-- (or all) arguments may be null pointers in which case the
-- corresponding datum is not returned.  If these properties have
-- not been set on this property list, the default values for a
-- file access property list are returned.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_chunk_cache(hid_t dapl_id,
-- >        size_t *rdcc_nslots/*out*/,
-- >        size_t *rdcc_nbytes/*out*/,
-- >        double *rdcc_w0/*out*/);
#ccall H5Pget_chunk_cache, <hid_t> -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>

#endif

-- * Dataset xfer property list (DXPL) routines

-- |Sets data transform expression.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_data_transform(hid_t plist_id, const char* expression);
#ccall H5Pset_data_transform, <hid_t> -> CString -> IO <herr_t>

-- |Gets data transform expression.
-- 
-- If 'expression' is non-NULL then write up to 'size' bytes into that
-- buffer and always return the length of the transform name.
-- Otherwise 'size' is ignored and the function does not store the expression,
-- just returning the number of characters required to store the expression.
-- If an error occurs then the buffer pointed to by 'expression' (NULL or non-NULL)
-- is unchanged and the function returns a negative value.
-- If a zero is returned for the name's length, then there is no name
-- associated with the ID.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > ssize_t H5Pget_data_transform(hid_t plist_id, char* expression /*out*/, size_t size);
#ccall H5Pget_data_transform, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Given a dataset transfer property list, set the maximum size
-- for the type conversion buffer and background buffer and
-- optionally supply pointers to application-allocated buffers.
-- If the buffer size is smaller than the entire amount of data
-- being transfered between application and file, and a type
-- conversion buffer or background buffer is required then
-- strip mining will be used.
-- 
-- If 'tconv' and/or 'bkg' are null pointers then buffers will be
-- allocated and freed during the data transfer.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_buffer(hid_t plist_id, size_t size, void *tconv,
-- >         void *bkg);
#ccall H5Pset_buffer, <hid_t> -> <size_t> -> Ptr a -> Ptr b -> IO <herr_t>

-- |Reads values previously set with 'h5p_set_buffer'.
-- 
-- Returns buffer size on success, 0 on failure.
--
-- > size_t H5Pget_buffer(hid_t plist_id, void **tconv/*out*/,
-- >         void **bkg/*out*/);
#ccall H5Pget_buffer, <hid_t> -> Out (Ptr a) -> Out (Ptr b) -> IO <size_t>

-- |When reading or writing compound data types and the
-- destination is partially initialized and the read/write is
-- intended to initialize the other members, one must set this
-- property to TRUE.  Otherwise the I/O pipeline treats the
-- destination datapoints as completely uninitialized.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_preserve(hid_t plist_id, hbool_t status);
#ccall H5Pset_preserve, <hid_t> -> <hbool_t> -> IO <herr_t>

-- |The inverse of 'h5p_set_preserve'
--
-- Returns TRUE or FALSE (C macros) on success, negative on failure.
-- 
-- > int H5Pget_preserve(hid_t plist_id);
#ccall H5Pget_preserve, <hid_t> -> IO CInt

-- |Enable or disable error-detecting for a dataset reading
-- process.  This error-detecting algorithm is whichever
-- user chooses earlier.  This function cannot control
-- writing process.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_edc_check(hid_t plist_id, H5Z_EDC_t check);
#ccall H5Pset_edc_check, <hid_t> -> <H5Z_EDC_t> -> IO <herr_t>

-- |
-- > H5Z_EDC_t H5Pget_edc_check(hid_t plist_id);
#ccall H5Pget_edc_check, <hid_t> -> IO <H5Z_EDC_t>

-- |Sets user's callback function for dataset transfer property
-- list.  This callback function defines what user wants to do
-- if certain filter fails.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_filter_callback(hid_t plist_id, H5Z_filter_func_t func,
-- >                                      void* op_data);
#ccall H5Pset_filter_callback, <hid_t> -> H5Z_filter_func_t a b -> InOut b -> IO <herr_t>

-- |Sets B-tree split ratios for a dataset transfer property
-- list. The split ratios determine what percent of children go
-- in the first node when a node splits.  The 'left' ratio is
-- used when the splitting node is the left-most node at its
-- level in the tree; the 'right' ratio is when the splitting node
-- is the right-most node at its level; and the 'middle' ratio for
-- all other cases.  A node which is the only node at its level
-- in the tree uses the 'right' ratio when it splits.  All ratios
-- are real numbers between 0 and 1, inclusive.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_btree_ratios(hid_t plist_id, double left, double middle,
-- >        double right);
#ccall H5Pset_btree_ratios, <hid_t> -> CDouble -> CDouble -> CDouble -> IO <herr_t>

-- |Queries B-tree split ratios.  See H5Pset_btree_ratios().
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_btree_ratios(hid_t plist_id, double *left/*out*/,
-- >        double *middle/*out*/,
-- >        double *right/*out*/);
#ccall H5Pget_btree_ratios, <hid_t> -> Out CDouble -> Out CDouble -> Out CDouble -> IO <herr_t>

-- |Sets the memory allocate/free pair for VL datatypes.  The
-- allocation routine is called when data is read into a new
-- array and the free routine is called when 'h5d_vlen_reclaim' is
-- called.  The 'alloc_info' and 'free_info' are user parameters
-- which are passed to the allocation and freeing functions
-- respectively.  To reset the allocate/free functions to the
-- default setting of using the system's malloc/free functions,
-- call this routine with 'alloc_func' and 'free_func' set to NULL.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_vlen_mem_manager(hid_t plist_id,
-- >        H5MM_allocate_t alloc_func,
-- >        void *alloc_info, H5MM_free_t free_func,
-- >        void *free_info);
#ccall H5Pset_vlen_mem_manager, <hid_t> -> H5MM_allocate_t allocInfo mem -> Ptr allocInfo -> H5MM_free_t freeInfo mem -> Ptr freeInfo -> IO <herr_t>

-- |The inverse of 'h5p_set_vlen_mem_manager'
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_vlen_mem_manager(hid_t plist_id,
-- >        H5MM_allocate_t *alloc_func,
-- >        void **alloc_info,
-- >        H5MM_free_t *free_func,
-- >        void **free_info);
#ccall H5Pget_vlen_mem_manager, <hid_t> -> Out (H5MM_allocate_t allocInfo mem) -> Out (Ptr allocInfo) -> Out (H5MM_free_t freeInfo mem) -> Out (Ptr freeInfo) -> IO <herr_t>

-- |Given a dataset transfer property list, set the number of
-- \"I/O vectors\" (offset and length pairs) which are to be
-- accumulated in memory before being issued to the lower levels
-- of the library for reading or writing the actual data.
-- Increasing the number should give better performance, but use
-- more memory during hyperslab I/O.  The vector size must be
-- greater than 1.
-- 
-- The default is to use 1024 vectors for I/O during hyperslab
-- reading/writing.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_hyper_vector_size(hid_t fapl_id, size_t size);
#ccall H5Pset_hyper_vector_size, <hid_t> -> <size_t> -> IO <herr_t>

-- |Reads values previously set with 'h5p_set_hyper_vector_size'.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_hyper_vector_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_hyper_vector_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- |Sets user's callback function for dataset transfer property
-- list.  This callback function defines what user wants to do
-- if there's exception during datatype conversion.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t op, void* operate_data);
#ccall H5Pset_type_conv_cb, <hid_t> -> H5T_conv_except_func_t a b -> InOut b -> IO <herr_t>

-- |Gets callback function for dataset transfer property
-- list.  This callback function defines what user wants to do
-- if there's exception during datatype conversion.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t *op, void** operate_data);
#ccall H5Pget_type_conv_cb, <hid_t> -> Out (H5T_conv_except_func_t a b) -> Out (InOut b) -> IO <herr_t>

#ifdef H5_HAVE_PARALLEL

#if H5_VERSION_GE(1,8,8)

-- TODO: docs
-- > herr_t H5Pget_mpio_actual_chunk_opt_mode(hid_t plist_id, H5D_mpio_actual_chunk_opt_mode_t *actual_chunk_opt_mode);
#ccall H5Pget_mpio_actual_chunk_opt_mode, <hid_t> -> Out H5D_mpio_actual_chunk_opt_mode_t -> IO <herr_t>

-- > herr_t H5Pget_mpio_actual_io_mode(hid_t plist_id, H5D_mpio_actual_io_mode_t *actual_io_mode);
#ccall H5Pget_mpio_actual_io_mode, <hid_t> -> Out H5D_mpio_actual_io_mode_t -> IO <herr_t>

#endif

#if H5_VERSION_GE(1,8,10)

-- TODO: ensure ptr sizes match and change Word32 to H5D_mpio_no_collective_cause_t
-- > herr_t H5Pget_mpio_no_collective_cause(hid_t plist_id, uint32_t *local_no_collective_cause, uint32_t *global_no_collective_cause);
#ccall H5Pget_mpio_no_collective_cause, <hid_t> -> Out Word32 -> Out Word32 -> IO <herr_t>

#endif

#endif /* H5_HAVE_PARALLEL */

-- * Link creation property list (LCPL) routines

-- |Set 'crt_intmd_group' so that 'h5l_create_*', 'h5o_link', etc.
-- will create missing groups along the given path \"name\".
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_create_intermediate_group(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_create_intermediate_group, <hid_t> -> CUInt -> IO <herr_t>

-- |Returns the 'crt_intmd_group', which is set to create missing
-- groups during 'h5o_link', etc.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_create_intermediate_group(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_create_intermediate_group, <hid_t> -> Out CUInt -> IO <herr_t>

-- * Group creation property list (GCPL) routines

-- |Set the \"size hint\" for creating local heaps for a group.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_local_heap_size_hint(hid_t plist_id, size_t size_hint);
#ccall H5Pset_local_heap_size_hint, <hid_t> -> <size_t> -> IO <herr_t>

-- |Returns the local heap size hint, which is used for creating groups
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_local_heap_size_hint(hid_t plist_id, size_t *size_hint /*out*/);
#ccall H5Pget_local_heap_size_hint, <hid_t> -> Out <size_t> -> IO <herr_t>

-- |Set the maximum # of links to store \"compactly\" and the
-- minimum # of links to store \"densely\".  (These should
-- overlap).
-- 
-- Currently both of these must be updated at the same time.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_link_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_link_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Returns the max. # of compact links & the min. # of dense
-- links, which are used for storing groups
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_link_phase_change(hid_t plist_id, unsigned *max_compact /*out*/, unsigned *min_dense /*out*/);
#ccall H5Pget_link_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Set the estimates for the number of entries and length of each
-- entry name in a group.
-- 
-- Currently both of these must be updated at the same time.
-- 
-- 'est_num_entries' applies only when the number of entries is less
-- than the 'max_compact' # of entries (from 'h5p_set_link_phase_change').
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_est_link_info(hid_t plist_id, unsigned est_num_entries, unsigned est_name_len);
#ccall H5Pset_est_link_info, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- |Returns the est. # of links in a group & the est. length of
-- the name of each link.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_est_link_info(hid_t plist_id, unsigned *est_num_entries /* out */, unsigned *est_name_len /* out */);
#ccall H5Pget_est_link_info, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Set the flags for creation order of links in a group
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_link_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_link_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- |Returns the flag indicating that creation order is tracked
-- for links in a group.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_link_creation_order(hid_t plist_id, unsigned *crt_order_flags /* out */);
#ccall H5Pget_link_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>

-- * String creation property list (STRCPL) routines

-- |Sets the character encoding of the string.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_char_encoding(hid_t plist_id, H5T_cset_t encoding);
#ccall H5Pset_char_encoding, <hid_t> -> <H5T_cset_t> -> IO <herr_t>

-- |Gets the character encoding of the string.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_char_encoding(hid_t plist_id, H5T_cset_t *encoding /*out*/);
#ccall H5Pget_char_encoding, <hid_t> -> Out <H5T_cset_t> -> IO <herr_t>


-- * Link access property list (LAPL) routines

-- |Set the number of soft or UD link traversals allowed before
-- the library assumes it has found a cycle and aborts the
-- traversal.
-- 
-- The limit on soft or UD link traversals is designed to
-- terminate link traversal if one or more links form a cycle.
-- However, users may have a file with a legitimate path
-- formed of a large number of soft or user-defined links.
-- This property can be used to allow traversal of as many
-- links as desired.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_nlinks(hid_t plist_id, size_t nlinks);
#ccall H5Pset_nlinks, <hid_t> -> <size_t> -> IO <herr_t>

-- |Gets the number of soft or user-defined links that can be
-- traversed before a failure occurs.
-- 
-- Retrieves the current setting for the nlinks property on
-- the given property list.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_nlinks(hid_t plist_id, size_t *nlinks);
#ccall H5Pget_nlinks, <hid_t> -> Out <size_t> -> IO <herr_t>

-- |Set a prefix to be applied to the path of any external links
-- traversed.  The prefix is appended to the filename stored
-- in the external link.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_elink_prefix(hid_t plist_id, const char *prefix);
#ccall H5Pset_elink_prefix, <hid_t> -> CString -> IO <herr_t>

-- |Gets the prefix to be applied to any external link
-- traversals made using this property list.
-- 
-- If the pointer is not NULL, it points to a user-allocated
-- buffer.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > ssize_t H5Pget_elink_prefix(hid_t plist_id, char *prefix, size_t size);
#ccall H5Pget_elink_prefix, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

#if H5_VERSION_GE(1,8,2)

-- |Gets the file access property list identifier that is
-- set for link access property.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > hid_t H5Pget_elink_fapl(hid_t lapl_id);
#ccall H5Pget_elink_fapl, <hid_t> -> IO <hid_t>

-- |Sets the file access property list for link access
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_elink_fapl(hid_t lapl_id, hid_t fapl_id);
#ccall H5Pset_elink_fapl, <hid_t> -> <hid_t> -> IO <herr_t>

#endif

#if H5_VERSION_GE(1,8,3)

-- |Sets the file access flags to be used when traversing an
-- external link.  This should be either 'h5f_ACC_RDONLY' or
-- 'h5f_ACC_RDWR', or 'h5f_ACC_DEFAULT' to unset the value.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_elink_acc_flags(hid_t lapl_id, unsigned flags);
#ccall H5Pset_elink_acc_flags, <hid_t> -> CUInt -> IO <herr_t>

-- |Gets the file access flags to be used when traversing an
-- external link.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_elink_acc_flags(hid_t lapl_id, unsigned *flags);
#ccall H5Pget_elink_acc_flags, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Sets the file access flags to be used when traversing an
-- external link.  This should be either 'h5f_ACC_RDONLY' or
-- 'h5f_ACC_RDWR'.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_elink_cb(hid_t lapl_id, H5L_elink_traverse_t func, void *op_data);
#ccall H5Pset_elink_cb, <hid_t> -> H5L_elink_traverse_t a -> Ptr a -> IO <herr_t>

-- |Gets the file access flags to be used when traversing an
-- external link.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_elink_cb(hid_t lapl_id, H5L_elink_traverse_t *func, void **op_data);
#ccall H5Pget_elink_cb, <hid_t> -> Out (H5L_elink_traverse_t a) -> Out (Ptr a) -> IO <herr_t>

#endif

-- * Object copy property list (OCPYPL) routines

-- |Set properties when copying an object (group, dataset, and datatype)
-- from one location to another
-- 
-- Parameters: 
-- 
-- [@ plist_id   :: 'HId_t' @]  Property list to copy object
-- 
-- [@ cpy_option :: 'CUInt' @]  Options to copy object
-- 
-- Possible values for 'cpy_option' include:
-- 
--  ['h5o_COPY_SHALLOW_HIERARCHY_FLAG'] Copy only immediate members
-- 
--  ['h5o_COPY_EXPAND_SOFT_LINK_FLAG' ] Expand soft links into new objects/
-- 
--  ['h5o_COPY_EXPAND_EXT_LINK_FLAG'  ] Expand external links into new objects
-- 
--  ['h5o_COPY_EXPAND_REFERENCE_FLAG' ] Copy objects that are pointed by references
-- 
--  ['h5o_COPY_WITHOUT_ATTR_FLAG'     ] Copy object without copying attributes
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_copy_object(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_copy_object, <hid_t> -> CUInt -> IO <herr_t>

-- |Returns the cpy_option, which is set for 'h5o_copy' for copying objects
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_copy_object(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_copy_object, <hid_t> -> Out CUInt -> IO <herr_t>

#if H5_VERSION_GE(1,8,9)

-- TODO: finish

-- |Adds path to the list of paths to search first in the
-- target file when merging committed datatypes during H5Ocopy
-- (i.e. when using the H5O_COPY_MERGE_COMMITTED_DTYPE_FLAG flag
-- as set by H5Pset_copy_object).  If the source named
-- dataype is not found in the list of paths created by this
-- function, the entire file will be searched.
--
-- Usage:       H5Padd_merge_committed_dtype_path(plist_id, path)
--              hid_t plist_id;                 IN: Property list to copy object
--              const char *path;               IN: Path to add to list
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Padd_merge_committed_dtype_path(hid_t plist_id, const char *path);
#ccall H5Padd_merge_committed_dtype_path, <hid_t> -> CString -> IO <herr_t>

-- |Frees and clears the list of paths created by
-- H5Padd_merge_committed_dtype_path.  A new list may then be
-- created by calling H5Padd_merge_committed_dtype_path again.
--
-- Usage:       H5Pfree_merge_committed_dtype_paths(plist_id)
--              hid_t plist_id;                 IN: Property list to copy object
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pfree_merge_committed_dtype_paths(hid_t plist_id);
#ccall H5Pfree_merge_committed_dtype_paths, <hid_t> -> IO <herr_t>

-- |Set the callback function when a matching committed datatype is not found
-- from the list of paths stored in the object copy property list.
-- H5Ocopy will invoke this callback before searching all committed datatypes
-- at destination.
--
-- Usage:       H5Pset_mcdt_search_cb(plist_id, H5O_mcdt_search_cb_t func, void *op_data)
--              hid_t plist_id;                 IN: Property list to copy object
--              H5O_mcdt_search_cb_t func;      IN: The callback function
--              void *op_data;              IN: The user data
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_mcdt_search_cb(hid_t plist_id, H5O_mcdt_search_cb_t func, void *op_data);
#ccall H5Pset_mcdt_search_cb, <hid_t> -> H5O_mcdt_search_cb_t a -> InOut a -> IO <herr_t>

-- |Retrieves the callback function and user data from the specified 
-- object copy property list.
--
-- Usage:       H5Pget_mcdt_search_cb(plist_id, H5O_mcdt_search_cb_t *func, void **op_data)
--              hid_t plist_id;                 IN: Property list to copy object
--      H5O_mcdt_search_cb_t *func; OUT: The callback function
--      void **op_data;         OUT: The user data
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_mcdt_search_cb(hid_t plist_id, H5O_mcdt_search_cb_t *func, void **op_data);
#ccall H5Pget_mcdt_search_cb, <hid_t> -> Out (H5O_mcdt_search_cb_t a) -> Out (InOut a) -> IO <herr_t>

#endif

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- * Deprecated Constants

-- |We renamed the "root" of the property list class hierarchy
h5p_NO_CLASS :: HId_t
h5p_NO_CLASS = h5p_ROOT

-- * Deprecated Functions

-- | Old version of 'h5p_register2'.
-- 
-- > herr_t H5Pregister1(hid_t cls_id, const char *name, size_t size,
-- >     void *def_value, H5P_prp_create_func_t prp_create,
-- >     H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
-- >     H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
-- >     H5P_prp_close_func_t prp_close);
#ccall H5Pregister1, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_create_func_t a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- |Old version of 'h5p_insert2'.
-- 
-- > herr_t H5Pinsert1(hid_t plist_id, const char *name, size_t size,
-- >     void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
-- >     H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
-- >     H5P_prp_close_func_t prp_close);
#ccall H5Pinsert1, <hid_t> -> CString -> <size_t> -> In a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- |This is the query counterpart of 'h5p_set_filter' and returns
-- information about a particular filter number in a permanent
-- or transient pipeline depending on whether 'plist_id' is a
-- dataset creation or transfer property list.  On input,
-- 'cd_nelmts' indicates the number of entries in the 'cd_values'
-- array allocated by the caller while on exit it contains the
-- number of values defined by the filter.  The 'idx'
-- should be a value between zero and N-1 as described for
-- 'h5p_get_nfilters' and the function will return failure if the
-- filter number is out of range.
-- 
-- > H5Z_filter_t H5Pget_filter1(hid_t plist_id, unsigned filter,
-- >     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
-- >     unsigned cd_values[]/*out*/, size_t namelen, char name[]);
#ccall H5Pget_filter1, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> Out CChar -> IO <H5Z_filter_t>

-- |This is an additional query counterpart of 'h5p_set_filter' and
-- returns information about a particular filter in a permanent
-- or transient pipeline depending on whether 'plist_id' is a
-- dataset creation or transfer property list.  On input,
-- 'cd_nelmts' indicates the number of entries in the 'cd_values'
-- array allocated by the caller while on exit it contains the
-- number of values defined by the filter.  The ID
-- should be the filter ID to retrieve the parameters for.  If the
-- filter is not set for the property list, an error will be returned.
-- 
-- > herr_t H5Pget_filter_by_id1(hid_t plist_id, H5Z_filter_t id,
-- >     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
-- >     unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/);
#ccall H5Pget_filter_by_id1, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
