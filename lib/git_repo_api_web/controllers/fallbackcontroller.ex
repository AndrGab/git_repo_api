defmodule GitRepoApiWeb.FallbackController do
  use GitRepoApiWeb, :controller

  alias GitRepoApi.Error
  alias GitRepoApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", %{result: result})
  end
end
