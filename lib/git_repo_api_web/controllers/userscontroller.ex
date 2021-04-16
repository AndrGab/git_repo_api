defmodule GitRepoApiWeb.UsersController do
  use GitRepoApiWeb, :controller

  alias GitRepoApi.User
  alias GitRepoApiWeb.FallbackController
  alias GitRepoApiWeb.Auth.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- GitRepoApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- GitRepoApi.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- GitRepoApi.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- GitRepoApi.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
