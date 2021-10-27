defmodule Toyex.Operator do
  @type t :: module()

  defmacro __using__(_opts) do
    quote do
      def to_string() do
        @name
      end
    end
  end
end
