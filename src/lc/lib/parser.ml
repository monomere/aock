
type token = 
  | VAR
  | USE
  | TYPE
  | SEMI
  | RPAR
  | RBR
  | LPAR
  | LET
  | LBR
  | INT of (
# 2 "lib/parser.mly"
       (int)
# 16 "lib/parser.ml"
)
  | IDEN of (
# 3 "lib/parser.mly"
       (string)
# 21 "lib/parser.ml"
)
  | FUN
  | EQ
  | DOT
  | COMMA
  | COLON

let menhir_begin_marker =
  0

and (xv_varletkw, xv_vardecl, xv_typedef, xv_ty, xv_terminated_stmt_SEMI_, xv_stmt, xv_separated_nonempty_list_DOT___anonymous_2_, xv_separated_nonempty_list_COMMA_qual_, xv_separated_nonempty_list_COMMA_binding_, xv_separated_list_COMMA_binding_, xv_qual, xv_prog, xv_preceded_EQ_expr_, xv_preceded_COLON_ty_, xv_option_stmt_, xv_option_preceded_EQ_expr__, xv_option_preceded_COLON_ty__, xv_meta, xv_loption_separated_nonempty_list_COMMA_binding__, xv_list_terminated_stmt_SEMI__, xv_list_meta_, xv_list_decl_, xv_ibinding, xv_fundecl, xv_expr, xv_either___anonymous_0___anonymous_1_, xv_delimited_LPAR_separated_list_COMMA_binding__RPAR_, xv_delimited_LBR_list_terminated_stmt_SEMI___RBR_, xv_decl, xv_block, xv_binding, xv___anonymous_2, xv___anonymous_1, xv___anonymous_0) =
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 187 "<standard.mly>"
        _2
# 36 "lib/parser.ml"
   : unit) (_startpos__2_ : Lexing.position) (_endpos__2_ : Lexing.position) (_startofs__2_ : int) (_endofs__2_ : int) (_loc__2_ : Lexing.position * Lexing.position) (
# 187 "<standard.mly>"
  x
# 40 "lib/parser.ml"
   : 'tv_stmt) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 188 "<standard.mly>"
    ( x )
# 45 "lib/parser.ml"
     : 'tv_terminated_stmt_SEMI_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
                    xs
# 50 "lib/parser.ml"
   : 'tv_separated_nonempty_list_DOT___anonymous_2_) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
        _2
# 54 "lib/parser.ml"
   : unit) (_startpos__2_ : Lexing.position) (_endpos__2_ : Lexing.position) (_startofs__2_ : int) (_endofs__2_ : int) (_loc__2_ : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
  x
# 58 "lib/parser.ml"
   : 'tv___anonymous_2) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 63 "lib/parser.ml"
     : 'tv_separated_nonempty_list_DOT___anonymous_2_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 237 "<standard.mly>"
  x
# 68 "lib/parser.ml"
   : 'tv___anonymous_2) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 73 "lib/parser.ml"
     : 'tv_separated_nonempty_list_DOT___anonymous_2_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
                    xs
# 78 "lib/parser.ml"
   : 'tv_separated_nonempty_list_COMMA_qual_) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
        _2
# 82 "lib/parser.ml"
   : unit) (_startpos__2_ : Lexing.position) (_endpos__2_ : Lexing.position) (_startofs__2_ : int) (_endofs__2_ : int) (_loc__2_ : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
  x
# 86 "lib/parser.ml"
   : 'tv_qual) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 91 "lib/parser.ml"
     : 'tv_separated_nonempty_list_COMMA_qual_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 237 "<standard.mly>"
  x
# 96 "lib/parser.ml"
   : 'tv_qual) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 101 "lib/parser.ml"
     : 'tv_separated_nonempty_list_COMMA_qual_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
                    xs
# 106 "lib/parser.ml"
   : 'tv_separated_nonempty_list_COMMA_binding_) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) (
# 239 "<standard.mly>"
        _2
# 110 "lib/parser.ml"
   : unit) (_startpos__2_ : Lexing.position) (_endpos__2_ : Lexing.position) (_startofs__2_ : int) (_endofs__2_ : int) (_loc__2_ : Lexing.position * Lexing.position) ((
# 239 "<standard.mly>"
  x
# 114 "lib/parser.ml"
   : 'tv_binding) : (
# 32 "lib/parser.mly"
      (Ast.binding)
# 118 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 123 "lib/parser.ml"
     : 'tv_separated_nonempty_list_COMMA_binding_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 237 "<standard.mly>"
  x
# 128 "lib/parser.ml"
   : 'tv_binding) : (
# 32 "lib/parser.mly"
      (Ast.binding)
# 132 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 137 "lib/parser.ml"
     : 'tv_separated_nonempty_list_COMMA_binding_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 228 "<standard.mly>"
  xs
# 142 "lib/parser.ml"
   : 'tv_loption_separated_nonempty_list_COMMA_binding__) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) ->
    (
# 229 "<standard.mly>"
    ( xs )
# 147 "lib/parser.ml"
     : 'tv_separated_list_COMMA_binding_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 179 "<standard.mly>"
           x
# 152 "lib/parser.ml"
   : 'tv_expr) : (
# 26 "lib/parser.mly"
      (Ast.expr)
# 156 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) (
# 178 "<standard.mly>"
                                     _1
# 161 "lib/parser.ml"
   : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 180 "<standard.mly>"
    ( x )
# 166 "lib/parser.ml"
     : 'tv_preceded_EQ_expr_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 179 "<standard.mly>"
           x
# 171 "lib/parser.ml"
   : 'tv_ty) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) (
# 178 "<standard.mly>"
                                     _1
# 176 "lib/parser.ml"
   : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 180 "<standard.mly>"
    ( x )
# 181 "lib/parser.ml"
     : 'tv_preceded_COLON_ty_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 112 "<standard.mly>"
  x
# 186 "lib/parser.ml"
   : 'tv_stmt) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 113 "<standard.mly>"
    ( Some x )
# 191 "lib/parser.ml"
     : 'tv_option_stmt_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 111 "<standard.mly>"
    ( None )
# 197 "lib/parser.ml"
     : 'tv_option_stmt_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 112 "<standard.mly>"
  x
# 202 "lib/parser.ml"
   : 'tv_preceded_EQ_expr_) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 113 "<standard.mly>"
    ( Some x )
# 207 "lib/parser.ml"
     : 'tv_option_preceded_EQ_expr__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 111 "<standard.mly>"
    ( None )
# 213 "lib/parser.ml"
     : 'tv_option_preceded_EQ_expr__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 112 "<standard.mly>"
  x
# 218 "lib/parser.ml"
   : 'tv_preceded_COLON_ty_) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 113 "<standard.mly>"
    ( Some x )
# 223 "lib/parser.ml"
     : 'tv_option_preceded_COLON_ty__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 111 "<standard.mly>"
    ( None )
# 229 "lib/parser.ml"
     : 'tv_option_preceded_COLON_ty__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 140 "<standard.mly>"
  x
# 234 "lib/parser.ml"
   : 'tv_separated_nonempty_list_COMMA_binding_) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 141 "<standard.mly>"
    ( x )
# 239 "lib/parser.ml"
     : 'tv_loption_separated_nonempty_list_COMMA_binding__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 139 "<standard.mly>"
    ( [] )
# 245 "lib/parser.ml"
     : 'tv_loption_separated_nonempty_list_COMMA_binding__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 209 "<standard.mly>"
         xs
# 250 "lib/parser.ml"
   : 'tv_list_terminated_stmt_SEMI__) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) (
# 209 "<standard.mly>"
  x
# 254 "lib/parser.ml"
   : 'tv_terminated_stmt_SEMI_) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 259 "lib/parser.ml"
     : 'tv_list_terminated_stmt_SEMI__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 208 "<standard.mly>"
    ( [] )
# 265 "lib/parser.ml"
     : 'tv_list_terminated_stmt_SEMI__) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 209 "<standard.mly>"
         xs
# 270 "lib/parser.ml"
   : 'tv_list_meta_) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) ((
# 209 "<standard.mly>"
  x
# 274 "lib/parser.ml"
   : 'tv_meta) : (
# 30 "lib/parser.mly"
      (Ast.meta)
# 278 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 283 "lib/parser.ml"
     : 'tv_list_meta_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 208 "<standard.mly>"
    ( [] )
# 289 "lib/parser.ml"
     : 'tv_list_meta_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 209 "<standard.mly>"
         xs
# 294 "lib/parser.ml"
   : 'tv_list_decl_) (_startpos_xs_ : Lexing.position) (_endpos_xs_ : Lexing.position) (_startofs_xs_ : int) (_endofs_xs_ : int) (_loc_xs_ : Lexing.position * Lexing.position) ((
# 209 "<standard.mly>"
  x
# 298 "lib/parser.ml"
   : 'tv_decl) : (
# 31 "lib/parser.mly"
      (Ast.decl)
# 302 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 307 "lib/parser.ml"
     : 'tv_list_decl_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ->
    (
# 208 "<standard.mly>"
    ( [] )
# 313 "lib/parser.ml"
     : 'tv_list_decl_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 65 "lib/parser.mly"
                        _1
# 318 "lib/parser.ml"
   : 'tv___anonymous_1) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (_1 : 'tv_either___anonymous_0___anonymous_1_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 65 "lib/parser.mly"
                    _1
# 324 "lib/parser.ml"
   : 'tv___anonymous_0) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (_1 : 'tv_either___anonymous_0___anonymous_1_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 196 "<standard.mly>"
                 _3
# 330 "lib/parser.ml"
   : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 196 "<standard.mly>"
           x
# 334 "lib/parser.ml"
   : 'tv_separated_list_COMMA_binding_) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) (
# 195 "<standard.mly>"
                                               _1
# 339 "lib/parser.ml"
   : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 197 "<standard.mly>"
    ( x )
# 344 "lib/parser.ml"
     : 'tv_delimited_LPAR_separated_list_COMMA_binding__RPAR_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 196 "<standard.mly>"
                 _3
# 349 "lib/parser.ml"
   : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 196 "<standard.mly>"
           x
# 353 "lib/parser.ml"
   : 'tv_list_terminated_stmt_SEMI__) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) (
# 195 "<standard.mly>"
                                               _1
# 358 "lib/parser.ml"
   : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 197 "<standard.mly>"
    ( x )
# 363 "lib/parser.ml"
     : 'tv_delimited_LBR_list_terminated_stmt_SEMI___RBR_) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 46 "lib/parser.mly"
                                _1
# 368 "lib/parser.ml"
   : 'tv_typedef) : (
# 29 "lib/parser.mly"
      (Ast.decl)
# 372 "lib/parser.ml"
  )) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((_1 : 'tv_decl) : (
# 31 "lib/parser.mly"
      (Ast.decl)
# 377 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 46 "lib/parser.mly"
                      _1
# 382 "lib/parser.ml"
   : 'tv_fundecl) : (
# 28 "lib/parser.mly"
      (Ast.decl)
# 386 "lib/parser.ml"
  )) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((_1 : 'tv_decl) : (
# 31 "lib/parser.mly"
      (Ast.decl)
# 391 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 46 "lib/parser.mly"
            _1
# 396 "lib/parser.ml"
   : 'tv_vardecl) : (
# 27 "lib/parser.mly"
      (Ast.decl)
# 400 "lib/parser.ml"
  )) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((_1 : 'tv_decl) : (
# 31 "lib/parser.mly"
      (Ast.decl)
# 405 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 48 "lib/parser.mly"
                                     ( false )
# 411 "lib/parser.ml"
     : 'tv_varletkw) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 48 "lib/parser.mly"
                     ( true )
# 417 "lib/parser.ml"
     : 'tv_varletkw) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 62 "lib/parser.mly"
 v
# 422 "lib/parser.ml"
   : 'tv_option_preceded_EQ_expr__) (_startpos_v_ : Lexing.position) (_endpos_v_ : Lexing.position) (_startofs_v_ : int) (_endofs_v_ : int) (_loc_v_ : Lexing.position * Lexing.position) ((
# 61 "lib/parser.mly"
               b
# 426 "lib/parser.ml"
   : 'tv_ibinding) : (
# 33 "lib/parser.mly"
      (Ast.ibinding)
# 430 "lib/parser.ml"
  )) (_startpos_b_ : Lexing.position) (_endpos_b_ : Lexing.position) (_startofs_b_ : int) (_endofs_b_ : int) (_loc_b_ : Lexing.position * Lexing.position) (
# 61 "lib/parser.mly"
 m
# 434 "lib/parser.ml"
   : 'tv_varletkw) (_startpos_m_ : Lexing.position) (_endpos_m_ : Lexing.position) (_startofs_m_ : int) (_endofs_m_ : int) (_loc_m_ : Lexing.position * Lexing.position) ->
    ((
# 63 "lib/parser.mly"
 ( Ast.VarDecl (m, b, v) )
# 439 "lib/parser.ml"
     : 'tv_vardecl) : (
# 27 "lib/parser.mly"
      (Ast.decl)
# 443 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 75 "lib/parser.mly"
                     t
# 448 "lib/parser.ml"
   : 'tv_ty) (_startpos_t_ : Lexing.position) (_endpos_t_ : Lexing.position) (_startofs_t_ : int) (_endofs_t_ : int) (_loc_t_ : Lexing.position * Lexing.position) (_3 : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 75 "lib/parser.mly"
       n
# 452 "lib/parser.ml"
   : 'tv_qual) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((
# 76 "lib/parser.mly"
 ( Ast.Tydef (Ast.AliasTydef (n, t)) )
# 457 "lib/parser.ml"
     : 'tv_typedef) : (
# 29 "lib/parser.mly"
      (Ast.decl)
# 461 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 94 "lib/parser.mly"
          n
# 466 "lib/parser.ml"
   : 'tv_qual) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) ->
    (
# 94 "lib/parser.mly"
                    ( Ast.NameTy n )
# 471 "lib/parser.ml"
     : 'tv_ty) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 88 "lib/parser.mly"
   d
# 476 "lib/parser.ml"
   : 'tv_decl) : (
# 31 "lib/parser.mly"
      (Ast.decl)
# 480 "lib/parser.ml"
  )) (_startpos_d_ : Lexing.position) (_endpos_d_ : Lexing.position) (_startofs_d_ : int) (_endofs_d_ : int) (_loc_d_ : Lexing.position * Lexing.position) ->
    (
# 88 "lib/parser.mly"
             ( Ast.DeclStmt d )
# 485 "lib/parser.ml"
     : 'tv_stmt) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) ((
# 87 "lib/parser.mly"
   e
# 490 "lib/parser.ml"
   : 'tv_expr) : (
# 26 "lib/parser.mly"
      (Ast.expr)
# 494 "lib/parser.ml"
  )) (_startpos_e_ : Lexing.position) (_endpos_e_ : Lexing.position) (_startofs_e_ : int) (_endofs_e_ : int) (_loc_e_ : Lexing.position * Lexing.position) ->
    (
# 87 "lib/parser.mly"
             ( Ast.ExprStmt e )
# 499 "lib/parser.ml"
     : 'tv_stmt) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 78 "lib/parser.mly"
            l
# 504 "lib/parser.ml"
   : 'tv_separated_nonempty_list_DOT___anonymous_2_) (_startpos_l_ : Lexing.position) (_endpos_l_ : Lexing.position) (_startofs_l_ : int) (_endofs_l_ : int) (_loc_l_ : Lexing.position * Lexing.position) ->
    (
# 79 "lib/parser.mly"
 ( Array.of_list l )
# 509 "lib/parser.ml"
     : 'tv_qual) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 39 "lib/parser.mly"
                   decls
# 514 "lib/parser.ml"
   : 'tv_list_decl_) (_startpos_decls_ : Lexing.position) (_endpos_decls_ : Lexing.position) (_startofs_decls_ : int) (_endofs_decls_ : int) (_loc_decls_ : Lexing.position * Lexing.position) (
# 39 "lib/parser.mly"
    metas
# 518 "lib/parser.ml"
   : 'tv_list_meta_) (_startpos_metas_ : Lexing.position) (_endpos_metas_ : Lexing.position) (_startofs_metas_ : int) (_endofs_metas_ : int) (_loc_metas_ : Lexing.position * Lexing.position) ->
    ((
# 40 "lib/parser.mly"
  ( (Array.of_list metas, Array.of_list decls) )
# 523 "lib/parser.ml"
     : 'tv_prog) : (
# 35 "lib/parser.mly"
       (Ast.prog)
# 527 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (_3 : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 43 "lib/parser.mly"
         n
# 532 "lib/parser.ml"
   : 'tv_separated_nonempty_list_COMMA_qual_) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((
# 44 "lib/parser.mly"
  ( Ast.UseMeta (Array.of_list n) )
# 537 "lib/parser.ml"
     : 'tv_meta) : (
# 30 "lib/parser.mly"
      (Ast.meta)
# 541 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 57 "lib/parser.mly"
 t
# 546 "lib/parser.ml"
   : 'tv_option_preceded_COLON_ty__) (_startpos_t_ : Lexing.position) (_endpos_t_ : Lexing.position) (_startofs_t_ : int) (_endofs_t_ : int) (_loc_t_ : Lexing.position * Lexing.position) (
# 56 "lib/parser.mly"
 n
# 550 "lib/parser.ml"
   : (
# 3 "lib/parser.mly"
       (string)
# 554 "lib/parser.ml"
  )) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) ->
    ((
# 58 "lib/parser.mly"
 ( (n, t) )
# 559 "lib/parser.ml"
     : 'tv_ibinding) : (
# 33 "lib/parser.mly"
      (Ast.ibinding)
# 563 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 71 "lib/parser.mly"
 b
# 568 "lib/parser.ml"
   : 'tv_either___anonymous_0___anonymous_1_) (_startpos_b_ : Lexing.position) (_endpos_b_ : Lexing.position) (_startofs_b_ : int) (_endofs_b_ : int) (_loc_b_ : Lexing.position * Lexing.position) (
# 70 "lib/parser.mly"
 t
# 572 "lib/parser.ml"
   : 'tv_option_preceded_COLON_ty__) (_startpos_t_ : Lexing.position) (_endpos_t_ : Lexing.position) (_startofs_t_ : int) (_endofs_t_ : int) (_loc_t_ : Lexing.position * Lexing.position) (
# 69 "lib/parser.mly"
 a
# 576 "lib/parser.ml"
   : 'tv_delimited_LPAR_separated_list_COMMA_binding__RPAR_) (_startpos_a_ : Lexing.position) (_endpos_a_ : Lexing.position) (_startofs_a_ : int) (_endofs_a_ : int) (_loc_a_ : Lexing.position * Lexing.position) (
# 68 "lib/parser.mly"
      n
# 580 "lib/parser.ml"
   : (
# 3 "lib/parser.mly"
       (string)
# 584 "lib/parser.ml"
  )) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    ((
# 72 "lib/parser.mly"
 ( Ast.FunDecl ((n, t), Array.of_list a, b) )
# 589 "lib/parser.ml"
     : 'tv_fundecl) : (
# 28 "lib/parser.mly"
      (Ast.decl)
# 593 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 93 "lib/parser.mly"
   i
# 598 "lib/parser.ml"
   : (
# 2 "lib/parser.mly"
       (int)
# 602 "lib/parser.ml"
  )) (_startpos_i_ : Lexing.position) (_endpos_i_ : Lexing.position) (_startofs_i_ : int) (_endofs_i_ : int) (_loc_i_ : Lexing.position * Lexing.position) ->
    ((
# 93 "lib/parser.mly"
            ( Ast.IntExpr i )
# 607 "lib/parser.ml"
     : 'tv_expr) : (
# 26 "lib/parser.mly"
      (Ast.expr)
# 611 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 92 "lib/parser.mly"
   n
# 616 "lib/parser.ml"
   : (
# 3 "lib/parser.mly"
       (string)
# 620 "lib/parser.ml"
  )) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) ->
    ((
# 92 "lib/parser.mly"
             ( Ast.VarExpr n )
# 625 "lib/parser.ml"
     : 'tv_expr) : (
# 26 "lib/parser.mly"
      (Ast.expr)
# 629 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 91 "lib/parser.mly"
   b
# 634 "lib/parser.ml"
   : 'tv_block) (_startpos_b_ : Lexing.position) (_endpos_b_ : Lexing.position) (_startofs_b_ : int) (_endofs_b_ : int) (_loc_b_ : Lexing.position * Lexing.position) ->
    ((
# 91 "lib/parser.mly"
              ( Ast.BlockExpr b )
# 639 "lib/parser.ml"
     : 'tv_expr) : (
# 26 "lib/parser.mly"
      (Ast.expr)
# 643 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 83 "lib/parser.mly"
 tail
# 648 "lib/parser.ml"
   : 'tv_option_stmt_) (_startpos_tail_ : Lexing.position) (_endpos_tail_ : Lexing.position) (_startofs_tail_ : int) (_endofs_tail_ : int) (_loc_tail_ : Lexing.position * Lexing.position) (
# 82 "lib/parser.mly"
 s
# 652 "lib/parser.ml"
   : 'tv_delimited_LBR_list_terminated_stmt_SEMI___RBR_) (_startpos_s_ : Lexing.position) (_endpos_s_ : Lexing.position) (_startofs_s_ : int) (_endofs_s_ : int) (_loc_s_ : Lexing.position * Lexing.position) ->
    (
# 84 "lib/parser.mly"
 ( (Array.of_list s, tail) )
# 657 "lib/parser.ml"
     : 'tv_block) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 52 "lib/parser.mly"
 t
# 662 "lib/parser.ml"
   : 'tv_preceded_COLON_ty_) (_startpos_t_ : Lexing.position) (_endpos_t_ : Lexing.position) (_startofs_t_ : int) (_endofs_t_ : int) (_loc_t_ : Lexing.position * Lexing.position) (
# 51 "lib/parser.mly"
 n
# 666 "lib/parser.ml"
   : (
# 3 "lib/parser.mly"
       (string)
# 670 "lib/parser.ml"
  )) (_startpos_n_ : Lexing.position) (_endpos_n_ : Lexing.position) (_startofs_n_ : int) (_endofs_n_ : int) (_loc_n_ : Lexing.position * Lexing.position) ->
    ((
# 53 "lib/parser.mly"
 ( (n, t) )
# 675 "lib/parser.ml"
     : 'tv_binding) : (
# 32 "lib/parser.mly"
      (Ast.binding)
# 679 "lib/parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 78 "lib/parser.mly"
                                             x
# 684 "lib/parser.ml"
   : (
# 3 "lib/parser.mly"
       (string)
# 688 "lib/parser.ml"
  )) (_startpos_x_ : Lexing.position) (_endpos_x_ : Lexing.position) (_startofs_x_ : int) (_endofs_x_ : int) (_loc_x_ : Lexing.position * Lexing.position) ->
    (
# 78 "lib/parser.mly"
                                                       (x)
# 693 "lib/parser.ml"
     : 'tv___anonymous_2) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (_1 : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 71 "lib/parser.mly"
                                       (None)
# 699 "lib/parser.ml"
     : 'tv___anonymous_1) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 71 "lib/parser.mly"
            b
# 704 "lib/parser.ml"
   : 'tv_block) (_startpos_b_ : Lexing.position) (_endpos_b_ : Lexing.position) (_startofs_b_ : int) (_endofs_b_ : int) (_loc_b_ : Lexing.position * Lexing.position) ->
    (
# 71 "lib/parser.mly"
                       (Some b)
# 709 "lib/parser.ml"
     : 'tv___anonymous_0) in
  ((let rec diverge() = diverge() in diverge()) : 'tv_varletkw * 'tv_vardecl * 'tv_typedef * 'tv_ty * 'tv_terminated_stmt_SEMI_ * 'tv_stmt * 'tv_separated_nonempty_list_DOT___anonymous_2_ * 'tv_separated_nonempty_list_COMMA_qual_ * 'tv_separated_nonempty_list_COMMA_binding_ * 'tv_separated_list_COMMA_binding_ * 'tv_qual * 'tv_prog * 'tv_preceded_EQ_expr_ * 'tv_preceded_COLON_ty_ * 'tv_option_stmt_ * 'tv_option_preceded_EQ_expr__ * 'tv_option_preceded_COLON_ty__ * 'tv_meta * 'tv_loption_separated_nonempty_list_COMMA_binding__ * 'tv_list_terminated_stmt_SEMI__ * 'tv_list_meta_ * 'tv_list_decl_ * 'tv_ibinding * 'tv_fundecl * 'tv_expr * 'tv_either___anonymous_0___anonymous_1_ * 'tv_delimited_LPAR_separated_list_COMMA_binding__RPAR_ * 'tv_delimited_LBR_list_terminated_stmt_SEMI___RBR_ * 'tv_decl * 'tv_block * 'tv_binding * 'tv___anonymous_2 * 'tv___anonymous_1 * 'tv___anonymous_0)

and menhir_end_marker =
  0
