defmodule Toyex.Ast.Expr.IntegerLiteral do
  defstruct [:value]

  @type value :: integer()
  @type t :: %Toyex.Ast.Expr.IntegerLiteral{
          value: value
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "integer(#{expr.value})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.IntegerLiteral do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.IntegerLiteral
end
