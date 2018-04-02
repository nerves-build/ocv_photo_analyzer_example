defmodule OcvPhotoAnalyzerExampleWeb.PhotoControllerTest do
  use OcvPhotoAnalyzerExampleWeb.ConnCase

  alias OcvPhotoAnalyzerExample.Photos

  @create_attrs %{
    name: "some name",
    upload_path: %Plug.Upload{path: "test/fixtures/IMG_0507.jpg", filename: "IMG_0507.jpg"}
  }
  @update_attrs %{
    name: "some updated name",
    upload_path: %Plug.Upload{path: "test/fixtures/IMG_0507.jpg", filename: "IMG_0507.jpg"}
  }

  def fixture(:photo) do
    {:ok, photo} = Photos.create_photo(@create_attrs)
    photo
  end

  setup do
    {:ok, _} = start_supervised(Upload.Adapters.Test)
    :ok
  end

  describe "index" do
    test "lists all photos", %{conn: conn} do
      conn = get(conn, photo_path(conn, :index))
      assert html_response(conn, 200) =~ "All Photos"
    end
  end

  describe "new photo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, photo_path(conn, :new))
      assert html_response(conn, 200) =~ "New Photo"
    end
  end

  describe "create photo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, photo_path(conn, :create), photo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == photo_path(conn, :show, id)

      conn = get(conn, photo_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Photo"
    end
  end

  describe "edit photo" do
    setup [:create_photo]

    test "renders form for editing chosen photo", %{conn: conn, photo: photo} do
      conn = get(conn, photo_path(conn, :edit, photo))
      assert html_response(conn, 200) =~ "Edit Photo"
    end
  end

  describe "update photo" do
    setup [:create_photo]

    test "redirects when data is valid", %{conn: conn, photo: photo} do
      conn = put(conn, photo_path(conn, :update, photo), photo: @update_attrs)
      assert redirected_to(conn) == photo_path(conn, :show, photo)

      conn = get(conn, photo_path(conn, :show, photo))
      assert html_response(conn, 200) =~ "some updated name"
    end
  end

  describe "delete photo" do
    setup [:create_photo]

    test "deletes chosen photo", %{conn: conn, photo: photo} do
      conn = delete(conn, photo_path(conn, :delete, photo))
      assert redirected_to(conn) == photo_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, photo_path(conn, :show, photo))
      end)
    end
  end

  defp create_photo(_) do
    photo = fixture(:photo)
    {:ok, photo: photo}
  end
end
