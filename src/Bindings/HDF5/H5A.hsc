#include <bindings.h>
#include <H5Apublic.h>

module Bindings.HDF5.H5A where
#strict_import

import Bindings.HDF5.H5

import Bindings.HDF5.H5I -- IDs
import Bindings.HDF5.H5O -- Object Headers
import Bindings.HDF5.H5T -- Datatypes

-- #starttype H5A_info_t
-- #field corder_valid , <hbool_t>
-- #field corder       , <H5O_msg_crt_idx_t>
-- #field cset         , <H5T_cset_t>
-- #field data_size    , <hsize_t>
-- #stoptype

-- TODO: continue at line 39
