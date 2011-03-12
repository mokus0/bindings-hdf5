#include <bindings.h>

#include <H5Tpublic.h>

module Bindings.HDF5.H5T where
#strict_import

import Foreign.Ptr.Conventions

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

#newtype H5T_class_t, Eq
#newtype_const H5T_class_t, H5T_NO_CLASS
#newtype_const H5T_class_t, H5T_INTEGER
#newtype_const H5T_class_t, H5T_FLOAT
#newtype_const H5T_class_t, H5T_TIME
#newtype_const H5T_class_t, H5T_STRING
#newtype_const H5T_class_t, H5T_BITFIELD
#newtype_const H5T_class_t, H5T_OPAQUE
#newtype_const H5T_class_t, H5T_COMPOUND
#newtype_const H5T_class_t, H5T_REFERENCE
#newtype_const H5T_class_t, H5T_ENUM
#newtype_const H5T_class_t, H5T_VLEN
#newtype_const H5T_class_t, H5T_ARRAY
#num H5T_NCLASSES

#newtype H5T_order_t, Eq
#newtype_const H5T_order_t, H5T_ORDER_ERROR
#newtype_const H5T_order_t, H5T_ORDER_LE
#newtype_const H5T_order_t, H5T_ORDER_BE
#newtype_const H5T_order_t, H5T_ORDER_VAX
#newtype_const H5T_order_t, H5T_ORDER_MIXED
#newtype_const H5T_order_t, H5T_ORDER_NONE

#newtype H5T_sign_t, Eq
#newtype_const H5T_sign_t, H5T_SGN_ERROR
#newtype_const H5T_sign_t, H5T_SGN_NONE
#newtype_const H5T_sign_t, H5T_SGN_2
#num H5T_NSGN

#newtype H5T_norm_t, Eq
#newtype_const H5T_norm_t, H5T_NORM_ERROR
#newtype_const H5T_norm_t, H5T_NORM_IMPLIED
#newtype_const H5T_norm_t, H5T_NORM_MSBSET
#newtype_const H5T_norm_t, H5T_NORM_NONE

#newtype H5T_cset_t, Eq
#newtype_const H5T_cset_t, H5T_CSET_ERROR
#newtype_const H5T_cset_t, H5T_CSET_ASCII
#newtype_const H5T_cset_t, H5T_CSET_UTF8
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_2
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_3
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_4
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_5
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_6
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_7
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_8
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_9
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_10
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_11
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_12
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_13
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_14
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_15
#num H5T_NCSET

#newtype H5T_str_t, Eq
#newtype_const H5T_str_t, H5T_STR_ERROR
#newtype_const H5T_str_t, H5T_STR_NULLTERM
#newtype_const H5T_str_t, H5T_STR_NULLPAD
#newtype_const H5T_str_t, H5T_STR_SPACEPAD
#newtype_const H5T_str_t, H5T_STR_RESERVED_3
#newtype_const H5T_str_t, H5T_STR_RESERVED_4
#newtype_const H5T_str_t, H5T_STR_RESERVED_5
#newtype_const H5T_str_t, H5T_STR_RESERVED_6
#newtype_const H5T_str_t, H5T_STR_RESERVED_7
#newtype_const H5T_str_t, H5T_STR_RESERVED_8
#newtype_const H5T_str_t, H5T_STR_RESERVED_9
#newtype_const H5T_str_t, H5T_STR_RESERVED_10
#newtype_const H5T_str_t, H5T_STR_RESERVED_11
#newtype_const H5T_str_t, H5T_STR_RESERVED_12
#newtype_const H5T_str_t, H5T_STR_RESERVED_13
#newtype_const H5T_str_t, H5T_STR_RESERVED_14
#newtype_const H5T_str_t, H5T_STR_RESERVED_15
#num H5T_NSTR

#newtype H5T_pad_t, Eq
#newtype_const H5T_pad_t, H5T_PAD_ERROR
#newtype_const H5T_pad_t, H5T_PAD_ZERO
#newtype_const H5T_pad_t, H5T_PAD_ONE
#newtype_const H5T_pad_t, H5T_PAD_BACKGROUND
#num H5T_NPAD

#newtype H5T_cmd_t, Eq
#newtype_const H5T_cmd_t, H5T_CONV_INIT
#newtype_const H5T_cmd_t, H5T_CONV_CONV
#newtype_const H5T_cmd_t, H5T_CONV_FREE

#newtype H5T_bkg_t, Eq
#newtype_const H5T_bkg_t, H5T_BKG_NO  
#newtype_const H5T_bkg_t, H5T_BKG_TEMP
#newtype_const H5T_bkg_t, H5T_BKG_YES 

#starttype H5T_cdata_t
#field command,     H5T_cmd_t
#field need_bkg,    H5T_bkg_t
#field recalc,      <hbool_t>
#field priv,        Ptr ()
#stoptype

#newtype H5T_pers_t
#newtype_const H5T_pers_t, H5T_PERS_DONTCARE
#newtype_const H5T_pers_t, H5T_PERS_HARD
#newtype_const H5T_pers_t, H5T_PERS_SOFT

#newtype H5T_direction_t
#newtype_const H5T_direction_t, H5T_DIR_DEFAULT
#newtype_const H5T_direction_t, H5T_DIR_ASCEND
#newtype_const H5T_direction_t, H5T_DIR_DESCEND

#newtype H5T_conv_except_t
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_RANGE_HI
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_RANGE_LOW
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_PRECISION
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_TRUNCATE
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_PINF
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_NINF
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_NAN

#newtype H5T_conv_ret_t
#newtype_const H5T_conv_ret_t, H5T_CONV_ABORT
#newtype_const H5T_conv_ret_t, H5T_CONV_UNHANDLED
#newtype_const H5T_conv_ret_t, H5T_CONV_HANDLED

#starttype hvl_t
#field len, CSize
#field p, Ptr ()
#stoptype

h5t_VARIABLE :: CSize
h5t_VARIABLE = #const H5T_VARIABLE

#num H5T_OPAQUE_TAG_MAX

type H5T_conv_t a b = FunPtr 
    (HId_t -> HId_t -> Ptr H5T_cdata_t 
    -> CSize -> CSize -> CSize -> Ptr a -> Ptr b -> HId_t
    -> IO HErr_t)
    -- TODO: figure out whether these Ptrs are in or out parameters, and 
    -- what they are pointers to

type H5T_conv_except_func_t a userData = FunPtr
    (H5T_conv_except_t -> HId_t -> HId_t -> In a -> In a -> Ptr userData
    -> IO H5T_conv_ret_t)

#cinline H5T_IEEE_F32BE,        <hid_t>
#cinline H5T_IEEE_F32LE,        <hid_t>
#cinline H5T_IEEE_F64BE,        <hid_t>
#cinline H5T_IEEE_F64LE,        <hid_t>

#cinline H5T_STD_I8BE,          <hid_t>
#cinline H5T_STD_I8LE,          <hid_t>
#cinline H5T_STD_I16BE,         <hid_t>
#cinline H5T_STD_I16LE,         <hid_t>
#cinline H5T_STD_I32BE,         <hid_t>
#cinline H5T_STD_I32LE,         <hid_t>
#cinline H5T_STD_I64BE,         <hid_t>
#cinline H5T_STD_I64LE,         <hid_t>
#cinline H5T_STD_U8BE,          <hid_t>
#cinline H5T_STD_U8LE,          <hid_t>
#cinline H5T_STD_U16BE,         <hid_t>
#cinline H5T_STD_U16LE,         <hid_t>
#cinline H5T_STD_U32BE,         <hid_t>
#cinline H5T_STD_U32LE,         <hid_t>
#cinline H5T_STD_U64BE,         <hid_t>
#cinline H5T_STD_U64LE,         <hid_t>
#cinline H5T_STD_B8BE,          <hid_t>
#cinline H5T_STD_B8LE,          <hid_t>
#cinline H5T_STD_B16BE,         <hid_t>
#cinline H5T_STD_B16LE,         <hid_t>
#cinline H5T_STD_B32BE,         <hid_t>
#cinline H5T_STD_B32LE,         <hid_t>
#cinline H5T_STD_B64BE,         <hid_t>
#cinline H5T_STD_B64LE,         <hid_t>
#cinline H5T_STD_REF_OBJ,       <hid_t>
#cinline H5T_STD_REF_DSETREG,   <hid_t>

#cinline H5T_UNIX_D32BE,        <hid_t>
#cinline H5T_UNIX_D32LE,        <hid_t>
#cinline H5T_UNIX_D64BE,        <hid_t>
#cinline H5T_UNIX_D64LE,        <hid_t>

#cinline H5T_C_S1,              <hid_t>

#cinline H5T_FORTRAN_S1,        <hid_t>

h5t_INTEL_I8  = h5t_STD_I8LE
h5t_INTEL_I16 = h5t_STD_I16LE
h5t_INTEL_I32 = h5t_STD_I32LE
h5t_INTEL_I64 = h5t_STD_I64LE
h5t_INTEL_U8  = h5t_STD_U8LE
h5t_INTEL_U16 = h5t_STD_U16LE
h5t_INTEL_U32 = h5t_STD_U32LE
h5t_INTEL_U64 = h5t_STD_U64LE
h5t_INTEL_B8  = h5t_STD_B8LE
h5t_INTEL_B16 = h5t_STD_B16LE
h5t_INTEL_B32 = h5t_STD_B32LE
h5t_INTEL_B64 = h5t_STD_B64LE
h5t_INTEL_F32 = h5t_IEEE_F32LE
h5t_INTEL_F64 = h5t_IEEE_F64LE

h5t_ALPHA_I8  = h5t_STD_I8LE
h5t_ALPHA_I16 = h5t_STD_I16LE
h5t_ALPHA_I32 = h5t_STD_I32LE
h5t_ALPHA_I64 = h5t_STD_I64LE
h5t_ALPHA_U8  = h5t_STD_U8LE
h5t_ALPHA_U16 = h5t_STD_U16LE
h5t_ALPHA_U32 = h5t_STD_U32LE
h5t_ALPHA_U64 = h5t_STD_U64LE
h5t_ALPHA_B8  = h5t_STD_B8LE
h5t_ALPHA_B16 = h5t_STD_B16LE
h5t_ALPHA_B32 = h5t_STD_B32LE
h5t_ALPHA_B64 = h5t_STD_B64LE
h5t_ALPHA_F32 = h5t_IEEE_F32LE
h5t_ALPHA_F64 = h5t_IEEE_F64LE

h5t_MIPS_I8  = h5t_STD_I8BE
h5t_MIPS_I16 = h5t_STD_I16BE
h5t_MIPS_I32 = h5t_STD_I32BE
h5t_MIPS_I64 = h5t_STD_I64BE
h5t_MIPS_U8  = h5t_STD_U8BE
h5t_MIPS_U16 = h5t_STD_U16BE
h5t_MIPS_U32 = h5t_STD_U32BE
h5t_MIPS_U64 = h5t_STD_U64BE
h5t_MIPS_B8  = h5t_STD_B8BE
h5t_MIPS_B16 = h5t_STD_B16BE
h5t_MIPS_B32 = h5t_STD_B32BE
h5t_MIPS_B64 = h5t_STD_B64BE
h5t_MIPS_F32 = h5t_IEEE_F32BE
h5t_MIPS_F64 = h5t_IEEE_F64BE

#cinline H5T_VAX_F32,           <hid_t>
#cinline H5T_VAX_F64,           <hid_t>

#cinline H5T_NATIVE_CHAR,       <hid_t>
#cinline H5T_NATIVE_SCHAR,      <hid_t>
#cinline H5T_NATIVE_UCHAR,      <hid_t>
#cinline H5T_NATIVE_SHORT,      <hid_t>
#cinline H5T_NATIVE_USHORT,     <hid_t>
#cinline H5T_NATIVE_INT,        <hid_t>
#cinline H5T_NATIVE_UINT,       <hid_t>
#cinline H5T_NATIVE_LONG,       <hid_t>
#cinline H5T_NATIVE_ULONG,      <hid_t>
#cinline H5T_NATIVE_LLONG,      <hid_t>
#cinline H5T_NATIVE_ULLONG,     <hid_t>
#cinline H5T_NATIVE_FLOAT,      <hid_t>
#cinline H5T_NATIVE_DOUBLE,     <hid_t>
#if H5_SIZEOF_LONG_DOUBLE !=0
#cinline H5T_NATIVE_LDOUBLE,    <hid_t>
#endif
#cinline H5T_NATIVE_B8,         <hid_t>
#cinline H5T_NATIVE_B16,        <hid_t>
#cinline H5T_NATIVE_B32,        <hid_t>
#cinline H5T_NATIVE_B64,        <hid_t>
#cinline H5T_NATIVE_OPAQUE,     <hid_t>
#cinline H5T_NATIVE_HADDR,      <hid_t>
#cinline H5T_NATIVE_HSIZE,      <hid_t>
#cinline H5T_NATIVE_HSSIZE,     <hid_t>
#cinline H5T_NATIVE_HERR,       <hid_t>
#cinline H5T_NATIVE_HBOOL,      <hid_t>

#cinline H5T_NATIVE_INT8,           <hid_t>
#cinline H5T_NATIVE_UINT8,          <hid_t>
#cinline H5T_NATIVE_INT_LEAST8,     <hid_t>
#cinline H5T_NATIVE_UINT_LEAST8,    <hid_t>
#cinline H5T_NATIVE_INT_FAST8,      <hid_t>
#cinline H5T_NATIVE_UINT_FAST8,     <hid_t>

#cinline H5T_NATIVE_INT16,          <hid_t>
#cinline H5T_NATIVE_UINT16,         <hid_t>
#cinline H5T_NATIVE_INT_LEAST16,    <hid_t>
#cinline H5T_NATIVE_UINT_LEAST16,   <hid_t>
#cinline H5T_NATIVE_INT_FAST16,     <hid_t>
#cinline H5T_NATIVE_UINT_FAST16,    <hid_t>

#cinline H5T_NATIVE_INT32,          <hid_t>
#cinline H5T_NATIVE_UINT32,         <hid_t>
#cinline H5T_NATIVE_INT_LEAST32,    <hid_t>
#cinline H5T_NATIVE_UINT_LEAST32,   <hid_t>
#cinline H5T_NATIVE_INT_FAST32,     <hid_t>
#cinline H5T_NATIVE_UINT_FAST32,    <hid_t>

#cinline H5T_NATIVE_INT64,          <hid_t>
#cinline H5T_NATIVE_UINT64,         <hid_t>
#cinline H5T_NATIVE_INT_LEAST64,    <hid_t>
#cinline H5T_NATIVE_UINT_LEAST64,   <hid_t>
#cinline H5T_NATIVE_INT_FAST64,     <hid_t>
#cinline H5T_NATIVE_UINT_FAST64,    <hid_t>

-- /* Operations defined on all datatypes */
-- hid_t H5Tcreate(H5T_class_t type, size_t size);
#ccall H5Tcreate, H5T_class_t -> <size_t> -> IO <hid_t>

-- hid_t H5Tcopy(hid_t type_id);
#ccall H5Tcopy, <hid_t> -> IO <hid_t>

-- herr_t H5Tclose(hid_t type_id);
#ccall H5Tclose, <hid_t> -> <herr_t>

-- htri_t H5Tequal(hid_t type1_id, hid_t type2_id);
#ccall H5Tequal, <hid_t> -> <hid_t> -> IO <htri_t>

-- herr_t H5Tlock(hid_t type_id);
#ccall H5Tlock, <hid_t> -> IO <herr_t>

-- herr_t H5Tcommit2(hid_t loc_id, const char *name, hid_t type_id,
--     hid_t lcpl_id, hid_t tcpl_id, hid_t tapl_id);
#ccall H5Tcommit2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- hid_t H5Topen2(hid_t loc_id, const char *name, hid_t tapl_id);
#ccall H5Topen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- herr_t H5Tcommit_anon(hid_t loc_id, hid_t type_id, hid_t tcpl_id, hid_t tapl_id);
#ccall H5Tcommit_anon, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- hid_t H5Tget_create_plist(hid_t type_id);
#ccall H5Tget_create_plist, <hid_t> -> IO <hid_t>

-- htri_t H5Tcommitted(hid_t type_id);
#ccall H5Tcommitted, <hid_t> -> IO <htri_t>

-- herr_t H5Tencode(hid_t obj_id, void *buf, size_t *nalloc);
#ccall H5Tencode, <hid_t> -> In a -> InOut <size_t> -> IO <herr_t>

-- hid_t H5Tdecode(const void *buf);
#ccall H5Tdecode, In a -> IO <hid_t>

-- /* Operations defined on compound datatypes */
-- herr_t H5Tinsert(hid_t parent_id, const char *name, size_t offset,
-- 			 hid_t member_id);
#ccall H5Tinsert, <hid_t> -> CString -> <size_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Tpack(hid_t type_id);
#ccall H5Tpack, <hid_t> -> IO <herr_t>

-- /* Operations defined on enumeration datatypes */
-- hid_t H5Tenum_create(hid_t base_id);
#ccall H5Tenum_create, <hid_t> -> IO <hid_t>

-- herr_t H5Tenum_insert(hid_t type, const char *name, const void *value);
#ccall H5Tenum_insert, <hid_t> -> CString -> In a -> IO <herr_t>

-- herr_t H5Tenum_nameof(hid_t type, const void *value, char *name/*out*/,
-- 			     size_t size);
#ccall H5Tenum_nameof, <hid_t> -> CString -> OutArray CChar -> <size_t> -> IO <herr_t>

-- herr_t H5Tenum_valueof(hid_t type, const char *name,
-- 			      void *value/*out*/);
#ccall H5Tenum_valueof, <hid_t> -> CString -> Out a -> IO <herr_t>

-- 
-- /* Operations defined on variable-length datatypes */
-- hid_t H5Tvlen_create(hid_t base_id);
#ccall H5Tvlen_create, <hid_t> -> IO <hid_t>

-- 
-- /* Operations defined on array datatypes */
-- hid_t H5Tarray_create2(hid_t base_id, unsigned ndims,
--             const hsize_t dim[/* ndims */]);
#ccall H5Tarray_create2, <hid_t> -> CUInt -> <hsize_t> -> IO <hid_t>

-- int H5Tget_array_ndims(hid_t type_id);
#ccall H5Tget_array_ndims, <hid_t> -> IO CInt

-- int H5Tget_array_dims2(hid_t type_id, hsize_t dims[]);
#ccall H5Tget_array_dims2, <hid_t> -> <hsize_t> -> IO CInt

-- 
-- /* Operations defined on opaque datatypes */
-- herr_t H5Tset_tag(hid_t type, const char *tag);
#ccall H5Tset_tag, <hid_t> -> CString -> IO <herr_t>

-- char *H5Tget_tag(hid_t type);
#ccall H5Tget_tag, <hid_t> -> IO CString

-- 
-- /* Querying property values */
-- hid_t H5Tget_super(hid_t type);
#ccall H5Tget_super, <hid_t> -> IO <hid_t>

-- H5T_class_t H5Tget_class(hid_t type_id);
#ccall H5Tget_class, <hid_t> -> IO <H5T_class_t>

-- htri_t H5Tdetect_class(hid_t type_id, H5T_class_t cls);
#ccall H5Tdetect_class, <hid_t> -> <H5T_class_t> -> IO <htri_t>

-- size_t H5Tget_size(hid_t type_id);
#ccall H5Tget_size, <hid_t> -> IO <size_t>

-- H5T_order_t H5Tget_order(hid_t type_id);
#ccall H5Tget_order, <hid_t> -> IO H5T_order_t

-- size_t H5Tget_precision(hid_t type_id);
#ccall H5Tget_precision, <hid_t> -> IO <size_t>

-- int H5Tget_offset(hid_t type_id);
#ccall H5Tget_offset, <hid_t> -> IO CInt

-- herr_t H5Tget_pad(hid_t type_id, H5T_pad_t *lsb/*out*/,
-- 			  H5T_pad_t *msb/*out*/);
#ccall H5Tget_pad, <hid_t> -> Out <H5T_pad_t> -> Out <H5T_pad_t> -> IO <herr_t>

-- H5T_sign_t H5Tget_sign(hid_t type_id);
#ccall H5Tget_sign, <hid_t> -> IO <H5T_sign_t>

-- herr_t H5Tget_fields(hid_t type_id, size_t *spos/*out*/,
-- 			     size_t *epos/*out*/, size_t *esize/*out*/,
-- 			     size_t *mpos/*out*/, size_t *msize/*out*/);
#ccall H5Tget_fields, <hid_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

-- size_t H5Tget_ebias(hid_t type_id);
#ccall H5Tget_ebias, <hid_t> -> IO <size_t>

-- H5T_norm_t H5Tget_norm(hid_t type_id);
#ccall H5Tget_norm, <hid_t> -> IO <H5T_norm_t>

-- H5T_pad_t H5Tget_inpad(hid_t type_id);
#ccall H5Tget_inpad, <hid_t> -> IO <H5T_pad_t>

-- H5T_str_t H5Tget_strpad(hid_t type_id);
#ccall H5Tget_strpad, <hid_t> -> IO <H5T_str_t>

-- int H5Tget_nmembers(hid_t type_id);
#ccall H5Tget_nmembers, <hid_t> -> IO CInt

-- char *H5Tget_member_name(hid_t type_id, unsigned membno);
#ccall H5Tget_member_name, <hid_t> -> CUInt -> IO CString

-- int H5Tget_member_index(hid_t type_id, const char *name);
#ccall H5Tget_member_index, <hid_t> -> CString -> IO CInt

-- size_t H5Tget_member_offset(hid_t type_id, unsigned membno);
#ccall H5Tget_member_offset, <hid_t> -> CUInt -> IO <size_t>

-- H5T_class_t H5Tget_member_class(hid_t type_id, unsigned membno);
#ccall H5Tget_member_class, <hid_t> -> CUInt -> IO <H5T_class_t>

-- hid_t H5Tget_member_type(hid_t type_id, unsigned membno);
#ccall H5Tget_member_type, <hid_t> -> CUInt -> IO <hid_t>

-- herr_t H5Tget_member_value(hid_t type_id, unsigned membno, void *value/*out*/);
#ccall H5Tget_member_value, <hid_t> -> CUInt -> Out a -> IO <herr_t>

-- H5T_cset_t H5Tget_cset(hid_t type_id);
#ccall H5Tget_cset, <hid_t> -> IO <H5T_cset_t>

-- htri_t H5Tis_variable_str(hid_t type_id);
#ccall H5Tis_variable_str, <hid_t> -> IO <htri_t>

-- hid_t H5Tget_native_type(hid_t type_id, H5T_direction_t direction);
#ccall H5Tget_native_type, <hid_t> -> <H5T_direction_t> -> IO <hid_t>

-- 
-- /* Setting property values */
-- herr_t H5Tset_size(hid_t type_id, size_t size);
#ccall H5Tset_size, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Tset_order(hid_t type_id, H5T_order_t order);
#ccall H5Tset_order, <hid_t> -> <H5T_order_t> -> IO <herr_t>

-- herr_t H5Tset_precision(hid_t type_id, size_t prec);
#ccall H5Tset_precision, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Tset_offset(hid_t type_id, size_t offset);
#ccall H5Tset_offset, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Tset_pad(hid_t type_id, H5T_pad_t lsb, H5T_pad_t msb);
#ccall H5Tset_pad, <hid_t> -> <H5T_pad_t> -> <H5T_pad_t> -> IO <herr_t>

-- herr_t H5Tset_sign(hid_t type_id, H5T_sign_t sign);
#ccall H5Tset_sign, <hid_t> -> <H5T_sign_t> -> IO <herr_t>

-- herr_t H5Tset_fields(hid_t type_id, size_t spos, size_t epos,
-- 			     size_t esize, size_t mpos, size_t msize);
#ccall H5Tset_fields, <hid_t> -> <size_t> -> <size_t> -> <size_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Tset_ebias(hid_t type_id, size_t ebias);
#ccall H5Tset_ebias, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Tset_norm(hid_t type_id, H5T_norm_t norm);
#ccall H5Tset_norm, <hid_t> -> <H5T_norm_t> -> IO <herr_t>

-- herr_t H5Tset_inpad(hid_t type_id, H5T_pad_t pad);
#ccall H5Tset_inpad, <hid_t> -> <H5T_pad_t> -> IO <herr_t>

-- herr_t H5Tset_cset(hid_t type_id, H5T_cset_t cset);
#ccall H5Tset_cset, <hid_t> -> <H5T_cset_t> -> IO <herr_t>

-- herr_t H5Tset_strpad(hid_t type_id, H5T_str_t strpad);
#ccall H5Tset_strpad, <hid_t> -> <H5T_str_t> -> IO <herr_t>

-- 
-- /* Type conversion database */
-- herr_t H5Tregister(H5T_pers_t pers, const char *name, hid_t src_id,
-- 			   hid_t dst_id, H5T_conv_t func);
#ccall H5Tregister, <H5T_pers_t> -> CString -> <hid_t> -> <hid_t> -> H5T_conv_t a b -> IO <herr_t>

-- herr_t H5Tunregister(H5T_pers_t pers, const char *name, hid_t src_id,
-- 			     hid_t dst_id, H5T_conv_t func);
#ccall H5Tunregister, <H5T_pers_t> -> CString -> <hid_t> -> <hid_t> -> H5T_conv_t a b -> IO <herr_t>

-- TODO: check docs on this funtion and figure out what its type should be
-- H5T_conv_t H5Tfind(hid_t src_id, hid_t dst_id, H5T_cdata_t **pcdata);
#ccall H5Tfind, <hid_t> -> <hid_t> -> Out (Ptr H5T_cdata_t) -> IO (H5T_conv_t a b)

-- htri_t H5Tcompiler_conv(hid_t src_id, hid_t dst_id);
#ccall H5Tcompiler_conv, <hid_t> -> <hid_t> -> IO <htri_t>

-- herr_t H5Tconvert(hid_t src_id, hid_t dst_id, size_t nelmts,
-- 			  void *buf, void *background, hid_t plist_id);
#ccall H5Tconvert, <hid_t> -> <hid_t> -> <size_t> -> Ptr a -> Ptr b -> <hid_t> -> IO <herr_t>

-- 
-- /* Symbols defined for compatibility with previous versions of the HDF5 API.
--  *
--  * Use of these symbols is deprecated.
--  */
#ifndef H5_NO_DEPRECATED_SYMBOLS
-- 
-- /* Macros */
-- 
-- 
-- /* Typedefs */
-- 
-- 
-- /* Function prototypes */
-- herr_t H5Tcommit1(hid_t loc_id, const char *name, hid_t type_id);
#ccall H5Tcommit1, <hid_t> -> CString -> <hid_t> -> IO <herr_t>

-- hid_t H5Topen1(hid_t loc_id, const char *name);
#ccall H5Topen1, <hid_t> -> CString -> IO <hid_t>

-- hid_t H5Tarray_create1(hid_t base_id, int ndims,
--             const hsize_t dim[/* ndims */],
--             const int perm[/* ndims */]);
#ccall H5Tarray_create1, <hid_t> -> CInt -> <hsize_t> -> CInt -> IO <hid_t>

-- int H5Tget_array_dims1(hid_t type_id, hsize_t dims[], int perm[]);
#ccall H5Tget_array_dims1, <hid_t> -> OutArray <hsize_t> -> OutArray CInt -> IO CInt

-- 
#endif /* H5_NO_DEPRECATED_SYMBOLS */

