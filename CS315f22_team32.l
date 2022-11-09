STRING_VALUE ~.*~
BEGIN_PROGRAM begin\{
END_PROGRAM \}end
INTEGER int
DOUBLE double
NULL_VALUE null
BOOLEAN bool
STRING str
LETTER letter
TRUE true
FALSE false
CHAR char
VOID void
LETTER_VALUE [a-zA-Z$_!?]
CHAR_VALUE '[a-zA-Z$_!?]'
UNSIGNED_INT [0-9]+
SIGNED_INT [+-]{UNSIGNED_INT}
UNSIGNED_DOUBLE [0-9]*\.[0-9]+
SIGNED_DOUBLE [+-]{UNSIGNED_DOUBLE}
COMMA \,
LCURLY \{
RCURLY \}
LP \(
RP \)
MULT_OPR \*
DIV_OPR \/
ADD_OPR \+
ADD_ONE \+\+
SUB_OPR \-
SUB_ONE \-\-
MOD_OPR \%
ASSIGN_OPR \=
EQUAL_OPR \=\=
NOT_EQUAL_OPR \!\=\=\!
GTE_OPR \>\=
GT_OPR \>
LTE_OPR \<\=
LT_OPR \<
SEMICOLON \;
DOT \.
AND_OPR AND
OR_OPR OR
COMMENT ##.*##
PRINT print
SCAN scan
FOR_LOOP for
WHILE_LOOP while
IF if
ELSE else 
READ_TEMP readTemp
READ_HUMIDITY readHumidity
READ_PRESSURE readPressure
READ_AIRQ readAirQuality
READ_LIGHT readLight
READ_SOUND readSound
READ_TIME readTime
SET_ACTUATOR setActuator
CONNECT connect
SEND send
RECEIVE receive
ACTUATOR motor|valve|hydraulic_cylinder|servo|solenoid|thermal_actuator|linear_motor|pneumatic_actuator|stepper_motor|comb_drive
COMPONENT (air|temp|humidity|pressure|light|sound|time)Component
IDENTIFIER {LETTER_VALUE}({LETTER_VALUE}|{UNSIGNED_INT})*
FUNCTION {IDENTIFIER}{LP}({BOOLEAN}|{STRING}|{INTEGER}|{DOUBLE}|{LETTER})\ {IDENTIFIER}{RP}
%%
{STRING_VALUE} return (STRING_VALUE);
{BEGIN_PROGRAM} return (BEGIN_PROGRAM);
{END_PROGRAM} return (END_PROGRAM);
{SIGNED_INT} return (SIGNED_INT);
{SIGNED_DOUBLE} return (SIGNED_DOUBLE);
{UNSIGNED_INT} return (UNSIGNED_INT);
{UNSIGNED_DOUBLE} return (UNSIGNED_DOUBLE);
{INTEGER} return (INTEGER);
{DOUBLE} return (DOUBLE);
{NULL_VALUE} return (NULL_VALUE);
{BOOLEAN} return (BOOLEAN);
{STRING} return (STRING);
{LETTER} return (LETTER);
{TRUE} return (TRUE);
{FALSE} return (FALSE);
{CHAR} return (CHAR);
{VOID} return (VOID);
{LETTER_VALUE} return (LETTER_VALUE);
{CHAR_VALUE} return (CHAR_VALUE);
{COMMA} return (COMMA);
{DOT} return (DOT);
{LCURLY} return (LCURLY);
{RCURLY} return (RCURLY);
{LP} return (LP);
{RP} return (RP);
{MULT_OPR} return (MULT_OPR);
{DIV_OPR} return (DIV_OPR);
{ADD_OPR} return (ADD_OPR);
{ADD_ONE} return (ADD_ONE);
{SUB_OPR} return (SUB_OPR);
{SUB_ONE} return (SUB_ONE);
{MOD_OPR} return (MOD_OPR);
{ASSIGN_OPR} return (ASSIGN_OPR);
{EQUAL_OPR} return (EQUAL_OPR);
{NOT_EQUAL_OPR} return (NOT_EQUAL_OPR);
{GTE_OPR} return (GTE_OPR);
{GT_OPR} return (GT_OPR);
{LTE_OPR} return (LTE_OPR);
{LT_OPR} return (LT_OPR);
{AND_OPR} return (AND_OPR);
{OR_OPR} return (OR_OPR);
{COMMENT} return (COMMENT);
{PRINT} return (PRINT);
{SCAN} return (SCAN);
{FOR_LOOP} return (FOR_LOOP);
{WHILE_LOOP} return (WHILE_LOOP);
{IF} return (IF);
{ELSE} return (ELSE);
{READ_TEMP} return (READ_TEMP);
{READ_HUMIDITY} return (READ_HUMIDITY);
{READ_PRESSURE} return (READ_PRESSURE);
{READ_AIRQ} return (READ_AIRQ);
{READ_LIGHT} return (READ_LIGHT);
{READ_SOUND} return (READ_SOUND);
{READ_TIME} return (READ_TIME);
{ACTUATOR} return (ACTUATOR);
{SET_ACTUATOR} return (SET_ACTUATOR);
{CONNECT} return (CONNECT);
{SEND} return (SEND);
{RECEIVE} return (RECEIVE);
{COMPONENT} return (COMPONENT);
{IDENTIFIER} return (IDENTIFIER);
{SEMICOLON} return ( SEMICOLON);
{FUNCTION} return (FUNCTION);
\n { yylineno++; }
[ \t\n] ;
. ;
%%
int yywrap() { return 1; }
