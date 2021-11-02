# Toyex

A toy language implementation using Elixir.

## Installation

This repository provides a way to build an escript of Toyex interpreter.

* `mix escript.build` generates `toyex` command in your current directory.

```shell
$ mix escript.build
Generated escript toyex with MIX_ENV=dev
```

* `mix escript.install` installs `toyex` command into `$HOME/.mix/escripts`.

```shell
$ mix escript.install
Generated escript toyex with MIX_ENV=dev
Are you sure you want to replace it with "toyex"? [Yn]
* creating /Users/kentaro/.mix/escripts/toyex
```

## Usage

### --eval / -e

Evaluates the Toyex code.

```shell
$ toyex -e "puts(1 + 1)"
2
```

### --file / -f

Reads the content of the file and evaluates it.

```shell
$ toyex -f examples/factorial.toyex
120
```

### --ast / -a

Parses Toyex code and shows the parse tree. This option must be used with either `-e` or `-f` option.

```shell
$ toyex -a -e '1+1'
[
  %Toyex.Ast.Expr.Binary{
    left: %Toyex.Ast.Expr.IntegerLiteral{value: 1},
    operator: Toyex.Operator.Add,
    right: %Toyex.Ast.Expr.IntegerLiteral{value: 1}
  }
]
```

### --help / -h

Shows the help message.

## Grammar

Toyex currently supports a basic grammar.

See [lib/toyex/grammar.ex](./lib/toyex/grammar.ex) for details.

## Examples

### Factorial ([factorial.toyex](./examples/factorial.toyex))

```
def factorial(n) {
  if (n < 2) {
    1
  } else {
    n * factorial(n - 1)
  }
}

result = factorial(5)
puts(result)
```

### Fizz Buzz ([fizzbuzz.toyex](./examples/fizzbuzz.toyex))

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

The author has been encouraged by the article published in [WEB+DB PRESS Vol.125](https://gihyo.jp/magazine/wdpress/archive/2021/vol125) to make my own toy language.

## Author

Kentaro Kuribayashi <kentarok@gmail.com>
