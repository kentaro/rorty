defmodule Toyex.Ast.Expr.StringLiteral do
  defstruct [:value]

  @type value :: String.t()
  @type t :: %Toyex.Ast.Expr.StringLiteral{
          value: value
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "string(#{expr.value})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.StringLiteral do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.StringLiteral
end
