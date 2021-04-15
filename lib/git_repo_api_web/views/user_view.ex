defmodule GitRepoApiWeb.UsersView do
  use GitRepoApiWeb, :view

  alias GitRepoApi.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User Created!",
      user: user,
      token: token
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
