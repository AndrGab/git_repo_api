defmodule GitRepoApiWeb.GetRepoView do
  use GitRepoApiWeb, :view

  def render("repo.json", %{repo: [%{} | _rest] = repo}) do
    repo
  end
end
