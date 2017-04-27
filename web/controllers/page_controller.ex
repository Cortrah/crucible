defmodule Crucible.PageController do
  use Crucible.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
