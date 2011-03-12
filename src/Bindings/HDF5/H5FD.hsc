#include <bindings.h>
#include <H5FDpublic.h>

-- |The Virtual File Layer as described in documentation.
-- This is the greatest common denominator for all types of
-- storage access whether a file, memory, network, etc. This
-- layer usually just dispatches the request to an actual
-- file driver layer.
module Bindings.HDF5.H5FD where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5F
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

-- |Default VFL driver value
#newtype_const hid_t, H5FD_VFD_DEFAULT

-- |Types of allocation requests: see "Bindings.HDF5.H5F"
type H5FD_mem_t = H5F_mem_t

-- |Map "fractal heap" header blocks to 'ohdr' type file memory, since its
-- a fair amount of work to add a new kind of file memory and they are similar
-- enough to object headers and probably too minor to deserve their own type.
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_HDR

-- |Map "fractal heap" indirect blocks to 'ohdr' type file memory, since they
-- are similar to fractal heap header blocks.
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_IBLOCK

-- |Map "fractal heap" direct blocks to 'lheap' type file memory, since they
-- will be replacing local heaps.
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_DBLOCK

-- |Map "fractal heap" 'huge' objects to 'draw' type file memory, since they
-- represent large objects that are directly stored in the file.
#newtype_const H5F_mem_t, H5FD_MEM_FHEAP_HUGE_OBJ

-- |Map "free space" header blocks to 'ohdr' type file memory, since its
-- a fair amount of work to add a new kind of file memory and they are similar
-- enough to object headers and probably too minor to deserve their own type.
#newtype_const H5F_mem_t, H5FD_MEM_FSPACE_HDR

-- |Map "free space" serialized sections to 'lheap' type file memory, since they
-- are similar enough to local heap info.
#newtype_const H5F_mem_t, H5FD_MEM_FSPACE_SINFO

-- |Map "shared object header message" master table to 'ohdr' type file memory,
-- since its a fair amount of work to add a new kind of file memory and they are
-- similar enough to object headers and probably too minor to deserve their own
-- type.
#newtype_const H5F_mem_t, H5FD_MEM_SOHM_TABLE

-- |Map "shared object header message" indices to 'btree' type file memory,
-- since they are similar enough to B-tree nodes.
#newtype_const H5F_mem_t, H5FD_MEM_SOHM_INDEX

-- Array initializers: pass a buffer and the size of that buffer (in bytes)
-- and it will be filled as prescribed by the corresponding array-literal macro.
--
-- TODO: create statically-allocated constant versions of these?
-- TODO: explain more in haddock docs about how to use these

-- |Initialize a free-list map which maps all types of allocation requests 
-- to a single free list.  This is useful for drivers that don't really care 
-- about keeping different requests segregated in the underlying file and which
-- want to make most efficient reuse of freed memory.  The use of the
-- 'h5fd_MEM_SUPER' free list is arbitrary.
#cinline H5FD_FLMAP_SINGLE,    OutArray <H5FD_mem_t> -> <size_t> -> IO ()

-- |A free-list map which segregates requests into \"raw\" or \"meta\" data
-- pools.
#cinline H5FD_FLMAP_DICHOTOMY, OutArray <H5FD_mem_t> -> <size_t> -> IO ()

-- |The default free list map which causes each request type to use its own
-- free-list.
#cinline H5FD_FLMAP_DEFAULT,   OutArray <H5FD_mem_t> -> <size_t> -> IO ()

-- |Defining the 'h5fd_FEAT_AGGREGATE_METADATA' for a VFL driver means that
-- the library will attempt to allocate a larger block for metadata and
-- then sub-allocate each metadata request from that larger block.
#num H5FD_FEAT_AGGREGATE_METADATA

-- |Defining the 'h5fd_FEAT_ACCUMULATE_METADATA' for a VFL driver means that
-- the library will attempt to cache metadata as it is written to the file
-- and build up a larger block of metadata to eventually pass to the VFL
-- 'write' routine.
-- 
-- Distinguish between updating the metadata accumulator on writes 
-- ('h5fd_FEAT_ACCUMULATE_METADATA_WRITE') and reads
-- ('h5fd_FEAT_ACCUMULATE_METADATA_READ').  This is particularly (perhaps
-- only, even) important for MPI-I/O where we guarantee that writes are
-- collective, but reads may not be.  If we were to allow the metadata 
-- accumulator to be written during a read operation, the application would
-- hang.
#num H5FD_FEAT_ACCUMULATE_METADATA
#num H5FD_FEAT_ACCUMULATE_METADATA_WRITE
#num H5FD_FEAT_ACCUMULATE_METADATA_READ

-- |Defining the 'h5fd_FEAT_DATA_SIEVE' for a VFL driver means that
-- the library will attempt to cache raw data as it is read from/written to
-- a file in a "data seive" buffer.  See Rajeev Thakur's papers:
-- 
--  * <http://www.mcs.anl.gov/~thakur/papers/romio-coll.ps.gz>
-- 
--  * <http://www.mcs.anl.gov/~thakur/papers/mpio-high-perf.ps.gz>
#num H5FD_FEAT_DATA_SIEVE

-- |Defining the 'h5fd_FEAT_AGGREGATE_SMALLDATA' for a VFL driver means that
-- the library will attempt to allocate a larger block for \"small\" raw data
-- and then sub-allocate \"small\" raw data requests from that larger block.
#num H5FD_FEAT_AGGREGATE_SMALLDATA

-- |Defining the 'h5fd_FEAT_IGNORE_DRVRINFO' for a VFL driver means that
-- the library will ignore the driver info that is encoded in the file
-- for the VFL driver.  (This will cause the driver info to be eliminated
-- from the file when it is flushed/closed, if the file is opened R/W).
#num H5FD_FEAT_IGNORE_DRVRINFO

-- |Defining the 'h5fd_FEAT_DIRTY_SBLK_LOAD' for a VFL driver means that
-- the library will mark the superblock dirty when the file is opened
-- R/W.  This will cause the driver info to be re-encoded when the file
-- is flushed/closed.
#num H5FD_FEAT_DIRTY_SBLK_LOAD

-- |Defining the h5fd_FEAT_POSIX_COMPAT_HANDLE for a VFL driver means that
-- the handle for the VFD (returned with the 'get_handle' callback) is
-- of type 'int' and is compatible with POSIX I/O calls.
#num H5FD_FEAT_POSIX_COMPAT_HANDLE

-- |Class information for each file driver
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


-- |A free list is a singly-linked list of address/size pairs.
#starttype H5FD_free_t
#field addr,    <haddr_t>
#field size,    <hsize_t>
#field next,    Ptr <H5FD_free_t>
#stoptype


-- |The main datatype for each driver. Public fields common to all drivers
-- are declared here and the driver appends private fields in memory.
#starttype H5FD_t

-- |driver ID for this file
#field driver_id,       <hid_t>

-- |constant class info
#field cls,             Ptr <H5FD_class_t>

-- |File 'serial' number
#field fileno,          CULong

-- |VFL Driver feature Flags
#field feature_flags,   CULong

-- |For this file, overrides class
#field maxaddr,         <haddr_t>

-- |Base address for HDF5 data w/in file
#field base_addr,       <haddr_t>

-- Space allocation management fields

-- |Threshold for alignment
#field threshold,       <hsize_t>
-- |Allocation alignment
#field alignment,       <hsize_t>
#stoptype


-- |Registers a new file driver as a member of the virtual file
-- driver class.  Certain fields of the class struct are
-- required and that is checked here so it doesn't have to be
-- checked every time the field is accessed.
--
-- On success, returns a file driver ID which is good until the
-- library is closed or the driver is unregistered.
-- On failure, returns a negative value.
--
-- > hid_t H5FDregister(const H5FD_class_t *cls);
#ccall H5FDregister, In <H5FD_class_t> -> IO <hid_t>

-- |Removes a driver ID from the library. This in no way affects
-- file access property lists which have been defined to use
-- this driver or files which are already opened under this
-- driver.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5FDunregister(hid_t driver_id);
#ccall H5FDunregister, <hid_t> -> IO <herr_t>

-- |Opens a file named 'name' for the type(s) of access described
-- by the bit vector 'flags' according to a file access property
-- list 'fapl_id' (which may be the constant 'h5p_DEFAULT'). The
-- file should expect to handle format addresses in the range [0,
-- 'maxaddr'] (if 'maxaddr' is 'hADDR_UNDEF' then the caller
-- doesn't care about the address range).
-- 
-- Possible values for the 'flags' bits are:
-- 
-- ['h5f_ACC_RDWR']
--  Open the file for read and write access. If
--  this bit is not set then open the file for
--  read only access. It is permissible to open a
--  file for read and write access when only read
--  access is requested by the library (the
--  library will never attempt to write to a file
--  which it opened with only read access).
-- 
-- ['h5f_ACC_CREAT']
--  Create the file if it doesn't already exist.
--  However, see 'h5f_ACC_EXCL' below.
-- 
-- ['h5f_ACC_TRUNC']
--  Truncate the file if it already exists. This
--  is equivalent to deleting the file and then
--  creating a new empty file.
-- 
-- ['h5f_ACC_EXCL']
--  When used with 'h5f_ACC_CREAT', if the file
--  already exists then the open should fail.
--  Note that this is unsupported/broken with
--  some file drivers (e.g., sec2 across nfs) and
--  will contain a race condition when used to
--  perform file locking.
-- 
-- The 'maxaddr' is the maximum address which will be requested by
-- the library during an allocation operation. Usually this is
-- the same value as the 'maxaddr' field of the class structure,
-- but it can be smaller if the driver is being used under some
-- other driver.
-- 
-- Note that when the driver 'open' callback gets control that
-- the public part of the file struct (the 'H5FD_t' part) will be
-- incomplete and will be filled in after that callback returns.
-- 
-- On success, returns a pointer to a new file driver struct.
-- On failure, returns 'nullPtr'.
-- 
-- > H5FD_t *H5FDopen(const char *name, unsigned flags, hid_t fapl_id,
-- >        haddr_t maxaddr);
#ccall H5FDopen, CString -> CUInt -> <hid_t> -> <haddr_t> -> IO (Ptr <H5FD_t>)

-- |Closes the file by calling the driver 'close' callback, which
-- should free all driver-private data and free the file struct.
-- Note that the public part of the file struct (the 'H5FD_t' part)
-- will be all zero during the driver close callback like during
-- the 'open' callback.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5FDclose(H5FD_t *file);
#ccall H5FDclose, In <H5FD_t> -> IO <herr_t>

-- |Compare the keys of two files using the file driver callback
-- if the files belong to the same driver, otherwise sort the
-- files by driver class pointer value.
--
-- Returns an integer greater than, less than, or equal to zero,
-- indicating the corresponding ordering.
--
-- Must never fail. If both file handles are invalid then they 
-- compare equal. If one file handle is invalid then it compares
-- less than the other.  If both files belong to the same driver
-- and the driver doesn't provide a comparison callback then the
-- file pointers themselves are compared.
--
-- > int H5FDcmp(const H5FD_t *f1, const H5FD_t *f2);
#ccall H5FDcmp, In <H5FD_t> -> In <H5FD_t> -> IO CInt

-- |Query a VFL driver for its feature flags. (listed in
-- "Bindings.HDF5.H5FD")
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > int H5FDquery(const H5FD_t *f, unsigned long *flags);
#ccall H5FDquery, In <H5FD_t> -> Out CULong -> IO CInt

-- |Allocates 'size' bytes of memory from the 'file'. The memory will
-- be used according to the allocation class 'type'. First we try
-- to satisfy the request from one of the free lists, according
-- to the free list map provided by the driver. The free list
-- array has one entry for each request type and the value of
-- that array element can be one of four possibilities:
-- 
-- * It can be the constant 'h5fd_MEM_DEFAULT' (or zero) which
--   indicates that the identity mapping is used. In other
--   words, the request type maps to its own free list.
-- 
-- * It can be the request type itself, which has the same
--   effect as the 'h5fd_MEM_DEFAULT' value above.
-- 
-- * It can be the ID for another request type, which
--   indicates that the free list for the specified type
--   should be used instead.
-- 
-- * It can be the constant 'h5fd_MEM_NOLIST' which means that
--   no free list should be used for this type of request.
-- 
-- If the request cannot be satisfied from a free list then
-- either the driver's 'alloc' callback is invoked (if one was
-- supplied) or the end-of-address marker is extended. The
-- 'alloc' callback is always called with the same arguments as
-- the 'h5fd_alloc'.
--
-- Returns the format address of the new file memory, or the 
-- undefined address 'hADDR_UNDEF' on failure.
--
-- > haddr_t H5FDalloc(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id, hsize_t size);
#ccall H5FDalloc, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <hsize_t> -> IO <haddr_t>

-- |Frees format addresses starting with 'addr' and continuing for
-- 'size' bytes in the file 'file'. The type of space being freed is
-- specified by 'type', which is mapped to a free list as
-- described for the 'h5fd_alloc' function above.  If the request
-- doesn't map to a free list then either the application 'free'
-- callback is invoked (if defined) or the memory is leaked.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5FDfree(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
-- >                        haddr_t addr, hsize_t size);
#ccall H5FDfree, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <hsize_t> -> IO <herr_t>

-- |Returns the address of the first byte after the last
-- allocated memory in the file, or 'hADDR_UNDEF' on failure.
--
-- > haddr_t H5FDget_eoa(H5FD_t *file, H5FD_mem_t type);
#ccall H5FDget_eoa, In <H5FD_t> -> <H5FD_mem_t> -> IO <haddr_t>

-- |Set the end-of-address marker for the file. The 'addr' is the
-- address of the first byte past the last allocated byte of the
-- file. This function is called from two places:
-- 
--  1. It is called after an existing file is opened in order to
--     \"allocate\" enough space to read the superblock and then
--     to \"allocate\" the entire hdf5 file based on the contents
--     of the superblock.
-- 
--  2. It is called during file memory allocation if the
--     allocation request cannot be satisfied from the free list
--     and the driver didn't supply an allocation callback.
-- 
-- Returns non-negative on success, or negative on failure.  If the
-- operation fails, it will do so with no side-effects.
-- 
-- > herr_t H5FDset_eoa(H5FD_t *file, H5FD_mem_t type, haddr_t eoa);
#ccall H5FDset_eoa, In <H5FD_t> -> <H5FD_mem_t> -> <haddr_t> -> IO <herr_t>

-- |Returns the end-of-file address, which is the greater of the
-- end-of-format address and the actual EOF marker. This
-- function is called after an existing file is opened in order
-- for the library to learn the true size of the underlying file
-- and to determine whether the hdf5 data has been truncated.
-- 
-- It is also used when a file is first opened to learn whether
-- the file is empty or not.
-- 
-- It is permissible for the driver to return the maximum address
-- for the file size if the file is not empty.
-- 
-- On failure, returns 'hADDR_UNDEF'
-- 
-- > haddr_t H5FDget_eof(H5FD_t *file);
#ccall H5FDget_eof, In <H5FD_t> -> IO <haddr_t>

-- |Returns a pointer to the file handle of low-level virtual
-- file driver.
-- 
-- returns non-negative on success, negative otherwise.
-- 
-- > herr_t H5FDget_vfd_handle(H5FD_t *file, hid_t fapl, void**file_handle);
#ccall H5FDget_vfd_handle, In <H5FD_t> -> <hid_t> -> Out (Ptr a) -> IO <herr_t>

-- |Reads 'size' bytes from 'file' beginning at address 'addr'
-- according to the data transfer property list 'dxpl_id' (which may
-- be the constant 'h5p_DEFAULT'). The result is written into the
-- buffer 'buf'.
-- 
-- Returns non-negative on success.  The read result is written into
-- the 'buf' buffer which should be allocated by the caller.
-- 
-- On failure, returns a negative value and the contents of 'buf' 
-- is undefined.
--  
-- > herr_t H5FDread(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
-- >        haddr_t addr, size_t size, void *buf/*out*/);
#ccall H5FDread, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> OutArray a -> IO <herr_t>

-- |Writes 'size' bytes to 'file' beginning at address 'addr' according
-- to the data transfer property list 'dxpl_id' (which may be the
-- constant 'h5p_DEFAULT'). The bytes to be written come from the
-- buffer 'buf'.
--
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5FDwrite(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
-- >        haddr_t addr, size_t size, const void *buf);
#ccall H5FDwrite, In <H5FD_t> -> <H5FD_mem_t> -> <hid_t> -> <haddr_t> -> <size_t> -> InArray a -> IO <herr_t>

-- |Notify driver to flush all cached data.  If the driver has no
-- flush method then nothing happens.
--
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5FDflush(H5FD_t *file, hid_t dxpl_id, unsigned closing);
#ccall H5FDflush, In <H5FD_t> -> <hid_t> -> CUInt -> IO <herr_t>

-- |Notify driver to truncate the file back to the allocated size.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5FDtruncate(H5FD_t *file, hid_t dxpl_id, hbool_t closing);
#ccall H5FDtruncate, In <H5FD_t> -> <hid_t> -> <hbool_t> -> IO <herr_t>
