defmodule BankWeb.UserController do
  use BankWeb, :controller
  alias Bank.Users

  def create(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    end
  end

  def index(conn, _params) do
    users = Users.list_users()

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Users.get_user!(id)

    with {:ok, user} <- Users.update_user(user, params) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, user} <- Users.delete_user(user) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
