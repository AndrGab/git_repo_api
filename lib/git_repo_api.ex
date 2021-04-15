defmodule GitRepoApi do
  alias GitRepoApi.Users.Create, as: UserCreate
  alias GitRepoApi.Users.Get, as: UserGet
  alias GitRepoApi.Users.Delete, as: UserDelete
  alias GitRepoApi.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call
end
