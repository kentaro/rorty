defmodule Rorty.Ast.Expr.Identifier do
  defstruct [:name]

  @type name :: String.t()
  @type t :: %Rorty.Ast.Expr.Identifier{
          name: name
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "identifier(#{expr.name})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Identifier do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Identifier
end
