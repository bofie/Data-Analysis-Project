download.file("ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/hurdat_format/basin/Basin.NA.ibtracs_hurdat.v03r06.hdat",
              "resources/Basin.NA.ibtracs_hurdat.v03r06.hdat")
data <- read.table("resources/Basin.NA.ibtracs_hurdat.v03r06.hdat",
                   sep = '\t', header = FALSE)
library(stringr)
library(dplyr)

sid <- c()
sdate <- c()
sdays <- c()
sname <- c()
for (num in 1:nrow(data)) {
  row <- as.character(data[num,])
  if (nchar(row) == 85) {
    sid <- c(sid, str_extract(str_extract(row, 'SNBR=.{4}'), '[0-9]+'))
    sdate <- c(sdate, substr(row, 7, 16))
    sdays <- c(sdays, str_extract(str_extract(row, 'M=.{2}'), '[0-9]+'))
    sname <- c(sname, str_extract(substr(row, 36, 48), '[A-Z]+'))
  }
}
storms <- data.frame(id = as.numeric(sid),
                     date = format(as.Date(sdate, '%m/%d/%Y'), '%m/%d/%Y'),
                     days = as.numeric(sdays), name = as.character(sname))
write.table(storms, "data/storms.csv")

stage_convert <- function(symbol) {
  switch (symbol,
          '*' = 'cyclone',
          'S' = 'subtropical',
          'E' = 'extratropical',
          'W' = 'wave',
          'L' = 'remnant low')
}

tid <- c()
tdate <- c()
tperiod <- c()
tstage <- c()
tlat <- c()
tlong <- c()
twind <- c()
tpress <- c()

for (num in 1:nrow(data)) {
  row <- as.character(data[num,])
  if (nchar(row) == 85) {
    id <- str_extract(str_extract(row, 'SNBR=.{4}'), '[0-9]+')
    year <- substr(row, 13, 16)
  }
  if (nchar(row) == 80) {
    tid <- c(tid, rep(id, 4))
    tdate <- c(tdate, rep(paste0(substr(row, 7, 11), '/', year), 4))
    tperiod <- c(tperiod, c('00h', '06h', '12h', '18h'))
    tstage <- c(tstage, c(stage_convert(substr(row, 12, 12)),
                          stage_convert(substr(row, 29, 29)),
                          stage_convert(substr(row, 46, 46)),
                          stage_convert(substr(row, 63, 63)))) 
    tlat <- c(tlat, c(as.numeric(substr(row, 13, 15)) / 10,
                      as.numeric(substr(row, 30, 32)) / 10,
                      as.numeric(substr(row, 47, 49)) / 10,
                      as.numeric(substr(row, 64, 66)) / 10))
    tlong <- c(tlong, c(as.numeric(substr(row, 16, 19)) / 10 - 360,
                        as.numeric(substr(row, 33, 36)) / 10 - 360,
                        as.numeric(substr(row, 50, 53)) / 10 - 360,
                        as.numeric(substr(row, 67, 70)) / 10 - 360))
    twind <- c(twind, c(as.numeric(substr(row, 20, 23)),
                        as.numeric(substr(row, 37, 40)),
                        as.numeric(substr(row, 54, 57)),
                        as.numeric(substr(row, 71, 74))))
    tpress <- c(tpress, c(as.numeric(substr(row, 25, 28)),
                          as.numeric(substr(row, 42, 45)),
                          as.numeric(substr(row, 59, 62)),
                          as.numeric(substr(row, 76, 79))))
  }
}

tracks <- data.frame(id = as.numeric(tid),
                     date = format(as.Date(tdate, '%m/%d/%Y'), '%m/%d/%Y'),
                     period = as.character(tperiod),
                     stage = as.character(tstage),
                     lat = tlat, long = tlong, wind = twind, press = tpress)
tracks <- filter(tracks, !(lat == 0 & long == -360 & wind == 0 & press == 0))
row.names(tracks) <- 1:nrow(tracks)

write.table(tracks, 'data/tracks.csv')

