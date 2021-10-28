defmodule Toyex.Ast.Expr.While do
  defstruct [:condition, :body]

  @type condition :: Toyox.Ast.Expr.t()
  @type body :: Toyox.Ast.Expr.t()
  @type t :: %Toyex.Ast.Expr.While{
          condition: condition,
          body: body
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "while #{expr.condition} : #{expr.body}"
  end
end
