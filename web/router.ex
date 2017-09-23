defmodule DistanceTracker.Router do
  use DistanceTracker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DistanceTracker do
    pipe_through :api
    get "/", TrackerController, :index
  end
end
