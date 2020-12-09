defmodule BankWeb.AuthController do
  use BankWeb, :controller
  alias BankWeb.Auth.Guardian
  alias Bank.Users

  def signup(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> render("signup.json", %{user: user})
    end
  end

  def signin(conn, %{"user" => user}) do
    case Guardian.authenticate(user) do
      {:ok, token} ->
        conn
        |> put_status(:ok)
        |> render("signin.json", token: token)

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
