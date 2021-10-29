defmodule Toyex.Ast.Expr do
  defstruct []
  @type t :: %Toyex.Ast.Expr{}
  @callback to_string(expr :: Toyex.Ast.Expr.t()) :: String.t()
end
