defmodule Toyex.Ast.Expr.Assignment do
  defstruct [:name, :value]

  @type name :: String.t()
  @type value :: Toyox.Ast.Expr.t()
  @type t :: %Toyex.Ast.Expr.Assignment{
          name: name,
          value: value
        }

  @behaviour Toyex.Ast.Expr

  def to_string(expr) do
    "#{expr.name} = #{expr.value}"
  end
end
