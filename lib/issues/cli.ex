require Logger

defmodule Issues.Cli do

  @default_count 4

  def run(args) do
    args
      |> parse_args
      |> process
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [ help: :boolean], 
                                    aliases: [ h: :help])
    |> elem(1) 
    |> args_to_internal() 
  end


  def args_to_internal([user, project, count]) do
    { user, project, String.to_integer(count) }
  end
  def args_to_internal([user, project]) do
    { user, project, @default_count }
  end
  def args_to_internal(_) do
    :help
  end
end
