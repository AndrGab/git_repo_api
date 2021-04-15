defmodule GitRepoApi.GitRepo.GetRepoUser do
  use Tesla

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.Headers, [{"User-Agent", "GitUserRepo"}]
  plug Tesla.Middleware.JSON

  def get_repo_user(url \\ @base_url, id) do
    "#{url}#{id}/repos"
    |> get()
    |> handle_result()
  end

  defp handle_result({:ok, repo}) do
    with 200 <- Map.get(repo, :status) do
      result =
        Enum.reduce(Map.get(repo, :body), [], fn x, acc ->
          [
            %{
              id: Map.get(x, "id"),
              name: Map.get(x, "name"),
              description: Map.get(x, "description"),
              html_url: Map.get(x, "html_url"),
              stargazers_count: Map.get(x, "stargazers_count")
            }
            | acc
          ]
        end)

      {:ok, result}
    else
      erro -> {:error, erro}
    end
  end
end
