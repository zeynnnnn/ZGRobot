%%
"\n"	{
			extern int line_number;
			line_number++;
		}
"//".*"\n"    { return (SINGLECOMMENT);}   
[0-9]+"."[0-9]+  { return (FLOATINGPOINTNUMBER);}
"+""@"   { return (ADDOP);}
"-""@"   { return (SUBOP);}
("-"|"+")?[0-9]+  { return (INTEGER);}
\".*\" { return (STRING);}
"("     { return (LP);}
")"       { return (RP);}
"=""="      { return (EQUAL);}  
"=""/""="     { return (NOTEQUAL);} 
"="      { return (ASSIGNMENTOP);}     
"*"   { return (MULTOP);}  
"/"  { return (DIVOP);}
"%" { return (MODOP);}
"<=" { return (SMALLEROREQUAL);}
">=" { return (BIGGEROREQUAL);}
"<" { return (SMALLER);}
">" { return (BIGGER);}
"&""&" { return (AND);}
"|""|" { return (OR);}
start { return (START);}
done { return (DONE);}
inCase { return (INCASE);}
notTheCase { return (NOTTHECASE);}
const   { return (CONST);}
fun     { return (FUN);}
true    { return (LOGIC);}
false  { return (LOGIC);}
iter    { return (ITER);}
while    { return (WHILE);}
turn   { return (TURN);}
move   { return (MOVE);}
grab   { return (GRAB);}
release   { return (RELEASE);}
readData   { return (READDATA);}
receiveData   { return (RECEIVEDATA);}    
sendData   { return (SENDDATA);}
say  { return (SAY);} 
main { return (MAIN);}
input {    yyless(yyleng); 
            return (INPUT);
    }
return { return (RETURN);}
ID[0-9]+  { return (SENSORID);}
int|float|string|logic     { return (TYPE);} 
([a-z]|[A-Z])+([0-9]|[a-z]|[A-Z])*   { return (VARIABLE);}
!  { return (ENDSTATEMENT);}
"," {return yytext[0]; };
.|"\n" ;
%%
int yywrap() { return 1; }