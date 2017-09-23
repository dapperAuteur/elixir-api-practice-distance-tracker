defmodule DistanceTracker.TrackerController do
  use DistanceTracker.Web, :controller

  alias DistanceTracker.{ErrorView, Repo, Tracker}
  alias Plug.Conn

  def index(conn, _params) do
    trackers = Repo.all(Tracker)
    render(conn, "index.json", trackers: trackers)
  end

  def show(conn, %{"id" => uuid}) do
    with tracker = %Tracker{} <- Repo.get(Tracker, uuid) do
      render(conn, "show.json", tracker: tracker)
    else
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", error: "Not found")
    end
  end
end
