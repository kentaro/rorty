defmodule Rorty.Builtins do
  @functions %{
    "puts" => [module: IO, name: :puts]
  }

  def function_for(name) do
    @functions[name]
  end
end
