defmodule GitRepoApiWeb.GetRepoController do
  use GitRepoApiWeb, :controller

  alias GitRepoApi.GitRepo.GetRepoUser

  action_fallback GitRepoApiWeb.FallbackController

  def index(conn, %{"id" => id}) do
    with {:ok, repo} <- GetRepoUser.get_repo_user(id) do
      conn
      |> put_status(:ok)
      |> render("repo.json", repo: repo)
    end
  end
end
