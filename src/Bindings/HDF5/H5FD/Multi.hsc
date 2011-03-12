#include <bindings.h>
#include <H5FDcore.h>

-- |H5FDmulti Implements a file driver which dispatches I/O requests to
-- other file drivers depending on the purpose of the address
-- region being accessed. For instance, all meta-data could be
-- placed in one file while all raw data goes to some other file.
module Bindings.HDF5.H5FD.Multi where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I
import Bindings.HDF5.H5P
import Bindings.HDF5.H5F
import Bindings.HDF5.H5FD

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_MULTI"
    = unsafePerformIO (#mangle_ident "H5FD_multi_init")

-- |Initialize this driver by registering the driver with the library.
-- 
-- On success, returns the driver ID for the multi driver.  On failure,
-- returns a negative value.
--
-- > hid_t H5FD_multi_init(void);
#ccall H5FD_multi_init, IO <hid_t>

-- Shut down the VFD
-- 
-- > void H5FD_multi_term(void);
#ccall H5FD_multi_term, IO ()

-- TODO: find out whether input arrays need to be static... Probably not, since H5Pget_fapl_multi copies them out.
-- |Sets the file access property list 'fapl_id' to use the multi
-- driver. The 'memb_map' array maps memory usage types to other
-- memory usage types and is the mechanism which allows the
-- caller to specify how many files are created. The array
-- contains 'h5fd_MEM_NTYPES' entries which are either the value
-- 'h5fd_MEM_DEFAULT' or a memory usage type and the number of
-- unique values determines the number of files which are
-- opened.  For each memory usage type which will be associated
-- with a file the 'memb_fapl' array should have a property list
-- and the 'memb_name' array should be a name generator (a
-- printf-style format with a %s which will be replaced with the
-- name passed to 'h5fd_open', usually from 'h5f_create' or
-- 'h5f_open').
-- 
-- If 'relax' is set then opening an existing file for read-only
-- access will not fail if some file members are missing.  This
-- allows a file to be accessed in a limited sense if just the
-- meta data is available.
--
-- Default values for each of the optional arguments are:
--
-- ['memb_map'] 
--      The default member map has the value
--      'h5fd_MEM_DEFAULT' for each element.
-- 
-- ['memb_fapl']
--      The value 'h5p_DEFAULT' for each element.
-- 
-- ['memb_name']
--      The string \"%s-X.h5\" where \"X\" is one of the
--         letters \"s\" ('h5fd_MEM_SUPER'),
--         \"b\" ('h5fd_MEM_BTREE'), \"r\" ('h5fd_MEM_DRAW'),
--         \"g\" ('h5fd_MEM_GHEAP'), \"l\" ('h5fd_MEM_LHEAP'),
--         \"o\" ('h5fd_MEM_OHDR').
-- 
-- ['memb_addr']  
--      The value 'hADDR_UNDEF' for each element.
-- 
--
-- Example: To set up a multi file access property list which partitions
-- data into meta and raw files each being 1/2 of the address
-- space one would say (TODO: translate to Haskell):
-- 
-- > H5FD_mem_t mt, memb_map[H5FD_MEM_NTYPES];
-- > hid_t memb_fapl[H5FD_MEM_NTYPES];
-- > const char *memb[H5FD_MEM_NTYPES];
-- > haddr_t memb_addr[H5FD_MEM_NTYPES];
-- > 
-- > // The mapping...
-- > for (mt=0; mt<H5FD_MEM_NTYPES; mt++) {
-- >     memb_map[mt] = H5FD_MEM_SUPER;
-- > }
-- > memb_map[H5FD_MEM_DRAW] = H5FD_MEM_DRAW;
-- > 
-- > // Member information
-- > memb_fapl[H5FD_MEM_SUPER] = H5P_DEFAULT;
-- > memb_name[H5FD_MEM_SUPER] = "%s.meta";
-- > memb_addr[H5FD_MEM_SUPER] = 0;
-- > 
-- > memb_fapl[H5FD_MEM_DRAW] = H5P_DEFAULT;
-- > memb_name[H5FD_MEM_DRAW] = "%s.raw";
-- > memb_addr[H5FD_MEM_DRAW] = HADDR_MAX/2;
-- > 
-- > hid_t fapl = H5Pcreate(H5P_FILE_ACCESS);
-- > H5Pset_fapl_multi(fapl, memb_map, memb_fapl,
-- >                   memb_name, memb_addr, TRUE);
-- 
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_fapl_multi(hid_t fapl_id, const H5FD_mem_t *memb_map,
-- >        const hid_t *memb_fapl, const char * const *memb_name,
-- >        const haddr_t *memb_addr, hbool_t relax);
#ccall H5Pset_fapl_multi, <hid_t> -> InArray <H5FD_mem_t> -> InArray <hid_t> -> InArray CString -> InArray <haddr_t> -> <hbool_t> -> IO <herr_t>

-- |Returns information about the multi file access property
-- list though the function arguments which are the same as for
-- 'h5p_set_fapl_multi' above.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pget_fapl_multi(hid_t fapl_id, H5FD_mem_t *memb_map/*out*/,
-- >        hid_t *memb_fapl/*out*/, char **memb_name/*out*/,
-- >        haddr_t *memb_addr/*out*/, hbool_t *relax/*out*/);
#ccall H5Pget_fapl_multi, <hid_t> -> OutArray <H5FD_mem_t> -> OutArray <hid_t> -> OutArray CString -> OutArray <haddr_t> -> Out <hbool_t> -> IO <herr_t>

-- TODO: investigate and elaborate.  Does this use the same array size and format as H5Pset_fapl_multi?
-- |Set the data transfer property list 'dxpl_id' to use the multi
-- driver with the specified data transfer properties for each
-- memory usage type in the array 'memb_dxpl' (after the usage map is
-- applied).
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pset_dxpl_multi(hid_t dxpl_id, const hid_t *memb_dxpl);
#ccall H5Pset_dxpl_multi, <hid_t> -> InArray <hid_t> -> IO <herr_t>

-- Purpose:	Returns information which was set with 'h5p_set_dxpl_multi' above.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Pget_dxpl_multi(hid_t dxpl_id, hid_t *memb_dxpl/*out*/);
#ccall H5Pget_dxpl_multi, <hid_t> -> OutArray <hid_t> -> IO <herr_t>

-- |Compatability function. Makes the multi driver act like the
-- old split driver which stored meta data in one file and raw
-- data in another file.
--
-- If the raw or meta extension string contains a \"%s\", it will 
-- be substituted by the filename given for 'h5f_open' or 'h5f_create'.  
-- If no %s is found, one is inserted at the beginning.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Pset_fapl_split(hid_t fapl, const char *meta_ext,
-- >        hid_t meta_plist_id, const char *raw_ext,
-- >        hid_t raw_plist_id);
#ccall H5Pset_fapl_split, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> IO <herr_t>


