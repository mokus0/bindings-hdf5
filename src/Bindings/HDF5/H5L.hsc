#include <bindings.h>
#include <H5Lpublic.h>

module Bindings.HDF5.H5L where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5I
import Bindings.HDF5.H5T

import Foreign.Ptr.Conventions

h5l_MAX_LINK_NAME_LEN :: Word32
h5l_MAX_LINK_NAME_LEN = #const H5L_MAX_LINK_NAME_LEN

#num H5L_SAME_LOC

#num H5L_LINK_CLASS_T_VERS

#newtype H5L_type_t, Eq
#newtype_const H5L_type_t, H5L_TYPE_ERROR
#newtype_const H5L_type_t, H5L_TYPE_HARD
#newtype_const H5L_type_t, H5L_TYPE_SOFT
#newtype_const H5L_type_t, H5L_TYPE_EXTERNAL
#newtype_const H5L_type_t, H5L_TYPE_MAX

#newtype_const H5L_type_t, H5L_TYPE_BUILTIN_MAX
#newtype_const H5L_type_t, H5L_TYPE_UD_MIN

#starttype H5L_info_t
#field type,                <H5L_type_t>
#field corder_valid,        <hbool_t>
#field corder,              Int64
#field cset,                <H5T_cset_t>
#union_field u.address,     <haddr_t>
#union_field u.val_size,    <size_t>
#stoptype


-- /* The H5L_class_t struct can be used to override the behavior of a
--  * "user-defined" link class. Users should populate the struct with callback
--  * functions defined below.
--  */
-- /* Callback prototypes for user-defined links */
-- /* Link creation callback */
-- typedef herr_t (*H5L_create_func_t)(const char *link_name, hid_t loc_group,
--     const void *lnkdata, size_t lnkdata_size, hid_t lcpl_id);
type H5L_create_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> HId_t -> IO HErr_t)

-- 
-- /* Callback for when the link is moved */
-- typedef herr_t (*H5L_move_func_t)(const char *new_name, hid_t new_loc,
--     const void *lnkdata, size_t lnkdata_size);
type H5L_move_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- /* Callback for when the link is copied */
-- typedef herr_t (*H5L_copy_func_t)(const char *new_name, hid_t new_loc,
--     const void *lnkdata, size_t lnkdata_size);
type H5L_copy_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- 
-- /* Callback during link traversal */
-- typedef herr_t (*H5L_traverse_func_t)(const char *link_name, hid_t cur_group,
--     const void *lnkdata, size_t lnkdata_size, hid_t lapl_id);
type H5L_traverse_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> HId_t -> IO HErr_t)

-- 
-- /* Callback for when the link is deleted */
-- typedef herr_t (*H5L_delete_func_t)(const char *link_name, hid_t file,
--     const void *lnkdata, size_t lnkdata_size);
type H5L_delete_func_t a = FunPtr (CString -> HId_t -> Ptr a -> CSize -> IO HErr_t)

-- 
-- /* Callback for querying the link */
-- /* Returns the size of the buffer needed */
-- typedef ssize_t (*H5L_query_func_t)(const char *link_name, const void *lnkdata,
--     size_t lnkdata_size, void *buf /*out*/, size_t buf_size);
type H5L_query_func_t a b = FunPtr (CString -> Ptr a -> CSize -> Out b -> CSize -> IO CSSize)

-- 
-- /* User-defined link types */
-- typedef struct {
--     int version;                    /* Version number of this struct        */
--     H5L_type_t id;                  /* Link type ID                         */
--     const char *comment;            /* Comment for debugging                */
--     H5L_create_func_t create_func;  /* Callback during link creation        */
--     H5L_move_func_t move_func;      /* Callback after moving link           */
--     H5L_copy_func_t copy_func;      /* Callback after copying link          */
--     H5L_traverse_func_t trav_func;  /* Callback during link traversal       */
--     H5L_delete_func_t del_func;     /* Callback for link deletion           */
--     H5L_query_func_t query_func;    /* Callback for queries                 */
-- } H5L_class_t;
#starttype H5L_class_t
#field version,     CInt
#field id,          <H5L_type_t>
#field comment,     CString
#field create_func, H5L_create_func_t ()
#field move_func,   H5L_move_func_t ()
#field copy_func,   H5L_copy_func_t ()
#field trav_func,   H5L_traverse_func_t ()
#field del_func,    H5L_delete_func_t ()
#field query_func,  H5L_query_func_t () ()
#stoptype


-- /* Prototype for H5Literate/H5Literate_by_name() operator */
-- typedef herr_t (*H5L_iterate_t)(hid_t group, const char *name, const H5L_info_t *info,
--     void *op_data);
type H5L_iterate_t a = FunPtr (HId_t -> CString -> In H5L_info_t -> Ptr a -> IO HErr_t)

-- /* Callback for external link traversal */
-- typedef herr_t (*H5L_elink_traverse_t)(const char *parent_file_name,
--     const char *parent_group_name, const char *child_file_name,
--     const char *child_object_name, unsigned *acc_flags, hid_t fapl_id,
--     void *op_data);
type H5L_elink_traverse_t a = FunPtr (CString 
    -> CString -> CString
    -> CString -> Ptr CUInt -> HId_t
    -> Ptr a -> IO HErr_t)

-- 
-- 
-- /********************/
-- /* Public Variables */
-- /********************/
-- 
-- 
-- /*********************/
-- /* Public Prototypes */
-- /*********************/
-- herr_t H5Lmove(hid_t src_loc, const char *src_name, hid_t dst_loc,
--     const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lmove, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lcopy(hid_t src_loc, const char *src_name, hid_t dst_loc,
--     const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcopy, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lcreate_hard(hid_t cur_loc, const char *cur_name,
--     hid_t dst_loc, const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_hard, <hid_t> -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lcreate_soft(const char *link_target, hid_t link_loc_id,
--     const char *link_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_soft, CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Ldelete(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Ldelete, <hid_t> -> CString -> <hid_t> -> IO <herr_t>

-- herr_t H5Ldelete_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
#ccall H5Ldelete_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lget_val(hid_t loc_id, const char *name, void *buf/*out*/,
--     size_t size, hid_t lapl_id);
#ccall H5Lget_val, <hid_t> -> CString -> Out a -> <size_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lget_val_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
--     void *buf/*out*/, size_t size, hid_t lapl_id);
#ccall H5Lget_val_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out a -> CSize -> <hid_t> -> IO <herr_t>

-- htri_t H5Lexists(hid_t loc_id, const char *name, hid_t lapl_id);
#ccall H5Lexists, <hid_t> -> CString -> <hid_t> -> IO <htri_t>

-- herr_t H5Lget_info(hid_t loc_id, const char *name,
--     H5L_info_t *linfo /*out*/, hid_t lapl_id);
#ccall H5Lget_info, <hid_t> -> CString -> Out <H5L_info_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lget_info_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
--     H5L_info_t *linfo /*out*/, hid_t lapl_id);
#ccall H5Lget_info_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> Out <H5L_info_t> -> <hid_t> -> IO <herr_t>

-- ssize_t H5Lget_name_by_idx(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
--     char *name /*out*/, size_t size, hid_t lapl_id);
#ccall H5Lget_name_by_idx, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> <hsize_t> -> OutArray CChar -> <ssize_t> -> <hid_t> -> IO <ssize_t>

-- herr_t H5Literate(hid_t grp_id, H5_index_t idx_type,
--     H5_iter_order_t order, hsize_t *idx, H5L_iterate_t op, void *op_data);
#ccall H5Literate, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> Ptr <hsize_t> -> H5L_iterate_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Literate_by_name(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, hsize_t *idx,
--     H5L_iterate_t op, void *op_data, hid_t lapl_id);
#ccall H5Literate_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> Ptr <hsize_t> -> H5L_iterate_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- herr_t H5Lvisit(hid_t grp_id, H5_index_t idx_type, H5_iter_order_t order,
--     H5L_iterate_t op, void *op_data);
#ccall H5Lvisit, <hid_t> -> <H5_index_t> -> <H5_iter_order_t> -> H5L_iterate_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Lvisit_by_name(hid_t loc_id, const char *group_name,
--     H5_index_t idx_type, H5_iter_order_t order, H5L_iterate_t op,
--     void *op_data, hid_t lapl_id);
#ccall H5Lvisit_by_name, <hid_t> -> CString -> <H5_index_t> -> <H5_iter_order_t> -> H5L_iterate_t a -> Ptr a -> <hid_t> -> IO <herr_t>

-- /* UD link functions */
-- herr_t H5Lcreate_ud(hid_t link_loc_id, const char *link_name,
--     H5L_type_t link_type, const void *udata, size_t udata_size, hid_t lcpl_id,
--     hid_t lapl_id);
#ccall H5Lcreate_ud, <hid_t> -> CString -> <H5L_type_t> -> Ptr a -> <size_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Lregister(const H5L_class_t *cls);
#ccall H5Lregister, In <H5L_class_t> -> IO <herr_t>

-- herr_t H5Lunregister(H5L_type_t id);
#ccall H5Lunregister, <H5L_type_t> -> IO <herr_t>

-- htri_t H5Lis_registered(H5L_type_t id);
#ccall H5Lis_registered, <H5L_type_t> -> IO <htri_t>

-- 
-- /* External link functions */
-- herr_t H5Lunpack_elink_val(const void *ext_linkval/*in*/, size_t link_size,
--    unsigned *flags, const char **filename/*out*/, const char **obj_path /*out*/);
#ccall H5Lunpack_elink_val, In a -> <size_t> -> Ptr CUInt -> Out CString -> Out CString -> IO <herr_t>

-- herr_t H5Lcreate_external(const char *file_name, const char *obj_name,
--     hid_t link_loc_id, const char *link_name, hid_t lcpl_id, hid_t lapl_id);
#ccall H5Lcreate_external, CString -> CString -> <hid_t> -> CString -> <hid_t> -> <hid_t> -> IO <herr_t>

