use Mix.Config

# Configure your database
config :persistence, Persistence.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "standings_poller",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
