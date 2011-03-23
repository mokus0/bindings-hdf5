#include <bindings.h>
#include <H5Epublic.h>

module Bindings.HDF5.H5E where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign (nullPtr, nullFunPtr)
import Foreign.LibFFI
import Foreign.Ptr.Conventions

-- |Value for the default error stack
#newtype_const hid_t, H5E_DEFAULT

-- |Different kinds of error information
#newtype H5E_type_t
#newtype_const H5E_type_t, H5E_MAJOR
#newtype_const H5E_type_t, H5E_MINOR

-- |Information about an error; element of error stack
#starttype H5E_error2_t

-- | class ID
#field cls_id,       <hid_t>

-- | major error ID
#field maj_num,      <hid_t>

-- | minor error number
#field min_num,      <hid_t>

-- | line in file where error occurs
#field line,         CUInt

-- | function in which error occurred
#field func_name,    CString

-- | file in which error occurred
#field file_name,    CString

-- | optional supplied description
#field desc,         CString
#stoptype

-- |HDF5 error class
#cinline H5E_ERR_CLS,           <hid_t>

-- * Major error codes

-- |Dataset
#cinline H5E_DATASET,           <hid_t>

-- |Function entry/exit
#cinline H5E_FUNC,              <hid_t>

-- |Data storage
#cinline H5E_STORAGE,           <hid_t>

-- |File accessability
#cinline H5E_FILE,              <hid_t>

-- |Shared Object Header Messages
#cinline H5E_SOHM,              <hid_t>

-- |Symbol table
#cinline H5E_SYM,               <hid_t>

-- |Virtual File Layer
#cinline H5E_VFL,               <hid_t>

-- |Internal error (too specific to document in detail)
#cinline H5E_INTERNAL,          <hid_t>

-- |B-Tree node
#cinline H5E_BTREE,             <hid_t>

-- |References
#cinline H5E_REFERENCE,         <hid_t>

-- |Dataspace
#cinline H5E_DATASPACE,         <hid_t>

-- |Resource unavailable
#cinline H5E_RESOURCE,          <hid_t>

-- |Property lists
#cinline H5E_PLIST,             <hid_t>

-- |Links
#cinline H5E_LINK,              <hid_t>

-- |Datatype
#cinline H5E_DATATYPE,          <hid_t>

-- |Reference Counted Strings
#cinline H5E_RS,                <hid_t>

-- |Heap
#cinline H5E_HEAP,              <hid_t>

-- |Object header
#cinline H5E_OHDR,              <hid_t>

-- |Object atom
#cinline H5E_ATOM,              <hid_t>

-- |Attribute
#cinline H5E_ATTR,              <hid_t>

-- |No error
#cinline H5E_NONE_MAJOR,        <hid_t>

-- |Low-level I/O
#cinline H5E_IO,                <hid_t>

-- |Skip Lists
#cinline H5E_SLIST,             <hid_t>

-- |External file list
#cinline H5E_EFL,               <hid_t>

-- |Ternary Search Trees
#cinline H5E_TST,               <hid_t>

-- |Invalid arguments to routine
#cinline H5E_ARGS,              <hid_t>

-- |Error API
#cinline H5E_ERROR,             <hid_t>

-- |Data filters
#cinline H5E_PLINE,             <hid_t>

-- |Free Space Manager
#cinline H5E_FSPACE,            <hid_t>

-- |Object cache
#cinline H5E_CACHE,             <hid_t>

-- * Minor error codes

-- ** Generic low-level file I/O errors

-- |Seek failed
#cinline H5E_SEEKERROR,         <hid_t>

-- |Read failed
#cinline H5E_READERROR,         <hid_t>

-- |Write failed
#cinline H5E_WRITEERROR,        <hid_t>

-- |Close failed
#cinline H5E_CLOSEERROR,        <hid_t>

-- |Address overflowed
#cinline H5E_OVERFLOW,          <hid_t>

-- |File control (fcntl) failed
#cinline H5E_FCNTL,             <hid_t>

-- ** Resource errors

-- |No space available for allocation
#cinline H5E_NOSPACE,           <hid_t>

-- |Can't allocate space
#cinline H5E_CANTALLOC,         <hid_t>

-- |Unable to copy object
#cinline H5E_CANTCOPY,          <hid_t>

-- |Unable to free object
#cinline H5E_CANTFREE,          <hid_t>

-- |Object already exists
#cinline H5E_ALREADYEXISTS,     <hid_t>

-- |Unable to lock object
#cinline H5E_CANTLOCK,          <hid_t>

-- |Unable to unlock object
#cinline H5E_CANTUNLOCK,        <hid_t>

-- |Unable to garbage collect
#cinline H5E_CANTGC,            <hid_t>

-- |Unable to compute size
#cinline H5E_CANTGETSIZE,       <hid_t>

-- |Object is already open
#cinline H5E_OBJOPEN,           <hid_t>

-- ** Heap errors
#cinline H5E_CANTRESTORE,       <hid_t>
#cinline H5E_CANTCOMPUTE,       <hid_t>
#cinline H5E_CANTEXTEND,        <hid_t>
#cinline H5E_CANTATTACH,        <hid_t>
#cinline H5E_CANTUPDATE,        <hid_t>
#cinline H5E_CANTOPERATE,       <hid_t>

-- ** Function entry/exit interface errors
#cinline H5E_CANTINIT,          <hid_t>
#cinline H5E_ALREADYINIT,       <hid_t>
#cinline H5E_CANTRELEASE,       <hid_t>

-- ** Property list errors
#cinline H5E_CANTGET,           <hid_t>
#cinline H5E_CANTSET,           <hid_t>
#cinline H5E_DUPCLASS,          <hid_t>

-- ** Free space errors
#cinline H5E_CANTMERGE,         <hid_t>
#cinline H5E_CANTREVIVE,        <hid_t>
#cinline H5E_CANTSHRINK,        <hid_t>

-- ** Object header related errors
#cinline H5E_LINKCOUNT,         <hid_t>
#cinline H5E_VERSION,           <hid_t>
#cinline H5E_ALIGNMENT,         <hid_t>
#cinline H5E_BADMESG,           <hid_t>
#cinline H5E_CANTDELETE,        <hid_t>
#cinline H5E_BADITER,           <hid_t>
#cinline H5E_CANTPACK,          <hid_t>
#cinline H5E_CANTRESET,         <hid_t>
#cinline H5E_CANTRENAME,        <hid_t>

-- ** System level errors
#cinline H5E_SYSERRSTR,         <hid_t>

-- ** I/O pipeline errors
#cinline H5E_NOFILTER,          <hid_t>
#cinline H5E_CALLBACK,          <hid_t>
#cinline H5E_CANAPPLY,          <hid_t>
#cinline H5E_SETLOCAL,          <hid_t>
#cinline H5E_NOENCODER,         <hid_t>
#cinline H5E_CANTFILTER,        <hid_t>

-- ** Group related errors
#cinline H5E_CANTOPENOBJ,       <hid_t>
#cinline H5E_CANTCLOSEOBJ,      <hid_t>
#cinline H5E_COMPLEN,           <hid_t>
#cinline H5E_PATH,              <hid_t>

-- ** No error
#cinline H5E_NONE_MINOR,        <hid_t>

-- ** File accessability errors
#cinline H5E_FILEEXISTS,        <hid_t>
#cinline H5E_FILEOPEN,          <hid_t>
#cinline H5E_CANTCREATE,        <hid_t>
#cinline H5E_CANTOPENFILE,      <hid_t>
#cinline H5E_CANTCLOSEFILE,     <hid_t>
#cinline H5E_NOTHDF5,           <hid_t>
#cinline H5E_BADFILE,           <hid_t>
#cinline H5E_TRUNCATED,         <hid_t>
#cinline H5E_MOUNT,             <hid_t>

-- ** Object atom related errors
#cinline H5E_BADATOM,           <hid_t>
#cinline H5E_BADGROUP,          <hid_t>
#cinline H5E_CANTREGISTER,      <hid_t>
#cinline H5E_CANTINC,           <hid_t>
#cinline H5E_CANTDEC,           <hid_t>
#cinline H5E_NOIDS,             <hid_t>

-- ** Cache related errors
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

-- ** Link related errors
#cinline H5E_TRAVERSE,          <hid_t>
#cinline H5E_NLINKS,            <hid_t>
#cinline H5E_NOTREGISTERED,     <hid_t>
#cinline H5E_CANTMOVE,          <hid_t>
#cinline H5E_CANTSORT,          <hid_t>

-- ** Parallel MPI errors
#cinline H5E_MPI,               <hid_t>
#cinline H5E_MPIERRSTR,         <hid_t>
#cinline H5E_CANTRECV,          <hid_t>

-- ** Dataspace errors
#cinline H5E_CANTCLIP,          <hid_t>
#cinline H5E_CANTCOUNT,         <hid_t>
#cinline H5E_CANTSELECT,        <hid_t>
#cinline H5E_CANTNEXT,          <hid_t>
#cinline H5E_BADSELECT,         <hid_t>
#cinline H5E_CANTCOMPARE,       <hid_t>

-- ** Argument errors
#cinline H5E_UNINITIALIZED,     <hid_t>
#cinline H5E_UNSUPPORTED,       <hid_t>
#cinline H5E_BADTYPE,           <hid_t>
#cinline H5E_BADRANGE,          <hid_t>
#cinline H5E_BADVALUE,          <hid_t>

-- ** B-tree related errors
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

-- ** Datatype conversion errors
#cinline H5E_CANTCONVERT,       <hid_t>
#cinline H5E_BADSIZE,           <hid_t>

newtype H5E_TRY_STATE 
    = H5E_TRY_STATE (Either (H5E_auto1_t ()) (H5E_auto2_t ()), InOut ())

h5e_BEGIN_TRY :: IO H5E_TRY_STATE
h5e_BEGIN_TRY = do
    isV2 <- alloca $ \isV2 -> do
        h5e_auto_is_v2 h5e_DEFAULT (Out isV2)
        peek isV2
    
    alloca $ \cdata -> if isV2 /= 0
        then alloca $ \func -> do
            h5e_get_auto2 h5e_DEFAULT (Out func) (Out cdata)
            h5e_set_auto2 h5e_DEFAULT nullFunPtr (InOut nullPtr)
            
            func <- peek func
            cdata <- peek cdata
            return (H5E_TRY_STATE (Right func, cdata))
        else alloca $ \func -> do
            h5e_get_auto1 (Out func) (Out cdata)
            h5e_set_auto1 nullFunPtr (InOut nullPtr)
            
            func <- peek func
            cdata <- peek cdata
            return (H5E_TRY_STATE (Left func, cdata))

h5e_END_TRY :: H5E_TRY_STATE -> IO HErr_t
h5e_END_TRY (H5E_TRY_STATE (Right func, cdata)) = h5e_set_auto2 h5e_DEFAULT func cdata
h5e_END_TRY (H5E_TRY_STATE (Left  func, cdata)) = h5e_set_auto1 func cdata

-- |This is not a standard HDF5 function or macro, but rather a wrapper
-- to the paired macros H5E_BEGIN_TRY and H5E_END_TRY, wrapping a simple action.
h5e_try :: IO a -> IO a
h5e_try action = do
    tryState <- h5e_BEGIN_TRY
    result <- action
    h5e_END_TRY tryState
    return result

-- TODO: wrap these up in an exported header file (something like "Bindings.HDF5.H5E.h") as macros for use in haskell code, or maybe as TH macros
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

-- |Error stack traversal direction
#newtype H5E_direction_t

-- |begin deep, end at API function
#newtype_const H5E_direction_t, H5E_WALK_UPWARD

-- |begin at API function, end deep
#newtype_const H5E_direction_t, H5E_WALK_DOWNWARD

-- * Error stack traversal callback function types

-- |Callback type for 'h5e_walk2'
-- 
-- > typedef herr_t (*H5E_walk2_t)(unsigned n, const H5E_error2_t *err_desc,
-- >     void *client_data);
type H5E_walk2_t a = FunPtr (CUInt -> In H5E_error2_t -> InOut a -> IO HErr_t)

-- |Callback type for 'h5e_set_auto2'
-- 
-- > typedef herr_t (*H5E_auto2_t)(hid_t estack, void *client_data);
type H5E_auto2_t a = FunPtr (HId_t -> InOut a -> IO HErr_t)

-- * Public API functions

-- |Registers an error class.
--
-- Returns non-negative value as class ID on success / negative on failure
-- 
-- > hid_t  H5Eregister_class(const char *cls_name, const char *lib_name,
-- >     const char *version);
#ccall H5Eregister_class, CString -> CString -> CString -> IO <hid_t>

-- |Closes an error class.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Eunregister_class(hid_t class_id);
#ccall H5Eunregister_class, <hid_t> -> IO <herr_t>

-- |Closes a major or minor error.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Eclose_msg(hid_t err_id);
#ccall H5Eclose_msg, <hid_t> -> IO <herr_t>

-- |Creates a major or minor error, returns an ID.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > hid_t  H5Ecreate_msg(hid_t cls, H5E_type_t msg_type, const char *msg);
#ccall H5Ecreate_msg, <hid_t> -> H5E_type_t -> CString -> IO <hid_t>

-- |Creates a new, empty, error stack.
-- 
-- Returns non-negative value as stack ID on success / negative on failure
-- 
-- > hid_t  H5Ecreate_stack(void);
#ccall H5Ecreate_stack, IO <hid_t>

-- |Registers current error stack, returns object handle for it, clears it.
--
-- Returns non-negative value as stack ID on success / negative on failure
--
-- > hid_t  H5Eget_current_stack(void);
#ccall H5Eget_current_stack, IO <hid_t>

-- |Closes an error stack.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Eclose_stack(hid_t stack_id);
#ccall H5Eclose_stack, <hid_t> -> IO <herr_t>

-- |Retrieves error class name.
--
-- Returns non-negative for name length if succeeds(zero means no name);
-- otherwise returns negative value.
--
-- On successful return, 'name' will always be zero-terminated.  
-- 
-- NB: The return value is the length of the name, not the length copied
-- to the buffer.
-- 
-- > ssize_t H5Eget_class_name(hid_t class_id, char *name, size_t size);
#ccall H5Eget_class_name, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Replaces current stack with specified stack.  This closes the
-- stack ID also.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Eset_current_stack(hid_t err_stack_id);
#ccall H5Eset_current_stack, <hid_t> -> IO <herr_t>

-- libffi to the rescue!  I have no idea how I'd wrap this without it, and there
-- doesn't appear to be a non-deprecated non-private non-varargs equivalent.
-- 
-- |Pushes a new error record onto error stack for the current
-- thread.  The error has major and minor IDs 'maj_id' and
-- 'min_id', the name of a function where the error was detected,
-- the name of the file where the error was detected, the
-- line within that file, and an error description string.  The
-- function name, file name, and error description strings must
-- be statically allocated.
-- 
-- Returns non-negative on success/Negative on failure.
-- 
-- > herr_t H5Epush2(hid_t err_stack, const char *file, const char *func, unsigned line,
-- >     hid_t cls_id, hid_t maj_id, hid_t min_id, const char *msg, ...);
--
-- (msg is a printf format string, the varargs are the format parameters)
h5e_push2 :: HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> [Arg] -> IO HErr_t
h5e_push2 err_stack file func line cls_id maj_id min_id fmt [] =
    h5e_push2_no_varargs err_stack file func line cls_id maj_id min_id fmt
h5e_push2 (HId_t err_stack) file func line (HId_t cls_id) (HId_t maj_id) (HId_t min_id) fmt varargs =
    callFFI p_H5Epush2 retHErr_t args
    where 
        argHId_t = arg#type hid_t
        retHErr_t = fmap HErr_t (ret#type herr_t)
        
        args = argHId_t err_stack : argPtr file : argPtr func : argCUInt line
             : argHId_t cls_id : argHId_t maj_id : argHId_t min_id : argPtr fmt
             : varargs

foreign import ccall "H5Epush2"
    h5e_push2_no_varargs :: HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> IO HErr_t
foreign import ccall "&H5Epush2"
    p_H5Epush2 :: FunPtr (HId_t -> CString -> CString -> CUInt -> HId_t -> HId_t -> HId_t -> CString -> IO HErr_t)

-- |Deletes some error messages from the top of error stack.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Epop(hid_t err_stack, size_t count);
#ccall H5Epop, <hid_t> -> <size_t> -> IO <herr_t>

-- |Prints the error stack in some default way.  This is just a
-- convenience function for 'h5e_walk' with a function that
-- prints error messages.  Users are encouraged to write their
-- own more specific error handlers.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Eprint2(hid_t err_stack, FILE *stream);
#ccall H5Eprint2, <hid_t> -> InOut CFile -> IO <herr_t>

-- |Walks the error stack for the current thread and calls some
-- function for each error along the way.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Ewalk2(hid_t err_stack, H5E_direction_t direction, H5E_walk2_t func,
-- >     void *client_data);
#ccall H5Ewalk2, <hid_t> -> <H5E_direction_t> -> H5E_walk2_t a -> InOut a -> IO <herr_t>

-- |Returns the current settings for the automatic error stack
-- traversal function and its data for specific error stack.
-- Either (or both) arguments may be null in which case the
-- value is not returned.
--
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Eget_auto2(hid_t estack_id, H5E_auto2_t *func, void **client_data);
-- 
-- NB: the @a@ type here should be existentially quantified, not universally, but
-- Haskell doesn't have a convenient way to say so in a foreign import.
#ccall H5Eget_auto2, <hid_t> -> Out (H5E_auto2_t a) -> Out (InOut a) -> IO <herr_t>

-- |Turns on or off automatic printing of errors for certain
-- error stack.  When turned on (non-null 'func' pointer) any
-- API function which returns an error indication will first
-- call 'func' passing it 'client_data' as an argument.
--
-- The default values before this function is called are
-- 'h5e_print2' with client data being the standard error stream,
-- 'stderr'.
--
-- Automatic stack traversal is always in the 'h5e_WALK_DOWNWARD'
-- direction.
--
-- > herr_t H5Eset_auto2(hid_t estack_id, H5E_auto2_t func, void *client_data);
#ccall H5Eset_auto2, <hid_t> -> H5E_auto2_t a -> InOut a -> IO <herr_t>

-- |Clears the error stack for the specified error stack.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > herr_t H5Eclear2(hid_t err_stack);
#ccall H5Eclear2, <hid_t> -> IO <herr_t>

-- TODO: I think the type names mentioned here are wrong.  Sort them out.
-- |Determines if the error auto reporting function for an
-- error stack conforms to the 'H5E_auto_stack_t' typedef
-- or the 'H5E_auto_t' typedef.  The 'is_stack' parameter is set
-- to 1 for the first case and 0 for the latter case.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Eauto_is_v2(hid_t err_stack, unsigned *is_stack);
#ccall H5Eauto_is_v2, <hid_t> -> Out CUInt -> IO <herr_t>

-- |Retrieves an error message.
--
-- Returns non-negative for message length if succeeds(zero means no message);
-- otherwise returns negative value.
--
-- > ssize_t H5Eget_msg(hid_t msg_id, H5E_type_t *type, char *msg,
-- >     size_t size);
#ccall H5Eget_msg, <hid_t> -> Out <H5E_type_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- |Retrieves the number of error message.
-- 
-- Returns non-negative value on success / negative on failure
-- 
-- > ssize_t H5Eget_num(hid_t error_stack_id);
#ccall H5Eget_num, <hid_t> -> IO <ssize_t>

#ifndef H5_NO_DEPRECATED_SYMBOLS

-- * Deprecated symbols

#newtype H5E_major_t, Eq
#newtype H5E_minor_t, Eq

-- | Information about an error element of error stack
#starttype H5E_error1_t

-- |major error number
#field maj_num,    <H5E_major_t>

-- |minor error number
#field min_num,    <H5E_minor_t>

-- |function in which error occurred
#field func_name,  CString

-- |file in which error occurred
#field file_name,  CString

-- |line in file where error occurs
#field line,       CUInt

-- |optional supplied description
#field desc,       CString
#stoptype


-- | Callback type for 'h5e_walk1'
-- 
-- > typedef herr_t (*H5E_walk1_t)(int n, H5E_error1_t *err_desc, void *client_data);
type H5E_walk1_t a = FunPtr (CInt -> In H5E_error1_t -> Ptr a -> IO HErr_t)

-- | Callback type for 'h5e_set_auto1'
-- 
-- > typedef herr_t (*H5E_auto1_t)(void *client_data);
type H5E_auto1_t a = FunPtr (InOut a -> IO HErr_t)

-- ** Function prototypes

-- |This function is for backward compatbility.
-- Clears the error stack for the specified error stack.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Eclear1(void);
#ccall H5Eclear1, IO <herr_t>

-- |This function is for backward compatbility.
-- Returns the current settings for the automatic error stack
-- traversal function and its data for specific error stack.
-- Either (or both) arguments may be null in which case the
-- value is not returned.
--
-- Returns non-negative on success / negative on failure
--
-- > herr_t H5Eget_auto1(H5E_auto1_t *func, void **client_data);
-- 
-- NB: the @a@ type here should be existentially quantified, not universally, but
-- Haskell doesn't have a convenient way to say so in a foreign import.
#ccall H5Eget_auto1, Out (H5E_auto1_t a) -> Out (InOut a) -> IO <herr_t>

-- |This function definition is for backward compatibility only.
-- It doesn't have error stack and error class as parameters.
-- The old definition of major and minor is casted as HID_T
-- in H5Epublic.h
--
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Epush1(const char *file, const char *func, unsigned line,
-- >     H5E_major_t maj, H5E_minor_t min, const char *str);
#ccall H5Epush1, CString -> CString -> CUInt -> <H5E_major_t> -> <H5E_minor_t> -> CString -> IO <herr_t>

-- |This function is for backward compatbility.
-- Prints the error stack in some default way.  This is just a
-- convenience function for 'h5e_walk1' with a function that
-- prints error messages.  Users are encouraged to write there
-- own more specific error handlers.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Eprint1(FILE *stream);
-- 
-- NB: The first parameter is declared as 'InOut' to match 'H5E_auto1_t', 
-- but I'm quite sure it never modifies the passed value.
#ccall H5Eprint1, InOut CFile -> IO <herr_t>

-- |This function is for backward compatbility.
-- Turns on or off automatic printing of errors for certain
-- error stack.  When turned on (non-null 'func' pointer) any
-- API function which returns an error indication will first
-- call 'func' passing it 'client_data' as an argument.
-- 
-- The default values before this function is called are
-- 'h5e_print1' with client data being the standard error stream,
-- 'stderr'.
-- 
-- Automatic stack traversal is always in the 'h5e_WALK_DOWNWARD'
-- direction.
-- 
-- Returns non-negative on success / negative on failure
--
-- > herr_t H5Eset_auto1(H5E_auto1_t func, void *client_data);
#ccall H5Eset_auto1, H5E_auto1_t a -> InOut a -> IO <herr_t>

-- |This function is for backward compatbility.
-- Walks the error stack for the current thread and calls some
-- function for each error along the way.
-- 
-- Returns non-negative on success / negative on failure
-- 
-- > herr_t H5Ewalk1(H5E_direction_t direction, H5E_walk1_t func,
-- >     void *client_data);
#ccall H5Ewalk1, H5E_direction_t -> H5E_walk1_t a -> InOut a -> IO <herr_t>

-- |Retrieves a major error message.
--
-- Returns message if succeeds, otherwise returns NULL.
-- 
-- > char *H5Eget_major(H5E_major_t maj);
#ccall H5Eget_major, <H5E_major_t> -> IO CString

-- |Retrieves a minor error message.
-- 
-- Returns message if succeeds, otherwise returns NULL.
-- 
-- > char *H5Eget_minor(H5E_minor_t min);
#ccall H5Eget_minor, <H5E_minor_t> -> IO CString

#endif /* H5_NO_DEPRECATED_SYMBOLS */
