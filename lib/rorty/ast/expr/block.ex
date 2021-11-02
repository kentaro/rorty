defmodule Rorty.Ast.Expr.Block do
  defstruct [:exprs]

  @type exprs :: [Rorty.Ast.Expr.t()]
  @type t :: %Rorty.Ast.Expr.Block{
          exprs: exprs
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "#{expr.exprs}"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Block do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Block
end
