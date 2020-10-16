package TP2.ASD;

import TP2.Llvm;
import TP2.TypeException;
import TP2.Utils;

// Concrete class for Expression: add case
  public class MulExpression extends Expression {
    Expression left;
    Expression right;

    public MulExpression(Expression left, Expression right) {
      this.left = left;
      this.right = right;
    }

    public String pp() {
      return "(" + left.pp() + " * " + right.pp() + ")";
    }

    // IR generation
    public RetExpression toIR() throws TypeException {
      RetExpression leftRet = left.toIR();
      RetExpression rightRet = right.toIR();

      if(!leftRet.type.equals(rightRet.type)) {
        throw new TypeException("type mismatch: have " + leftRet.type + " and " + rightRet.type);
      }

      leftRet.ir.append(rightRet.ir);

      String result = Utils.newtmp();

      Llvm.Instruction mul = new Llvm.Mul(leftRet.type.toLlvmType(), leftRet.result, rightRet.result, result);

      leftRet.ir.appendCode(mul);

      return new RetExpression(leftRet.ir, leftRet.type, result);
    }
  }