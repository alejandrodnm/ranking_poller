defmodule Web.Router do
  use Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: Web.Schema)

    forward("/", Absinthe.Plug, schema: Web.Schema)
  end
end
