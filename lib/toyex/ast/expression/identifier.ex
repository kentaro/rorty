defmodule Toyex.Ast.Expression.Identifier do
  defstruct [:name]

  @type name :: String.t()
  @type t :: %Toyex.Ast.Expression.Identifier{
          name: name
        }

  @behaviour Toyex.Ast.Expression

  def to_string(expr) do
    "identifier(#{expr.name})"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expression.Identifier do
  def to_string(expr) do
    Toyex.Ast.Expression.Identifier.to_string(expr)
  end
end
