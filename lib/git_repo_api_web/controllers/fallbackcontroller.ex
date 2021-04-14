defmodule GitRepoApiWeb.FallbackController do
  use GitRepoApiWeb, :controller

  alias GitRepoApiWeb.ErrorView

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", %{result: result})
  end
end
