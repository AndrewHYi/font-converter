defmodule FontConverterWeb.Router do
  use FontConverterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FontConverterWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/fonts/convert", PageController, :convert
  end

  # Other scopes may use custom stacks.
  # scope "/api", FontConverterWeb do
  #   pipe_through :api
  # end
end
