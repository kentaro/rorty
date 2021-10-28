defmodule Toyex.Ast.Expr.If do
  defstruct [:condition, :then, :otherwise]

  @type condition :: Toyox.Ast.Expr.t()
  @type then :: Toyox.Ast.Expr.t()
  @type otherwise :: Toyox.Ast.Expr.t()
  @type t :: %Toyex.Ast.Expr.If{
          condition: condition,
          then: then,
          otherwise: otherwise
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "if #{expr.condition} then: #{expr.then} otherwise: #{expr.otherwise}"
  end
end
