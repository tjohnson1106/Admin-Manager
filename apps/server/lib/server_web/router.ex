defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ServerWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/employees", EmployeeController)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL,
        schema: ServerQL.Schema,
        socket: ServerWeb.UserSocket,
        interface: :advanced
      )
    end

    scope "/api", ServerWeb do
      pipe_through(:api)
    end
  end
end
