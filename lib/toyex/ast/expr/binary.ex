defmodule Toyex.Ast.Expr.Binary do
  defstruct [:operator, :left, :right]

  @type operator :: Toyox.Operator.t()
  @type left :: Toyox.Ast.Expr.t()
  @type right :: Toyox.Ast.Expr.t()
  @type t :: %Toyex.Ast.Expr.Binary{
          operator: operator,
          left: left,
          right: right
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "#{expr.operator.to_string()}(#{expr.left}, #{expr.right})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Binary do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Binary
end
