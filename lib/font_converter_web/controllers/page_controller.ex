defmodule FontConverterWeb.PageController do
  use FontConverterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def convert(conn, %{"convert" => %{"fontfile" => file}}) do
    {:ok, tmpdir_path, zipfile_path} = FontConverter.Converter.convert(file)
    conn
      |> put_resp_content_type("application/zip")
      |> put_resp_header("content-disposition", "attachment; filename=\"#{Path.basename(zipfile_path)}\"")
      |> send_file(200, zipfile_path)

    # TODO: delete file
    # File.rm_rf tmpdir_path
  end
end
