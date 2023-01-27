CC     = gcc
CXX    = gcc
LEX    = lex
YACC	= yacc
LEX_SPECS  = CS315f18_group17
YACC_SPECS = CS315f18_group17
PROG = parser

all: $(PROG)

lex.yy.c: $(LEX_SPECS).lex
	$(LEX) $(LEX_SPECS).lex  

y.tab.c: $(YACC_SPECS).yacc lex.yy.c
	$(YACC) $(YACC_SPECS).yacc

$(PROG):   y.tab.c lex.yy.c
	   $(CXX) -o $(PROG) y.tab.c

test:	
	./$(PROG) < CS315f18_group17.test

clean:
	-rm -f lex.yy.c
	-rm -f $(PROG)
	-rm -f y.tab.c

