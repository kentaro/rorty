defmodule Toyex.Ast.Expr.Boolean do
  defstruct [:value]

  @type value :: boolean()
  @type t :: %Toyex.Ast.Expr.Boolean{
          value: value
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "boolean(#{expr.value})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Boolean do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Boolean
end
