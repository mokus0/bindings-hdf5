#include <bindings.h>
#include <H5public.h>

module Bindings.HDF5.H5 where
#strict_import

import Data.Version
import Foreign.Ptr.Conventions

-- *Version numbers

-- |For major interface/format changes
#num H5_VERS_MAJOR

-- |For minor interface/format changes
#num H5_VERS_MINOR

-- |For tweaks, bug-fixes, or development
#num H5_VERS_RELEASE

-- |For pre-releases like snap0
#str H5_VERS_SUBRELEASE

-- |'h5_VERS_MAJOR', et al., wrapped up as a 'Version'
vers :: Version
vers = Version
    [ h5_VERS_MAJOR
    , h5_VERS_MINOR
    , h5_VERS_RELEASE 
    ]
    (filter (not.null) [ h5_VERS_SUBRELEASE ])

-- |Full version string
#str H5_VERS_INFO

-- |Check that the HDF5 library that is linked with the current executable is
-- the same version that these bindings were compiled against.  Returns 0 on
-- success, calls abort() on failure.
#cinline H5check, <herr_t>

-- * Types and constants

-- |Status return values.  Failed integer functions in HDF5 result almost
-- always in a negative value (unsigned failing functions sometimes return
-- zero for failure) while successfull return is non-negative (often zero).
-- The negative failure value is most commonly -1, but don't bet on it.  The
-- proper way to detect failure is something like:
--
-- @
-- if((dset = H5Dopen2(file, name)) < 0)
--    fprintf(stderr, "unable to open the requested dataset\n");
-- @
#newtype herr_t, Eq, Ord, Num, Real, Enum, Integral

-- |Boolean type.  Successful return values are zero (false) or positive
-- (true). The typical true value is 1 but don't bet on it.  Boolean
-- functions cannot fail.  Functions that return `htri_t' however return zero
-- (false), positive (true), or negative (failure). The proper way to test
-- for truth from a htri_t function is:
--
-- @
--  if ((retval = H5Tcommitted(type))>0) {
--    printf("data type is committed\n");
--  } else if (!retval) {
--    printf("data type is not committed\n");
--  } else {
--    printf("error determining whether data type is committed\n");
--  }
-- @
#newtype hbool_t

instance Eq HBool_t where
    HBool_t x == HBool_t y
        = (x /= 0) == (y /= 0)

#newtype htri_t

instance Eq HTri_t where
    HTri_t x == HTri_t y
        = compare x 0 == compare y 0

-- |C signed size type.  This is a semi-standard POSIX type that isn't in
-- the "Foreign.C.Types" module.  It is in "System.Posix.Types", but I'm not 
-- sure whether that module is available on all platforms.
#newtype ssize_t, Eq, Ord

h5_SIZEOF_SSIZE_T :: CSize
h5_SIZEOF_SSIZE_T = #const H5_SIZEOF_SSIZE_T

#newtype hsize_t, Eq, Ord
#newtype hssize_t, Eq, Ord

h5_SIZEOF_HSIZE_T, h5_SIZEOF_HSSIZE_T :: CSize
h5_SIZEOF_HSIZE_T  = #const H5_SIZEOF_HSIZE_T
h5_SIZEOF_HSSIZE_T = #const H5_SIZEOF_HSSIZE_T

#newtype haddr_t, Eq, Ord

hADDR_UNDEF :: HAddr_t
hADDR_UNDEF = HAddr_t (#const HADDR_UNDEF)

h5_SIZEOF_HADDR_T :: CSize
h5_SIZEOF_HADDR_T = #const H5_SIZEOF_HADDR_T

#str H5_PRINTF_HADDR_FMT

hADDR_MAX :: HAddr_t
hADDR_MAX = HAddr_t (#const HADDR_MAX)

-- |Common iteration orders
#newtype H5_iter_order_t

-- |Unknown order
#newtype_const H5_iter_order_t, H5_ITER_UNKNOWN

-- |Increasing order
#newtype_const H5_iter_order_t, H5_ITER_INC

-- |Decreasing order
#newtype_const H5_iter_order_t, H5_ITER_DEC

-- |No particular order, whatever is fastest
#newtype_const H5_iter_order_t, H5_ITER_NATIVE

-- |Number of iteration orders
#num H5_ITER_N

-- |Iteration callback return value indicating that iteration should stop 
-- and report an error.
#newtype_const herr_t, H5_ITER_ERROR

-- |Iteration callback return value indicating that iteration should continue.
#newtype_const herr_t, H5_ITER_CONT

-- |Iteration callback return value indicating that iteration should stop 
-- without error.
-- 
-- Actually, any postive value will cause the iterator to stop and pass back
-- that positive value to the function that called the iterator
#newtype_const herr_t, H5_ITER_STOP

-- |The types of indices on links in groups/attributes on objects.
-- Primarily used for \"\<do\> \<foo\> by index\" routines and for iterating over
-- links in groups/attributes on objects.
#newtype H5_index_t

-- |Unknown index type
#newtype_const H5_index_t, H5_INDEX_UNKNOWN

-- |Index on names
#newtype_const H5_index_t, H5_INDEX_NAME

-- |Index on creation order
#newtype_const H5_index_t, H5_INDEX_CRT_ORDER

-- |Number of indices defined
#num H5_INDEX_N

-- |Storage info struct used by 'H5O_info_t' and 'H5F_info_t'
#starttype H5_ih_info_t
#field index_size , <hsize_t>
#field heap_size  , <hsize_t>
#stoptype

-- *Functions in H5.c

-- |Initialize the library.  This is normally called automatically, but if you
-- find that an HDF5 library function is failing inexplicably, then try 
-- calling this function first.
--
-- Return: Non-negative on success/Negative on failure
-- 
-- > herr_t H5open(void);
#ccall H5open                   , IO <herr_t>

-- |Terminate the library and release all resources.
--
-- Return: Non-negative on success/Negative on failure
-- 
-- > herr_t H5close(void);
#ccall H5close                  , IO <herr_t>

-- |Indicates that the library is not to clean up after itself
-- when the application exits by calling exit() or returning
-- from main().  This function must be called before any other
-- HDF5 function or constant is used or it will have no effect.
-- 
-- If this function is used then certain memory buffers will not
-- be de-allocated nor will open files be flushed automatically.
-- The application may still call H5close() explicitly to
-- accomplish these things.
--
-- Return:  non-negative on success, 
--          negative if this function is called more than
--          once or if it is called too late.
-- 
-- > herr_t H5dont_atexit(void);
#ccall H5dont_atexit            , IO <herr_t>

-- |Walks through all the garbage collection routines for the
-- library, which are supposed to free any unused memory they have
-- allocated.
--
-- These should probably be registered dynamicly in a linked list of
-- functions to call, but there aren't that many right now, so we
-- hard-wire them...
-- 
-- Return: non-negative on success, negative on failure
--
-- > herr_t H5garbage_collect(void);
#ccall H5garbage_collect        , IO <herr_t>

-- |Sets limits on the different kinds of free lists.  Setting a value
-- of -1 for a limit means no limit of that type.  These limits are global
-- for the entire library.  Each \"global\" limit only applies to free lists
-- of that type, so if an application sets a limit of 1 MB on each of the
-- global lists, up to 3 MB of total storage might be allocated (1MB on
-- each of regular, array and block type lists).
-- 
-- The settings for block free lists are duplicated to factory free lists.
-- Factory free list limits cannot be set independently currently.
--
-- Parameters:
-- 
-- [@ reg_global_lim :: CInt @]  The limit on all \"regular\" free list memory used
-- 
-- [@ reg_list_lim   :: CInt @]  The limit on memory used in each \"regular\" free list
-- 
-- [@ arr_global_lim :: CInt @]  The limit on all \"array\" free list memory used
-- 
-- [@ arr_list_lim   :: CInt @]  The limit on memory used in each \"array\" free list
-- 
-- [@ blk_global_lim :: CInt @]  The limit on all \"block\" free list memory used
-- 
-- [@ blk_list_lim   :: CInt @]  The limit on memory used in each \"block\" free list
--
-- Return: non-negative on success, negative on failure
--
-- > herr_t H5set_free_list_limits (int reg_global_lim, int reg_list_lim,
-- >         int arr_global_lim, int arr_list_lim, int blk_global_lim,
-- >         int blk_list_lim);
#ccall H5set_free_list_limits   , CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> IO <herr_t>

-- |Returns the library version numbers through arguments. MAJNUM
-- will be the major revision number of the library, MINNUM the
-- minor revision number, and RELNUM the release revision number.
--
-- Note: When printing an HDF5 version number it should be printed as
--
-- > printf("%u.%u.%u", maj, min, rel)		or
-- > printf("version %u.%u release %u", maj, min, rel)
--
-- Return:	Non-negative on success/Negative on failure
--
-- > herr_t H5get_libversion(unsigned *majnum, unsigned *minnum,
-- >         unsigned *relnum);
#ccall H5get_libversion         , Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- |Purpose:	Verifies that the arguments match the version numbers
-- compiled into the library.  This function is intended to be
-- called from user to verify that the versions of header files
-- compiled into the application match the version of the hdf5
-- library.
--
-- Return: Success: 0, Failure: calls abort()
-- 
-- > herr_t H5check_version(unsigned majnum, unsigned minnum,
-- >         unsigned relnum);
#ccall H5check_version          , CUInt -> CUInt -> CUInt -> IO <herr_t>
