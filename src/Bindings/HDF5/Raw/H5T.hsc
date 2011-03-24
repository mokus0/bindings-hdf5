#include <bindings.h>

#include <H5Tpublic.h>

module Bindings.HDF5.Raw.H5T where
#strict_import

import Foreign.Ptr.Conventions

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I

-- |These are the various classes of datatypes
-- 
-- If this goes over 16 types (0-15), the file format will need to change)
#newtype H5T_class_t, Eq

-- |error
#newtype_const H5T_class_t, H5T_NO_CLASS

-- |integer types
#newtype_const H5T_class_t, H5T_INTEGER

-- |floating-point types
#newtype_const H5T_class_t, H5T_FLOAT

-- |date and time types
#newtype_const H5T_class_t, H5T_TIME

-- |character string types
#newtype_const H5T_class_t, H5T_STRING

-- |bit field types
#newtype_const H5T_class_t, H5T_BITFIELD

-- |opaque types
#newtype_const H5T_class_t, H5T_OPAQUE

-- |compound types
#newtype_const H5T_class_t, H5T_COMPOUND

-- |reference types
#newtype_const H5T_class_t, H5T_REFERENCE

-- |enumeration types
#newtype_const H5T_class_t, H5T_ENUM

-- |Variable-Length types
#newtype_const H5T_class_t, H5T_VLEN

-- |Array types
#newtype_const H5T_class_t, H5T_ARRAY

-- |The number of basic datatypes
#num H5T_NCLASSES

-- |Byte orders
#newtype H5T_order_t, Eq

-- |error
#newtype_const H5T_order_t, H5T_ORDER_ERROR

-- |little endian
#newtype_const H5T_order_t, H5T_ORDER_LE

-- |bit endian
#newtype_const H5T_order_t, H5T_ORDER_BE

-- |VAX mixed endian
#newtype_const H5T_order_t, H5T_ORDER_VAX

#if H5_VERSION_ATLEAST(1,8,6)
-- |Compound type with mixed member orders
#newtype_const H5T_order_t, H5T_ORDER_MIXED
#endif

-- |no particular order (strings, bits,..)
#newtype_const H5T_order_t, H5T_ORDER_NONE

-- |Types of integer sign schemes
#newtype H5T_sign_t, Eq

-- |error
#newtype_const H5T_sign_t, H5T_SGN_ERROR

-- |this is an unsigned type
#newtype_const H5T_sign_t, H5T_SGN_NONE

-- |two's complement
#newtype_const H5T_sign_t, H5T_SGN_2

-- |The number of recognized integer sign schemes
#num H5T_NSGN

-- |Floating-point normalization schemes
#newtype H5T_norm_t, Eq

-- |error
#newtype_const H5T_norm_t, H5T_NORM_ERROR

-- |msb of mantissa isn't stored, always 1
#newtype_const H5T_norm_t, H5T_NORM_IMPLIED

-- |msb of mantissa is always 1
#newtype_const H5T_norm_t, H5T_NORM_MSBSET

-- |not normalized
#newtype_const H5T_norm_t, H5T_NORM_NONE

-- |Character set to use for text strings.  Do not change these values since
-- they appear in HDF5 files!
#newtype H5T_cset_t, Eq

-- |error
#newtype_const H5T_cset_t, H5T_CSET_ERROR

-- |US ASCII
#newtype_const H5T_cset_t, H5T_CSET_ASCII

-- |UTF-8 Unicode encoding
#newtype_const H5T_cset_t, H5T_CSET_UTF8

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_2

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_3

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_4

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_5

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_6

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_7

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_8

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_9

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_10

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_11

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_12

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_13

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_14

-- |reserved for later use
#newtype_const H5T_cset_t, H5T_CSET_RESERVED_15

-- |Number of character sets actually defined
#num H5T_NCSET

-- |Type of padding to use in character strings.  Do not change these values
-- since they appear in HDF5 files!
#newtype H5T_str_t, Eq

-- |error
#newtype_const H5T_str_t, H5T_STR_ERROR

-- |null terminate like in C
#newtype_const H5T_str_t, H5T_STR_NULLTERM

-- |pad with nulls
#newtype_const H5T_str_t, H5T_STR_NULLPAD

-- |pad with spaces like in Fortran
#newtype_const H5T_str_t, H5T_STR_SPACEPAD

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_3

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_4

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_5

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_6

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_7

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_8

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_9

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_10

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_11

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_12

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_13

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_14

-- |reserved for later use
#newtype_const H5T_str_t, H5T_STR_RESERVED_15

-- |num 'H5T_str_t' types actually defined
#num H5T_NSTR

-- |Type of padding to use in other atomic types
#newtype H5T_pad_t, Eq

-- |error
#newtype_const H5T_pad_t, H5T_PAD_ERROR

-- |always set to zero
#newtype_const H5T_pad_t, H5T_PAD_ZERO

-- |always set to one
#newtype_const H5T_pad_t, H5T_PAD_ONE

-- |set to background value
#newtype_const H5T_pad_t, H5T_PAD_BACKGROUND

-- |Number of valid 'H5T_pad_t' values.
#num H5T_NPAD

-- |Commands sent to conversion functions
#newtype H5T_cmd_t, Eq

-- |query and/or initialize private data
#newtype_const H5T_cmd_t, H5T_CONV_INIT

-- |convert data from source to dest datatype
#newtype_const H5T_cmd_t, H5T_CONV_CONV

-- |function is being removed from path
#newtype_const H5T_cmd_t, H5T_CONV_FREE

-- |How is the 'bkg' buffer used by the conversion function?
#newtype H5T_bkg_t, Eq

-- |background buffer is not needed, send NULL
#newtype_const H5T_bkg_t, H5T_BKG_NO  

-- |bkg buffer used as temp storage only
#newtype_const H5T_bkg_t, H5T_BKG_TEMP

-- |init bkg buf with data before conversion
#newtype_const H5T_bkg_t, H5T_BKG_YES 

-- |Type conversion client data
data H5T_cdata_t a = H5T_cdata_t {

    -- |what should the conversion function do?
    h5t_cdata_t'command   :: H5T_cmd_t,

    -- |is the background buffer needed?
    h5t_cdata_t'need_bkg  :: H5T_bkg_t,

    -- |recalculate private data
    h5t_cdata_t'recalc    :: HBool_t,

    -- |private data
    h5t_cdata_t'priv      :: Ptr a}
    
    deriving (Eq,Show)

instance Storable (H5T_cdata_t a) where
  sizeOf _ = #size H5T_cdata_t
  alignment = sizeOf
  peek p = do
    v0 <- #{peek H5T_cdata_t, command}  p
    v1 <- #{peek H5T_cdata_t, need_bkg} p
    v2 <- #{peek H5T_cdata_t, recalc}   p
    v3 <- #{peek H5T_cdata_t, priv}     p
    return $ H5T_cdata_t v0 v1 v2 v3
  poke p (H5T_cdata_t v0 v1 v2 v3) = do
    #{poke H5T_cdata_t, command}  p v0
    #{poke H5T_cdata_t, need_bkg} p v1
    #{poke H5T_cdata_t, recalc}   p v2
    #{poke H5T_cdata_t, priv}     p v3
    return ()

-- |Conversion function persistence
#newtype H5T_pers_t

-- |wild card
#newtype_const H5T_pers_t, H5T_PERS_DONTCARE

-- |hard conversion function
#newtype_const H5T_pers_t, H5T_PERS_HARD

-- |soft conversion function
#newtype_const H5T_pers_t, H5T_PERS_SOFT

-- |The order to retrieve atomic native datatype
#newtype H5T_direction_t

-- |default direction is inscendent
#newtype_const H5T_direction_t, H5T_DIR_DEFAULT

-- |in inscendent order
#newtype_const H5T_direction_t, H5T_DIR_ASCEND

-- |in descendent order
#newtype_const H5T_direction_t, H5T_DIR_DESCEND

-- |The exception type passed into the conversion callback function
#newtype H5T_conv_except_t

-- |source value is greater than destination's range
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_RANGE_HI

-- |source value is less than destination's range
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_RANGE_LOW

-- |source value loses precision in destination
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_PRECISION

-- |source value is truncated in destination
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_TRUNCATE

-- |source value is positive infinity(floating number)
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_PINF

-- |source value is negative infinity(floating number)
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_NINF

-- |source value is NaN(floating number)
#newtype_const H5T_conv_except_t, H5T_CONV_EXCEPT_NAN

-- |The return value from conversion callback function 'h5t_conv_except_func_t'
#newtype H5T_conv_ret_t

-- |abort conversion
#newtype_const H5T_conv_ret_t, H5T_CONV_ABORT

-- |callback function failed to handle the exception
#newtype_const H5T_conv_ret_t, H5T_CONV_UNHANDLED

-- |callback function handled the exception successfully
#newtype_const H5T_conv_ret_t, H5T_CONV_HANDLED

-- |Variable Length Datatype struct in memory
-- (This is only used for VL sequences, not VL strings, which are stored in char *'s)
#starttype hvl_t

-- |Length of VL data (in base type units)
#field len, CSize

-- |Pointer to VL data
#field p, Ptr ()

#stoptype

-- |Indicate that a string is variable length (null-terminated in C, instead of fixed length)
h5t_VARIABLE :: CSize
h5t_VARIABLE = #const H5T_VARIABLE

-- |Maximum length of an opaque tag.
#num H5T_OPAQUE_TAG_MAX

-- TODO: find documentation for this type.
type H5T_conv_t a b conversionData = FunPtr 
    (HId_t -> HId_t -> Ptr (H5T_cdata_t conversionData)
    -> CSize -> CSize -> CSize -> Ptr a -> Ptr b -> HId_t
    -> IO HErr_t)

-- |Exception handler.  If an exception like overflow happens during conversion,
-- this function is called if it's registered through 'h5p_set_type_conv_cb'.
type H5T_conv_except_func_t a userData = FunPtr
    (H5T_conv_except_t -> HId_t -> HId_t -> In a -> In a -> InOut userData
    -> IO H5T_conv_ret_t)

-- * Constants identifying data types

-- ** The IEEE floating point types in various byte orders.

#cinline H5T_IEEE_F32BE,        <hid_t>
#cinline H5T_IEEE_F32LE,        <hid_t>
#cinline H5T_IEEE_F64BE,        <hid_t>
#cinline H5T_IEEE_F64LE,        <hid_t>

-- ** \"Standard\" Types
-- These are \"standard\" types.  For instance, signed (2's complement) and
-- unsigned integers of various sizes and byte orders.

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

-- ** Types which are particular to Unix.

#cinline H5T_UNIX_D32BE,        <hid_t>
#cinline H5T_UNIX_D32LE,        <hid_t>
#cinline H5T_UNIX_D64BE,        <hid_t>
#cinline H5T_UNIX_D64LE,        <hid_t>

-- **  Types particular to the C language.  
-- String types use \"bytes\" instead of \"bits\" as their size.

#cinline H5T_C_S1,              <hid_t>

-- ** Types particular to Fortran.

#cinline H5T_FORTRAN_S1,        <hid_t>

-- ** Types for Intel CPUs.
-- They are little endian with IEEE floating point.

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

-- ** Types for Alpha CPUs.
-- They are little endian with IEEE floating point.

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

-- ** Types for MIPS CPUs.
-- They are big endian with IEEE floating point.

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

-- ** VAX floating point types (i.e. in VAX byte order)

#cinline H5T_VAX_F32,           <hid_t>
#cinline H5T_VAX_F64,           <hid_t>

-- ** Predefined native types.
-- These are the types detected by 'h5_detect' and they violate the naming
-- scheme a little.  Instead of a class name, precision and byte order as 
-- the last component, they have a C-like type name.
-- If the type begins with 'U' then it is the unsigned version of the
-- integer type; other integer types are signed.  The type LLONG corresponds
-- to C's 'long long' and LDOUBLE is 'long double' (these types might be the
-- same as 'LONG' and 'DOUBLE' respectively).

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

-- ** C9x integer types

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

-- * Operations defined on all datatypes

-- |Create a new type and initialize it to reasonable values.
-- The type is a member of type class 'type' and is 'size' bytes.
-- 
-- On success, returns a new type identifier.  On failure, returns
-- a negative value.
-- 
-- > hid_t H5Tcreate(H5T_class_t type, size_t size);
#ccall H5Tcreate, H5T_class_t -> <size_t> -> IO <hid_t>

-- |Copies a datatype.  The resulting datatype is not locked.
-- The datatype should be closed when no longer needed by
-- calling 'h5t_close'.
-- 
-- Returns the ID of a new datatype on success, negative on failure.
-- 
-- > hid_t H5Tcopy(hid_t type_id);
#ccall H5Tcopy, <hid_t> -> IO <hid_t>

-- |Frees a datatype and all associated memory.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Tclose(hid_t type_id);
#ccall H5Tclose, <hid_t> -> <herr_t>

-- |Determines if two datatypes are equal.
--
-- > htri_t H5Tequal(hid_t type1_id, hid_t type2_id);
#ccall H5Tequal, <hid_t> -> <hid_t> -> IO <htri_t>

-- |Locks a type, making it read only and non-destructable.  This
-- is normally done by the library for predefined datatypes so
-- the application doesn't inadvertently change or delete a
-- predefined type.
-- 
-- Once a datatype is locked it can never be unlocked unless
-- the entire library is closed.
-- 
-- It is illegal to lock a named datatype since we must allow named
-- types to be closed (to release file resources) but locking a type
-- prevents that.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tlock(hid_t type_id);
#ccall H5Tlock, <hid_t> -> IO <herr_t>

-- |Save a transient datatype to a file and turn the type handle
-- into a \"named\", immutable type.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tcommit2(hid_t loc_id, const char *name, hid_t type_id,
-- >     hid_t lcpl_id, hid_t tcpl_id, hid_t tapl_id);
#ccall H5Tcommit2, <hid_t> -> CString -> <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Opens a named datatype using a Datatype Access Property
--     List.
-- 
-- Returns the object ID of the named datatype on success, negative
-- on failure.
--
-- > hid_t H5Topen2(hid_t loc_id, const char *name, hid_t tapl_id);
#ccall H5Topen2, <hid_t> -> CString -> <hid_t> -> IO <hid_t>

-- |Save a transient datatype to a file and turn the type handle
-- into a \"named\", immutable type.
-- 
-- The resulting ID should be linked into the file with
-- 'h5o_link' or it will be deleted when closed.
-- 
-- Note:  Datatype access property list is unused currently, but is
-- checked for sanity anyway.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tcommit_anon(hid_t loc_id, hid_t type_id, hid_t tcpl_id, hid_t tapl_id);
#ccall H5Tcommit_anon, <hid_t> -> <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |Returns a copy of the datatype creation property list, or negative on
-- failure.  The property list ID should be released by calling 'h5p_close'.
--
-- > hid_t H5Tget_create_plist(hid_t type_id);
#ccall H5Tget_create_plist, <hid_t> -> IO <hid_t>

-- |Determines if a datatype is committed or not.
--
-- > htri_t H5Tcommitted(hid_t type_id);
#ccall H5Tcommitted, <hid_t> -> IO <htri_t>

-- |Given a datatype ID, converts the object description into
-- binary in a buffer.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tencode(hid_t obj_id, void *buf, size_t *nalloc);
#ccall H5Tencode, <hid_t> -> In a -> InOut <size_t> -> IO <herr_t>

-- |Decode a binary object description and return a new object handle,
-- or negative on failure.
-- 
-- > hid_t H5Tdecode(const void *buf);
#ccall H5Tdecode, In a -> IO <hid_t>

-- * Operations defined on compound datatypes

-- |Adds another member to the compound datatype 'parent_id'.  The
-- new member has a 'name' which must be unique within the
-- compound datatype. The 'offset' argument defines the start of
-- the member in an instance of the compound datatype, and
-- 'member_id' is the type of the new member.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Tinsert(hid_t parent_id, const char *name, size_t offset,
-- >        hid_t member_id);
#ccall H5Tinsert, <hid_t> -> CString -> <size_t> -> <hid_t> -> IO <herr_t>

-- |Recursively removes padding from within a compound datatype
-- to make it more efficient (space-wise) to store that data.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tpack(hid_t type_id);
#ccall H5Tpack, <hid_t> -> IO <herr_t>

-- * Operations defined on enumeration datatypes

-- |Create a new enumeration data type based on the specified
-- 'type', which must be an integer type.
-- 
-- Returns the ID of a new enumeration data type on success, negative
-- on failure.
-- 
-- > hid_t H5Tenum_create(hid_t base_id);
#ccall H5Tenum_create, <hid_t> -> IO <hid_t>

-- |Insert a new enumeration data type member into an enumeration
-- type.  'type' is the enumeration type, 'name' is the name of the
-- new member, and 'value' points to the value of the new member.
-- The 'name' and 'value' must both be unique within the 'type'. 'value'
-- points to data which is of the data type defined when the
-- enumeration type was created.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tenum_insert(hid_t type, const char *name, const void *value);
#ccall H5Tenum_insert, <hid_t> -> CString -> In a -> IO <herr_t>

-- > herr_t H5Tenum_nameof(hid_t type, const void *value, char *name/*out*/,
-- >        size_t size);
#ccall H5Tenum_nameof, <hid_t> -> CString -> OutArray CChar -> <size_t> -> IO <herr_t>

-- |Finds the symbol name that corresponds to the specified 'value'
-- of an enumeration data type 'type'. At most 'size' characters of
-- the symbol name are copied into the 'name' buffer. If the
-- entire symbol name and null terminator do not fit in the 'name'
-- buffer then as many characters as possible are copied (not
-- null terminated) and the function fails.
-- 
-- On success, returns non-negative.  On failure, returns negative and the
-- first character of 'name' is set to null if 'size' allows it.
-- 
-- WARNING: the above 2 paragraphs contradict each other about what happens
-- on failure.  This is because the documentation in the source does.  If
-- I read the source correctly, this is because there are some failures which
-- have one behavior and some which have the other.  Therefore, I would 
-- probably not rely on either behavior.
-- 
-- > herr_t H5Tenum_valueof(hid_t type, const char *name,
-- >        void *value/*out*/);
#ccall H5Tenum_valueof, <hid_t> -> CString -> Out a -> IO <herr_t>

-- * Operations defined on variable-length datatypes

-- |Create a new variable-length datatype based on the specified 'base_type'.
-- 
-- Returns the ID of a new VL datatype on success, negative on failure.
-- 
-- > hid_t H5Tvlen_create(hid_t base_id);
#ccall H5Tvlen_create, <hid_t> -> IO <hid_t>

-- * Operations defined on array datatypes

-- |Create a new array datatype based on the specified 'base_type'.
-- The type is an array with 'ndims' dimensionality and the size of the
-- array is 'dims'. The total member size should be relatively small.
-- Array datatypes are currently limited to 'h5s_max_rank' number of
-- dimensions and must have the number of dimensions set greater than
-- 0. (i.e. 0 > 'ndims' <= 'h5s_MAX_RANK')  All dimensions sizes must be 
-- greater than 0 also.
-- 
-- Returns the ID of a new array datatype on success, negative on failure.
-- 
-- > hid_t H5Tarray_create2(hid_t base_id, unsigned ndims,
-- >        const hsize_t dim[/* ndims */]);
#ccall H5Tarray_create2, <hid_t> -> CUInt -> <hsize_t> -> IO <hid_t>

-- |Returns the number of dimensions of an array datatype, or negative on
-- failure.
-- 
-- > int H5Tget_array_ndims(hid_t type_id);
#ccall H5Tget_array_ndims, <hid_t> -> IO CInt

-- |Query the sizes of dimensions for an array datatype.
-- 
-- Returns the number of dimensions of the array type on success or
-- negative on failure.
-- 
-- > int H5Tget_array_dims2(hid_t type_id, hsize_t dims[]);
#ccall H5Tget_array_dims2, <hid_t> -> OutArray <hsize_t> -> IO CInt

-- * Operations defined on opaque datatypes

-- |Tag an opaque datatype with a unique ASCII identifier.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Tset_tag(hid_t type, const char *tag);
#ccall H5Tset_tag, <hid_t> -> CString -> IO <herr_t>

-- |Get the tag associated with an opaque datatype.
--
-- Returns a pointer to a 'malloc'ed string.  The caller should 'free' the
-- string.
--
-- > char *H5Tget_tag(hid_t type);
#ccall H5Tget_tag, <hid_t> -> IO CString

-- * Querying property values

-- |Returns the type from which 'type' is derived. In the case of
-- an enumeration type the return value is an integer type.
-- 
-- Returns the type ID for the base datatype on success, or negative on
-- failure.
-- 
-- > hid_t H5Tget_super(hid_t type);
#ccall H5Tget_super, <hid_t> -> IO <hid_t>

-- |Returns the datatype class identifier for datatype 'type_id'.
--
-- Returns one of the non-negative datatype class constants on success
-- or 'h5t_NO_CLASS' (which is negative) on failure.
--
-- > H5T_class_t H5Tget_class(hid_t type_id);
#ccall H5Tget_class, <hid_t> -> IO <H5T_class_t>

-- |Check whether a datatype contains (or is) a certain type of
-- datatype.
-- 
-- > htri_t H5Tdetect_class(hid_t type_id, H5T_class_t cls);
#ccall H5Tdetect_class, <hid_t> -> <H5T_class_t> -> IO <htri_t>

-- |Determines the total size of a datatype in bytes.
--
-- Returns the size of an instance of the datatype (in bytes) on
-- success or 0 on failure (valid datatypes are never zero size).
--
-- > size_t H5Tget_size(hid_t type_id);
#ccall H5Tget_size, <hid_t> -> IO <size_t>

-- |Returns the byte order of a datatype on success, or 'h5t_ORDER_ERROR'
-- (which is negative) on failure.
-- 
-- If the type is compound and its members have mixed orders, this function
-- returns 'h5t_ORDER_MIXED'.
-- 
-- > H5T_order_t H5Tget_order(hid_t type_id);
#ccall H5Tget_order, <hid_t> -> IO H5T_order_t

-- |Gets the precision of a datatype.  The precision is
-- the number of significant bits which, unless padding is
-- present, is 8 times larger than the value returned by
-- 'h5t_get_size'.
-- 
-- Returns 0 on failure (all atomic types have at least one
-- significant bit)
-- 
-- > size_t H5Tget_precision(hid_t type_id);
#ccall H5Tget_precision, <hid_t> -> IO <size_t>

-- |Retrieves the bit offset of the first significant bit.  The
-- signficant bits of an atomic datum can be offset from the
-- beginning of the memory for that datum by an amount of
-- padding. The 'offset' property specifies the number of bits
-- of padding that appear to the \"right of\" the value.  That is,
-- if we have a 32-bit datum with 16-bits of precision having
-- the value 0x1122 then it will be layed out in memory as (from
-- small byte address toward larger byte addresses):
-- 
-- >     Big      Big       Little   Little
-- >     Endian   Endian    Endian   Endian
-- >     offset=0 offset=16 offset=0 offset=16
-- > 
-- > 0:  [ pad]   [0x11]    [0x22]   [ pad]
-- > 1:  [ pad]   [0x22]    [0x11]   [ pad]
-- > 2:  [0x11]   [ pad]    [ pad]   [0x22]
-- > 3:  [0x22]   [ pad]    [ pad]   [0x11]
-- 
-- Returns the offset on success or negative on failure.
--
-- > int H5Tget_offset(hid_t type_id);
#ccall H5Tget_offset, <hid_t> -> IO CInt

-- |Gets the least significant pad type and the most significant
-- pad type and returns their values through the LSB and MSB
-- arguments, either of which may be the null pointer.
-- 
-- Returns non-negative on success or negative on failure.
-- 
-- > herr_t H5Tget_pad(hid_t type_id, H5T_pad_t *lsb/*out*/,
-- >        H5T_pad_t *msb/*out*/);
#ccall H5Tget_pad, <hid_t> -> Out <H5T_pad_t> -> Out <H5T_pad_t> -> IO <herr_t>

-- |Returns the sign type for an integer type or 'h5t_SGN_ERROR' (a negative
-- value) on failure.
--
-- > H5T_sign_t H5Tget_sign(hid_t type_id);
#ccall H5Tget_sign, <hid_t> -> IO <H5T_sign_t>

-- |Returns information about the locations of the various bit
-- fields of a floating point datatype.  The field positions
-- are bit positions in the significant region of the datatype.
-- Bits are numbered with the least significant bit number zero.
-- 
-- Any (or even all) of the arguments can be null pointers.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tget_fields(hid_t type_id, size_t *spos/*out*/,
-- >        size_t *epos/*out*/, size_t *esize/*out*/,
-- >        size_t *mpos/*out*/, size_t *msize/*out*/);
#ccall H5Tget_fields, <hid_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

-- |Returns the exponent bias of a floating-point type, or 0 on failure.
--
-- > size_t H5Tget_ebias(hid_t type_id);
#ccall H5Tget_ebias, <hid_t> -> IO <size_t>

-- |Returns the mantisssa normalization of a floating-point data type,
-- or 'h5t_NORM_ERROR' (a negative value) on failure.
-- 
-- > H5T_norm_t H5Tget_norm(hid_t type_id);
#ccall H5Tget_norm, <hid_t> -> IO <H5T_norm_t>

-- |If any internal bits of a floating point type are unused
-- (that is, those significant bits which are not part of the
-- sign, exponent, or mantissa) then they will be filled
-- according to the value of this property.
-- 
-- > H5T_pad_t H5Tget_inpad(hid_t type_id);
#ccall H5Tget_inpad, <hid_t> -> IO <H5T_pad_t>

-- |The method used to store character strings differs with the
-- programming language: C usually null terminates strings while
-- Fortran left-justifies and space-pads strings.  This property
-- defines the storage mechanism for the string.
-- 
-- Returns the character set of a string type on success, or
-- 'h5t_STR_ERROR' (a negative value) on failure.
-- 
-- > H5T_str_t H5Tget_strpad(hid_t type_id);
#ccall H5Tget_strpad, <hid_t> -> IO <H5T_str_t>

-- |Determines how many members 'type_id' has.  The type must be
-- either a compound datatype or an enumeration datatype.
-- 
-- Returns the number of members defined in the datatype on success, or
-- negative on failure.
-- 
-- > int H5Tget_nmembers(hid_t type_id);
#ccall H5Tget_nmembers, <hid_t> -> IO CInt

-- |Returns the name of a member of a compound or enumeration
-- datatype.  Members are stored in no particular order with
-- numbers 0 through N-1 where N is the value returned by
-- 'h5t_get_nmembers'.
-- 
-- Returns a pointer to a string allocated with 'malloc', or NULL on 
-- failure.  The caller is responsible for 'free'ing the string.
-- 
-- > char *H5Tget_member_name(hid_t type_id, unsigned membno);
#ccall H5Tget_member_name, <hid_t> -> CUInt -> IO CString

-- |Returns the index of a member in a compound or enumeration
-- datatype by given name.  Members are stored in no particular
-- order with numbers 0 through N-1 where N is the value
-- returned by 'h5t_get_nmembers'.
-- 
-- Returns the index of the member on success, or negative on
-- failure.
-- 
-- > int H5Tget_member_index(hid_t type_id, const char *name);
#ccall H5Tget_member_index, <hid_t> -> CString -> IO CInt

-- |Returns the byte offset of the beginning of a member with
-- respect to the beginning of the compound datatype datum.
-- 
-- Returns the byte offset on success, or zero on failure.
-- Zero is a valid offset, but this function will fail only
-- if a call to 'h5t_get_member_dims' fails with the same
-- arguments.
-- 
-- > size_t H5Tget_member_offset(hid_t type_id, unsigned membno);
#ccall H5Tget_member_offset, <hid_t> -> CUInt -> IO <size_t>

-- |Returns the datatype class of a member of a compound datatype.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > H5T_class_t H5Tget_member_class(hid_t type_id, unsigned membno);
#ccall H5Tget_member_class, <hid_t> -> CUInt -> IO <H5T_class_t>

-- |Returns a copy of the datatype of the specified member, or negative
-- on failure.  The caller should invoke 'h5t_close' to release resources
-- associated with the type.
-- 
-- > hid_t H5Tget_member_type(hid_t type_id, unsigned membno);
#ccall H5Tget_member_type, <hid_t> -> CUInt -> IO <hid_t>

-- |Return the value for an enumeration data type member.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Tget_member_value(hid_t type_id, unsigned membno, void *value/*out*/);
#ccall H5Tget_member_value, <hid_t> -> CUInt -> Out a -> IO <herr_t>

-- |HDF5 is able to distinguish between character sets of
-- different nationalities and to convert between them to the
-- extent possible.
-- 
-- Returns the character set of a string type on success, or
-- 'h5t_CSET_ERROR' (a negative value) on failure.
-- 
-- > H5T_cset_t H5Tget_cset(hid_t type_id);
#ccall H5Tget_cset, <hid_t> -> IO <H5T_cset_t>

-- |Check whether a datatype is a variable-length string
-- 
-- > htri_t H5Tis_variable_str(hid_t type_id);
#ccall H5Tis_variable_str, <hid_t> -> IO <htri_t>

-- |High-level API to return the native type of a datatype.
-- The native type is chosen by matching the size and class of
-- querried datatype from the following native premitive
-- datatypes:
-- 
--  'h5t_NATIVE_CHAR'         'h5t_NATIVE_UCHAR'
--  'h5t_NATIVE_SHORT'        'h5t_NATIVE_USHORT'
--  'h5t_NATIVE_INT'          'h5t_NATIVE_UINT'
--  'h5t_NATIVE_LONG'         'h5t_NATIVE_ULONG'
--  'h5t_NATIVE_LLONG'        'h5t_NATIVE_ULLONG'
-- 
--  'H5T_NATIVE_FLOAT'
--  'H5T_NATIVE_DOUBLE'
--  'H5T_NATIVE_LDOUBLE'
-- 
-- Compound, array, enum, and VL types all choose among these
-- types for theire members.  Time, Bifield, Opaque, Reference
-- types are only copy out.
-- 
-- Returns the native data type if successful, negative otherwise.
--
-- > hid_t H5Tget_native_type(hid_t type_id, H5T_direction_t direction);
#ccall H5Tget_native_type, <hid_t> -> <H5T_direction_t> -> IO <hid_t>

-- * Setting property values

-- |Sets the total size in bytes for a datatype (this operation
-- is not permitted on reference datatypes).  If the size is
-- decreased so that the significant bits of the datatype
-- extend beyond the edge of the new size, then the 'offset'
-- property is decreased toward zero.  If the 'offset' becomes
-- zero and the significant bits of the datatype still hang
-- over the edge of the new size, then the number of significant
-- bits is decreased.
-- 
-- Adjusting the size of an 'h5t_STRING' automatically sets the
-- precision to @8*size@.
-- 
-- All datatypes have a positive size.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_size(hid_t type_id, size_t size);
#ccall H5Tset_size, <hid_t> -> <size_t> -> IO <herr_t>

-- |Sets the byte order for a datatype.
-- 
-- Notes:  There are some restrictions on this operation:
-- 
--  1. For enum type, members shouldn't be defined yet.
-- 
--  2. 'h5t_ORDER_NONE' only works for reference and fixed-length
--     string.
-- 
--  3. For opaque type, the order will be ignored.
-- 
--  4. For compound type, all restrictions above apply to the 
--     members.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_order(hid_t type_id, H5T_order_t order);
#ccall H5Tset_order, <hid_t> -> <H5T_order_t> -> IO <herr_t>

-- |Sets the precision of a datatype.  The precision is
-- the number of significant bits which, unless padding is
-- present, is 8 times larger than the value returned by
-- 'h5t_get_size'.
-- 
-- If the precision is increased then the offset is decreased
-- and then the size is increased to insure that significant
-- bits do not \"hang over\" the edge of the datatype.
-- 
-- The precision property of strings is read-only.
-- 
-- When decreasing the precision of a floating point type, set
-- the locations and sizes of the sign, mantissa, and exponent
-- fields first.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_precision(hid_t type_id, size_t prec);
#ccall H5Tset_precision, <hid_t> -> <size_t> -> IO <herr_t>

-- |Sets the bit offset of the first significant bit.  The
-- signficant bits of an atomic datum can be offset from the
-- beginning of the memory for that datum by an amount of
-- padding. The `offset' property specifies the number of bits
-- of padding that appear to the "right of" the value.  That is,
-- if we have a 32-bit datum with 16-bits of precision having
-- the value 0x1122 then it will be layed out in memory as (from
-- small byte address toward larger byte addresses):
-- 
-- >     Big      Big       Little   Little
-- >     Endian   Endian    Endian   Endian
-- >     offset=0 offset=16 offset=0 offset=16
-- > 
-- > 0:  [ pad]   [0x11]    [0x22]   [ pad]
-- > 1:  [ pad]   [0x22]    [0x11]   [ pad]
-- > 2:  [0x11]   [ pad]    [ pad]   [0x22]
-- > 3:  [0x22]   [ pad]    [ pad]   [0x11]
-- 
-- If the offset is incremented then the total size is
-- incremented also if necessary to prevent significant bits of
-- the value from hanging over the edge of the data type.
-- 
-- The offset of an 'h5t_STRING' cannot be set to anything but
-- zero.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_offset(hid_t type_id, size_t offset);
#ccall H5Tset_offset, <hid_t> -> <size_t> -> IO <herr_t>

-- |Sets the LSB and MSB pad types.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_pad(hid_t type_id, H5T_pad_t lsb, H5T_pad_t msb);
#ccall H5Tset_pad, <hid_t> -> <H5T_pad_t> -> <H5T_pad_t> -> IO <herr_t>

-- |Sets the sign property for an integer.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_sign(hid_t type_id, H5T_sign_t sign);
#ccall H5Tset_sign, <hid_t> -> <H5T_sign_t> -> IO <herr_t>

-- |Sets the locations and sizes of the various floating point
-- bit fields.  The field positions are bit positions in the
-- significant region of the datatype.  Bits are numbered with
-- the least significant bit number zero.
-- 
-- Fields are not allowed to extend beyond the number of bits of
-- precision, nor are they allowed to overlap with one another.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_fields(hid_t type_id, size_t spos, size_t epos,
-- >        size_t esize, size_t mpos, size_t msize);
#ccall H5Tset_fields, <hid_t> -> <size_t> -> <size_t> -> <size_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- |Sets the exponent bias of a floating-point type.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_ebias(hid_t type_id, size_t ebias);
#ccall H5Tset_ebias, <hid_t> -> <size_t> -> IO <herr_t>

-- |Sets the mantissa normalization method for a floating point
-- datatype.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_norm(hid_t type_id, H5T_norm_t norm);
#ccall H5Tset_norm, <hid_t> -> <H5T_norm_t> -> IO <herr_t>

-- |If any internal bits of a floating point type are unused
-- (that is, those significant bits which are not part of the
-- sign, exponent, or mantissa) then they will be filled
-- according to the value of this property.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_inpad(hid_t type_id, H5T_pad_t pad);
#ccall H5Tset_inpad, <hid_t> -> <H5T_pad_t> -> IO <herr_t>

-- |HDF5 is able to distinguish between character sets of
-- different nationalities and to convert between them to the
-- extent possible.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_cset(hid_t type_id, H5T_cset_t cset);
#ccall H5Tset_cset, <hid_t> -> <H5T_cset_t> -> IO <herr_t>

-- |The method used to store character strings differs with the
-- programming language: C usually null terminates strings while
-- Fortran left-justifies and space-pads strings.  This property
-- defines the storage mechanism for the string.
-- 
-- When converting from a long string to a short string if the
-- short string is 'h5t_STR_NULLPAD' or 'h5t_STR_SPACEPAD' then the
-- string is simply truncated; otherwise if the short string is
-- 'h5t_STR_NULLTERM' it will be truncated and a null terminator
-- is appended.
-- 
-- When converting from a short string to a long string, the
-- long string is padded on the end by appending nulls or
-- spaces.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tset_strpad(hid_t type_id, H5T_str_t strpad);
#ccall H5Tset_strpad, <hid_t> -> <H5T_str_t> -> IO <herr_t>

-- * Type conversion database

-- |Register a hard or soft conversion function for a data type
-- conversion path.  The path is specified by the source and
-- destination data types 'src_id' and 'dst_id' (for soft functions
-- only the class of these types is important).  If 'func' is a
-- hard function then it replaces any previous path; if it's a
-- soft function then it replaces all existing paths to which it
-- applies and is used for any new path to which it applies as
-- long as that path doesn't have a hard function.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tregister(H5T_pers_t pers, const char *name, hid_t src_id,
-- >        hid_t dst_id, H5T_conv_t func);
#ccall H5Tregister, <H5T_pers_t> -> CString -> <hid_t> -> <hid_t> -> H5T_conv_t a b c -> IO <herr_t>

-- |Removes conversion paths that match the specified criteria.
-- All arguments are optional. Missing arguments are wild cards.
-- The special no-op path cannot be removed.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Tunregister(H5T_pers_t pers, const char *name, hid_t src_id,
-- >        hid_t dst_id, H5T_conv_t func);
#ccall H5Tunregister, <H5T_pers_t> -> CString -> <hid_t> -> <hid_t> -> H5T_conv_t a b c -> IO <herr_t>

-- TODO: check docs on this funtion and figure out what its type should be
-- |Finds a conversion function that can handle a conversion from
-- type 'src_id' to type 'dst_id'.  The 'pcdata' argument is a pointer
-- to a pointer to type conversion data which was created and
-- initialized by the type conversion function of this path
-- when the conversion function was installed on the path.
-- 
-- > H5T_convT H5Tfind(hid_t src_id, hid_t dst_id, H5T_cdata_t **pcdata);
#ccall H5Tfind, <hid_t> -> <hid_t> -> Out (Ptr (H5T_cdata_t c)) -> IO (H5T_conv_t a b c)

-- |Finds out whether the library's conversion function from
-- type 'src_id' to type 'dst_id' is a compiler (hard) conversion.
-- A hard conversion uses compiler's casting; a soft conversion
-- uses the library's own conversion function.
-- 
-- > htri_t H5Tcompiler_conv(hid_t src_id, hid_t dst_id);
#ccall H5Tcompiler_conv, <hid_t> -> <hid_t> -> IO <htri_t>

-- |Convert 'nelmts' elements from type 'src_id' to type 'dst_id'.  The
-- source elements are packed in 'buf' and on return the
-- destination will be packed in 'buf'.  That is, the conversion
-- is performed in place.  The optional background buffer is an
-- array of 'nelmts' values of destination type which are merged
-- with the converted values to fill in cracks (for instance,
-- 'background' might be an array of structs with the 'a' and 'b'
-- fields already initialized and the conversion of BUF supplies
-- the 'c' and 'd' field values).  The 'plist_id' a dataset transfer
-- property list which is passed to the conversion functions.  (It's
-- currently only used to pass along the VL datatype custom allocation
-- information -QAK 7/1/99)
-- 
-- > herr_t H5Tconvert(hid_t src_id, hid_t dst_id, size_t nelmts,
-- >        void *buf, void *background, hid_t plist_id);
#ccall H5Tconvert, <hid_t> -> <hid_t> -> <size_t> -> Ptr a -> Ptr b -> <hid_t> -> IO <herr_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- * Symbols defined for compatibility with previous versions of the HDF5 API.
--
-- Use of these symbols is deprecated.

-- |Save a transient datatype to a file and turn the type handle
-- into a named, immutable type.
-- 
-- Note:  Deprecated in favor of 'h5t_commit2'
-- 
-- > herr_t H5Tcommit1(hid_t loc_id, const char *name, hid_t type_id);
#ccall H5Tcommit1, <hid_t> -> CString -> <hid_t> -> IO <herr_t>

-- |Opens a named datatype.
--
-- Deprecated in favor of 'h5t_open2'.
--
-- > hid_t H5Topen1(hid_t loc_id, const char *name);
#ccall H5Topen1, <hid_t> -> CString -> IO <hid_t>

-- |Create a new array datatype based on the specified 'base_type'.
-- The type is an array with 'ndims' dimensionality and the size of the
-- array is 'dims'. The total member size should be relatively small.
-- Array datatypes are currently limited to 'h5s_MAX_RANK' number of
-- dimensions and must have the number of dimensions set greater than
-- 0. (i.e. @0 > ndims <= 'h5s_MAX_RANK'@)  All dimensions sizes must 
-- be greater than 0 also.
-- 
-- Returns the ID of a new array datatype on success, negative on 
-- failure.
-- 
-- > hid_t H5Tarray_create1(hid_t base_id, int ndims,
-- >        const hsize_t dim[/* ndims */],
-- >        const int perm[/* ndims */]);
#ccall H5Tarray_create1, <hid_t> -> CInt -> <hsize_t> -> CInt -> IO <hid_t>

-- |Query the sizes of dimensions for an array datatype.
--
-- Returns the number of dimensions of the array type on success, 
-- negative on failure.
--
-- > int H5Tget_array_dims1(hid_t type_id, hsize_t dims[], int perm[]);
#ccall H5Tget_array_dims1, <hid_t> -> OutArray <hsize_t> -> OutArray CInt -> IO CInt

-- 
#endif /* H5_NO_DEPRECATED_SYMBOLS */

