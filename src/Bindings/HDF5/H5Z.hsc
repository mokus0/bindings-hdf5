#include <bindings.h>
#include <H5Ipublic.h>
#include <H5Zpublic.h>

module Bindings.HDF5.H5Z where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#newtype H5Z_filter_t, Eq

#newtype_const H5Z_filter_t, H5Z_FILTER_ERROR
#newtype_const H5Z_filter_t, H5Z_FILTER_NONE
#newtype_const H5Z_filter_t, H5Z_FILTER_DEFLATE
#newtype_const H5Z_filter_t, H5Z_FILTER_SHUFFLE
#newtype_const H5Z_filter_t, H5Z_FILTER_FLETCHER32
#newtype_const H5Z_filter_t, H5Z_FILTER_SZIP
#newtype_const H5Z_filter_t, H5Z_FILTER_NBIT
#newtype_const H5Z_filter_t, H5Z_FILTER_SCALEOFFSET
#newtype_const H5Z_filter_t, H5Z_FILTER_RESERVED
#newtype_const H5Z_filter_t, H5Z_FILTER_MAX

#newtype_const H5Z_filter_t, H5Z_FILTER_ALL
#num H5Z_MAX_NFILTERS

#num H5Z_FLAG_DEFMASK
#num H5Z_FLAG_MANDATORY
#num H5Z_FLAG_OPTIONAL

#num H5Z_FLAG_INVMASK
#num H5Z_FLAG_REVERSE
#num H5Z_FLAG_SKIP_EDC

#num H5_SZIP_ALLOW_K13_OPTION_MASK
#num H5_SZIP_CHIP_OPTION_MASK
#num H5_SZIP_EC_OPTION_MASK
#num H5_SZIP_NN_OPTION_MASK
#num H5_SZIP_MAX_PIXELS_PER_BLOCK

#num H5Z_SHUFFLE_USER_NPARMS
#num H5Z_SHUFFLE_TOTAL_NPARMS

#num H5Z_SZIP_USER_NPARMS
#num H5Z_SZIP_TOTAL_NPARMS
#num H5Z_SZIP_PARM_MASK
#num H5Z_SZIP_PARM_PPB
#num H5Z_SZIP_PARM_BPP
#num H5Z_SZIP_PARM_PPS

#num H5Z_NBIT_USER_NPARMS

#num H5Z_SCALEOFFSET_USER_NPARMS


#num H5Z_SO_INT_MINBITS_DEFAULT
#newtype H5Z_SO_scale_type_t
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_FLOAT_DSCALE
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_FLOAT_ESCALE
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_INT

#num H5Z_CLASS_T_VERS

#newtype H5Z_EDC_t
#newtype_const H5Z_EDC_t, H5Z_ERROR_EDC
#newtype_const H5Z_EDC_t, H5Z_DISABLE_EDC
#newtype_const H5Z_EDC_t, H5Z_ENABLE_EDC
#newtype_const H5Z_EDC_t, H5Z_NO_EDC

#num H5Z_FILTER_CONFIG_ENCODE_ENABLED
#num H5Z_FILTER_CONFIG_DECODE_ENABLED

#newtype H5Z_cb_return_t
#newtype_const H5Z_cb_return_t, H5Z_CB_ERROR
#newtype_const H5Z_cb_return_t, H5Z_CB_FAIL
#newtype_const H5Z_cb_return_t, H5Z_CB_CONT
#newtype_const H5Z_cb_return_t, H5Z_CB_NO

type H5Z_filter_func_t a b = FunPtr (H5Z_filter_t -> Ptr a -> CSize -> InOut b -> IO H5Z_cb_return_t)

#starttype H5Z_cb_t
#field func, H5Z_filter_func_t () ()
#field op_data, Ptr ()
#stoptype

-- typedef htri_t (*H5Z_can_apply_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
#callback H5Z_can_apply_func_t, <hid_t> -> <hid_t> -> <hid_t> -> IO <htri_t>

-- typedef herr_t (*H5Z_set_local_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
#callback H5Z_set_local_func_t, <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- typedef size_t (*H5Z_func_t)(unsigned int flags, size_t cd_nelmts,
-- 			     const unsigned int cd_values[], size_t nbytes,
-- 			     size_t *buf_size, void **buf);
type H5Z_func_t a = FunPtr (CUInt -> CSize -> InArray CUInt -> CSize -> Ptr CSize -> Ptr (Ptr a) -> IO CSize)

#if H5_VERSION_ATLEAST(1,8,3)
#starttype H5Z_class2_t
#else
#starttype H5Z_class_t
#endif
#field version,         CInt
#field id,              <H5Z_filter_t>
#field encoder_present, CUInt
#field decoder_present, CUInt
#field name,            CString
#field can_apply,       <H5Z_can_apply_func_t>
#field set_local,       <H5Z_set_local_func_t>
#field filter,          H5Z_func_t ()
#stoptype

-- herr_t H5Zregister(const void *cls);
#ccall H5Zregister, In a -> IO <herr_t>

-- herr_t H5Zunregister(H5Z_filter_t id);
#ccall H5Zunregister, <H5Z_filter_t> -> IO <herr_t>

-- htri_t H5Zfilter_avail(H5Z_filter_t id);
#ccall H5Zfilter_avail, <H5Z_filter_t> -> IO <htri_t>

-- herr_t H5Zget_filter_info(H5Z_filter_t filter, unsigned int *filter_config_flags);
#ccall H5Zget_filter_info, <H5Z_filter_t> -> Ptr CUInt -> IO <herr_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS

#if H5_VERSION_ATLEAST(1,8,3)
#starttype H5Z_class1_t
#field id,          <H5Z_filter_t>
#field name,        CString
#field can_apply,   <H5Z_can_apply_func_t>
#field set_local,   <H5Z_set_local_func_t>
#field filter,      H5Z_func_t ()
#stoptype
#endif

#endif /* H5_NO_DEPRECATED_SYMBOLS */

