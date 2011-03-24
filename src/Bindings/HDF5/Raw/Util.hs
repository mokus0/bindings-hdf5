module Bindings.HDF5.Raw.Util where

import Bindings.HDF5.Raw

hboolToBool :: HBool_t -> Bool
hboolToBool (HBool_t n) = (n /= 0)

boolToHBool :: Bool -> HBool_t
boolToHBool True  = HBool_t 1
boolToHBool False = HBool_t 0

test_htri_t :: HTri_t -> Maybe Bool
test_htri_t (HTri_t n) = case compare n 0 of
    LT -> Nothing
    EQ -> Just False
    GT -> Just True
