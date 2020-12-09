defmodule BankWeb.AuthController do
  use BankWeb, :controller
  alias BankWeb.Auth.Guardian

  def signin(conn, %{"user" => user}) do
    case Guardian.authenticate(user) do
      {:ok, token} ->
        conn
        |> put_status(:ok)
        |> render("token.json", token: token)

      {:error, status, message} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          status,
          Jason.encode!(%{
            error: message
          })
        )
    end
  end
end
