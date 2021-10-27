defmodule Toyex.Ast.Expression.Binary do
  defstruct [:operator, :left, :right]

  @type operator :: Toyox.Operator.t()
  @type left :: Toyox.Ast.Expression.t()
  @type right :: Toyox.Ast.Expression.t()
  @type t :: %Toyex.Ast.Expression.Binary{
          operator: operator,
          left: left,
          right: right
        }

  @behaviour Toyex.Ast.Expression

  def to_string(expr) do
    "#{expr.operator.to_string()}(#{expr.left}, #{expr.right})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expression.Binary do
  def to_string(expr) do
    Toyex.Ast.Expression.Binary.to_string(expr)
  end
end
