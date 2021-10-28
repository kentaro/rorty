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

defmodule Toyex.Operator.Add do
  @name "add"
  use Toyex.Operator
end

defmodule Toyex.Operator.Divide do
  @name "divide"
  use Toyex.Operator
end

defmodule Toyex.Operator.Equal do
  @name "equal"
  use Toyex.Operator
end

defmodule Toyex.Operator.GreaterOrEqual do
  @name "greater_or_equal"
  use Toyex.Operator
end

defmodule Toyex.Operator.GreaterThan do
  @name "greater_than"
  use Toyex.Operator
end

defmodule Toyex.Operator.LessOrEqual do
  @name "less_or_equal"
  use Toyex.Operator
end

defmodule Toyex.Operator.LessThan do
  @name "less_than"
  use Toyex.Operator
end

defmodule Toyex.Operator.Multiply do
  @name "multiply"
  use Toyex.Operator
end

defmodule Toyex.Operator.NotEqual do
  @name "not_equal"
  use Toyex.Operator
end

defmodule Toyex.Operator.Subtract do
  @name "subtract"
  use Toyex.Operator
end
