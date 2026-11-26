# Third-party notices

GigDatasets' datasets, in `priv/datasets/`, are copied from R and its packages, but for the map
outlines, which come from public-domain sources. Each is listed with
what was taken, where its data comes from, and the licence it carries; each file's header and each
dataset's documentation name that licence too, and `dev/regenerate.R` says how each file was made.
The GPL's texts are `LICENSES/GPL-2.0.txt` and `LICENSES/GPL-3.0.txt`; MIT's is below.

## ggplot2 4.0.3 — MIT License

`priv/datasets/diamonds.csv`, `economics.csv`, `economics_long.csv`, `faithfuld.csv`,
`luv_colours.csv`, `mpg.csv`, `msleep.csv`, `presidential.csv`, `seals.csv` and `txhousing.csv`
hold the datasets of those names as ggplot2 4.0.3 ships them,
written out by R. Their data comes from: diamonds, the prices of 53,940 diamonds, for which
ggplot2 names no source; economics and economics_long, the Federal Reserve Bank of St. Louis's
FRED database; faithfuld, ggplot2's density estimate of R's `faithful` data on the Old Faithful
geyser; mpg, the US Environmental Protection Agency's fuel economy data (fueleconomy.gov);
msleep, V. M. Savage and G. B. West, "A quantitative, theoretical framework for understanding
mammalian sleep", PNAS 104(3), 2007, with each mammal's order, conservation status and diet added
from Wikipedia; txhousing, the Texas A&M Real Estate Center; luv_colours, R's built-in colours
placed in Luv space; presidential, the terms of 12 US presidents; seals, a vector field of seal
movements from the data of Brillinger, Preisler, Ager and Kie (2004).

```
MIT License

Copyright (c) 2025 ggplot2 core developer team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## R 4.6.1's datasets package — GPL-2.0 or GPL-3.0

`priv/datasets/mtcars.csv` holds R's `mtcars` table as R 4.6.1's datasets package ships it,
written out by R: the fuel consumption and ten aspects of design and performance of 32 cars, from
the road tests of the 1974 Motor Trend US magazine, as published by H. V. Henderson and P. F.
Velleman, "Building multiple regression models interactively", Biometrics 37, 391-411, 1981.
`priv/datasets/faithful.csv` holds R's `faithful` table, the eruption and waiting times of 272
eruptions of the Old Faithful geyser, from W. Härdle, Smoothing Techniques with Implementation in
S, Springer, 1991. `priv/datasets/usarrests.csv` holds R's `USArrests` table, arrests per 100,000
residents in each US state in 1973, from the World Almanac and Book of Facts 1975 and the
Statistical Abstracts of the United States 1975, as D. R. McNeil, Interactive Data Analysis, Wiley,
1977, gives them. R's datasets package is "Part of R", which is licensed GPL-2 or GPL-3. No code or
text of R's is included.

## nlme 3.1.171 — GPL-2.0 or later

`priv/datasets/oxboys.csv` holds nlme's `Oxboys` table, the heights of 26 boys from Oxford,
England, each measured on nine occasions, from H. Goldstein, Multilevel Statistical Models, 1987,
as J. C. Pinheiro and D. M. Bates give it in Mixed-Effects Models in S and S-PLUS, Springer, 2000,
Appendix A.19. nlme is licensed GPL (>= 2). No code or text of nlme's is included.

## rpart 4.1.27 — GPL-2.0 or GPL-3.0

`priv/datasets/kyphosis.csv` holds rpart's `kyphosis` table, 81 children who had corrective spinal
surgery, from J. M. Chambers and T. J. Hastie, Statistical Models in S, Wadsworth and Brooks/Cole,
1992. rpart is licensed GPL-2 or GPL-3. No code or text of rpart's is included.

## ggplot2movies 0.0.1 — GPL-3.0

`priv/datasets/movies.csv` holds ggplot2movies' `movies` table, 58,788 films from the Internet
Movie Database with their lengths, budgets, user ratings and genres. ggplot2movies is licensed
GPL-3. No code or text of ggplot2movies' is included.

## US Census Bureau — public domain

`priv/datasets/state_map.csv` holds the outlines of the lower 48 US states and the District of
Columbia from the Bureau's 2024 cartographic boundary file of states at 1:20,000,000,
`cb_2024_us_state_20m`, a work of the US government and so in the public domain. Its states are
named in lowercase and its rings laid out as ggplot2's `map_data()` lays them.

## Natural Earth 5.1.1 — public domain

`priv/datasets/world_map.csv` holds every country's outline from Natural Earth's 1:110m Admin 0
countries, and `priv/datasets/nz_map.csv` New Zealand's main islands from its 1:50m Admin 0
countries. Natural Earth's map data is in the public domain (naturalearthdata.com). Holes are left
out, a country inside another's outline is put after it, and the rings are laid out as ggplot2's
`map_data()` lays them.
