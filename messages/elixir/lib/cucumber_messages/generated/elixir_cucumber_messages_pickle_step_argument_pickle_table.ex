# credo:disable-for-this-file
defmodule(CucumberMessages.PickleStepArgument.PickleTable) do
  @moduledoc(false)
  (
    defstruct(rows: [], __uf__: [])
    (
      @spec(encode(struct) :: {:ok, iodata} | {:error, any})
      def(encode(msg)) do
        try do
          {:ok, encode!(msg)}
        rescue
          e ->
            {:error, e}
        end
      end
      @spec(encode!(struct) :: iodata | no_return)
      def(encode!(msg)) do
        [] |> encode_rows(msg) |> encode_unknown_fields(msg)
      end
      []
      [defp(encode_rows(acc, msg)) do
        case(msg.rows()) do
          [] ->
            acc
          values ->
            [acc, Enum.reduce(values, [], fn value, acc -> [acc, "\n", Protox.Encode.encode_message(value)] end)]
        end
      end]
      defp(encode_unknown_fields(acc, msg)) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc -> case(wire_type) do
          0 ->
            [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]
          1 ->
            [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]
          2 ->
            len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
            [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]
          5 ->
            [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
        end end)
      end
    )
    (
      @spec(decode(binary) :: {:ok, struct} | {:error, any})
      def(decode(bytes)) do
        try do
          {:ok, decode!(bytes)}
        rescue
          e ->
            {:error, e}
        end
      end
      (
        @spec(decode!(binary) :: struct | no_return)
        def(decode!(bytes)) do
          parse_key_value(bytes, struct(CucumberMessages.PickleStepArgument.PickleTable))
        end
      )
      (
        @spec(parse_key_value(binary, struct) :: struct)
        defp(parse_key_value(<<>>, msg)) do
          msg
        end
        defp(parse_key_value(bytes, msg)) do
          {field, rest} = case(Protox.Decode.parse_key(bytes)) do
            {0, _, _} ->
              raise(%Protox.IllegalTagError{})
            {1, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow.decode!(delimited)
              field = {:rows, msg.rows() ++ List.wrap(value)}
              {field, rest}
            {tag, wire_type, rest} ->
              {value, new_rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)
              field = {msg.__struct__.unknown_fields_name, [value | msg.__struct__.unknown_fields(msg)]}
              {field, new_rest}
          end
          msg_updated = struct(msg, [field])
          parse_key_value(rest, msg_updated)
        end
      )
      []
    )
    @spec(defs() :: %{required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}})
    def(defs()) do
      %{1 => {:rows, :unpacked, {:message, CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow}}}
    end
    @spec(defs_by_name() :: %{required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}})
    def(defs_by_name()) do
      %{rows: {1, :unpacked, {:message, CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow}}}
    end
    @spec(required_fields() :: [])
    def(required_fields()) do
      []
    end
    @spec(unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}])
    def(unknown_fields(msg)) do
      msg.__uf__()
    end
    @spec(unknown_fields_name() :: :__uf__)
    def(unknown_fields_name()) do
      :__uf__
    end
    @spec(clear_unknown_fields(struct) :: struct)
    def(clear_unknown_fields(msg)) do
      struct!(msg, [{unknown_fields_name(), []}])
    end
    @spec(syntax() :: atom)
    def(syntax()) do
      :proto3
    end
    [@spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}), [def(default(:rows)) do
      {:error, :no_default_value}
    end], def(default(_)) do
      {:error, :no_such_field}
    end]
  )
  []
end