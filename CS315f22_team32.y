%{
#include <stdio.h>
#include <stdlib.h>
%}

%token STRING_VALUE
%token BEGIN_PROGRAM
%token END_PROGRAM
%token INTEGER
%token DOUBLE
%token NULL_VALUE
%token BOOLEAN
%token STRING
%token LETTER
%token TRUE
%token FALSE
%token CHAR
%token VOID
%token LETTER_VALUE
%token CHAR_VALUE
%token UNSIGNED_INT
%token SIGNED_INT
%token UNSIGNED_DOUBLE
%token SIGNED_DOUBLE
%token COMMA
%token DOT
%token LCURLY
%token RCURLY
%token LP
%token RP
%token MULT_OPR
%token DIV_OPR
%token ADD_OPR
%token ADD_ONE
%token SUB_OPR
%token SUB_ONE
%token MOD_OPR
%token ASSIGN_OPR
%token EQUAL_OPR
%token NOT_EQUAL_OPR
%token GTE_OPR
%token GT_OPR
%token LTE_OPR
%token LT_OPR
%token SEMICOLON
%token AND_OPR
%token OR_OPR
%token COMMENT
%token PRINT
%token SCAN
%token FOR_LOOP
%token WHILE_LOOP
%token IF
%token ELSE
%token READ_TEMP
%token READ_HUMIDITY
%token READ_PRESSURE
%token READ_AIRQ 
%token READ_LIGHT 
%token READ_SOUND 
%token READ_TIME 
%token SET_ACTUATOR 
%token CONNECT 
%token SEND 
%token RECEIVE 
%token ACTUATOR 
%token COMPONENT
%token IDENTIFIER
%token FUNCTION 
%%

program:   BEGIN_PROGRAM main END_PROGRAM;

main:	statements;

statements:	statement SEMICOLON statements
		| 
		;

statement:	expression
		| assignment_exp
		| loop
		| comment
		| if_stmt
		| print_stmt
		| scan_stmt
		| idntf_definition
		| function
		| built_in_function
		;

type:	number_types
	| null
	| bool
	| str
	| letter
	| void
	;

type_name:	INTEGER | DOUBLE | NULL_VALUE | BOOLEAN | STRING | LETTER | VOID ;

bool:	TRUE
	| FALSE
	;
	
null:	NULL_VALUE;

void:	VOID;

letter: LETTER_VALUE;

str: STRING_VALUE;

int:	 unsigned_int 
	| signed_int
	;
	
signed_int: SIGNED_INT;

unsigned_int: UNSIGNED_INT;

double: signed_double
	| unsigned_double
	;
		
signed_double: 	SIGNED_DOUBLE;

unsigned_double: 	UNSIGNED_DOUBLE;

idntf_definition:	type_name idntf;

idntf:	IDENTIFIER;

higher_precedence:	multiply_opr
			| division_opr
			| mod_opr
			;

lower_precedence:	addition_opr
			| subtraction_opr
			;

multiply_opr:	MULT_OPR;

division_opr:	DIV_OPR;

addition_opr:	ADD_OPR;

subtraction_opr:	SUB_OPR;

mod_opr:	MOD_OPR;

assign_opr:	ASSIGN_OPR;

expression :	logical_exp 
| increment_exp
| subtract_exp 
		| arithmetic_exp
		;

increment_exp: 	int ADD_ONE
			| double ADD_ONE
			| idntf ADD_ONE
			;
subtract_exp:	int SUB_ONE
		| double SUB_ONE
		| idntf SUB_ONE
		;
assignment_exp: 	idntf assign_opr expression
			| idntf assign_opr type
			;

arithmetic_exp:	arithmetic_exp lower_precedence term
| term
;	

term:	term higher_precedence factor
	| factor
	;

factor:	LP expression RP
	| number_types
	| LP idntf RP
	;
	
number_types:	int | double;

logical_exp: 	logical_exp_operands compare_opr logical_exp_operands
		;
		
logical_exp_operands: number_types | LP expression RP | idntf;

compare_opr: NOT_EQUAL_OPR 
		| EQUAL_OPR
		| GTE_OPR 
| LTE_OPR 
| GT_OPR
| LT_OPR 
| AND_OPR
| OR_OPR
;

loop:	while_loop
	| for_loop
	;

while_loop: 	WHILE_LOOP LP logical_exp RP LCURLY statements RCURLY;

for_loop: 	FOR_LOOP LP assignment_exp  SEMICOLON  logical_exp  SEMICOLON  for_exp RP LCURLY statements RCURLY;
 
for_exp:	increment_exp 
		| subtract_exp  
		| arithmetic_exp
;

if_stmt:	single_if_stmt
			| if_else_stmt
			;
			
single_if_stmt:	IF LP logical_exp RP LCURLY statements RCURLY
			;

if_else_stmt:	IF LP logical_exp RP LCURLY statements RCURLY ELSE LCURLY statements RCURLY
			;
			
function: 	function_definition
		| function_call
		;
			
function_definition:	type_name idntf LP multiple_params_in_def RP LCURLY statements RCURLY
					|	type_name idntf LP idntf_definition RP LCURLY statements RCURLY
					;

multiple_params_in_def: idntf_definition SEMICOLON multiple_params_in_def
				|
				;

params_list: idntf SEMICOLON params_list
			| 
			;

function_call:	idntf LP params_list RP
		| idntf LP idntf RP
		;
 
comment: COMMENT;

component: COMPONENT;

print_stmt:	PRINT LP str RP
		| PRINT LP idntf RP
		;

scan_stmt: SCAN LP RP;

components_list: component SEMICOLON components_list
                        |
                        ;

built_in_function: READ_TEMP LP components_list RP 
		| READ_HUMIDITY LP components_list RP
		| READ_PRESSURE LP components_list RP
		| READ_AIRQ LP components_list RP
		| READ_LIGHT LP components_list RP
		| READ_SOUND LP components_list RP
		| READ_TIME LP components_list RP
		| CONNECT LP str RP
		| SEND LP int COMMA str RP 
		| RECEIVE LP str RP
		| ACTUATOR DOT SET_ACTUATOR LP bool RP
		;

%%
#include "lex.yy.c"

void yyerror(char *s) {
	
	fprintf(stderr, "Syntax error on line: %d, %s\n", yylineno, s);
}

int main(){
yyparse();
printf( "\n Last reached line: \n");
fprintf(stdout, "%d\n", yylineno);
if(yynerrs < 1){
	printf("Syntax is completely correct! \n");
}
return 0;	
}



