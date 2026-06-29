;; extends
(
 ((variable) @variable.parameter (#has-ancestor? @variable.parameter patterns))
 (#set! "priority" 100)
 )
(
 ((variable) @type.haskell
  (#has-ancestor? @type.haskell signature)
  (#has-ancestor? @type.haskell function))
 (#set! "priority" 101)
 )
(
 (boolean(variable) @keyword (#match? "otherwise"))
 (#set! "priority" 101)
 )
(
 ((signature) @signature)
 )
