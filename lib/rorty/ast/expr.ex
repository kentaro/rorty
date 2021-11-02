defmodule Rorty.Ast.Expr do
  defstruct []
  @type t :: %Rorty.Ast.Expr{}
  @callback to_string(expr :: Rorty.Ast.Expr.t()) :: String.t()
end
