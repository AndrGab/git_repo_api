defmodule GitRepoApi.GitRepo.GetRepoUserTest do
  use ExUnit.Case, async: true

  alias GitRepoApi.GitRepo.GetRepoUser
  alias Plug.Conn

  describe "get_user_repo/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "When user exist", %{bypass: bypass} do
      id = "carlos4"

      url = endpoint_url(bypass.port)

      body = ~s(
        [
          {
                  "description": "Curso de Estructura de datos",
                  "html_url": "https://github.com/Carlos3/Estructuras-de-Datos",
                  "id": 30689700,
                  "name": "Estructuras-de-Datos",
                  "stargazers_count": 0
                }
        ]
      )

      Bypass.expect(bypass, "GET", "#{id}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = GetRepoUser.get_repo_user(url, id)

      expected_response =
        {:ok,
         [
           %{
             description: "Curso de Estructura de datos",
             html_url: "https://github.com/Carlos3/Estructuras-de-Datos",
             id: 30_689_700,
             name: "Estructuras-de-Datos",
             stargazers_count: 0
           }
         ]}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
