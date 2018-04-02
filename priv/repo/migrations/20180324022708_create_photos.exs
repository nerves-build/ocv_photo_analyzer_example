defmodule OcvPhotoAnalyzerExample.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :name, :string
      add :upload_path, :string

      timestamps()
    end

  end
end
