defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BankWeb.Auth.Pipeline
  end

  scope "/app", BankWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController, except: [:new, :edit, :create]
    resources "/accounts", AccountController, except: [:new, :edit]
  end

  scope "/auth", BankWeb do
    post "/signin", AuthController, :signin
    post "/signup", AuthController, :signup
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BankWeb.Telemetry
    end
  end
end
