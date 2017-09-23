defmodule DistanceTracker.TrackerControllerTest do
  use DistanceTracker.ConnCase, async: true

  import DistanceTracker.Router.Helpers, only: [tracker_path: 2]

  alias DistanceTracker.{Factory, Repo, Tracker}

  def insert_tracker(params \\ []) do
    Factory.insert(Tracker, params)
  end

  test "List all trackers", %{conn: conn} do
    tracker_a = insert_tracker()
    tracker_b = insert_tracker()

    %{"data" => data} = conn
      |> get(tracker_path(conn, :index))
      |> Map.get(:resp_body)
      |> Poison.decode!

    assert [
      %{
        "activity" => tracker_a.activity,
        "completed_at" => DateTime.to_iso8601(tracker_a.completed_at),
        "distance" => tracker_a.distance,
        "inserted_at" => DateTime.to_iso8601(tracker_a.inserted_at),
        "updated_at" => DateTime.to_iso8601(tracker_a.updated_at),
        "uuid" => tracker_a.uuid
      },
      %{
        "activity" => tracker_b.activity,
        "completed_at" => DateTime.to_iso8601(tracker_b.completed_at),
        "distance" => tracker_b.distance,
        "inserted_at" => DateTime.to_iso8601(tracker_b.inserted_at),
        "updated_at" => DateTime.to_iso8601(tracker_b.updated_at),
        "uuid" => tracker_b.uuid
      }
    ] == data
  end

  test "Show a tracker", %{conn: conn} do
    tracker_a = insert_tracker()
    insert_tracker()

    %{resp_body: body, status: status} = conn
      |> get(tracker_path(conn, :show, tracker_a.uuid))

    %{"data" => data} = Poison.decode!(body)

    assert 200 == status
    assert %{
      "activity" => tracker_a.activity,
      "completed_at" => DateTime.to_iso8601(tracker_a.completed_at),
      "distance" => tracker_a.distance,
      "inserted_at" => DateTime.to_iso8601(tracker_a.inserted_at),
      "updated_at" => DateTime.to_iso8601(tracker_a.updated_at),
      "uuid" => tracker_a.uuid
    } == data
  end
end
