defmodule GitRepoApi.Repo do
  use Ecto.Repo,
    otp_app: :git_repo_api,
    adapter: Ecto.Adapters.Postgres
end
