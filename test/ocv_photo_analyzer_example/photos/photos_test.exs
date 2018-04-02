defmodule OcvPhotoAnalyzerExample.PhotosTest do
  use OcvPhotoAnalyzerExample.DataCase

  alias OcvPhotoAnalyzerExample.Photos

  describe "photos" do
    alias OcvPhotoAnalyzerExample.Photos.Photo

    @valid_attrs %{
      name: "some name",
      upload_path: %Plug.Upload{path: "test/fixtures/IMG_0507.jpg", filename: "IMG_0507.jpg"}
    }
    @update_attrs %{
      name: "some updated name",
      upload_path: %Plug.Upload{path: "test/fixtures/IMG_0507.jpg", filename: "IMG_0507.jpg"}
    }

    setup do
      {:ok, _} = start_supervised(Upload.Adapters.Test)
      :ok
    end

    def photo_fixture(attrs \\ %{}) do
      {:ok, photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Photos.create_photo()

      photo
    end

    test "list_photos/0 returns all photos" do
      photo_fixture()
      assert Enum.count(Photos.list_photos()) == 1
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert not is_nil(Photos.get_photo!(photo.id))
    end

    test "create_photo/1 with valid data creates a photo" do
      assert {:ok, %Photo{} = photo} = Photos.create_photo(@valid_attrs)
      assert photo.name == "some name"
      assert not is_nil(photo.upload_path)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      assert {:ok, photo} = Photos.update_photo(photo, @update_attrs)
      assert %Photo{} = photo
      assert photo.name == "some updated name"
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end
end
