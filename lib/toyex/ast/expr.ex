defmodule Toyex.Ast.Expr do
  defstruct []
  @type t :: %Toyex.Ast.Expr{}
  @callback to_string(expr :: Toyex.Ast.Expr.t()) :: String.t()

  defmacro __using__(_opts) do
    quote do
      defimpl String.Chars, for: __MODULE__ do
        def to_string(expr) do
          __MODULE__.to_string(expr)
        end
      end
    end
  end
end
