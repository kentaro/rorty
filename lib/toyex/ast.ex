defmodule Toyex.Ast do
  def add(left, right) do
    %Toyex.Ast.Expression.Binary{
      operator: Toyex.Operator.Add,
      left: left,
      right: right
    }
  end

  def divide(left, right) do
    %Toyex.Ast.Expression.Binary{
      operator: Toyex.Operator.Divide,
      left: left,
      right: right
    }
  end

  def multiply(left, right) do
    %Toyex.Ast.Expression.Binary{
      operator: Toyex.Operator.Multiply,
      left: left,
      right: right
    }
  end

  def subtract(left, right) do
    %Toyex.Ast.Expression.Binary{
      operator: Toyex.Operator.Subtract,
      left: left,
      right: right
    }
  end

  def integer(value) do
    %Toyex.Ast.Expression.IntegerLiteral{value: value}
  end

  def identifier(name) do
    %Toyex.Ast.Expression.Identifier{name: name}
  end

  def assignment(name, value) do
    %Toyex.Ast.Expression.Assignment{
      name: name,
      value: value
    }
  end
end
