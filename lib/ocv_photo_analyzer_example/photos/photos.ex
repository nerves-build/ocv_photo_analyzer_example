defmodule OcvPhotoAnalyzerExample.Photos do
  @moduledoc """
  The Photos context.
  """

  import Ecto.Query, warn: false
  alias OcvPhotoAnalyzerExample.Repo

  alias OcvPhotoAnalyzerExample.Photos.Photo

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    Repo.all(Photo)
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Upload.Ecto.cast_upload(:upload_path, prefix: ["upload_paths"])
    |> Repo.insert()
  end

  def create_histogram(photo_path) do
    Application.get_env(:ocv_photo_analyzer_example, Photos.Photo)[:base_path]
    |> Path.join(photo_path)
    |> OcvPhotoAnalyzer.analyze([:histogram])
  end

  def find_dominant(photo_path) do
    Application.get_env(:ocv_photo_analyzer_example, Photos.Photo)[:base_path]
    |> Path.join(photo_path)
    |> OcvPhotoAnalyzer.analyze([:dominant])
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{source: %Photo{}}

  """
  def change_photo(%Photo{} = photo) do
    Photo.changeset(photo, %{})
  end
end