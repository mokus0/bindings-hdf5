module Bindings.HDF5.Util where

import Bindings.HDF5

test_htri_t :: HTri_t -> Maybe Bool
test_htri_t (HTri_t n) = case compare n 0 of
    LT -> Nothing
    EQ -> Just False
    GT -> Just True
