%token <int> INT
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token EOL
%token DOT

%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */

%start<unit> main

%%

main:
| nothing expr EOL
    {}

/* Added just to exercise productions with an empty right-hand side. */
nothing:
| /* nothing */
    { Aux.print "nothing" $startpos $endpos }

/* Added just to exercise productions with an empty right-hand side, in a choice. */
optional_dot:
| nothing
| DOT
    { Aux.print "optional_dot" $startpos $endpos}

%inline operator:
  PLUS | MINUS | TIMES | DIV {}

raw_expr:
| INT
| optional_dot LPAREN nothing expr RPAREN optional_dot
| expr operator expr
| MINUS expr %prec UMINUS
    {}

expr:
  raw_expr
    { Aux.print "expr" $startpos $endpos }

