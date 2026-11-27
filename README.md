# GigDatasets

Datasets to plot: copies of the tables R, ggplot2 and their packages ship, and map outlines from
public-domain sources laid out as ggplot2's `map_data()` lays them, for the examples in
[Giggly](https://github.com/giggleton/giggly)'s notebooks and for your own plots.

Each dataset is a keyword list of plain columns, which Giggly, Explorer and Kino all read as a
table: integers, floats, strings, `Date`s and `nil` for a missing value. A column R holds as a
factor holds its labels, as a table read from a file would, and the dataset's documentation gives
R's levels, so you can make the factor yourself where you want R's order.

## Installation

Add it to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gig_datasets, "~> 0.1.0"}
  ]
end
```

## Use

```elixir
GigDatasets.mpg()
|> Giggly.Plot.new(%{x: :displ, y: :hwy})
|> Giggly.Plot.geom_point()
|> Giggly.to_svg()
```

The datasets are read when the package compiles, so asking for one reads no file; the biggest
are kept compressed and decoded when asked for.

## Licences

The code is MIT; see `LICENSE`. Each dataset carries its source's licence, which its file's header
and its documentation name: ggplot2's datasets are MIT; R's own (`mtcars`, `faithful`,
`USArrests`) and rpart's `kyphosis` are GPL-2.0 or GPL-3.0; nlme's `Oxboys` is GPL-2.0 or later;
ggplot2movies' `movies` is GPL-3.0; and the map outlines (`state_map`, from the US Census Bureau,
and `world_map` and `nz_map`, from Natural Earth) are in the public domain, which needs no licence
listed; sf's `nc`, North Carolina's counties, is MIT. The package lists every licence its datasets carry,
`LICENSES/` holds the GPL's two texts, and `THIRD_PARTY_NOTICES.md` says where each dataset comes
from.

## Regenerating a dataset

The files in `priv/datasets` and the fingerprint the tests check them against are written from R's
own data, and the map outlines from their sources' files, by `dev/regenerate.R`, whose header gives
the command and where to download the outlines' files. Only a maintainer changing a
dataset needs R; the package and its tests read only the committed files.
