defmodule OcvPhotoAnalyzerExampleWeb.PageController do
  use OcvPhotoAnalyzerExampleWeb, :controller

  alias OcvPhotoAnalyzerExample.Photos

  def index(conn, _params) do
    photos = Photos.list_photos()
    render(conn, "index.html", photos: photos)
  end
end
