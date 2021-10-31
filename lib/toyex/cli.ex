defmodule Toyex.Cli do
  def main(argv) do
    parse_argv(argv)
    |> process
  end

  def parse_argv(argv) do
    parse =
      OptionParser.parse(argv,
        switches: [
          file: :string,
          eval: :string,
          help: :boolean
        ],
        aliases: [
          f: :file,
          e: :eval,
          h: :help
        ]
      )

    case parse do
      {[file: file], _, _} ->
        {:file, file}

      {[eval: src], _, _} ->
        {:eval, src}

      {[help: true], _, _} ->
        :help

      _ ->
        :help
    end
  end

  def process({:file, file}) do
    Toyex.run_from_file(file)
  end

  def process({:eval, src}) do
    Toyex.run(src)
  end

  def process(:help) do
    IO.puts("""
    usage: toyex [options] [args]

    # Options

    -e <program>
    -f <program file>
    -h: help
    """)

    System.halt(0)
  end
end
