#include <bindings.h>
#include <H5Epublic.h>

module Bindings.HDF5.H5E where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.LibFFI
import Foreign.Ptr.Conventions

#num H5E_DEFAULT

#newtype H5E_type_t
#newtype_const H5E_type_t, H5E_MAJOR
#newtype_const H5E_type_t, H5E_MINOR

#starttype H5E_error2_t
#field cls_id,       <hid_t>
#field maj_num,      <hid_t>
#field min_num,      <hid_t>
#field line,         CUInt
#field func_name,    CString
#field file_name,    CString
#field desc,         CString
#stoptype

#cinline H5E_ERR_CLS,           <hid_t>

#cinline H5E_DATASET,           <hid_t>
#cinline H5E_FUNC,              <hid_t>
#cinline H5E_STORAGE,           <hid_t>
#cinline H5E_FILE,              <hid_t>
#cinline H5E_SOHM,              <hid_t>
#cinline H5E_SYM,               <hid_t>
#cinline H5E_VFL,               <hid_t>
#cinline H5E_INTERNAL,          <hid_t>
#cinline H5E_BTREE,             <hid_t>
#cinline H5E_REFERENCE,         <hid_t>
#cinline H5E_DATASPACE,         <hid_t>
#cinline H5E_RESOURCE,          <hid_t>
#cinline H5E_PLIST,             <hid_t>
#cinline H5E_LINK,              <hid_t>
#cinline H5E_DATATYPE,          <hid_t>
#cinline H5E_RS,                <hid_t>
#cinline H5E_HEAP,              <hid_t>
#cinline H5E_OHDR,              <hid_t>
#cinline H5E_ATOM,              <hid_t>
#cinline H5E_ATTR,              <hid_t>
#cinline H5E_NONE_MAJOR,        <hid_t>
#cinline H5E_IO,                <hid_t>
#cinline H5E_SLIST,             <hid_t>
#cinline H5E_EFL,               <hid_t>
#cinline H5E_TST,               <hid_t>
#cinline H5E_ARGS,              <hid_t>
#cinline H5E_ERROR,             <hid_t>
#cinline H5E_PLINE,             <hid_t>
#cinline H5E_FSPACE,            <hid_t>
#cinline H5E_CACHE,             <hid_t>

#cinline H5E_SEEKERROR,         <hid_t>
#cinline H5E_READERROR,         <hid_t>
#cinline H5E_WRITEERROR,        <hid_t>
#cinline H5E_CLOSEERROR,        <hid_t>
#cinline H5E_OVERFLOW,          <hid_t>
#cinline H5E_FCNTL,             <hid_t>

#cinline H5E_NOSPACE,           <hid_t>
#cinline H5E_CANTALLOC,         <hid_t>
#cinline H5E_CANTCOPY,          <hid_t>
#cinline H5E_CANTFREE,          <hid_t>
#cinline H5E_ALREADYEXISTS,     <hid_t>
#cinline H5E_CANTLOCK,          <hid_t>
#cinline H5E_CANTUNLOCK,        <hid_t>
#cinline H5E_CANTGC,            <hid_t>
#cinline H5E_CANTGETSIZE,       <hid_t>
#cinline H5E_OBJOPEN,           <hid_t>

#cinline H5E_CANTRESTORE,       <hid_t>
#cinline H5E_CANTCOMPUTE,       <hid_t>
#cinline H5E_CANTEXTEND,        <hid_t>
#cinline H5E_CANTATTACH,        <hid_t>
#cinline H5E_CANTUPDATE,        <hid_t>
#cinline H5E_CANTOPERATE,       <hid_t>

#cinline H5E_CANTINIT,          <hid_t>
#cinline H5E_ALREADYINIT,       <hid_t>
#cinline H5E_CANTRELEASE,       <hid_t>

#cinline H5E_CANTGET,           <hid_t>
#cinline H5E_CANTSET,           <hid_t>
#cinline H5E_DUPCLASS,          <hid_t>

#cinline H5E_CANTMERGE,         <hid_t>
#cinline H5E_CANTREVIVE,        <hid_t>
#cinline H5E_CANTSHRINK,        <hid_t>

#cinline H5E_LINKCOUNT,         <hid_t>
#cinline H5E_VERSION,           <hid_t>
#cinline H5E_ALIGNMENT,         <hid_t>
#cinline H5E_BADMESG,           <hid_t>
#cinline H5E_CANTDELETE,        <hid_t>
#cinline H5E_BADITER,           <hid_t>
#cinline H5E_CANTPACK,          <hid_t>
#cinline H5E_CANTRESET,         <hid_t>
#cinline H5E_CANTRENAME,        <hid_t>

#cinline H5E_SYSERRSTR,         <hid_t>

#cinline H5E_NOFILTER,          <hid_t>
#cinline H5E_CALLBACK,          <hid_t>
#cinline H5E_CANAPPLY,          <hid_t>
#cinline H5E_SETLOCAL,          <hid_t>
#cinline H5E_NOENCODER,         <hid_t>
#cinline H5E_CANTFILTER,        <hid_t>

#cinline H5E_CANTOPENOBJ,       <hid_t>
#cinline H5E_CANTCLOSEOBJ,      <hid_t>
#cinline H5E_COMPLEN,           <hid_t>
#cinline H5E_PATH,              <hid_t>

#cinline H5E_NONE_MINOR,        <hid_t>

#cinline H5E_FILEEXISTS,        <hid_t>
#cinline H5E_FILEOPEN,          <hid_t>
#cinline H5E_CANTCREATE,        <hid_t>
#cinline H5E_CANTOPENFILE,      <hid_t>
#cinline H5E_CANTCLOSEFILE,     <hid_t>
#cinline H5E_NOTHDF5,           <hid_t>
#cinline H5E_BADFILE,           <hid_t>
#cinline H5E_TRUNCATED,         <hid_t>
#cinline H5E_MOUNT,             <hid_t>

#cinline H5E_BADATOM,           <hid_t>
#cinline H5E_BADGROUP,          <hid_t>
#cinline H5E_CANTREGISTER,      <hid_t>
#cinline H5E_CANTINC,           <hid_t>
#cinline H5E_CANTDEC,           <hid_t>
#cinline H5E_NOIDS,             <hid_t>

#cinline H5E_CANTFLUSH,         <hid_t>
#cinline H5E_CANTSERIALIZE,     <hid_t>
#cinline H5E_CANTLOAD,          <hid_t>
#cinline H5E_PROTECT,           <hid_t>
#cinline H5E_NOTCACHED,         <hid_t>
#cinline H5E_SYSTEM,            <hid_t>
#cinline H5E_CANTINS,           <hid_t>
#cinline H5E_CANTPROTECT,       <hid_t>
#cinline H5E_CANTUNPROTECT,     <hid_t>
#cinline H5E_CANTPIN,           <hid_t>
#cinline H5E_CANTUNPIN,         <hid_t>
#cinline H5E_CANTMARKDIRTY,     <hid_t>
#cinline H5E_CANTDIRTY,         <hid_t>
#cinline H5E_CANTEXPUNGE,       <hid_t>
#cinline H5E_CANTRESIZE,        <hid_t>

#cinline H5E_TRAVERSE,          <hid_t>
#cinline H5E_NLINKS,            <hid_t>
#cinline H5E_NOTREGISTERED,     <hid_t>
#cinline H5E_CANTMOVE,          <hid_t>
#cinline H5E_CANTSORT,          <hid_t>

#cinline H5E_MPI,               <hid_t>
#cinline H5E_MPIERRSTR,         <hid_t>
#cinline H5E_CANTRECV,          <hid_t>

#cinline H5E_CANTCLIP,          <hid_t>
#cinline H5E_CANTCOUNT,         <hid_t>
#cinline H5E_CANTSELECT,        <hid_t>
#cinline H5E_CANTNEXT,          <hid_t>
#cinline H5E_BADSELECT,         <hid_t>
#cinline H5E_CANTCOMPARE,       <hid_t>

#cinline H5E_UNINITIALIZED,     <hid_t>
#cinline H5E_UNSUPPORTED,       <hid_t>
#cinline H5E_BADTYPE,           <hid_t>
#cinline H5E_BADRANGE,          <hid_t>
#cinline H5E_BADVALUE,          <hid_t>

#cinline H5E_NOTFOUND,          <hid_t>
#cinline H5E_EXISTS,            <hid_t>
#cinline H5E_CANTENCODE,        <hid_t>
#cinline H5E_CANTDECODE,        <hid_t>
#cinline H5E_CANTSPLIT,         <hid_t>
#cinline H5E_CANTREDISTRIBUTE,  <hid_t>
#cinline H5E_CANTSWAP,          <hid_t>
#cinline H5E_CANTINSERT,        <hid_t>
#cinline H5E_CANTLIST,          <hid_t>
#cinline H5E_CANTMODIFY,        <hid_t>
#cinline H5E_CANTREMOVE,        <hid_t>

#cinline H5E_CANTCONVERT,       <hid_t>
#cinline H5E_BADSIZE,           <hid_t>

-- |This is not a standard HDF5 function or macro, but rather a wrapper
-- to the paired macros H5E_BEGIN_TRY and H5E_END_TRY, wrapping a simple action.
#cinline h5e_try,               FunPtr (IO (Ptr a)) -> IO (Ptr a)

-- /*
--  * Public API Convenience Macros for Error reporting - Documented
--  */
-- /* Use the Standard C __FILE__ & __LINE__ macros instead of typing them in */
-- #define H5Epush_sim(func, cls, maj, min, str) H5Epush2(H5E_DEFAULT, __FILE__, func, __LINE__, cls, maj, min, str)
-- 
-- /*
--  * Public API Convenience Macros for Error reporting - Undocumented
--  */
-- /* Use the Standard C __FILE__ & __LINE__ macros instead of typing them in */
-- /*  And return after pushing error onto stack */
-- #define H5Epush_ret(func, cls, maj, min, str, ret) {			      \
--     H5Epush2(H5E_DEFAULT, __FILE__, func, __LINE__, cls, maj, min, str);      \
--     return(ret);							      \
-- }
-- 
-- /* Use the Standard C __FILE__ & __LINE__ macros instead of typing them in
--  * And goto a label after pushing error onto stack.
--  */
-- #define H5Epush_goto(func, cls, maj, min, str, label) {			      \
--     H5Epush2(H5E_DEFAULT, __FILE__, func, __LINE__, cls, maj, min, str);      \
--     goto label;								      \
-- }
-- 
-- /* Error stack traversal direction */
#newtype H5E_direction_t
#newtype_const H5E_direction_t, H5E_WALK_UPWARD
#newtype_const H5E_direction_t, H5E_WALK_DOWNWARD

-- /* Error stack traversal callback function pointers */
-- typedef herr_t (*H5E_walk2_t)(unsigned n, const H5E_error2_t *err_desc,
--     void *client_data);
type H5E_walk2_t a = FunPtr (CUInt -> Ptr H5E_error2_t -> Ptr a -> IO HErr_t)

-- typedef herr_t (*H5E_auto2_t)(hid_t estack, void *client_data);
type H5E_auto2_t a = FunPtr (HId_t -> Ptr a -> IO HErr_t)

-- /* Public API functions */
-- hid_t  H5Eregister_class(const char *cls_name, const char *lib_name,
--     const char *version);
#ccall H5Eregister_class, CString -> CString -> CString -> IO <hid_t>

-- herr_t H5Eunregister_class(hid_t class_id);
#ccall H5Eunregister_class, <hid_t> -> IO <herr_t>

-- herr_t H5Eclose_msg(hid_t err_id);
#ccall H5Eclose_msg, <hid_t> -> IO <herr_t>

-- hid_t  H5Ecreate_msg(hid_t cls, H5E_type_t msg_type, const char *msg);
#ccall H5Ecreate_msg, <hid_t> -> H5E_type_t -> CString -> IO <hid_t>

-- hid_t  H5Ecreate_stack(void);
#ccall H5Ecreate_stack, IO <hid_t>

-- hid_t  H5Eget_current_stack(void);
#ccall H5Eget_current_stack, IO <hid_t>

-- herr_t H5Eclose_stack(hid_t stack_id);
#ccall H5Eclose_stack, <hid_t> -> IO <herr_t>

-- ssize_t H5Eget_class_name(hid_t class_id, char *name, size_t size);
#ccall H5Eget_class_name, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- herr_t H5Eset_current_stack(hid_t err_stack_id);
#ccall H5Eset_current_stack, <hid_t> -> IO <herr_t>

-- libffi to the rescue!  I have no idea how I'd wrap this without it, and there
-- doesn't appear to be a non-deprecated non-private non-varargs equivalent.
-- 
-- |herr_t H5Epush2(hid_t err_stack, const char *file, const char *func, unsigned line,
--     hid_t cls_id, hid_t maj_id, hid_t min_id, const char *msg, ...);
--
-- (msg is a printf format string, the varargs are the format parameters)
h5epush2 :: HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> [Arg] -> IO HErr_t
h5epush2 err_stack file func line cls_id maj_id min_id fmt [] =
    h5epush2_no_varargs err_stack file func line cls_id maj_id min_id fmt
h5epush2 (HId_t err_stack) file func line (HId_t cls_id) (HId_t maj_id) (HId_t min_id) fmt varargs =
    callFFI p_h5epush2 retHErr_t args
    where 
        argHId_t = arg#type hid_t
        retHErr_t = fmap HErr_t (ret#type herr_t)
        
        args = argHId_t err_stack : argPtr file : argPtr func : argCUInt line
             : argHId_t cls_id : argHId_t maj_id : argHId_t min_id : argPtr fmt
             : varargs

foreign import ccall "H5Epush2"
    h5epush2_no_varargs :: HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> IO HErr_t
foreign import ccall "&H5Epush2"
    p_h5epush2 :: FunPtr (HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> IO HErr_t)

-- herr_t H5Epop(hid_t err_stack, size_t count);
#ccall H5Epop, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Eprint2(hid_t err_stack, FILE *stream);
#ccall H5Eprint2, <hid_t> -> Ptr CFile -> IO <herr_t>

-- herr_t H5Ewalk2(hid_t err_stack, H5E_direction_t direction, H5E_walk2_t func,
--     void *client_data);
#ccall H5Ewalk2, <hid_t> -> <H5E_direction_t> -> H5E_walk2_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Eget_auto2(hid_t estack_id, H5E_auto2_t *func, void **client_data);
#ccall H5Eget_auto2, <hid_t> -> Out (H5E_auto2_t a) -> Out (Ptr a) -> IO <herr_t>

-- herr_t H5Eset_auto2(hid_t estack_id, H5E_auto2_t func, void *client_data);
#ccall H5Eset_auto2, <hid_t> -> H5E_auto2_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Eclear2(hid_t err_stack);
#ccall H5Eclear2, <hid_t> -> IO <herr_t>

-- herr_t H5Eauto_is_v2(hid_t err_stack, unsigned *is_stack);
#ccall H5Eauto_is_v2, <hid_t> -> Out CUInt -> IO <herr_t>

-- ssize_t H5Eget_msg(hid_t msg_id, H5E_type_t *type, char *msg,
--     size_t size);
#ccall H5Eget_msg, <hid_t> -> Out <H5E_type_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- ssize_t H5Eget_num(hid_t error_stack_id);
#ccall H5Eget_num, <hid_t> -> IO <ssize_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- /* Typedefs */
-- 
-- /* Alias major & minor error types to hid_t's, for compatibility with new
--  *      error API in v1.8
--  */
-- typedef hid_t   H5E_major_t;
-- typedef hid_t   H5E_minor_t;
#newtype H5E_major_t, Eq
#newtype H5E_minor_t, Eq

-- /* Information about an error element of error stack. */
#starttype H5E_error1_t
#field maj_num,    <H5E_major_t>
#field min_num,    <H5E_minor_t>
#field func_name,  CString
#field file_name,  CString
#field line,       CUInt
#field desc,       CString
#stoptype

-- /* Error stack traversal callback function pointers */
-- typedef herr_t (*H5E_walk1_t)(int n, H5E_error1_t *err_desc, void *client_data);
type H5E_walk1_t a = FunPtr (CInt -> In H5E_error1_t -> Ptr a -> IO HErr_t)

-- typedef herr_t (*H5E_auto1_t)(void *client_data);
type H5E_auto1_t a = FunPtr (Ptr a -> IO HErr_t)

-- /* Function prototypes */
-- herr_t H5Eclear1(void);
#ccall H5Eclear1, IO <herr_t>

-- herr_t H5Eget_auto1(H5E_auto1_t *func, void **client_data);
#ccall H5Eget_auto1, Out (H5E_auto1_t a) -> Out (Ptr a) -> IO <herr_t>

-- herr_t H5Epush1(const char *file, const char *func, unsigned line,
--     H5E_major_t maj, H5E_minor_t min, const char *str);
#ccall H5Epush1, CString -> CString -> CUInt -> <H5E_major_t> -> <H5E_minor_t> -> CString -> IO <herr_t>

-- herr_t H5Eprint1(FILE *stream);
#ccall H5Eprint1, Ptr CFile -> IO <herr_t>

-- herr_t H5Eset_auto1(H5E_auto1_t func, void *client_data);
#ccall H5Eset_auto1, H5E_auto1_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Ewalk1(H5E_direction_t direction, H5E_walk1_t func,
--     void *client_data);
#ccall H5Ewalk1, H5E_direction_t -> H5E_walk1_t a -> Ptr a -> IO <herr_t>

-- char *H5Eget_major(H5E_major_t maj);
#ccall H5Eget_major, <H5E_major_t> -> IO CString

-- char *H5Eget_minor(H5E_minor_t min);
#ccall H5Eget_minor, <H5E_minor_t> -> IO CString

#endif /* H5_NO_DEPRECATED_SYMBOLS */
