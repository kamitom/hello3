defmodule Hello3Web.Router do
  use Hello3Web, :router

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

  scope "/", Hello3Web do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/hello", Hello3Controller, :index)
    get("/hello/:msgA", Hello3Controller, :show)
    get("/hi", ElihereController, :world)

    # for CRUD
    resources("/users", UserController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Hello3Web do
  #   pipe_through :api
  # end
end
