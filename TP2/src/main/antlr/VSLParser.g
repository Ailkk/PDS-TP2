parser grammar VSLParser;

options {
  language = Java;
  tokenVocab = VSLLexer;
}

@header {
  package TP2;

  import java.util.stream.Collectors;
  import java.util.Arrays;
}


// TODO : other rules

program returns [TP2.ASD.Program out]
    : e=expression EOF { $out = new TP2.ASD.Program($e.out); } // TODO : change when you extend the language
    ;

expression returns [TP2.ASD.Expression out]
    : l=factor PLUS r=expression  { $out = new TP2.ASD.AddExpression($l.out, $r.out); }
    | l=factor MOINS r=expression  { $out = new TP2.ASD.SubExpression($l.out, $r.out); }
    | f=factor { $out = $f.out; }
    // TODO : that's all?
    ;

factor returns [TP2.ASD.Expression out]
    : p=primary { $out = $p.out; }
    | LP l=factor MULTI r=expression RP { $out = new TP2.ASD.MulExpression($l.out, $r.out); }
    | LP l=factor DIVI r=expression RP { $out = new TP2.ASD.DivExpression($l.out, $r.out); }
    | l=factor MULTI r=expression  { $out = new TP2.ASD.MulExpression($l.out, $r.out); }
    | l=factor DIVI r=expression  { $out = new TP2.ASD.DivExpression($l.out, $r.out); }
    | LP l=factor PLUS r=expression RP { $out = new TP2.ASD.AddExpression($l.out, $r.out); }
    | LP l=factor MOINS r=expression RP { $out = new TP2.ASD.SubExpression($l.out, $r.out); }
    // TODO : that's all?
    ;

primary returns [TP2.ASD.Expression out]
    : INTEGER { $out = new TP2.ASD.IntegerExpression($INTEGER.int); }
    // TODO : that's all?
    ;
