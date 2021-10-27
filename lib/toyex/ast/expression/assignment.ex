defmodule Toyex.Ast.Expression.Assignment do
  defstruct [:name, :value]

  @type name :: String.t()
  @type value :: Toyox.Ast.Expression.t()
  @type t :: %Toyex.Ast.Expression.Assignment{
          name: name,
          value: value
        }

  @behaviour Toyex.Ast.Expression

  def to_string(expr) do
    "#{expr.name} = #{expr.value}"
  end
end

defimpl String.Chars, for: Toyex.Ast.Expression.Assignment do
  def to_string(expr) do
    Toyex.Ast.Expression.Assignment.to_string(expr)
  end
end
