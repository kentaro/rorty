defmodule Toyex.Ast do
  def add(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.Add,
      left: left,
      right: right
    }
  end

  def divide(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.Divide,
      left: left,
      right: right
    }
  end

  def multiply(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.Multiply,
      left: left,
      right: right
    }
  end

  def subtract(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.Subtract,
      left: left,
      right: right
    }
  end

  def less_than(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.LessThan,
      left: left,
      right: right
    }
  end

  def less_or_equal(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.LessOrEqual,
      left: left,
      right: right
    }
  end

  def greater_than(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.GreaterThan,
      left: left,
      right: right
    }
  end

  def greater_or_equal(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.GreaterOrEqual,
      left: left,
      right: right
    }
  end

  def equal(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.Equal,
      left: left,
      right: right
    }
  end

  def not_equal(left, right) do
    %Toyex.Ast.Expr.Binary{
      operator: Toyex.Operator.NotEqual,
      left: left,
      right: right
    }
  end

  def integer(value) do
    %Toyex.Ast.Expr.IntegerLiteral{value: value}
  end

  def identifier(name) do
    %Toyex.Ast.Expr.Identifier{name: name}
  end

  def assignment(name, value) do
    %Toyex.Ast.Expr.Assignment{
      name: name,
      value: value
    }
  end

  def block(exprs) do
    %Toyex.Ast.Expr.Block{
      exprs: exprs
    }
  end

  def if(condition, then, otherwise \\ nil) do
    %Toyex.Ast.Expr.If{
      condition: condition,
      then: then,
      otherwise: otherwise
    }
  end

  def while(condition, body) do
    %Toyex.Ast.Expr.While{
      condition: condition,
      body: body
    }
  end
end
