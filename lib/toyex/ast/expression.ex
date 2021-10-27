defmodule Toyex.Ast.Expression do
  defstruct []
  @type t :: %Toyex.Ast.Expression{}
  @callback to_string(expr :: Toyex.Ast.Expression.t()) :: String.t()
end
