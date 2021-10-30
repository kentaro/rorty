defmodule Toyex.Ast.Expr.Block do
  defstruct [:stmts]

  @type stmts :: [Toyox.Ast.Expr.t()]
  @type t :: %Toyex.Ast.Expr.Block{
          stmts: stmts
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "#{expr.stmts}"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Block do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Block
end
