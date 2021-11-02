defmodule Rorty.Ast.Expr.While do
  defstruct [:condition, :body]

  @type condition :: Rorty.Ast.Expr.t()
  @type body :: Rorty.Ast.Expr.t()
  @type t :: %Rorty.Ast.Expr.While{
          condition: condition,
          body: body
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "while #{expr.condition} : #{expr.body}"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.While do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.While
end
