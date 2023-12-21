
type iden = string
type qual = iden array

type binop =
	| Add | Sub | Mul | Div | Mod
	(* TODO *)

type binding = iden * ty
and ibinding = iden * ty option
and enumdef = iden * expr
and bitdecl = int * iden * ty option
and decl =
	| VarDecl of bool * ibinding * expr option
	| FunDecl of ibinding * binding array * block option
	| Tydef of tydef
and tydef =
	| AliasTydef of qual * ty
	| OpaqueTydef of qual * ty
	| StructTydef of qual * ty option * binding array
	| BitfieldTydef of qual * ty * bitdecl array
	| EnumTydef of qual * ty option * enumdef array
and ty =
	| NameTy of qual
	| PtrTy of ty
	| MutTy of ty
	| ArrTy of expr option * ty
and stmt =
	| ExprStmt of expr
	| DeclStmt of decl
and block = stmt array * stmt option
and expr =
	| VarExpr of iden
	| IntExpr of int
	| BlockExpr of block
	| BinOpExpr of expr * binop * expr
	| IfExpr of expr * expr * expr option
	| WhileExpr of expr * expr * expr option
	| ForExpr of iden * expr * expr * expr option

type meta =
	| UseMeta of qual array

type prog = meta array * decl array

