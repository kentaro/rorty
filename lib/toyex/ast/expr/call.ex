defmodule Toyex.Ast.Expr.Call do
  defstruct [:name, :args]

  @type name :: String.t()
  @type args :: [Toyex.Ast.Expr.t()]
  @type t :: %Toyex.Ast.Expr.Call{
          name: name,
          args: args
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "#{expr.name}(#{Enum.join(expr.args, ", ")})"
  end
end
