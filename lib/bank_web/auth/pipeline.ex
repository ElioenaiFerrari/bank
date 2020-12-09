defmodule BankWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :bank

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
