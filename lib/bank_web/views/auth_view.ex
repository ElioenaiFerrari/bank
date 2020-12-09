defmodule BankWeb.AuthView do
  use BankWeb, :view

  def render("token.json", %{token: token}), do: %{token: token}
end
