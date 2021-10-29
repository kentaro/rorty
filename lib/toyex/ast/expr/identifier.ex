defmodule Toyex.Ast.Expr.Identifier do
  defstruct [:name]

  @type name :: String.t()
  @type t :: %Toyex.Ast.Expr.Identifier{
          name: name
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "identifier(#{expr.name})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Identifier do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Identifier
end
