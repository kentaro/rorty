# Rorty

Yet another language implementation using Elixir.

## Installation

This repository provides the Rorty interpreter as an escript.

* `mix escript.build` generates `rorty` command in your current directory.

```shell
$ mix escript.build
Generated escript rorty with MIX_ENV=dev
```

* `mix escript.install` installs `rorty` command into `$HOME/.mix/escripts`.

```shell
$ mix escript.install
Generated escript rorty with MIX_ENV=dev
Are you sure you want to replace it with "rorty"? [Yn]
* creating /Users/kentaro/.mix/escripts/rorty
```

## Usage

### --eval / -e

Evaluates the given code.

```shell
$ rorty -e "puts(1 + 1)"
2
```

### --file / -f

Reads the content of the given file and evaluates it.

```shell
$ rorty -f examples/factorial.rorty
120
```

### --ast / -a

Parses the given code and shows the parse tree. This option must be used with either `-e` or `-f` option.

```shell
$ rorty -a -e '1+1'
[
  %Rorty.Ast.Expr.Binary{
    left: %Rorty.Ast.Expr.IntegerLiteral{value: 1},
    operator: Rorty.Operator.Add,
    right: %Rorty.Ast.Expr.IntegerLiteral{value: 1}
  }
]
```

### --help / -h

Shows the help message.

## Grammar

Rorty currently supports a basic grammar.

See [lib/rorty/grammar.ex](./lib/rorty/grammar.ex) for details.

## Examples

### Factorial ([factorial.rorty](./examples/factorial.rorty))

```
def factorial(n) {
  if (n < 2) {
    1
  } else {
    n * factorial(n - 1)
  }
}

puts(factorial(5))
```

### Fizz Buzz ([fizzbuzz.rorty](./examples/fizzbuzz.rorty))

```
def rem(n, base) {
  n % base
}

i = 1
while (i <= 100) {
  if (rem(i, 15) == 0) {
    puts("FizzBuzz")
  } else {
    if (rem(i, 5) == 0) {
      puts("Buzz")
    } else {
      if (rem(i, 3) == 0) {
        puts("Fizz")
      } else {
        puts(i)
      }
    }
  }

  i = i + 1
}
```

## Acknowledgement

The author has been encouraged by the article published in [WEB+DB PRESS Vol.125](https://gihyo.jp/magazine/wdpress/archive/2021/vol125) to make my own language.

## Author

[Kentaro Kuribayashi](https://kentarokuribayashi.com/) &lt;kentarok@gmail.com&gt;
