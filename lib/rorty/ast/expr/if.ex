defmodule Rorty.Ast.Expr.If do
  defstruct [:condition, :then, :otherwise]

  @type condition :: Rorty.Ast.Expr.t()
  @type then :: Rorty.Ast.Expr.t()
  @type otherwise :: Rorty.Ast.Expr.t()
  @type t :: %Rorty.Ast.Expr.If{
          condition: condition,
          then: then,
          otherwise: otherwise
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "if #{expr.condition} then: #{expr.then} otherwise: #{expr.otherwise}"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.If do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.If
end
