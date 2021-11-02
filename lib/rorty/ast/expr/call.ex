defmodule Rorty.Ast.Expr.Call do
  defstruct [:name, :args]

  @type name :: String.t()
  @type args :: [Rorty.Ast.Expr.t()]
  @type t :: %Rorty.Ast.Expr.Call{
          name: name,
          args: args
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "#{expr.name}(#{Enum.join(expr.args, ", ")})"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Call do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Call
end
