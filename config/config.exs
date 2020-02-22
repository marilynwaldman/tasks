# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tasks,
  ecto_repos: [Tasks.Repo]

# Configures the endpoint
config :tasks, TasksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q4tWiYaCstb6mnwIGuSnllnl1VZapbfDX9oq55I4qikKSfiDXjslc6+auy2JgRN+",
  render_errors: [view: TasksWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasks.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use pow for Autheniticaion
config :tasks, :pow,
       user: Tasks.Users.User,
       repo: Tasks.Repo,
       web_module: TasksWeb,
       extensions: [PowResetPassword],
       controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
       mailer_backend: TasksWeb.PowMailer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
