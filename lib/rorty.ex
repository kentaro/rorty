defmodule Rorty do
  @moduledoc """
  Documentation for `Rorty`.
  """

  @doc """
  Reeceive

  ## Examples

    iex> Rorty.run("1 + 1")
    2
  """
  @spec run(String.t()) :: term()
  def run(src) do
    {result, _} =
      src
      |> parse()
      |> Rorty.Interpreter.interpret(%Rorty.Env{})

    result
  end

  @doc """
  Reeceive

  ## Examples

    # iex> Rorty.run_from_file("examples/factorial.rorty")
    # 120
  """
  @spec run_from_file(String.t()) :: term()
  def run_from_file(filename) do
    {:ok, src} = filename |> File.read()
    src |> run()
  end

  @spec parse(src :: String.t()) :: [%Rorty.Ast.Expr{}]
  def parse(src) do
    try do
      src |> String.trim() |> Rorty.Grammar.parse!()
    rescue
      e in Neotomex.Grammar.ParseError ->
        e |> handle_exception()
    end
  end

  @spec parse_from_file(String.t()) :: [%Rorty.Ast.Expr{}]
  def parse_from_file(filename) do
    {:ok, src} = filename |> File.read()
    src |> parse()
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
