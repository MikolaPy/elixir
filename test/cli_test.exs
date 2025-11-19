defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.Cli, only: [ parse_args: 1 ]

  test "options wiht -h and --help return :help" do
    assert parse_args(["-h", "any"]) == :help
    assert parse_args(["--help", "any"]) == :help
  end

  test "options with three values returned three values " do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 } 
  end
end
