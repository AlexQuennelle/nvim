;;extends
((comment) @injection.content
  (#match? @injection.content "/[*\/][!*\/]<?[^a-zA-Z]")
  (#set! injection.language "doxygen"))
; (
;  (type_parameter_declaration) @Comment
;  (#match? @Comment "typename")
;  )
; (
;  (comment)+ @comment.documentation
;   (#match? @comment.documentation "^///\\s+.*")
;   )
; (
;  (comment) @keyword
;  (#match? @keyword "^[@][a-zA-Z0-9_-]+$")
;  (#set! "priority" 160)
;  )
