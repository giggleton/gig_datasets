# Writes every dataset's file, priv/datasets/<name>.csv, and the fingerprint the tests check each
# dataset against, test/fixtures/fingerprint.csv, from R's own data. Run it from the package root
# when a dataset's source releases a new version, or a dataset is added:
#
#   docker build -t gig-datasets-r dev
#   docker run --rm --user "$(id -u):$(id -g)" -v "$PWD":/work -w /work gig-datasets-r \
#     Rscript dev/regenerate.R
#
# The image is Giggly's R image with ggplot2movies added (dev/Dockerfile).
#
# Nothing else needs R: the files and the fingerprint are committed, and the package and its tests
# read only them.
#
# Each file is a header of comment lines, written from the table below, then the dataset exactly as
# write.csv(row.names = FALSE) writes it, but for its doubles: write.csv() writes 15 significant
# digits, which loses some values, so a double those lose is written in 17 (shortest() below says
# why not 16). The values are copied as R holds them, never recomputed.
#
# The fingerprint holds one row per column of every dataset: its place, R's class, the dataset's
# row count, how many values are missing and how many distinct, the first, last, least and greatest
# value (text in byte order, as R's C locale sorts it), a factor's levels, a digest of every value
# (digest() below says how), and whether a factor's levels are ordered.

library(ggplot2)

datasets <- list(
  list(
    name = "mtcars",
    data = function() cbind(model = rownames(datasets::mtcars), datasets::mtcars),
    source = "R's datasets package, R 4.6.1",
    licence = "GPL-2.0-only OR GPL-3.0-only",
    about = c(
      "mtcars: fuel consumption and ten aspects of design and performance for 32 cars (1973-74",
      "models), from the 1974 Motor Trend US magazine. Source: Henderson and Velleman (1981),",
      "Building multiple regression models interactively, Biometrics 37, 391-411.",
      "",
      "Columns: model (the car, R's row names), mpg (miles per US gallon), cyl (cylinders), disp",
      "(displacement, cubic inches), hp (gross horsepower), drat (rear axle ratio), wt (weight, 1000",
      "lbs), qsec (quarter mile time, seconds), vs (engine: 0 V-shaped, 1 straight), am",
      "(transmission: 0 automatic, 1 manual), gear (forward gears), carb (carburettors)."
    )
  ),
  list(
    name = "mpg",
    data = function() ggplot2::mpg,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "mpg: fuel economy from 1999 to 2008 for 38 popular models of car, a subset of the data the",
      "US Environmental Protection Agency publishes at https://fueleconomy.gov/, keeping only models",
      "with a new release every year from 1999 to 2008.",
      "",
      "Columns: manufacturer; model; displ (engine displacement, litres); year (of manufacture); cyl",
      "(cylinders); trans (transmission); drv (drive: f front-wheel, r rear-wheel, 4 four-wheel); cty",
      "(city miles per gallon); hwy (highway miles per gallon); fl (fuel type); class (type of car)."
    )
  ),
  list(
    name = "diamonds",
    data = function() ggplot2::diamonds,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "diamonds: the prices and other attributes of 53,940 round cut diamonds.",
      "",
      "Columns: carat (weight, 0.2-5.01); cut (quality of the cut: Fair, Good, Very Good, Premium,",
      "Ideal); color (D, best, to J, worst); clarity (how clear: I1, worst, SI2, SI1, VS2, VS1, VVS2,",
      "VVS1, IF, best); depth (total depth percentage, 2 * z / (x + y)); table (width of the top",
      "relative to the widest point); price (US dollars); x (length, mm); y (width, mm); z (depth,",
      "mm). cut, color and clarity are ordered factors in R; here they are their labels."
    )
  ),
  list(
    name = "economics",
    data = function() ggplot2::economics,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "economics: US economic time series, monthly from July 1967 to April 2015, from the Federal",
      "Reserve Bank of St. Louis's FRED database (https://fred.stlouisfed.org/).",
      "",
      "Columns: date (the month of collection, its first day); pce (personal consumption",
      "expenditures, billions of dollars); pop (total population, thousands); psavert (personal",
      "savings rate); uempmed (median duration of unemployment, weeks); unemploy (number unemployed,",
      "thousands)."
    )
  ),
  list(
    name = "economics_long",
    data = function() ggplot2::economics_long,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "economics_long: ggplot2's economics in long form, one row a month and series, the five",
      "series of economics (pce, pop, psavert, uempmed, unemploy) each from July 1967 to April",
      "2015; the data is the Federal Reserve Bank of St. Louis's FRED database",
      "(https://fred.stlouisfed.org/).",
      "",
      "Columns: date (the month of collection, its first day); variable (the series: pce, pop,",
      "psavert, uempmed or unemploy, as economics names them); value (the series' value that month,",
      "in its units, as economics gives it); value01 (the value rescaled within its series, 0 its",
      "lowest and 1 its highest)."
    )
  ),
  list(
    name = "txhousing",
    data = function() ggplot2::txhousing,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "txhousing: housing sales in Texas, one row a month for each of 46 multiple listing service",
      "areas from January 2000 to July 2015, from the TAMU real estate center",
      "(https://trerc.tamu.edu/).",
      "",
      "Columns: city (the area's name); year and month (of the sales); sales (number of sales);",
      "volume (total value of sales, dollars); median (median sale price, dollars); listings (total",
      "active listings); inventory (months inventory: the time it would take to sell every listing",
      "at the current pace of sales); date (the year and month as a decimal, year + (month - 1) /",
      "12)."
    )
  ),
  list(
    name = "msleep",
    data = function() ggplot2::msleep,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "msleep: the sleep of 83 mammals, an updated and expanded version of the mammals sleep",
      "dataset, its sleep times and weights from V. M. Savage and G. B. West, \"A quantitative,",
      "theoretical framework for understanding mammalian sleep\", PNAS 104(3), 2007, and its order,",
      "conservation status and diet added from Wikipedia.",
      "",
      "Columns: name (common name); genus; vore (diet: carni, herbi, insecti or omni); order;",
      "conservation (conservation status: cd, domesticated, en, lc, nt or vu); sleep_total (total",
      "sleep, hours); sleep_rem (REM sleep, hours); sleep_cycle (length of the sleep cycle, hours);",
      "awake (time awake, hours); brainwt (brain weight, kilograms); bodywt (body weight,",
      "kilograms)."
    )
  ),
  list(
    name = "faithfuld",
    data = function() ggplot2::faithfuld,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "faithfuld: a two-dimensional density estimate of the eruptions and waiting times in R's",
      "faithful data on the Old Faithful geyser, on a 75 by 75 grid; ggplot2 made it with",
      "MASS::kde2d(faithful$eruptions, faithful$waiting, h = c(1, 10), n = 75) (its",
      "data-raw/faithfuld.R).",
      "",
      "Columns: eruptions (eruption time, minutes); waiting (waiting time to the next eruption,",
      "minutes); density (the two-dimensional density estimate there)."
    )
  ),
  list(
    name = "faithful",
    data = function() datasets::faithful,
    source = "R's datasets package, R 4.6.1",
    licence = "GPL-2.0-only OR GPL-3.0-only",
    about = c(
      "faithful: the eruption and waiting times of 272 eruptions of the Old Faithful geyser in",
      "Yellowstone National Park; the data are from Härdle (1991).",
      "",
      "Columns: eruptions (eruption time, minutes); waiting (waiting time to the next eruption,",
      "minutes). R stores both as doubles."
    )
  ),
  list(
    name = "presidential",
    data = function() ggplot2::presidential,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "presidential: the terms of 12 US presidents, from Eisenhower to Trump.",
      "",
      "Columns: name (the president's last name); start and end (the dates the term began and",
      "ended); party (Republican or Democratic)."
    )
  ),
  list(
    name = "seals",
    data = function() ggplot2::seals,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "seals: a vector field of seal movements, from the data of Brillinger, Preisler, Ager and",
      "Kie, \"An exploratory data analysis (EDA) of the paths of moving animals\" (2004), with the",
      "methods of Brillinger's \"Learning a potential function from a trajectory\" (2007).",
      "",
      "Columns: lat and long (where each arrow starts, degrees); delta_long and delta_lat (how far",
      "it runs east and north, degrees)."
    )
  ),
  list(
    name = "luv_colours",
    data = function() ggplot2::luv_colours,
    source = "ggplot2 4.0.3",
    licence = "MIT",
    about = c(
      "luv_colours: every one of R's built-in colors(), 657 of them, each placed in the CIE Luv",
      "colour space.",
      "",
      "Columns: L, u and v (the colour's place in Luv space); col (its name, one of R's colour",
      "names, most of which CSS does not name)."
    )
  ),
  list(
    name = "movies",
    data = function() ggplot2movies::movies,
    source = "ggplot2movies 0.0.1",
    licence = "GPL-3.0-only",
    about = c(
      "movies: 58,788 films from the Internet Movie Database, each with its length, budget, user",
      "rating and genres.",
      "",
      "Columns: title; year (of release); length (minutes); budget (US dollars, not adjusted for",
      "inflation, NA where unknown); rating (average IMDB user rating); votes (number of IMDB users",
      "who rated it); r1 to r10 (the share of its votes rating it 1 to 10, as the midpoint of its",
      "decile: 0 for none, 4.5 for 1-9%, 14.5 for 11-19%, and so on); mpaa (MPAA rating, empty",
      "where it has none); Action, Animation, Comedy, Drama, Documentary, Romance and Short",
      "(1 for a film in that genre, else 0)."
    )
  ),
  list(
    name = "usarrests",
    data = function() cbind(state = rownames(datasets::USArrests), datasets::USArrests),
    source = "R's datasets package, R 4.6.1",
    licence = "GPL-2.0-only OR GPL-3.0-only",
    about = c(
      "USArrests: arrests per 100,000 residents for assault, murder and rape in each of the 50 US",
      "states in 1973, and the percentage of the population living in urban areas. Source: World",
      "Almanac and Book of facts 1975 (crime rates) and Statistical Abstracts of the United States",
      "1975 (urban rates), as McNeil (1977), Interactive Data Analysis, gives them.",
      "",
      "Columns: state (R's row names); Murder (arrests per 100,000); Assault (arrests per",
      "100,000); UrbanPop (percent urban population); Rape (arrests per 100,000)."
    )
  ),
  list(
    name = "kyphosis",
    data = function() rpart::kyphosis,
    source = "rpart 4.1.27",
    licence = "GPL-2.0-only OR GPL-3.0-only",
    about = c(
      "kyphosis: 81 children who had corrective spinal surgery, and whether kyphosis, a forward",
      "curvature of the spine, was present after the operation. Source: Chambers and Hastie",
      "(1992), Statistical Models in S, Wadsworth and Brooks/Cole.",
      "",
      "Columns: Kyphosis (absent or present after the operation); Age (in months); Number (the",
      "number of vertebrae involved); Start (the number of the first, topmost, vertebra operated",
      "on). Kyphosis is a factor in R; here it is its labels."
    )
  ),
  list(
    name = "oxboys",
    data = function() as.data.frame(nlme::Oxboys),
    source = "nlme 3.1.171",
    licence = "GPL-2.0-or-later",
    about = c(
      "Oxboys: the heights of 26 boys from Oxford, England, each measured on nine occasions,",
      "against a standardised age; the data are from Goldstein (1987). Source: Pinheiro and Bates",
      "(2000), Mixed-Effects Models in S and S-PLUS, Springer, New York, Appendix A.19.",
      "",
      "Columns: Subject (the boy); age (standardised age, dimensionless, -1 to 1.0055); height (cm,",
      "126.2-174.8); Occasion (the measurement, 1 to 9). Subject and Occasion are ordered factors in",
      "R; here they are their labels. R stores age and height as doubles."
    )
  )
)

# Each double in 15 significant digits where those read back as R's, else 17, which always do;
# NA as NA. Never 16: R's as.numeric() does not round every long decimal correctly, and passed a
# 16-digit faithfuld density that a correct parser reads as the next double (dev's check, the
# fingerprint's digest, found it). 17 digits, from the C library's correctly rounded sprintf(), read
# back exactly.
shortest <- function(values) {
  vapply(values, function(value) {
    if (is.na(value)) return("NA")
    written <- format(value, digits = 15, scientific = FALSE)
    if (as.numeric(written) == value) written else sprintf("%.17g", value)
  }, character(1), USE.NAMES = FALSE)
}

# A value as the fingerprint writes it: a double as shortest() writes it, a date as
# format() writes it, anything else as as.character() does.
written <- function(values) {
  if (is.double(values) && !inherits(values, "Date")) shortest(values) else as.character(values)
}

# The MD5 of every value of a column, missing ones as zero or empty, each a big-endian double, a
# big-endian 32-bit integer (a date its days since 1970-01-01) or UTF-8 text, texts joined by the
# unit separator, so a value changed anywhere in the column changes it.
digest <- function(values) {
  bytes <- if (inherits(values, "Date")) {
    days <- as.integer(values)
    days[is.na(days)] <- 0L
    writeBin(days, raw(), size = 4, endian = "big")
  } else if (is.double(values)) {
    values[is.na(values)] <- 0
    writeBin(values, raw(), size = 8, endian = "big")
  } else if (is.integer(values)) {
    values[is.na(values)] <- 0L
    writeBin(values, raw(), size = 4, endian = "big")
  } else {
    text <- as.character(values)
    text[is.na(text)] <- ""
    charToRaw(enc2utf8(paste(text, collapse = "\x1f")))
  }
  unname(tools::md5sum(bytes = bytes))
}

fingerprint <- list()

for (dataset in datasets) {
  data <- as.data.frame(dataset$data())
  path <- file.path("priv", "datasets", paste0(dataset$name, ".csv"))

  header <- c(
    dataset$about,
    "",
    paste0("Source: ", dataset$source, ". Licence: ", dataset$licence, "."),
    "",
    "Written by dev/regenerate.R, which says how; regenerate with it, never by hand."
  )

  out <- data
  for (column in names(out)) {
    values <- out[[column]]
    if (is.double(values) && !inherits(values, "Date")) out[[column]] <- shortest(values)
  }
  quoted <- which(vapply(data, function(values) is.character(values) || is.factor(values),
                         logical(1)))

  connection <- file(path, "w", encoding = "UTF-8")
  writeLines(paste0("#", ifelse(header == "", "", " "), header), connection)
  write.csv(out, connection, row.names = FALSE, quote = if (length(quoted)) quoted else FALSE)
  close(connection)

  for (index in seq_along(data)) {
    values <- data[[index]]
    present <- values[!is.na(values)]
    sorted <- if (is.character(present) || is.factor(present)) {
      sort(as.character(present), method = "radix")
    } else {
      sort(present)
    }
    ends <- function(at) if (length(sorted)) written(sorted[at]) else "NA"
    fingerprint[[length(fingerprint) + 1]] <- data.frame(
      dataset = dataset$name,
      column = names(data)[index],
      position = index,
      class = class(values)[1],
      rows = nrow(data),
      missing = sum(is.na(values)),
      distinct = length(unique(present)),
      first = written(values[1]),
      last = written(values[length(values)]),
      least = ends(1),
      greatest = ends(length(sorted)),
      levels = if (is.factor(values)) paste(levels(values), collapse = "|") else "",
      digest = digest(values),
      ordered = is.ordered(values)
    )
  }
}

write.csv(do.call(rbind, fingerprint), file.path("test", "fixtures", "fingerprint.csv"),
          row.names = FALSE)
