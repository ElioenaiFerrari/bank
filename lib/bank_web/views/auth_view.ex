defmodule BankWeb.AuthView do
  use BankWeb, :view

  def render("signin.json", %{token: token}), do: %{token: token}

  def render("signup.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
