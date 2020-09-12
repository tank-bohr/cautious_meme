defmodule CautiousMemeWeb.Router do
  use CautiousMemeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CautiousMemeWeb do
    pipe_through :api
  end
end
