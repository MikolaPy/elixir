defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.Cli, only: [parse_args: 1, sort_info_descending_order: 1]

  test "sort list correct way" do
    fake_list = fake_created_at_list(["c", "a", "b"])
    result = sort_info_descending_order(fake_list)

    issues =
      for issue <- result do
        Map.get(issue, "created_at")
      end

    assert issues == ~w{ c b a }
  end

  defp fake_created_at_list(values) do
    for value <- values do
      %{"created_at" => value, "other_data" => "test"}
    end
  end

  test "options wiht -h and --help return :help" do
    assert parse_args(["-h", "any"]) == :help
    assert parse_args(["--help", "any"]) == :help
  end

  test "options with three values returned three values " do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end
end
