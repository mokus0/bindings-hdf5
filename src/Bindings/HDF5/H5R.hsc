#include <bindings.h>
#include <H5Rpublic.h>

module Bindings.HDF5.H5R where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5G
import Bindings.HDF5.H5I
import Bindings.HDF5.H5O

import Data.ByteString

import Foreign.Ptr.Conventions

#newtype H5R_type_t
#newtype_const H5R_type_t, H5R_BADTYPE
#newtype_const H5R_type_t, H5R_OBJECT
#newtype_const H5R_type_t, H5R_DATASET_REGION
#newtype_const H5R_type_t, H5R_MAXTYPE

#mangle_ident "H5R_OBJ_REF_BUF_SIZE"
    = #const H5R_OBJ_REF_BUF_SIZE
    :: CSize

#newtype hobj_ref_t

#mangle_ident "H5R_DSET_REG_REF_BUF_SIZE"
    = #const H5R_DSET_REG_REF_BUF_SIZE
    :: CSize

-- |typedef unsigned char hdset_reg_ref_t[H5R_DSET_REG_REF_BUF_SIZE];
--
--  Buffer to store heap ID and index
newtype #mangle_tycon   "hdset_reg_ref_t"
    =   #mangle_datacon "hdset_reg_ref_t"
    ByteString


-- herr_t H5Rcreate(void *ref, hid_t loc_id, const char *name,
-- 			 H5R_type_t ref_type, hid_t space_id);
#ccall H5Rcreate, Out a -> <hid_t> -> CString -> <H5R_type_t> -> <hid_t> -> IO <herr_t>

-- hid_t H5Rdereference(hid_t dataset, H5R_type_t ref_type, const void *ref);
#ccall H5Rdereference, <hid_t> -> <H5R_type_t> -> In a -> IO <hid_t>

-- hid_t H5Rget_region(hid_t dataset, H5R_type_t ref_type, const void *ref);
#ccall H5Rget_region, <hid_t> -> <H5R_type_t> -> In a -> IO <hid_t>

-- herr_t H5Rget_obj_type2(hid_t id, H5R_type_t ref_type, const void *_ref,
--     H5O_type_t *obj_type);
#ccall H5Rget_obj_type2, <hid_t> -> <H5R_type_t> -> In a -> Out <H5O_type_t> -> IO <herr_t>

-- ssize_t H5Rget_name(hid_t loc_id, H5R_type_t ref_type, const void *ref,
--     char *name/*out*/, size_t size);
#ccall H5Rget_name, <hid_t> -> <H5R_type_t> -> In a -> OutArray CChar -> <size_t> -> IO <ssize_t>


#ifndef H5_NO_DEPRECATED_SYMBOLS

-- H5G_obj_t H5Rget_obj_type1(hid_t id, H5R_type_t ref_type, const void *_ref);
#ccall H5Rget_obj_type1, <hid_t> -> <H5R_type_t> -> In a -> IO <H5G_obj_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
