# The R that dev/regenerate.R runs in: Giggly's R image with sf, which reads the map outlines'
# files, with the one package it lacks that a dataset comes from, ggplot2movies (movies). Build it
# once:
#
#   docker build -t gig-datasets-r dev
FROM giggly-r:ggplot2-4.0.3-sf
RUN Rscript -e 'install.packages("ggplot2movies", repos = "https://cloud.r-project.org")' \
 && Rscript -e 'library(ggplot2movies); cat(as.character(packageVersion("ggplot2movies")), "\n")'
