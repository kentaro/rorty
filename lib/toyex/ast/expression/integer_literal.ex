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
