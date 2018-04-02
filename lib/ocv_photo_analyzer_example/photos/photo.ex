defmodule OcvPhotoAnalyzerExample.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field(:name, :string)
    field(:upload_path, :string)

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:name])
    |> Upload.Ecto.cast_upload(:upload_path, prefix: ["upload_paths"])
  end
end
