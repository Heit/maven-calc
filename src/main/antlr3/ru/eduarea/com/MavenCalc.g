grammar MavenCalc;

@lexer::header{ package ru.eduarea.com; import java.util.HashMap;}
@parser::header{ package ru.eduarea.com; import java.util.HashMap;}

@parser::members {

  HashMap memory = new HashMap();

  public MavenCalcParser() {
    super(null);
  }

  public void process(String source) throws Exception {
    ANTLRStringStream in = new ANTLRStringStream(source);
    MavenCalcLexer lexer = new MavenCalcLexer(in);
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    super.setTokenStream(tokens);
    this.prog();
  } 
}


prog:   stat+ ;

stat:   expr NEWLINE {System.out.println($expr.value);}
    |   ID '=' expr NEWLINE {memory.put($ID.text, new Float($expr.value));}
    |   NEWLINE
    ;

expr returns [float value]
    :   e=multExpr {$value = $e.value;}
        ('+' e=multExpr {$value += $e.value;}
        |'-' e=multExpr {$value -= $e.value;}
        )*
    ;

multExpr returns [float value]
    :   e=atom {$value = $e.value;} 
        ('*' e=atom {$value *= $e.value; }
        |'/' e=atom {$value /= $e.value; }
        )*   
    ;

atom returns [float value]
    :   FLOAT {$value = Float.parseFloat($FLOAT.text);}
    |   ID  {
             Float v = (Float)memory.get($ID.text);
             if ( v!=null ) $value = v.floatValue();
              else System.err.println("undefined variable "+$ID.text);
            }
    |   '(' expr ')' {$value = $expr.value;}
    ;

ID  :   ('a'..'z'|'A'..'Z')+ ;
FLOAT : ('0'..'9'+'\.')?'0'..'9'+ ;
NEWLINE:'\r'? '\n' ;
WS  :   (' '|'\t')+ {skip();} ;