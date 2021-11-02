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
          ast: :boolean,
          help: :boolean
        ],
        aliases: [
          f: :file,
          e: :eval,
          a: :ast,
          h: :help
        ]
      )

    case parse do
      {[file: file], _, _} ->
        [file: file]

      {[ast: true, file: file], _, _} ->
        [ast: true, file: file]

      {[eval: src], _, _} ->
        [eval: src]

      {[ast: true, eval: src], _, _} ->
        [ast: true, eval: src]

      {[ast: true], _, _} ->
        :help

      {[help: true], _, _} ->
        :help

      x ->
        IO.inspect(x)
    end
  end

  def process(file: file) do
    Toyex.run_from_file(file)
  end

  def process(ast: true, file: file) do
    Toyex.parse_from_file(file)
    |> IO.inspect()
  end

  def process(eval: src) do
    Toyex.run(src)
  end

  def process(ast: true, eval: src) do
    Toyex.parse(src)
    |> IO.inspect()
  end

  def process(:help) do
    IO.puts("""
    usage: toyex [options] [args]

    # Options

    -e / --eval <program>
    -f / --file <program file>
    -a / --ast  show parse tree. This option must be used with either -e or -f
    -h / --help show help message
    """ |> String.trim())

    System.halt(0)
  end
end
