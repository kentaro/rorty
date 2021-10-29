defmodule Toyex.Ast.Expr.Def do
  defstruct [:name, :args, :body]

  @type name :: String.t()
  @type args :: [String.t()]
  @type body :: Toyox.Ast.Expr.t()
  @type t :: %Toyex.Ast.Expr.Def{
          name: name,
          args: args,
          body: body
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "def #{expr.name} (#{Enum.join(expr.args, ", ")}) { #{expr.body} }"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expr.Def do
  defdelegate to_string(expr), to: Toyex.Ast.Expr.Def
end
