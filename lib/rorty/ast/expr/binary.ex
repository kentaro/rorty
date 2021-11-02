defmodule Rorty.Ast.Expr.Binary do
  defstruct [:operator, :left, :right]

  @type operator :: Rorty.Operator.t()
  @type left :: Rorty.Ast.Expr.t()
  @type right :: Rorty.Ast.Expr.t()
  @type t :: %Rorty.Ast.Expr.Binary{
          operator: operator,
          left: left,
          right: right
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "#{expr.operator.to_string()}(#{expr.left}, #{expr.right})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Binary do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Binary
end
