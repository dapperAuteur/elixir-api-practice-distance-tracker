defmodule DistanceTracker.TrackerControllerTest do
  use DistanceTracker.ConnCase, async: true

  import DistanceTracker.Router.Helpers, only: [tracker_path: 2]

  alias DistanceTracker.{Factory, Repo, Tracker}

  def insert_tracker(params \\ []) do
    Factory.insert(Tracker, params)
  end
end
