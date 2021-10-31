defmodule Toyex.Ast.Expr.Block do
  defstruct [:exprs]

  @type exprs :: [Toyox.Ast.Expr.t()]
  @type t :: %Toyex.Ast.Expr.Block{
          exprs: exprs
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "#{expr.exprs}"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Block do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Block
end
