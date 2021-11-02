defmodule Rorty.Operator do
  @callback execute(
              left :: Rorty.Ast.Expr.t(),
              right :: Rorty.Ast.Expr.t(),
              env :: Rorty.Env.t()
            ) :: {
              Rorty.Ast.Expr.t(),
              Rorty.Env.t()
            }

  defmacro __using__(_opts) do
    quote do
      @behaviour Rorty.Operator

      def to_string() do
        @name
      end
    end
  end
end

defmodule Rorty.Operator.Add do
  @name "add"
  use Rorty.Operator

  def execute(left, right, env) do
    {left + right, env}
  end
end

defmodule Rorty.Operator.Divide do
  @name "divide"
  use Rorty.Operator

  def execute(left, right, env) do
    {left / right, env}
  end
end

defmodule Rorty.Operator.Equal do
  @name "equal"
  use Rorty.Operator

  def execute(left, right, env) do
    {left == right, env}
  end
end

defmodule Rorty.Operator.GreaterOrEqual do
  @name "greater_or_equal"
  use Rorty.Operator

  def execute(left, right, env) do
    {left >= right, env}
  end
end

defmodule Rorty.Operator.GreaterThan do
  @name "greater_than"
  use Rorty.Operator

  def execute(left, right, env) do
    {left > right, env}
  end
end

defmodule Rorty.Operator.LessOrEqual do
  @name "less_or_equal"
  use Rorty.Operator

  def execute(left, right, env) do
    {left <= right, env}
  end
end

defmodule Rorty.Operator.LessThan do
  @name "less_than"
  use Rorty.Operator

  def execute(left, right, env) do
    {left < right, env}
  end
end

defmodule Rorty.Operator.Multiply do
  @name "multiply"
  use Rorty.Operator

  def execute(left, right, env) do
    {left * right, env}
  end
end

defmodule Rorty.Operator.NotEqual do
  @name "not_equal"
  use Rorty.Operator

  def execute(left, right, env) do
    {left != right, env}
  end
end

defmodule Rorty.Operator.Subtract do
  @name "subtract"
  use Rorty.Operator

  def execute(left, right, env) do
    {left - right, env}
  end
end

defmodule Rorty.Operator.Mod do
  @name "mod"
  use Rorty.Operator

  def execute(left, right, env) do
    {rem(left, right), env}
  end
end
