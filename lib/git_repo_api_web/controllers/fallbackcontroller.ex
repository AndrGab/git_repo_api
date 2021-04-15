defmodule GitRepoApiWeb.FallbackController do
  use GitRepoApiWeb, :controller

  alias GitRepoApiWeb.ErrorView

  def call(conn, {:error, result}) do
    conn
    |> put_status(result)
    |> put_view(ErrorView)
    |> render("error.json", %{result: "Invalid User"})
  end
end
