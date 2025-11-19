# require Logger

defmodule Issues.Cli do
  @default_count 4

  def run(args) do
    args
    |> parse_args
    |> process
  end

  def process(:help) do
    IO.puts("""
    usege: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> sort_info_descending_order()
    |> last(count)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  def sort_info_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] >= i2["created_at"]
    end)
  end

  def parse_args(args) do
    OptionParser.parse(args,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> args_to_internal()
  end

  def args_to_internal([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal([user, project]) do
    {user, project, @default_count}
  end

  def args_to_internal(_) do
    :help
  end
end
