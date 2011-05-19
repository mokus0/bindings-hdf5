#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.Raw.H5I where
#strict_import

import Bindings.HDF5.Raw.H5

import Data.Bits
import Data.Char
import Foreign.Ptr.Conventions

-- |Library type values
#newtype H5I_type_t, Eq

-- |uninitialized type
#newtype_const H5I_type_t, H5I_UNINIT

-- |invalid Type
#newtype_const H5I_type_t, H5I_BADID

-- |type ID for File objects
#newtype_const H5I_type_t, H5I_FILE

-- |type ID for Group objects
#newtype_const H5I_type_t, H5I_GROUP

-- |type ID for Datatype objects
#newtype_const H5I_type_t, H5I_DATATYPE

-- |type ID for Dataspace objects
#newtype_const H5I_type_t, H5I_DATASPACE

-- |type ID for Dataset objects
#newtype_const H5I_type_t, H5I_DATASET

-- |type ID for Attribute objects
#newtype_const H5I_type_t, H5I_ATTR

-- |type ID for Reference objects
#newtype_const H5I_type_t, H5I_REFERENCE

-- |type ID for virtual file layer
#newtype_const H5I_type_t, H5I_VFL

-- |type ID for generic property list classes
#newtype_const H5I_type_t, H5I_GENPROP_CLS

-- |type ID for generic property lists
#newtype_const H5I_type_t, H5I_GENPROP_LST

-- |type ID for error classes
#newtype_const H5I_type_t, H5I_ERROR_CLASS

-- |type ID for error messages
#newtype_const H5I_type_t, H5I_ERROR_MSG

-- |type ID for error stacks
#newtype_const H5I_type_t, H5I_ERROR_STACK

-- |number of library types
#num H5I_NTYPES

-- TODO: I think HId_t should be parameterised over the element type and 
-- possibly also dimensionality of the dataset
-- |Type of atoms to return to users
newtype HId_t = HId_t Int32 deriving (Storable, Eq, Ord)

instance Show HId_t where
    showsPrec p (HId_t x) = showParen (p>10)
        ( showString "HId_t 0x"
        . showString 
            [ intToDigit (fromIntegral digit)
            | place <- [bitSize x - 4, bitSize x - 8 .. 0]
            , let mask = 0xf `shiftL` place
            , let digit = ((x .&. mask) `shiftR` place) .&. 0xf
            ]
        )

h5_SIZEOF_HID_T :: CSize
h5_SIZEOF_HID_T = #const H5_SIZEOF_HID_T

-- |An invalid object ID. This is also negative for error return.
#newtype_const hid_t, H5I_INVALID_HID

-- |Function for freeing objects. This function will be called with an object
-- ID type number and a pointer to the object. The function should free the
-- object and return non-negative to indicate that the object
-- can be removed from the ID type. If the function returns negative
-- (failure) then the object will remain in the ID type.
type H5I_free_t        a = FunPtr (In a -> IO HErr_t)

-- |Type of the function to compare objects & keys
type H5I_search_func_t a = FunPtr (In a -> HId_t -> In a -> IO CInt)
   
-- |Registers an 'object' in a 'type' and returns an ID for it.
-- This routine does _not_ check for unique-ness of the objects,
-- if you register an object twice, you will get two different
-- IDs for it.  This routine does make certain that each ID in a
-- type is unique.  IDs are created by getting a unique number
-- for the type the ID is in and incorporating the type into
-- the ID which is returned to the user.
-- 
-- Return:	Success:	New object id.
--  	Failure:	Negative
-- 
-- > hid_t H5Iregister(H5I_type_t type, const void *object);
#ccall H5Iregister , <H5I_type_t> -> In a -> IO <hid_t>

-- |Find an object pointer for the specified ID, verifying that
-- it is in a particular type.
-- 
-- On success, returns a non-null object pointer associated with the
-- specified ID.
-- On failure, returns NULL.
-- 
-- > void *H5Iobject_verify(hid_t id, H5I_type_t id_type);
#ccall H5Iobject_verify , <hid_t> -> <H5I_type_t> -> IO (Ptr a)

-- |Removes the specified ID from its type, first checking that the
-- type of the ID and the type type are the same.
-- 
-- On success, returns a pointer to the object that was removed, the
-- same pointer which would have been found by calling 'h5i_object'.
-- On failure, returns NULL.
-- 
-- > void *H5Iremove_verify(hid_t id, H5I_type_t id_type);
#ccall H5Iremove_verify , <hid_t> -> <H5I_type_t> -> IO (Ptr a)

-- |Retrieves the number of references outstanding for a type.
-- Returns negative on failure.
-- 
-- > H5I_type_t H5Iget_type(hid_t id);
#ccall H5Iget_type , <hid_t> -> IO <H5I_type_t>

-- |Obtains the file ID given an object ID.  User has to close this ID.
-- Returns a negative value on failure.
-- 
-- > hid_t H5Iget_file_id(hid_t id);
#ccall H5Iget_file_id , <hid_t> -> IO <hid_t>

-- |Gets a name of an object from its ID.
-- 
-- If 'name' is non-NULL then write up to 'size' bytes into that
-- buffer and always return the length of the entry name.
-- Otherwise 'size' is ignored and the function does not store the name,
-- just returning the number of characters required to store the name.
-- If an error occurs then the buffer pointed to by 'name' (NULL or non-NULL)
-- is unchanged and the function returns a negative value.
-- If a zero is returned for the name's length, then there is no name
-- associated with the ID.
-- 
-- > ssize_t H5Iget_name(hid_t id, char *name/*out*/, size_t size);
#ccall H5Iget_name, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Increments the number of references outstanding for an ID.
-- 
-- On success, returns the new reference count.  On failure, returns 
-- a negative value.
-- 
-- > int H5Iinc_ref(hid_t id);
#ccall H5Iinc_ref, <hid_t> -> IO CInt

-- |Decrements the number of references outstanding for an ID.
-- If the reference count for an ID reaches zero, the object
-- will be closed.
-- 
-- On success, returns the new reference count.  On failure, returns 
-- a negative value.
-- 
-- > int H5Idec_ref(hid_t id);
#ccall H5Idec_ref, <hid_t> -> IO CInt

-- |Retrieves the number of references outstanding for an ID.
-- Returns a negative value on failure.
-- 
-- > int H5Iget_ref(hid_t id);
#ccall H5Iget_ref, <hid_t> -> IO CInt

-- |Creates a new type of ID's to give out.  A specific number
-- ('reserved') of type entries may be reserved to enable \"constant\" 
-- values to be handed out which are valid IDs in the type, but which 
-- do not map to any data structures and are not allocated dynamically
-- later.  'hash_size' is the minimum hash table size to use for the 
-- type.  'free_func' is called with an object pointer when the object
-- is removed from the type.
--
-- On success, returns the type ID of the new type.  
-- On failure, returns 'h5i_BADID'.
--
-- > H5I_type_t H5Iregister_type(size_t hash_size, unsigned reserved, H5I_free_t free_func);
#ccall H5Iregister_type, <size_t> -> CUInt -> <H5I_free_t> a -> IO <H5I_type_t>

-- |Removes all objects from the type, calling the free
-- function for each object regardless of the reference count.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Iclear_type(H5I_type_t type, hbool_t force);
#ccall H5Iclear_type, <H5I_type_t> -> <hbool_t> -> IO <herr_t>

-- |Destroys a type along with all atoms in that type
-- regardless of their reference counts. Destroying IDs
-- involves calling the free-func for each ID's object and
-- then adding the ID struct to the ID free list.
--
-- Returns zero on success, negative on failure.
--
-- herr_t H5Idestroy_type(H5I_type_t type);
#ccall H5Idestroy_type, <H5I_type_t> -> IO <herr_t>

-- |Increments the number of references outstanding for an ID type.
-- 
-- On success, returns the new reference count.  On failure, returns 
-- a negative value.
-- 
-- > int H5Iinc_type_ref(H5I_type_t type);
#ccall H5Iinc_type_ref, <H5I_type_t> -> IO CInt

-- |Decrements the reference count on an entire type of IDs.
-- If the type reference count becomes zero then the type is
-- destroyed along with all atoms in that type regardless of
-- their reference counts.  Destroying IDs involves calling
-- the free-func for each ID's object and then adding the ID
-- struct to the ID free list.
-- 
-- Returns the number of references to the type on success; a
-- return value of 0 means that the type will have to be
-- re-initialized before it can be used again (and should probably
-- be set to H5I_UNINIT).
-- 
-- > int H5Idec_type_ref(H5I_type_t type);
#ccall H5Idec_type_ref, <H5I_type_t> -> IO CInt

-- |Retrieves the number of references outstanding for a type.
-- Returns a negative value on failure.
-- 
-- > int H5Iget_type_ref(H5I_type_t type);
#ccall H5Iget_type_ref, <H5I_type_t> -> IO CInt

-- |Apply function 'func' to each member of type 'type' and return a
-- pointer to the first object for which 'func' returns non-zero.
-- The 'func' should take a pointer to the object and the 'key' as
-- arguments and return non-zero to terminate the search (zero
-- to continue).
--
-- Limitation:  Currently there is no way to start searching from where a
-- previous search left off.
--
-- Returns the first object in the type for which 'func' returns 
-- non-zero.  Returns NULL if 'func' returned zero for every object in 
-- the type.
--
-- > void *H5Isearch(H5I_type_t type, H5I_search_func_t func, void *key);
#ccall H5Isearch, <H5I_type_t> -> <H5I_search_func_t> a -> In a -> IO (Ptr a)

-- |Returns the number of members in a type.  The public interface 
-- throws an error if the supplied type does not exist.  This is 
-- different than the private interface, which will just return 0.
--
-- Returns zero on success, negative on failure.
--
-- > herr_t H5Inmembers(H5I_type_t type, hsize_t *num_members);
#ccall H5Inmembers, <H5I_type_t> -> Out <hsize_t> -> IO <herr_t>

-- |Check whether the given type is currently registered with the library.
--
-- > htri_t H5Itype_exists(H5I_type_t type);
#ccall H5Itype_exists, <H5I_type_t> -> IO <htri_t>

#if H5_VERSION_GE(1,8,3)
-- |Check if the given id is valid.  An id is valid if it is in
-- use and has an application reference count of at least 1.
--
-- > htri_t H5Iis_valid(hid_t id);
#ccall H5Iis_valid, <hid_t> -> IO <htri_t>
#endif