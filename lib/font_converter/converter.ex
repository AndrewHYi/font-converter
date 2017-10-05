defmodule FontConverter.Converter do

  def convert(file) do
    filepath = file.path
    file_ext = Path.extname(file.filename)
    basename = Path.basename(file.filename, file_ext)
    filename = "#{basename}#{file_ext}"

    {:ok, file_contents} = File.read(filepath)
    {:ok, tmpdir_path} = Temp.mkdir(SecureRandom.uuid)

    tmpfile_path = Path.join(tmpdir_path, filename)
    File.write tmpfile_path, file_contents

    new_file_paths = Enum.map [".ttf", ".eot", ".woff", ".woff2", ".svg"], fn(font_ext) ->
      to_file_path = Path.join([tmpdir_path, "#{basename}#{font_ext}"])
      FontConverter.Converter.trycmd("fontforge", [
        "-lang=ff",
        "-c",
        "Open($1); Generate($2);",
        tmpfile_path,
        to_file_path
      ])

      "#{to_file_path}"
    end

    zipfile_path = Path.join(tmpdir_path, "fonts.zip")
    zip(new_file_paths, zipfile_path)
    {:ok, tmpdir_path, zipfile_path}
  end

  def zip(file_paths, archive_name) when is_list(file_paths) do
    file_paths_list = file_paths |> Enum.map&(String.to_char_list(&1))
    :zip.create(String.to_char_list(archive_name), file_paths_list)
  end

  def trycmd(command, args, opts \\ []) do
    {result, exit_status} = System.cmd(command, args)
    {:ok, String.trim(result)}
  rescue # command doesn't exist
    ErlangError ->
      {:error, "The command: '#{command}' failed! Did you install the necessary binaries?"}
  end
end
