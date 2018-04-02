# OcvPhotoAnalyzerExample

This is the sample app for the blog post at:

https://nerves.build/posts/ocv_photo_analyzer

In order to run the project you must set the following value

config :ocv_photo_analyzer_example, Photos.Photo,
  base_path: "APP_DIR/priv/static/uploads"

You can change the location of the uploaded photos if you like through this config:

config :upload, Upload.Adapters.Local,
  storage_path: "priv/static/uploads",
  public_path: "/uploads"

You can also control the values ocv_photo_analyzer uses for determining dominant colors. These are the default values:

config :ocv_photo_analyzer, OcvPhotoAnalyzer.Analyzer,
  clusters: 5,
  iterations: 10,
  attempts: 5,
  precision: 0.1,
  analysis_size: 1000

The details of these parameters are discussed here:
https://docs.opencv.org/2.4/modules/core/doc/clustering.html


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

