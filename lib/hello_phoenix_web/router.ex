defmodule HelloPhoenixWeb.Router do
  use HelloPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelloPhoenixWeb do
    pipe_through :api
  end

  scope "/custom" do
    pipe_through :api

    forward "/blog", HelloPhoenix.Blog.Router    
  end
end
