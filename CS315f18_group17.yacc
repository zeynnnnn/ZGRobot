%{
#include <stdio.h>
int yylex();
int yyerror();
%}
%start start
%token START DONE MOVE GRAB VARIABLE ENDSTATEMENT TYPE SENSORID ASSIGNMENTOP STRING OR AND ADDOP SUBOP MODOP MULTOP DIVOP BIGGEROREQUAL SMALLEROREQUAL SMALLER BIGGER INPUT EQUAL 
%token LP RP RETURN WHILE LOGIC NOTEQUAL INCASE NOTTHECASE SINGLECOMMENT FLOATINGPOINTNUMBER INTEGER FUN CONST ITER TURN RELEASE READDATA RECEIVEDATA SENDDATA SAY MAIN 
%%
start: program ;
program:    statements
		| 	empty ;
blockStatement: START statements DONE;
statements:	statement
		|	statements statement 
		|	statements SINGLECOMMENT
		;
statement: matched
        |   unmatched;
nonIncaseStatement: iter_statement
        |        while_statement
        |          assign_statement 
        |   function_call
		|	declarations
		|	return_statement	
		;
return_statement:	RETURN expression ;
assign_statement: VARIABLE ASSIGNMENTOP expression ;
declarations:	constant_declaration
		|	variable_declaration
		|	function_declaration;
matched: INCASE LP logic_express RP  matched NOTTHECASE matched
       	|	nonIncaseStatement ENDSTATEMENT ;
unmatched: INCASE LP logic_express RP blockStatement
       	|	INCASE LP logic_express RP matched NOTTHECASE unmatched;
iter_statement: ITER LP assign_statement  ENDSTATEMENT logic_express  ENDSTATEMENT assign_statement RP blockStatement;	
while_statement: WHILE LP logic_express RP blockStatement;            
expression: nonLogicExpression
       	|	logic_express;
nonLogicExpression: math_expression
       	|	function_call;
	
math_expression:	math_expression math_op_post math_expressionHigher
					|	math_expressionHigher;
math_expressionHigher:
						math_expressionHigher math_op_pre expressionable
					|	expressionable  ;					
expressionable: constant 
| VARIABLE;

math_op_pre: MULTOP	
		|	DIVOP
		|	MODOP
        ;
math_op_post: ADDOP
		|	SUBOP;
function_declaration: main_function_declarations
		|	function_declarations;
function_declarations: funcHead funcBody;
main_function_declarations: MAIN LP RP funcBody;
funcHead: FUN VARIABLE LP parameterList  RP;
parameterList: TYPE VARIABLE
		|	  TYPE VARIABLE  ',' loo
		|	empty;
loo: TYPE VARIABLE  ',' loo
	 |	TYPE VARIABLE;
funcBody: blockStatement;
constant_declaration:	CONST TYPE assign_statement;
variable_declaration: TYPE VARIABLE
		|	TYPE assign_statement;
logic_express: logic_express logical_op nonLogicExpression	
		|	nonLogicExpression logical_op nonLogicExpression ;
logical_op: EQUAL
        |	NOTEQUAL	
		|	BIGGEROREQUAL
		|	SMALLEROREQUAL
		|	SMALLER
		|	BIGGER
		|	AND
        |	OR
        ;
function_call:	moveCall
	    	|	sayCall
          	|	turnCall
          	|	grabCall
          	|	releaseCall
          	|	readDataCall
          	|	sendDataCall
          	|	receiveDataCall
	        |	otherFunctionCalls	
			|   inputCall;
inputCall: INPUT LP  RP ;
otherFunctionCalls:	VARIABLE LP param RP;
param: expression
    |	expression ','  kal
	|	empty;
kal: expression ','  kal
	 |	expression;
sayCall: SAY LP STRING RP;
moveCall: MOVE LP RP;
turnCall: TURN LP STRING RP;
grabCall: GRAB LP  RP;
releaseCall: RELEASE LP RP;
readDataCall: READDATA LP SENSORID RP;
sendDataCall: SENDDATA LP RP;
receiveDataCall: RECEIVEDATA LP RP;
constant: STRING
|	INTEGER
|	FLOATINGPOINTNUMBER
|	LOGIC;
empty: ;
%%
#include "lex.yy.c"
int line_number;
int yyerror( char *s ) { 
							printf("Syntax error on line %d !!!", line_number);
						}
int main() {
	if(yyparse()==0)
		printf("Input program is valid.\n");
    return 0;
	  
}


