defmodule Rorty.Ast do
  def add(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Add,
      left: left,
      right: right
    }
  end

  def divide(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Divide,
      left: left,
      right: right
    }
  end

  def multiply(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Multiply,
      left: left,
      right: right
    }
  end

  def subtract(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Subtract,
      left: left,
      right: right
    }
  end

  def mod(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Mod,
      left: left,
      right: right
    }
  end

  def less_than(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.LessThan,
      left: left,
      right: right
    }
  end

  def less_or_equal(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.LessOrEqual,
      left: left,
      right: right
    }
  end

  def greater_than(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.GreaterThan,
      left: left,
      right: right
    }
  end

  def greater_or_equal(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.GreaterOrEqual,
      left: left,
      right: right
    }
  end

  def equal(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.Equal,
      left: left,
      right: right
    }
  end

  def not_equal(left, right) do
    %Rorty.Ast.Expr.Binary{
      operator: Rorty.Operator.NotEqual,
      left: left,
      right: right
    }
  end

  def integer(value) do
    %Rorty.Ast.Expr.IntegerLiteral{value: value}
  end

  def string(value) do
    %Rorty.Ast.Expr.StringLiteral{value: value}
  end

  def identifier(name) do
    %Rorty.Ast.Expr.Identifier{name: name}
  end

  def boolean(value) do
    %Rorty.Ast.Expr.Boolean{value: value}
  end

  def assignment(name, value) do
    %Rorty.Ast.Expr.Assignment{
      name: name,
      value: value
    }
  end

  def block(exprs) do
    %Rorty.Ast.Expr.Block{
      exprs: exprs
    }
  end

  def if(condition, then, otherwise \\ nil) do
    %Rorty.Ast.Expr.If{
      condition: condition,
      then: then,
      otherwise: otherwise
    }
  end

  def while(condition, body) do
    %Rorty.Ast.Expr.While{
      condition: condition,
      body: body
    }
  end

  def def(name, args, body) do
    %Rorty.Ast.Expr.Def{
      name: name,
      args: args,
      body: body
    }
  end

  def call(name, args) do
    %Rorty.Ast.Expr.Call{
      name: name,
      args: args
    }
  end
end
