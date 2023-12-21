
%token <int> INT
%token <string> IDEN
// %token <string> STRING
%token DOT
%token COLON
%token SEMI
%token COMMA
%token EQ
%token VAR
%token LET
%token TYPE
// %token STRUCT
// %token ENUM
// %token BITFIELD
// %token OPAQUE
%token USE
%token FUN
%token LPAR
%token RPAR
// %token LSQ
// %token RSQ
%token LBR
%token RBR

%type <Ast.expr> expr
%type <Ast.decl> vardecl
%type <Ast.decl> fundecl
%type <Ast.decl> typedef
%type <Ast.meta> meta
%type <Ast.decl> decl
%type <Ast.binding> binding
%type <Ast.ibinding> ibinding

%start <Ast.prog> prog
%%

let prog :=
  | metas = meta*; decls = decl*;
		{ (Array.of_list metas, Array.of_list decls) }

let meta :=
  | USE; n = separated_nonempty_list(COMMA, qual); SEMI;
		{ Ast.UseMeta (Array.of_list n) }

let decl == vardecl | fundecl | typedef

let varletkw == VAR; { true } | LET; { false }

let binding :=
	n = IDEN;
	t = preceded(COLON, ty);
	{ (n, t) }

let ibinding :=
	n = IDEN;
	t = preceded(COLON, ty)?;
	{ (n, t) }

let vardecl :=
	m = varletkw; b = ibinding;
	v = preceded(EQ, expr)?;
	{ Ast.VarDecl (m, b, v) }

let either(X, Y) := X | Y

let fundecl :=
	FUN; n = IDEN;
	a = delimited(LPAR, separated_list(COMMA, binding), RPAR);
	t = preceded(COLON, ty)?;
	b = either(b = block; {Some b}, SEMI; {None});
	{ Ast.FunDecl ((n, t), Array.of_list a, b) }

let typedef :=
	TYPE; n = qual; EQ; t = ty;
	{ Ast.Tydef (Ast.AliasTydef (n, t)) }

let qual := l = separated_nonempty_list(DOT, x = IDEN; {x});
	{ Array.of_list l }

let block :=
	s = delimited(LBR, list(terminated(stmt, SEMI)), RBR);
	tail = stmt?;
	{ (Array.of_list s, tail) }

let stmt :=
	| e = expr; { Ast.ExprStmt e }
	| d = decl; { Ast.DeclStmt d }

let expr :=
	| b = block; { Ast.BlockExpr b }
	| n = IDEN; { Ast.VarExpr n }
	| i = INT; { Ast.IntExpr i }

let ty := n = qual; { Ast.NameTy n }
