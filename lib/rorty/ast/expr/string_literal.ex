defmodule Rorty.Ast.Expr.StringLiteral do
  defstruct [:value]

  @type value :: String.t()
  @type t :: %Rorty.Ast.Expr.StringLiteral{
          value: value
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "string(#{expr.value})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.StringLiteral do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.StringLiteral
end
