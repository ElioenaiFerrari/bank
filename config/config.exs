# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank,
  ecto_repos: [Bank.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :bank, BankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "692Y2f84Q5K3fIeX1T71HOrQ3FOcTrbogomQYprEdZtUCASEZEeX+kJ3TfX5Q3Pp",
  render_errors: [view: BankWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Bank.PubSub,
  live_view: [signing_salt: "ohJkf+tR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bank, BankWeb.Auth.Guardian,
  issuer: "bank",
  verify_issuer: true,
  secret_key: "DNbC6Nbi2mCrRBxDvUyn3+4U1y9Q1IbqcIUzMobNVMJdlevKURm9NiTDByOaSawU"

config :bcrypt_elixir, log_rounds: 8

config :bank, BankWeb.Auth.Pipeline,
  module: BankWeb.Auth.Guardian,
  error_handle: BankWeb.Auth.ErrorHandle

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
