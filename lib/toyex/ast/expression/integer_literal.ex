defmodule Toyex.Ast.Expression.IntegerLiteral do
  defstruct [:value]

  @type value :: integer()
  @type t :: %Toyex.Ast.Expression.IntegerLiteral{
          value: value
        }

  @behaviour Toyex.Ast.Expression

  def to_string(expr) do
    "integer(#{expr.value})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expression.IntegerLiteral do
  def to_string(expr) do
    Toyex.Ast.Expression.IntegerLiteral.to_string(expr)
  end
end
