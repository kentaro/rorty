defmodule Toyex.Ast.Expression.Binary do
  defstruct [:operator, :left, :right]

  @type t :: %Toyex.Ast.Expression.Binary{
          operator: Toyox.Operator.t(),
          left: Toyox.Ast.Expression.t(),
          right: Toyox.Ast.Expression.t()
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
