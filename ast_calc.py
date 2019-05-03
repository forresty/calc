# ast_calc.py
import ast
import operator

class Calculator(ast.NodeVisitor):
  _BIN_OP_MAP = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.div
  }
  _UNARY_OP_MAP = {
    ast.UAdd: operator.pos,
    ast.USub: operator.neg
  }

  def compute(self, expression):
    tree = ast.parse(expression)
    return self.visit(tree.body[0])

  def visit_Expr(self, node):
    return self.visit(node.value)

  def visit_BinOp(self, node):
    left = self.visit(node.left)
    right = self.visit(node.right)
    return self._BIN_OP_MAP[type(node.op)](left, right)

  def visit_UnaryOp(self, node):
    child = self.visit(node.operand)
    return self._UNARY_OP_MAP[type(node.op)](child)

  def visit_Num(self, node):
    return node.n


# calc = Calculator()
# print(calc.compute('(3 + 11) * 5'))
# print(calc.compute('(+3 + 11) * 5'))
# print(calc.compute('(-3 + 11) * 5'))
# print(calc.compute('(--3 + 11) * 5'))
# print(calc.compute('(-(3 + 11)) * 5'))
