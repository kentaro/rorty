defmodule Rorty.Ast.Expr.Assignment do
  defstruct [:name, :value]

  @type name :: String.t()
  @type value :: Upg.Ast.Expr.t()
  @type t :: %Rorty.Ast.Expr.Assignment{
          name: name,
          value: value
        }

  @behaviour Rorty.Ast.Expr

  def to_string(expr) do
    "#{expr.name} = #{expr.value}"
  end
end

defimpl String.Chars, for: Rorty.Ast.Expr.Assignment do
  defdelegate to_string(expr), to: Rorty.Ast.Expr.Assignment
end
