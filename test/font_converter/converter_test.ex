defmodule FontConverter.ConverterTest do

  use ExUnit.Case
  describe "FontConverter.Converter.trycmd/3" do
    test "runs valid command and returns {:ok, result}" do
      result = FontConverter.Converter.trycmd("ls", ["test/support/dummy_files/test.txt"])
      assert result == {:ok, "test/support/dummy_files/test.txt"}
    end

    test "runs invalid command and returns {:error, message}" do
      result = FontConverter.Converter.trycmd("dontwork", ["test/support/dummy_files/test.txt"])
      assert result == {:error, "The command: 'dontwork' failed! Did you install the necessary binaries?"}
    end
  end
end
