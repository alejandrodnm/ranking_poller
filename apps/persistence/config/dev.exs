use Mix.Config

# Configure your database
config :persistence, Persistence.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ranking_poller",
  hostname: "localhost",
  pool_size: 10
