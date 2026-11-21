defmodule GigDatasets do
  @moduledoc """
  Datasets to plot: copies of tables R and its packages ship, for the examples in Giggly's
  notebooks and for your own plots.

  Each dataset is a keyword list of columns, in the dataset's own order, which
  `Giggly.Plot.new/2` reads as a table, as do Explorer's `DataFrame.new/1` and Kino's data table.
  A column of numbers holds integers or floats, as each dataset's doc shows; a name is a string, a
  date a `Date`, and a value the data lacks `nil`. It is plain data: a column R holds as a factor
  holds its labels, strings, as a table read from a file holds them, and the dataset's doc gives
  R's levels, for an example that wants R's order to make the column a factor of its own.

  Each is kept in the package's `priv/datasets`, as R writes it, with a header saying where it came
  from and under which licence, and read when the package compiles, so asking for one reads
  nothing. Each dataset's doc names its source's licence too; they differ, and the package lists
  every one.
  """

  # How each of mtcars's columns is read; the file's header gives their order.
  @mtcars_types [
    model: :string,
    mpg: :float,
    cyl: :float,
    disp: :float,
    hp: :float,
    drat: :float,
    wt: :float,
    qsec: :float,
    vs: :float,
    am: :float,
    gear: :float,
    carb: :float
  ]

  # How each of mpg's columns is read; the file's header gives their order.
  @mpg_types [
    manufacturer: :string,
    model: :string,
    displ: :float,
    year: :integer,
    cyl: :integer,
    trans: :string,
    drv: :string,
    cty: :integer,
    hwy: :integer,
    fl: :string,
    class: :string
  ]

  # How each of diamonds's columns is read; the file's header gives their order. R stores `table`
  # as a double, whole as its values are, and its factors are read as their labels.
  @diamonds_types [
    carat: :float,
    cut: :string,
    color: :string,
    clarity: :string,
    depth: :float,
    table: :float,
    price: :integer,
    x: :float,
    y: :float,
    z: :float
  ]

  # How each of economics's columns is read; the file's header gives their order. R stores every
  # number as a double, whole ones included.
  @economics_types [
    date: :date,
    pce: :float,
    pop: :float,
    psavert: :float,
    uempmed: :float,
    unemploy: :float
  ]

  # How each of economics_long's columns is read; the file's header gives their order.
  @economics_long_types [
    date: :date,
    variable: :string,
    value: :float,
    value01: :float
  ]

  # How each of txhousing's columns is read; the file's header gives their order. R stores `year`
  # and `month` as integers and every other number as a double, whole ones included.
  @txhousing_types [
    city: :string,
    year: :integer,
    month: :integer,
    sales: :float,
    volume: :float,
    median: :float,
    listings: :float,
    inventory: :float,
    date: :float
  ]

  # How each of msleep's columns is read; the file's header gives their order. R stores every
  # number as a double.
  @msleep_types [
    name: :string,
    genus: :string,
    vore: :string,
    order: :string,
    conservation: :string,
    sleep_total: :float,
    sleep_rem: :float,
    sleep_cycle: :float,
    awake: :float,
    brainwt: :float,
    bodywt: :float
  ]

  # How each of faithfuld's columns is read; the file's header gives their order. R stores every
  # number as a double, the whole waiting times among them.
  @faithfuld_types [
    eruptions: :float,
    waiting: :float,
    density: :float
  ]

  # How each of faithful's columns is read; the file's header gives their order. R stores both as
  # doubles, the whole waiting times among them.
  @faithful_types [
    eruptions: :float,
    waiting: :float
  ]

  # How each of presidential's columns is read; the file's header gives their order.
  @presidential_types [name: :string, start: :date, end: :date, party: :string]

  # How each of seals's columns is read; the file's header gives their order.
  @seals_types [lat: :float, long: :float, delta_long: :float, delta_lat: :float]

  # How each of luv_colours's columns is read; the file's header gives their order.
  @luv_colours_types [L: :float, u: :float, v: :float, col: :string]

  # How each of movies's columns is read; the file's header gives their order. R stores the year,
  # length, budget, votes and genre flags as integers and the ratings as doubles.
  @movies_types [
    title: :string,
    year: :integer,
    length: :integer,
    budget: :integer,
    rating: :float,
    votes: :integer,
    r1: :float,
    r2: :float,
    r3: :float,
    r4: :float,
    r5: :float,
    r6: :float,
    r7: :float,
    r8: :float,
    r9: :float,
    r10: :float,
    mpaa: :string,
    Action: :integer,
    Animation: :integer,
    Comedy: :integer,
    Drama: :integer,
    Documentary: :integer,
    Romance: :integer,
    Short: :integer
  ]

  # How each of USArrests's columns is read; the file's header gives their order. R stores the
  # assaults and urban population as integers, the murders and rapes as doubles.
  @usarrests_types [
    state: :string,
    Murder: :float,
    Assault: :integer,
    UrbanPop: :integer,
    Rape: :float
  ]

  # How each of kyphosis's columns is read; the file's header gives their order. Its factor is read
  # as its labels.
  @kyphosis_types [Kyphosis: :string, Age: :integer, Number: :integer, Start: :integer]

  # How each of Oxboys's columns is read; the file's header gives their order. R stores age and
  # height as doubles, and its factors are read as their labels.
  @oxboys_types [
    Subject: :string,
    age: :float,
    height: :float,
    Occasion: :string
  ]

  # The datasets, each read from its file once, at compile time, so asking for one does no IO.
  @types [
    mtcars: @mtcars_types,
    mpg: @mpg_types,
    diamonds: @diamonds_types,
    economics: @economics_types,
    economics_long: @economics_long_types,
    txhousing: @txhousing_types,
    msleep: @msleep_types,
    faithfuld: @faithfuld_types,
    faithful: @faithful_types,
    presidential: @presidential_types,
    seals: @seals_types,
    luv_colours: @luv_colours_types,
    movies: @movies_types,
    usarrests: @usarrests_types,
    kyphosis: @kyphosis_types,
    oxboys: @oxboys_types
  ]

  @directory Path.expand("../priv/datasets", __DIR__)

  for {dataset, _types} <- @types do
    @external_resource Path.join(@directory, "#{dataset}.csv")
  end

  # How a value is read by its column's type, R's `NA` missing whatever the type.
  read = fn
    "NA", _type ->
      nil

    value, :string ->
      value

    value, :integer ->
      String.to_integer(value)

    value, :float ->
      {number, ""} = Float.parse(value)
      number

    value, :date ->
      Date.from_iso8601!(value)
  end

  # Each dataset's columns, its file's comment lines skipped: each named by its header, an atom its
  # table of types already holds, and read by its type.
  @parsed Map.new(@types, fn {dataset, types} ->
            [header | rows] =
              @directory
              |> Path.join("#{dataset}.csv")
              |> File.read!()
              |> String.split("\n")
              |> Enum.drop_while(fn line -> String.starts_with?(line, "#") end)
              |> Enum.join("\n")
              |> NimbleCSV.RFC4180.parse_string(skip_headers: false)

            columns =
              Enum.zip_with([header | rows], fn [name | values] ->
                name = String.to_existing_atom(name)
                type = Keyword.fetch!(types, name)
                {name, Enum.map(values, fn value -> read.(value, type) end)}
              end)

            {dataset, columns}
          end)

  # The small datasets are kept as their columns. diamonds and txhousing are kept compressed, their
  # columns in Erlang's external term format, and decoded each time they are asked for: as columns
  # they would be some 18 MB and 2 MB held wherever this module is loaded, a release loading every
  # module at boot, where compressed they are half a megabyte and a tenth of one, decoded in a few
  # tens of milliseconds and a few, with no IO either way.
  @datasets Map.take(@parsed, [
              :mtcars,
              :mpg,
              :economics,
              :economics_long,
              :msleep,
              :faithfuld,
              :faithful,
              :presidential,
              :seals,
              :luv_colours,
              :usarrests,
              :kyphosis,
              :oxboys
            ])
  @diamonds @parsed
            |> Map.fetch!(:diamonds)
            |> :erlang.term_to_binary(compressed: 9)
  @txhousing @parsed
             |> Map.fetch!(:txhousing)
             |> :erlang.term_to_binary(compressed: 9)
  @movies @parsed
          |> Map.fetch!(:movies)
          |> :erlang.term_to_binary(compressed: 9)

  @doc """
  R's `mtcars`: fuel consumption and ten aspects of design and performance for 32 cars (1973-74
  models), from the 1974 *Motor Trend* US magazine (Henderson and Velleman, 1981). Every number
  is a float.

  The columns: `model`; `mpg`, miles per US gallon; `cyl`, cylinders; `disp`, displacement in
  cubic inches; `hp`, gross horsepower; `drat`, rear axle ratio; `wt`, weight in thousands of
  pounds; `qsec`, quarter-mile time in seconds; `vs`, the engine, 0 V-shaped and 1 straight; `am`,
  the transmission, 0 automatic and 1 manual; `gear`, forward gears; `carb`, carburettors.

  Copied from R's datasets package, R 4.6.1; licence: GPL-2.0-only OR GPL-3.0-only.

      iex> mtcars = GigDatasets.mtcars()
      iex> Keyword.keys(mtcars)
      [:model, :mpg, :cyl, :disp, :hp, :drat, :wt, :qsec, :vs, :am, :gear, :carb]
      iex> mtcars |> Keyword.fetch!(:model) |> length()
      32
      iex> Enum.map(mtcars, fn {name, values} -> {name, Enum.at(values, 2)} end)
      [
        model: "Datsun 710",
        mpg: 22.8,
        cyl: 4.0,
        disp: 108.0,
        hp: 93.0,
        drat: 3.85,
        wt: 2.32,
        qsec: 18.61,
        vs: 1.0,
        am: 1.0,
        gear: 4.0,
        carb: 1.0
      ]
  """
  @spec mtcars() :: [{atom(), [String.t() | number()]}]
  def mtcars, do: Map.fetch!(@datasets, :mtcars)

  @doc """
  ggplot2's `mpg`: fuel economy from 1999 to 2008 for 38 popular models of car, 234 cars in all, a
  subset of the data the US Environmental Protection Agency publishes at
  [fueleconomy.gov](https://fueleconomy.gov/), keeping only models with a new release every year
  from 1999 to 2008.

  The columns: `manufacturer`; `model`; `displ`, engine displacement in litres; `year`, of
  manufacture; `cyl`, cylinders; `trans`, the transmission; `drv`, the drive, `"f"` front-wheel,
  `"r"` rear-wheel and `"4"` four-wheel; `cty`, city miles per gallon; `hwy`, highway miles per
  gallon; `fl`, the fuel type; `class`, the type of car.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> mpg = GigDatasets.mpg()
      iex> Keyword.keys(mpg)
      [:manufacturer, :model, :displ, :year, :cyl, :trans, :drv, :cty, :hwy, :fl, :class]
      iex> mpg |> Keyword.fetch!(:model) |> length()
      234
      iex> Enum.map(mpg, fn {name, values} -> {name, Enum.at(values, 2)} end)
      [
        manufacturer: "audi",
        model: "a4",
        displ: 2.0,
        year: 2008,
        cyl: 4,
        trans: "manual(m6)",
        drv: "f",
        cty: 20,
        hwy: 31,
        fl: "p",
        class: "compact"
      ]
  """
  @spec mpg() :: [{atom(), [String.t() | number()]}]
  def mpg, do: Map.fetch!(@datasets, :mpg)

  @doc """
  ggplot2's `diamonds`: the prices and other attributes of 53,940 round cut diamonds.

  The columns: `carat`, the weight; `cut`, the quality of the cut, from `"Fair"`, `"Good"`,
  `"Very Good"` and `"Premium"` to `"Ideal"`; `color`, from `"D"`, the best, to `"J"`, the worst;
  `clarity`, how clear, from `"I1"`, the worst, through `"SI2"`, `"SI1"`, `"VS2"`, `"VS1"`,
  `"VVS2"` and `"VVS1"` to `"IF"`, the best; `depth`, the total depth as a percentage of the
  mean width, `2 * z / (x + y)`; `table`, the width of the top relative to the widest point;
  `price`, in US dollars; and `x`, `y` and `z`, the length, width and depth in millimetres.

  R holds `cut`, `color` and `clarity` as ordered factors with these levels, in this order:

    * `cut`: `"Fair"`, `"Good"`, `"Very Good"`, `"Premium"`, `"Ideal"`
    * `color`: `"D"`, `"E"`, `"F"`, `"G"`, `"H"`, `"I"`, `"J"`
    * `clarity`: `"I1"`, `"SI2"`, `"SI1"`, `"VS2"`, `"VS1"`, `"VVS2"`, `"VVS1"`, `"IF"`

  Here each is its labels, so a plot orders them alphabetically; to order one as R does, make it
  a factor: `Giggly.Factor.new(diamonds[:cut], levels: ["Fair", "Good", "Very Good", "Premium",
  "Ideal"], ordered: true)`. It is kept compressed and decoded each time it is asked for, in a few tens of
  milliseconds, so bind it once.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> diamonds = GigDatasets.diamonds()
      iex> Keyword.keys(diamonds)
      [:carat, :cut, :color, :clarity, :depth, :table, :price, :x, :y, :z]
      iex> diamonds |> Keyword.fetch!(:price) |> length()
      53940
      iex> Enum.map(diamonds, fn {name, values} -> {name, Enum.at(values, 2)} end)
      [
        carat: 0.23,
        cut: "Good",
        color: "E",
        clarity: "VS1",
        depth: 56.9,
        table: 65.0,
        price: 327,
        x: 4.05,
        y: 4.07,
        z: 2.31
      ]
  """
  @spec diamonds() :: [{atom(), [String.t() | number()]}]
  def diamonds, do: :erlang.binary_to_term(@diamonds)

  @doc """
  ggplot2's `economics`: US economic time series, one row a month from July 1967 to April 2015,
  574 in all, from the Federal Reserve Bank of St. Louis's
  [FRED](https://fred.stlouisfed.org/) database.

  The columns: `date`, the month, as a `Date` on its first day; `pce`, personal consumption
  expenditures, in billions of dollars; `pop`, the total population, in thousands; `psavert`, the
  personal savings rate; `uempmed`, the median duration of unemployment, in weeks; and `unemploy`,
  the number unemployed, in thousands. Every number is a float.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> economics = GigDatasets.economics()
      iex> Keyword.keys(economics)
      [:date, :pce, :pop, :psavert, :uempmed, :unemploy]
      iex> economics |> Keyword.fetch!(:date) |> length()
      574
      iex> Enum.map(economics, fn {name, values} -> {name, Enum.at(values, 0)} end)
      [
        date: ~D[1967-07-01],
        pce: 506.7,
        pop: 198712.0,
        psavert: 12.6,
        uempmed: 4.5,
        unemploy: 2944.0
      ]
  """
  @spec economics() :: [{atom(), [Date.t() | number()]}]
  def economics, do: Map.fetch!(@datasets, :economics)

  @doc """
  ggplot2's `economics_long`: `economics/0` in long form, a row for each month and series, 2,870
  in all, so the five series can be drawn as lines of one plot.

  The columns: `date`, the month, as a `Date` on its first day; `variable`, the series, `"pce"`,
  `"pop"`, `"psavert"`, `"uempmed"` or `"unemploy"`, as `economics/0` names its columns; `value`,
  the series' value that month, in its own units; and `value01`, the value rescaled within its
  series, from 0, its lowest, to 1, its highest, so series of different units share an axis.
  Every number is a float.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> economics_long = GigDatasets.economics_long()
      iex> Keyword.keys(economics_long)
      [:date, :variable, :value, :value01]
      iex> economics_long |> Keyword.fetch!(:date) |> length()
      2870
      iex> Enum.map(economics_long, fn {name, values} -> {name, Enum.at(values, 1)} end)
      [
        date: ~D[1967-08-01],
        variable: "pce",
        value: 509.8,
        value01: 0.0002652497197765077
      ]
  """
  @spec economics_long() :: [{atom(), [Date.t() | String.t() | number()]}]
  def economics_long, do: Map.fetch!(@datasets, :economics_long)

  @doc """
  ggplot2's `txhousing`: housing sales in Texas, a row for each month from January 2000 to July
  2015 and each of 46 multiple listing service areas, 8,602 in all, from the TAMU real estate
  center, [trerc.tamu.edu](https://trerc.tamu.edu/).

  The columns: `city`, the area's name; `year` and `month`, of the sales, integers; `sales`, the
  number of sales; `volume`, their total value, in dollars; `median`, the median sale price, in
  dollars; `listings`, the total active listings; `inventory`, the months it would take to sell
  every listing at the current pace of sales; and `date`, the year and month as a decimal, `year +
  (month - 1) / 12`. Every number but the year and month is a float, and a value the data lacks
  is `nil`, as R's is `NA`. It is kept compressed and decoded each time it is asked for, in a few
  milliseconds, so bind it once.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> txhousing = GigDatasets.txhousing()
      iex> Keyword.keys(txhousing)
      [:city, :year, :month, :sales, :volume, :median, :listings, :inventory, :date]
      iex> txhousing |> Keyword.fetch!(:city) |> length()
      8602
      iex> Enum.map(txhousing, fn {name, values} -> {name, Enum.at(values, 2)} end)
      [
        city: "Abilene",
        year: 2000,
        month: 3,
        sales: 130.0,
        volume: 9285000.0,
        median: 58100.0,
        listings: 784.0,
        inventory: 6.8,
        date: 2000.1666666666667
      ]
  """
  @spec txhousing() :: [{atom(), [String.t() | number() | nil]}]
  def txhousing, do: :erlang.binary_to_term(@txhousing)

  @doc """
  ggplot2's `msleep`: the sleep of 83 mammals, an updated and expanded version of the mammals
  sleep dataset. The sleep times and weights are from Savage and West (2007); the order,
  conservation status and diet were added from Wikipedia.

  The columns: `name`, the animal's common name; `genus`; `vore`, its diet, `"carni"`,
  `"herbi"`, `"insecti"` or `"omni"`; `order`; `conservation`, its conservation status, such as
  `"lc"`, least concern, or `"domesticated"`; `sleep_total`, its total sleep in hours;
  `sleep_rem`, its REM sleep in hours; `sleep_cycle`, the length of its sleep cycle in hours;
  `awake`, its time awake in hours; and `brainwt` and `bodywt`, its brain and body weight in
  kilograms. Every number is a float, and a value the data lacks is `nil`, as R's is `NA`.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> msleep = GigDatasets.msleep()
      iex> Keyword.keys(msleep)
      [:name, :genus, :vore, :order, :conservation, :sleep_total, :sleep_rem, :sleep_cycle,
       :awake, :brainwt, :bodywt]
      iex> msleep |> Keyword.fetch!(:name) |> length()
      83
      iex> Enum.map(msleep, fn {name, values} -> {name, Enum.at(values, 1)} end)
      [
        name: "Owl monkey",
        genus: "Aotus",
        vore: "omni",
        order: "Primates",
        conservation: nil,
        sleep_total: 17.0,
        sleep_rem: 1.8,
        sleep_cycle: nil,
        awake: 7.0,
        brainwt: 0.0155,
        bodywt: 0.48
      ]
  """
  @spec msleep() :: [{atom(), [String.t() | number() | nil]}]
  def msleep, do: Map.fetch!(@datasets, :msleep)

  @doc """
  ggplot2's `faithfuld`: a two-dimensional density estimate of the eruption and waiting times in
  R's `faithful` data on the Old Faithful geyser, at each point of a 75 by 75 grid, 5,625 rows in
  all, for drawing a surface.

  The columns: `eruptions`, the eruption time in minutes; `waiting`, the waiting time to the next
  eruption in minutes; and `density`, the estimated density there. Every number is a float.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> faithfuld = GigDatasets.faithfuld()
      iex> Keyword.keys(faithfuld)
      [:eruptions, :waiting, :density]
      iex> faithfuld |> Keyword.fetch!(:density) |> length()
      5625
      iex> Enum.map(faithfuld, fn {name, values} -> {name, Enum.at(values, 2)} end)
      [eruptions: 1.6945945945945946, waiting: 43.0, density: 0.0044355477659065081]
  """
  @spec faithfuld() :: [{atom(), [float()]}]
  def faithfuld, do: Map.fetch!(@datasets, :faithfuld)

  @doc """
  R's `faithful`: the eruption and waiting times of 272 eruptions of the Old Faithful geyser in
  Yellowstone National Park, the data `faithfuld/0` estimates the density of.

  The columns: `eruptions`, the eruption time in minutes, and `waiting`, the waiting time to the
  next eruption in minutes. Every number is a float, as R stores both as doubles.

  Copied from R's datasets package, R 4.6.1; licence: GPL-2.0-only OR GPL-3.0-only.

      iex> faithful = GigDatasets.faithful()
      iex> Keyword.keys(faithful)
      [:eruptions, :waiting]
      iex> faithful |> Keyword.fetch!(:waiting) |> length()
      272
      iex> Enum.map(faithful, fn {name, values} -> {name, Enum.take(values, 3)} end)
      [eruptions: [3.6, 1.8, 3.333], waiting: [79.0, 54.0, 74.0]]
  """
  @spec faithful() :: [{atom(), [float()]}]
  def faithful, do: Map.fetch!(@datasets, :faithful)

  @doc """
  ggplot2's `presidential`: the terms of 12 US presidents, from Eisenhower to Trump.

  The columns: `name`, the president's last name; `start` and `end`, the dates the term began and
  ended, `Date`s; and `party`, `"Republican"` or `"Democratic"`.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> presidential = GigDatasets.presidential()
      iex> Keyword.keys(presidential)
      [:name, :start, :end, :party]
      iex> Enum.map(presidential, fn {name, values} -> {name, hd(values)} end)
      [name: "Eisenhower", start: ~D[1953-01-20], end: ~D[1961-01-20], party: "Republican"]
  """
  @spec presidential() :: [{atom(), [String.t() | Date.t()]}]
  def presidential, do: Map.fetch!(@datasets, :presidential)

  @doc """
  ggplot2's `seals`: a vector field of seal movements, 1,155 arrows, from the data of Brillinger,
  Preisler, Ager and Kie, "An exploratory data analysis (EDA) of the paths of moving animals"
  (2004), with the methods of Brillinger's "Learning a potential function from a trajectory"
  (2007).

  The columns: `lat` and `long`, where each arrow starts, in degrees; and `delta_long` and
  `delta_lat`, how far it runs east and north, in degrees. Every number is a float.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> seals = GigDatasets.seals()
      iex> Keyword.keys(seals)
      [:lat, :long, :delta_long, :delta_lat]
      iex> Enum.map(seals, fn {name, values} -> {name, hd(values)} end)
      [lat: 29.7, long: -172.8, delta_long: -0.915046236652548, delta_lat: 0.143475253741286]
  """
  @spec seals() :: [{atom(), [float()]}]
  def seals, do: Map.fetch!(@datasets, :seals)

  @doc """
  ggplot2's `luv_colours`: every one of R's built-in colours, 657 of them, each placed in the CIE
  Luv colour space.

  The columns: `L`, `u` and `v`, the colour's place in Luv space, floats; and `col`, its name, one
  of R's colour names, most of which CSS does not name, so a plot drawing them as colours as they
  stand refuses the first it meets.

  Copied from ggplot2 4.0.3; licence: MIT.

      iex> luv_colours = GigDatasets.luv_colours()
      iex> Keyword.keys(luv_colours)
      [:L, :u, :v, :col]
      iex> Enum.map(luv_colours, fn {name, values} -> {name, hd(values)} end)
      [L: 9341.57022199546, u: -3.370648562648931e-12, v: 0.0, col: "white"]
  """
  @spec luv_colours() :: [{atom(), [float() | String.t()]}]
  def luv_colours, do: Map.fetch!(@datasets, :luv_colours)

  @doc """
  ggplot2movies' `movies`: 58,788 films from the Internet Movie Database, each with its length,
  budget, user rating and genres.

  The columns: `title`; `year`, of release; `length`, in minutes; `budget`, in US dollars, not
  adjusted for inflation, `nil` where unknown; `rating`, the average IMDB user rating; `votes`,
  the number of IMDB users who rated it; `r1` to `r10`, the share of its votes rating it 1 to 10,
  as the midpoint of its decile, 0 for none, 4.5 for 1-9%, 14.5 for 11-19% and so on; `mpaa`, its
  MPAA rating, `""` where it has none; and `Action`, `Animation`, `Comedy`, `Drama`,
  `Documentary`, `Romance` and `Short`, 1 for a film in that genre, else 0. The ratings are
  floats and the rest of the numbers integers. It is kept compressed and decoded each time it is
  asked for, so bind it once.

  Copied from ggplot2movies 0.0.1; licence: GPL-3.0-only.

      iex> movies = GigDatasets.movies()
      iex> movies |> Keyword.fetch!(:title) |> length()
      58788
      iex> columns = Keyword.take(movies, [:title, :year, :length, :budget, :rating, :mpaa])
      iex> Enum.map(columns, fn {name, values} -> {name, hd(values)} end)
      [title: "$", year: 1971, length: 121, budget: nil, rating: 6.4, mpaa: ""]
  """
  @spec movies() :: [{atom(), [String.t() | number() | nil]}]
  def movies, do: :erlang.binary_to_term(@movies)

  @doc """
  R's `USArrests`: arrests per 100,000 residents for assault, murder and rape in each of the 50 US
  states in 1973, and the percentage of each state's population living in urban areas, from the
  World Almanac and Book of Facts 1975 and the Statistical Abstracts of the United States 1975, as
  McNeil (1977), *Interactive Data Analysis*, gives them.

  The columns: `state`, R's row names; `Murder`, `Assault` and `Rape`, arrests per 100,000; and
  `UrbanPop`, the percentage of the population that is urban. `Assault` and `UrbanPop` are
  integers, `Murder` and `Rape` floats, as R stores them.

  Copied from R's datasets package, R 4.6.1; licence: GPL-2.0-only OR GPL-3.0-only.

      iex> usarrests = GigDatasets.usarrests()
      iex> Keyword.keys(usarrests)
      [:state, :Murder, :Assault, :UrbanPop, :Rape]
      iex> Enum.map(usarrests, fn {name, values} -> {name, hd(values)} end)
      [state: "Alabama", Murder: 13.2, Assault: 236, UrbanPop: 58, Rape: 21.2]
  """
  @spec usarrests() :: [{atom(), [String.t() | number()]}]
  def usarrests, do: Map.fetch!(@datasets, :usarrests)

  @doc """
  rpart's `kyphosis`: 81 children who had corrective spinal surgery, and whether kyphosis, a
  forward curvature of the spine, was present after the operation (Chambers and Hastie, 1992,
  *Statistical Models in S*).

  The columns: `Kyphosis`, `"absent"` or `"present"` after the operation; `Age`, in months;
  `Number`, the number of vertebrae involved; and `Start`, the number of the first, topmost,
  vertebra operated on. The numbers are integers.

  R holds `Kyphosis` as a factor with these levels, in this order:

    * `Kyphosis`: `"absent"`, `"present"`

  Here it is its labels, so a plot orders them as strings, which here is R's order too.

  Copied from rpart 4.1.27; licence: GPL-2.0-only OR GPL-3.0-only.

      iex> kyphosis = GigDatasets.kyphosis()
      iex> Keyword.keys(kyphosis)
      [:Kyphosis, :Age, :Number, :Start]
      iex> Enum.map(kyphosis, fn {name, values} -> {name, hd(values)} end)
      [Kyphosis: "absent", Age: 71, Number: 3, Start: 5]
  """
  @spec kyphosis() :: [{atom(), [String.t() | integer()]}]
  def kyphosis, do: Map.fetch!(@datasets, :kyphosis)

  @doc """
  nlme's `Oxboys`: the heights of 26 boys from Oxford, England, each measured on nine occasions,
  234 rows in all, against a standardised age (Goldstein, 1987; Pinheiro and Bates, 2000).

  The columns, named as R names them: `Subject`, the boy; `age`, his standardised age, from -1 to
  about 1, dimensionless; `height`, in centimetres; and `Occasion`, the measurement, from `"1"` to
  `"9"`. `age` and `height` are floats.

  R holds `Subject` and `Occasion` as ordered factors with these levels, in this order: the boys
  from the shortest at his tallest to the tallest, as nlme orders them, and the occasions in
  order.

    * `Subject`: `"10"`, `"26"`, `"25"`, `"9"`, `"2"`, `"6"`, `"7"`, `"17"`, `"16"`, `"15"`, `"8"`,
      `"20"`, `"1"`, `"18"`, `"5"`, `"23"`, `"11"`, `"21"`, `"3"`, `"24"`, `"22"`, `"12"`, `"13"`,
      `"14"`, `"19"`, `"4"`
    * `Occasion`: `"1"`, `"2"`, `"3"`, `"4"`, `"5"`, `"6"`, `"7"`, `"8"`, `"9"`

  Here each is its labels, so a plot orders them as strings; to order one as R does, make it a
  factor with those levels, ordered, as `Giggly.Factor.new/2` takes them.

  Copied from nlme 3.1.171; licence: GPL-2.0-or-later.

      iex> oxboys = GigDatasets.oxboys()
      iex> Keyword.keys(oxboys)
      [:Subject, :age, :height, :Occasion]
      iex> oxboys |> Keyword.fetch!(:height) |> length()
      234
      iex> Enum.map(oxboys, fn {name, values} -> {name, Enum.at(values, 1)} end)
      [Subject: "1", age: -0.7479, height: 143.4, Occasion: "2"]
  """
  @spec oxboys() :: [{atom(), [String.t() | float()]}]
  def oxboys, do: Map.fetch!(@datasets, :oxboys)
end
