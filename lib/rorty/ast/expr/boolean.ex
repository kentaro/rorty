defmodule Rorty.Ast.Expr.Boolean do
  defstruct [:value]

  @type value :: boolean()
  @type t :: %Rorty.Ast.Expr.Boolean{
          value: value
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "boolean(#{expr.value})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Boolean do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Boolean
end
