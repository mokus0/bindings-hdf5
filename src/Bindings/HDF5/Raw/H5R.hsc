#include <bindings.h>
#include <H5Rpublic.h>

module Bindings.HDF5.Raw.H5R where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5G
import Bindings.HDF5.Raw.H5I
import Bindings.HDF5.Raw.H5O

import Data.ByteString

import Foreign.Ptr.Conventions

-- |Reference types allowed
#newtype H5R_type_t

-- |invalid Reference Type
#newtype_const H5R_type_t, H5R_BADTYPE

-- |Object reference
#newtype_const H5R_type_t, H5R_OBJECT

-- |Dataset Region Reference
#newtype_const H5R_type_t, H5R_DATASET_REGION

-- |Number of reference types
#num H5R_MAXTYPE

#mangle_ident "H5R_OBJ_REF_BUF_SIZE"
    = #const H5R_OBJ_REF_BUF_SIZE
    :: CSize

#newtype hobj_ref_t

#mangle_ident "H5R_DSET_REG_REF_BUF_SIZE"
    = #const H5R_DSET_REG_REF_BUF_SIZE
    :: CSize

-- |Buffer to store heap ID and index
-- 
-- > typedef unsigned char hdset_reg_ref_t[H5R_DSET_REG_REF_BUF_SIZE];
newtype #mangle_tycon   "hdset_reg_ref_t"
    =   #mangle_datacon "hdset_reg_ref_t"
    ByteString


-- |Creates a particular type of reference specified with 'ref_type', in the
-- space pointed to by 'ref'.  The 'loc_id' and 'name' are used to locate the object
-- pointed to and the 'space_id' is used to choose the region pointed to (for
-- Dataset Region references).
-- 
-- Parameters:
-- 
-- [@ ref      :: 'Out' a      @] Reference created
-- 
-- [@ loc_id   :: 'HId_t'      @] Location ID used to locate object pointed to
-- 
-- [@ name     :: 'CString'    @] Name of object at location LOC_ID of object pointed to
-- 
-- [@ ref_type :: 'H5R_type_t' @] Type of reference to create
-- 
-- [@ space_id :: 'HId_t'      @] Dataspace ID with selection, used for Dataset Region references.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Rcreate(void *ref, hid_t loc_id, const char *name,
-- >        H5R_type_t ref_type, hid_t space_id);
#ccall H5Rcreate, Out a -> <hid_t> -> CString -> <H5R_type_t> -> <hid_t> -> IO <herr_t>

-- |Opens the HDF5 object referenced.  Given a reference to some object, 
-- open that object and return an ID for that object.
-- 
-- Parameters:
-- 
-- [@ id       :: 'HId_t'      @]   Dataset reference object is in or location ID of object that the dataset is located within.
-- 
-- [@ ref_type :: 'H5R_type_t' @]   Type of reference to create
-- 
-- [@ ref      :: 'In' a       @]   Reference to open.
-- 
-- Returns a valid ID on success, negative on failure
-- 
-- > hid_t H5Rdereference(hid_t dataset, H5R_type_t ref_type, const void *ref);
#ccall H5Rdereference, <hid_t> -> <H5R_type_t> -> In a -> IO <hid_t>

-- |Retrieves a dataspace with the region pointed to selected.
-- Given a reference to some object, creates a copy of the dataset pointed
-- to's dataspace and defines a selection in the copy which is the region
-- pointed to.
-- 
-- Parameters:
-- 
-- [@ id       :: 'HId_t'      @]   Dataset reference object is in or location ID of object that the dataset is located within.
-- 
-- [@ ref_type :: 'H5R_type_t' @]   Type of reference to get region of
-- 
-- [@ ref      :: 'In' a       @]   Reference to open.
-- 
-- Returns a valid ID on success, negative on failure.
-- 
-- > hid_t H5Rget_region(hid_t dataset, H5R_type_t ref_type, const void *ref);
#ccall H5Rget_region, <hid_t> -> <H5R_type_t> -> In a -> IO <hid_t>

-- |Given a reference to some object, this function retrieves the type of
-- object pointed to.
-- 
-- Parameters:
-- 
-- [@ id       :: 'HId_t'            @] Dataset reference object is in or location ID of object that the dataset is located within.
-- 
-- [@ ref_type :: 'H5R_type_t'       @] Type of reference to query
-- 
-- [@ ref      :: 'In' a             @] Reference to query.
-- 
-- [@ obj_type :: 'Out' 'H5O_type_t' @] Type of object reference points to
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Rget_obj_type2(hid_t id, H5R_type_t ref_type, const void *_ref,
-- >     H5O_type_t *obj_type);
#ccall H5Rget_obj_type2, <hid_t> -> <H5R_type_t> -> In a -> Out <H5O_type_t> -> IO <herr_t>

-- |Given a reference to some object, determine a path to the object
-- referenced in the file.
-- 
-- Note:  This may not be the only path to that object.
-- 
-- Parameters:
-- 
-- [@ loc_id   :: 'HId_t'       @]  Dataset reference object is in or location ID of object that the dataset is located within.
-- 
-- [@ ref_type :: 'H5R_type_t'  @]  Type of reference
-- 
-- [@ ref      :: 'In' a        @]  Reference to query.
-- 
-- [@ name     :: 'Out' 'CChar' @]  Buffer to place name of object referenced
-- 
-- [@ size     :: 'CSize'       @]  Size of name buffer
--
-- Returns non-negative length of the path on success, Negative on failure
-- 
-- > ssize_t H5Rget_name(hid_t loc_id, H5R_type_t ref_type, const void *ref,
-- >     char *name/*out*/, size_t size);
#ccall H5Rget_name, <hid_t> -> <H5R_type_t> -> In a -> OutArray CChar -> <size_t> -> IO <ssize_t>


#ifndef H5_NO_DEPRECATED_SYMBOLS

-- |Retrieves the type of object that an object reference points to
-- Given a reference to some object, this function returns the type of object
-- pointed to.
-- 
-- Parameters:
-- 
-- [@ id       :: 'HId_t'      @]   Dataset reference object is in or location ID of object that the dataset is located within.
-- 
-- [@ ref_type :: 'H5R_type_t' @]   Type of reference to query
-- 
-- [@ ref      :: 'In' a       @]   Reference to query.
-- 
-- On success, returns an object type defined in "Bindings.HDF5.Raw.H5G"
-- On failure, returns 'h5g_UNKNOWN'
-- 
-- > H5G_obj_t H5Rget_obj_type1(hid_t id, H5R_type_t ref_type, const void *_ref);
#ccall H5Rget_obj_type1, <hid_t> -> <H5R_type_t> -> In a -> IO <H5G_obj_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
