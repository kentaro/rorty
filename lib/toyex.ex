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
        src |> String.trim() |> parse()
      rescue
        e in Neotomex.Grammar.ParseError ->
          e |> handle_exception()
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

  @spec parse(src :: String.t()) :: [%Toyex.Ast.Expr{}]
  def parse(src) do
    src |> String.trim() |> Toyex.Grammar.parse!()
  end

  defp handle_exception(ex) do
    if ex.error do
      IO.puts("Error: reason: #{ex.error}, message: #{ex.description}")
    else
      IO.puts("Error: #{ex.description}")
    end

    System.halt(1)
  end
end
