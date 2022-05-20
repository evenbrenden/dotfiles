
```haskell
Alternative :: (* -> *) -> Constraint
```

*Defined in ‘GHC.Base’*
 *(base-4.14.3.0)*


A monoid on applicative functors. 

If defined,  `some`  and  `many`  should be the least solutions
 of the equations: 
+ ```haskell
  `some`  v = (:)  `Prelude.<$>`  v  `<*>`   `many`  v
  ```

+ ```haskell
  `many`  v =  `some`  v  `<|>`   `pure`  []
  ```




[Documentation](file:///nix/store/0whrhk848iipvmfsg0l0s59bmqpd9skg-ghc-8.10.7-doc/share/doc/ghc/html/libraries/base-4.14.3.0/GHC-Base.html#t:Alternative)
[Source](file:///nix/store/0whrhk848iipvmfsg0l0s59bmqpd9skg-ghc-8.10.7-doc/share/doc/ghc/html/libraries/base-4.14.3.0/src/GHC-Base.html#Alternative)


