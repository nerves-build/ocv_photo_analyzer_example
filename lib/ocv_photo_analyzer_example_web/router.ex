defmodule OcvPhotoAnalyzerExampleWeb.Router do
  use OcvPhotoAnalyzerExampleWeb, :router

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

  scope "/", OcvPhotoAnalyzerExampleWeb do
    # Use the default browser stack
    pipe_through(:browser)
    resources("/photo", PhotoController)
    get("/", PhotoController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", OcvPhotoAnalyzerExampleWeb do
  #   pipe_through :api
  # end
end
