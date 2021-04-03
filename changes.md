# changelog

## 9.0.0

- added `Infinity` to say: no upper maximum

Made `Min min` alias to type `In min Infinity`.

- renamed module `Nat.N` to `NNat`
- renamed module `Nat.In` to `InNat`
- renamed module `Nat.Min` to `MinNat`
- renamed module `Nat.Ns` to `NNats`
- removed functions that apply for any `max` in `MinNat`
- moved functions that just result in a `Nat (Min ...)` into `InNat`
- moved `abs` & `isInt...` & `int...` into `Nat`

### 9.1.0

- added `sub` & `add` in `NNat`.

#### 9.1.1

- minor doc fix for `Nat.Bound.In`

## 10.0.0

- added `maybeN` type parameter to `In`
- `N n (Is a To nPlusA) (Is b To nPlusB)` now looks like `N n (Is a To) nPlusA (And b To nPlusB)`

`N n (Is a To) nPlusA (And b To nPlusB)` is now a `In n nPlusA ...`.

- added `ValueIn`
- renamed `Min` to `ValueMin`
- added `ValueOnly`
- unexposed `Infinity`
- renamed `Nat.N.Type` to `TypeNats`
- moved `random` into `Nat`
- moved `range` into `Nat`
- moved operations like `mul`, where the `max` is ignored into `MinNat`
- renamed `dropMax` to `toMin`
- removed `NNat.toMin` as `dropMax` works the same
- removed `NNats.nat168` to `NNats.nat192` for performance reasons

## 11.0.0

Fixed a bug in the `MinNat.add` type. Upgrade if you can.
