defmodule GigDatasetsTest do
  use ExUnit.Case, async: true

  doctest GigDatasets

  # Golden: test/fixtures/fingerprint.csv, written by dev/regenerate.R from R's own data beside the
  # datasets' files. Each row is one column of one dataset: its place, R's class, the dataset's row
  # count, how many values are missing and how many distinct, and its first, last, least and
  # greatest value, text in byte order as R's C locale sorts it, and the MD5 of every value, as
  # `digest/2` below works it out. Every column of every dataset is checked whole, so a dropped
  # row, a column read as the wrong type, a missing value read as one, or a value anywhere that
  # lost a digit fails it.
  @fingerprint "test/fixtures/fingerprint.csv"
               |> File.read!()
               |> NimbleCSV.RFC4180.parse_string()

  @datasets @fingerprint
            |> Enum.map(fn [dataset | _rest] -> String.to_atom(dataset) end)
            |> Enum.uniq()

  test "every dataset is R's, column by column, as its fingerprint records" do
    found =
      for [
            dataset,
            column,
            position,
            class,
            rows,
            missing,
            distinct,
            first,
            last,
            least,
            greatest,
            _levels,
            digest,
            _ordered
          ] <- @fingerprint do
        table = apply(GigDatasets, String.to_atom(dataset), [])
        {name, values} = Enum.at(table, String.to_integer(position) - 1)
        present = Enum.reject(values, &is_nil/1)
        read = fn text -> read(text, class) end

        actual =
          {Atom.to_string(name), length(values), Enum.count(values, &is_nil/1),
           length(Enum.uniq(present)), Enum.all?(present, fn value -> typed?(value, class) end),
           List.first(values), List.last(values), least(present, class), greatest(present, class),
           digest(values, class)}

        expected =
          {column, String.to_integer(rows), String.to_integer(missing),
           String.to_integer(distinct), true, read.(first), read.(last), read.(least),
           read.(greatest), digest}

        {dataset, column, actual === expected, actual, expected}
      end

    assert Enum.reject(found, fn {_dataset, _column, same, _actual, _expected} -> same end) == []

    assert Enum.map(@datasets, fn dataset -> length(apply(GigDatasets, dataset, [])) end) ==
             Enum.map(@datasets, fn dataset ->
               Enum.count(@fingerprint, fn [name | _rest] -> name == Atom.to_string(dataset) end)
             end)
  end

  # Golden: the fingerprint's `levels()` and `is.ordered()` of each of R's factors. A factor's
  # column holds its labels, and the dataset's doc lists the levels, one bullet per column, in R's
  # order, for an example to make the factor with.
  test "each factor's column holds its labels, and its dataset's doc lists R's levels in order" do
    factors =
      for [
            dataset,
            column,
            _position,
            class,
            _rows,
            _missing,
            _distinct,
            _first,
            _last,
            _least,
            _greatest,
            levels,
            _digest,
            ordered
          ] <- @fingerprint,
          class in ["factor", "ordered"] do
        {String.to_atom(dataset), column, String.split(levels, "|"), ordered == "TRUE"}
      end

    for {dataset, column, levels, ordered} <- factors do
      doc = doc_of(dataset)
      [_line, listed] = Regex.run(~r/^\s*\* `#{column}`: (.*?)(?=\n\s*\*|\n\n)/ms, doc)
      documented = List.flatten(Regex.scan(~r/`"([^"]*)"`/, listed, capture: :all_but_first))
      labels = Keyword.fetch!(apply(GigDatasets, dataset, []), String.to_atom(column))

      assert {dataset, column, documented, Enum.reject(labels, fn label -> label in levels end)} ==
               {dataset, column, levels, []}

      assert doc =~ if(ordered, do: ~r/as (an )?ordered factors?/, else: ~r/as (a )?factors? /)
    end

    assert factors != []
  end

  # Each dataset's file names its source's licence in its header, and so does its doc; the
  # package lists every licence its datasets carry, and no other.
  test "each dataset names its licence in its file and its doc, and the package lists them all" do
    licences =
      for dataset <- @datasets do
        [_line, header] =
          Regex.run(
            ~r/^# Source: .*?\. Licence: (.*)\.$/m,
            File.read!("priv/datasets/#{dataset}.csv")
          )

        [_line, documented] = Regex.run(~r/; licence: (.*)\.$/m, doc_of(dataset))
        assert {dataset, documented} == {dataset, header}
        header
      end

    # Hex takes single SPDX identifiers only, so a dataset under either of two licences
    # ("GPL-2.0-only OR GPL-3.0-only") is listed in the package under each.
    identifiers = Enum.flat_map(licences, fn licence -> String.split(licence, " OR ") end)

    listed = Mix.Project.config()[:package][:licenses]
    assert MapSet.new(identifiers) == MapSet.new(listed)
  end

  defp read("NA", _class), do: nil
  defp read(text, "integer"), do: String.to_integer(text)
  defp read(text, "Date"), do: Date.from_iso8601!(text)

  defp read(text, "numeric") do
    {number, ""} = Float.parse(text)
    number
  end

  defp read(text, _text_class), do: text

  defp typed?(value, "integer"), do: is_integer(value)
  defp typed?(value, "numeric"), do: is_float(value)
  defp typed?(value, "Date"), do: is_struct(value, Date)
  defp typed?(value, _text_class), do: is_binary(value)

  # The MD5 of every value of a column as dev/regenerate.R's digest() works it out: a missing value
  # zero or empty, each a big-endian double, a big-endian 32-bit integer (a date its days since
  # 1970-01-01) or UTF-8 text, texts joined by the unit separator.
  defp digest(values, class), do: Base.encode16(:erlang.md5(bytes(values, class)), case: :lower)

  defp bytes(values, "numeric"),
    do: for(value <- values, into: <<>>, do: <<value || 0.0::float-64-big>>)

  defp bytes(values, "integer"),
    do: for(value <- values, into: <<>>, do: <<value || 0::signed-32-big>>)

  defp bytes(values, "Date"),
    do: for(value <- values, into: <<>>, do: <<days(value)::signed-32-big>>)

  defp bytes(values, _text_class), do: Enum.map_join(values, "\x1f", fn value -> value || "" end)

  defp days(nil), do: 0
  defp days(date), do: Date.diff(date, ~D[1970-01-01])

  defp least([], _class), do: nil
  defp least(values, "Date"), do: Enum.min(values, Date)
  defp least(values, _class), do: Enum.min(values)

  defp greatest([], _class), do: nil
  defp greatest(values, "Date"), do: Enum.max(values, Date)
  defp greatest(values, _class), do: Enum.max(values)

  defp doc_of(dataset) do
    {:docs_v1, _anno, _language, _format, _module_doc, _metadata, docs} =
      Code.fetch_docs(GigDatasets)

    [doc] =
      for {{:function, ^dataset, 0}, _anno, _signature, %{"en" => doc}, _metadata} <- docs,
          do: doc

    doc
  end
end
