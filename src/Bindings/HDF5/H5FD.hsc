#include <bindings.h>
#include <H5FDpublic.h>

module Bindings.HDF5.H5FD where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5F
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#newtype_const hid_t, H5FD_VFD_DEFAULT

type H5FD_mem_t = H5F_mem_t

#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_HDR
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_IBLOCK
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_DBLOCK
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_HUGE_OBJ

#newtype_const H5F_mem_t, H5FD_MEM_FSPACE_HDR
#newtype_const H5F_mem_t, H5FD_MEM_FSPACE_SINFO

#newtype_const H5F_mem_t, H5FD_MEM_SOHM_TABLE
#newtype_const H5F_mem_t, H5FD_MEM_SOHM_INDEX

-- Array initializers: pass a buffer and the size of that buffer (in bytes)
-- and it will be filled as prescribed by the corresponding array-literal macro
#cinline H5FD_FLMAP_SINGLE,    OutArray <H5FD_mem_t> -> <size_t> -> IO ()
#cinline H5FD_FLMAP_DICHOTOMY, OutArray <H5FD_mem_t> -> <size_t> -> IO ()
#cinline H5FD_FLMAP_DEFAULT,   OutArray <H5FD_mem_t> -> <size_t> -> IO ()

#num H5FD_FEAT_AGGREGATE_METADATA

#num H5FD_FEAT_ACCUMULATE_METADATA_WRITE
#num H5FD_FEAT_ACCUMULATE_METADATA_READ
#num H5FD_FEAT_ACCUMULATE_METADATA

#num H5FD_FEAT_DATA_SIEVE

#num H5FD_FEAT_AGGREGATE_SMALLDATA

#num H5FD_FEAT_IGNORE_DRVRINFO

#num H5FD_FEAT_DIRTY_SBLK_LOAD

#num H5FD_FEAT_POSIX_COMPAT_HANDLE

#starttype H5FD_class_t
#field name,            CString
#field maxaddr,         <haddr_t>
#field fc_degree,       <H5F_close_degree_t>
#field sb_size,         FunPtr (In H5FD_t -> IO <hsize_t>)
#field sb_encode,       FunPtr (In H5FD_t -> OutArray CChar -> Out CUChar -> IO <herr_t>)
#field sb_decode,       FunPtr (In H5FD_t -> CString -> In CUChar -> IO <herr_t>)
#field fapl_size,       <size_t>
#field fapl_get,        FunPtr (In H5FD_t -> IO (Ptr ()))
#field fapl_copy,       FunPtr (Ptr () -> IO (Ptr ()))
#field fapl_free,       FunPtr (Ptr () -> IO <herr_t>)
#field dxpl_size,       <size_t>
#field dxpl_copy,       FunPtr (Ptr () -> IO (Ptr ()))
#field dxpl_free,       FunPtr (Ptr () -> IO <herr_t>)
#field open,            FunPtr (CString -> CUInt -> <hid_t> -> <haddr_t> -> IO (Ptr <H5FD_t>))
#field close,           FunPtr (In <H5FD_t> -> IO <herr_t>)
#field cmp,             FunPtr (In <H5FD_t> -> In <H5FD_t> -> IO CInt)
#field query,           FunPtr (In <H5FD_t> -> Ptr CULong -> IO <herr_t>)
#field get_type_map,    FunPtr (In <H5FD_t> -> Out <H5FD_mem_t> -> IO <herr_t>)
#field alloc,           FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <hsize_t> -> IO <haddr_t>)
#field free,            FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <hsize_t> -> IO <herr_t>)
#field get_eoa,         FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> IO <haddr_t>)
#field set_eoa,         FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> <haddr_t>)
#field get_eof,         FunPtr (In <H5FD_t> -> IO <haddr_t>)
#field get_handle,      FunPtr (In <H5FD_t> -> <hid_t> -> Out (Ptr ()) -> IO <herr_t>)
#field read,            FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> OutArray () -> IO <herr_t>)
#field write,           FunPtr (In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> InArray  () -> IO <herr_t>)
#field flush,           FunPtr (In <H5FD_t> -> <hid_t> -> CUInt -> IO <herr_t>)
#field truncate,        FunPtr (In <H5FD_t> -> <hid_t> -> <hbool_t> -> IO <herr_t>)
#field lock,            FunPtr (In <H5FD_t> -> Ptr CUChar -> CUInt -> <hbool_t> -> IO <herr_t>)
#field unlock,          FunPtr (In <H5FD_t> -> Ptr CUChar -> <hbool_t> -> IO <herr_t>)
#array_field fl_map,          <H5FD_mem_t>
#stoptype

-- /* A free list is a singly-linked list of address/size pairs. */

#starttype H5FD_free_t
#field addr,    <haddr_t>
#field size,    <hsize_t>
#field next,    Ptr <H5FD_free_t>
#stoptype

-- /*
--  * The main datatype for each driver. Public fields common to all drivers
--  * are declared here and the driver appends private fields in memory.
--  */
#starttype H5FD_t
#field driver_id,       <hid_t>
#field cls,             Ptr <H5FD_class_t>
#field fileno,          CULong
#field feature_flags,   CULong
#field maxaddr,         <haddr_t>
#field base_addr,       <haddr_t>

--     /* Space allocation management fields */
#field threshold,       <hsize_t>
#field alignment,       <hsize_t>
#stoptype

-- /* Function prototypes */
-- hid_t H5FDregister(const H5FD_class_t *cls);
#ccall H5FDregister, In <H5FD_class_t> -> IO <hid_t>

-- herr_t H5FDunregister(hid_t driver_id);
#ccall H5FDunregister, <hid_t> -> IO <herr_t>

-- H5FD_t *H5FDopen(const char *name, unsigned flags, hid_t fapl_id,
--                         haddr_t maxaddr);
#ccall H5FDopen, CString -> CUInt -> <hid_t> -> <haddr_t> -> IO (Ptr <H5FD_t>)

-- herr_t H5FDclose(H5FD_t *file);
#ccall H5FDclose, In <H5FD_t> -> IO <herr_t>

-- int H5FDcmp(const H5FD_t *f1, const H5FD_t *f2);
#ccall H5FDcmp, In <H5FD_t> -> In <H5FD_t> -> IO CInt

-- int H5FDquery(const H5FD_t *f, unsigned long *flags);
#ccall H5FDquery, In <H5FD_t> -> Ptr CULong -> IO CInt

-- haddr_t H5FDalloc(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id, hsize_t size);
#ccall H5FDalloc, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <hsize_t> -> IO <haddr_t>

-- herr_t H5FDfree(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
--                        haddr_t addr, hsize_t size);
#ccall H5FDfree, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <hsize_t> -> IO <herr_t>

-- haddr_t H5FDget_eoa(H5FD_t *file, H5FD_mem_t type);
#ccall H5FDget_eoa, In <H5FD_t> -> <H5FD_mem_t> -> IO <haddr_t>

-- herr_t H5FDset_eoa(H5FD_t *file, H5FD_mem_t type, haddr_t eoa);
#ccall H5FDset_eoa, In <H5FD_t> -> <H5FD_mem_t> -> <haddr_t> -> IO <herr_t>

-- haddr_t H5FDget_eof(H5FD_t *file);
#ccall H5FDget_eof, In <H5FD_t> -> IO <haddr_t>

-- herr_t H5FDget_vfd_handle(H5FD_t *file, hid_t fapl, void**file_handle);
#ccall H5FDget_vfd_handle, In <H5FD_t> -> <hid_t> -> Out (Ptr a) -> IO <herr_t>

-- herr_t H5FDread(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
--                        haddr_t addr, size_t size, void *buf/*out*/);
#ccall H5FDread, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> OutArray a -> IO <herr_t>

-- herr_t H5FDwrite(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
--                         haddr_t addr, size_t size, const void *buf);
#ccall H5FDwrite, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> InArray a -> IO <herr_t>

-- herr_t H5FDflush(H5FD_t *file, hid_t dxpl_id, unsigned closing);
#ccall H5FDflush, In <H5FD_t> -> <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5FDtruncate(H5FD_t *file, hid_t dxpl_id, hbool_t closing);
#ccall H5FDtruncate, In <H5FD_t> -> <hid_t> -> <hbool_t> -> IO <herr_t>
