defmodule Rorty.Ast.Expr.IntegerLiteral do
  defstruct [:value]

  @type value :: integer()
  @type t :: %Rorty.Ast.Expr.IntegerLiteral{
          value: value
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "integer(#{expr.value})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.IntegerLiteral do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.IntegerLiteral
end
