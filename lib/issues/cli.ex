require Logger

defmodule Issues.Cli do

  @default_count 4

  def run(args) do
    parse_args(args)
  end

  def parse_args(args) do
    Logger.info("start parse_args")
    Logger.info(args)

    parse = OptionParser.parse(args, switches: [ help: :boolean], 
                                      aliases: [ h: :help])
    
    case parse do
      { [ help: true ], _, _ } -> 
        :help  

      { _, [ user, project, count ], _ } -> 
        { user, project, String.to_integer(count) }

      { _, [ user, project ], _ } -> 
        { user, project, @default_count }

      _ -> :help
    end
  end
end
