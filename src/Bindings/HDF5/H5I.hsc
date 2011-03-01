#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.H5I where
#strict_import

import Bindings.HDF5.H5

#newtype H5I_type_t
    deriving Eq
#newtype_const H5I_type_t, H5I_UNINIT
#newtype_const H5I_type_t, H5I_BADID
#newtype_const H5I_type_t, H5I_FILE
#newtype_const H5I_type_t, H5I_GROUP
#newtype_const H5I_type_t, H5I_DATATYPE
#newtype_const H5I_type_t, H5I_DATASPACE
#newtype_const H5I_type_t, H5I_DATASET
#newtype_const H5I_type_t, H5I_ATTR
#newtype_const H5I_type_t, H5I_REFERENCE
#newtype_const H5I_type_t, H5I_VFL
#newtype_const H5I_type_t, H5I_GENPROP_CLS
#newtype_const H5I_type_t, H5I_GENPROP_LST
#newtype_const H5I_type_t, H5I_ERROR_CLASS
#newtype_const H5I_type_t, H5I_ERROR_MSG
#newtype_const H5I_type_t, H5I_ERROR_STACK
#num H5I_NTYPES

#newtype hid_t
h5_SIZEOF_HID_T :: CSize
h5_SIZEOF_HID_T = #const H5_SIZEOF_HID_T

#newtype_const hid_t, H5I_INVALID_HID

type H5I_free_t        a = FunPtr (Ptr a -> IO HErr_t)
type H5I_search_func_t a = FunPtr (Ptr a -> HId_t -> Ptr a -> IO CInt)
   
-- hid_t H5Iregister(H5I_type_t type, const void *object);
#ccall H5Iregister , <H5I_type_t> -> Ptr a -> IO <hid_t>

-- void *H5Iobject_verify(hid_t id, H5I_type_t id_type);
#ccall H5Iobject_verify , <hid_t> -> <H5I_type_t> -> IO (Ptr a)

-- void *H5Iremove_verify(hid_t id, H5I_type_t id_type);
#ccall H5Iremove_verify , <hid_t> -> <H5I_type_t> -> IO (Ptr a)

-- H5I_type_t H5Iget_type(hid_t id);
#ccall H5Iget_type , <hid_t> -> IO <H5I_type_t>

-- hid_t H5Iget_file_id(hid_t id);
#ccall H5Iget_file_id , <hid_t> -> IO <hid_t>

-- ssize_t H5Iget_name(hid_t id, char *name/*out*/, size_t size);
#ccall H5Iget_name, <hid_t> -> Ptr Char -> CSize -> IO CSize

-- int H5Iinc_ref(hid_t id);
-- int H5Idec_ref(hid_t id);
-- int H5Iget_ref(hid_t id);
#ccall H5Iinc_ref, <hid_t> -> IO CInt
#ccall H5Idec_ref, <hid_t> -> IO CInt
#ccall H5Iget_ref, <hid_t> -> IO CInt

-- H5I_type_t H5Iregister_type(size_t hash_size, unsigned reserved, H5I_free_t free_func);
#ccall H5Iregister_type, CSize -> CUInt -> <H5I_free_t> a -> IO <H5I_type_t>

-- herr_t H5Iclear_type(H5I_type_t type, hbool_t force);
#ccall H5Iclear_type, <H5I_type_t> -> <hbool_t> -> IO <herr_t>

-- herr_t H5Idestroy_type(H5I_type_t type);
#ccall H5Idestroy_type, <H5I_type_t> -> IO <herr_t>

-- int H5Iinc_type_ref(H5I_type_t type);
-- int H5Idec_type_ref(H5I_type_t type);
-- int H5Iget_type_ref(H5I_type_t type);
#ccall H5Iinc_type_ref, <H5I_type_t> -> IO CInt
#ccall H5Idec_type_ref, <H5I_type_t> -> IO CInt
#ccall H5Iget_type_ref, <H5I_type_t> -> IO CInt

-- void *H5Isearch(H5I_type_t type, H5I_search_func_t func, void *key);
#ccall H5Isearch, <H5I_type_t> -> <H5I_search_func_t> a -> Ptr a -> IO (Ptr a)

-- herr_t H5Inmembers(H5I_type_t type, hsize_t *num_members);
#ccall H5Inmembers, <H5I_type_t> -> Ptr <hsize_t> -> IO <herr_t>

-- htri_t H5Itype_exists(H5I_type_t type);
#ccall H5Itype_exists, <H5I_type_t> -> IO <htri_t>

-- htri_t H5Iis_valid(hid_t id);
#ccall H5Iis_valid, <hid_t> -> IO <htri_t>
