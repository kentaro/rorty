defmodule Rorty.Ast.Expr.Def do
  defstruct [:name, :args, :body]

  @type name :: String.t()
  @type args :: [String.t()]
  @type body :: Rorty.Ast.Expr.t()
  @type t :: %Rorty.Ast.Expr.Def{
          name: name,
          args: args,
          body: body
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "def #{expr.name} (#{Enum.join(expr.args, ", ")}) { #{expr.body} }"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Def do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Def
end
