defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir"}]
  @git_url Application.get_env(:issues, :git_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> parse_body
  end

  def issues_url(user, project) do
    "#{@git_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    body
  end

  def parse_body(body) do
    Poison.Parser.parse!(body)
  end
end
