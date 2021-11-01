defmodule Toyex do
  @moduledoc """
  Documentation for `Toyex`.
  """

  @doc """
  Reeceive

  ## Examples

    iex> Toyex.run("1 + 1")
    2
  """
  @spec run(String.t()) :: integer()
  def run(src) do
    ast =
      try do
        src |> String.trim() |> Toyex.Grammar.parse!()
      rescue
        e in Neotomex.Grammar.ParseError ->
          Neotomex.Grammar.ParseError.message(e)
          |> handle_error()
      end

    {result, _} = Toyex.Interpreter.interpret(ast, %Toyex.Env{})
    result
  end

  @doc """
  Reeceive

  ## Examples

    # iex> Toyex.run_from_file("examples/factorial.toyex")
    # 120
  """
  @spec run_from_file(String.t()) :: integer()
  def run_from_file(filename) do
    {:ok, src} = filename |> File.read()
    run(src)
  end

  defp handle_error(message) do
    IO.puts("Error: #{message}")
    System.halt(1)
  end
end
