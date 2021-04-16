defmodule GitRepoApiWeb.Auth.Guardian do
  use Guardian, otp_app: :git_repo_api

  alias GitRepoApi.User
  alias GitRepoApi.Error
  alias GitRepoApi.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  def refresh_token(token) do
    with {:ok, _old_token, {new_token, _new_claims}} <- refresh(token, ttl: {1, :minute}) do
      {:ok, new_token}
    else
      error -> {:error, Error.build(:unauthorized, error)}
    end
  end
end
