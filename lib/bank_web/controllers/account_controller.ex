defmodule BankWeb.AccountController do
  use BankWeb, :controller

  alias Bank.{Accounts}

  def create(conn, %{"account" => params}) do
    account = Accounts.create_account(params)

    conn
    |> put_status(:created)
    |> render("show.json", account: account)
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()

    conn
    |> put_status(:ok)
    |> render("index.json", accounts: accounts)
  end
end
