system('mkdir code')
system('mkdir rawdata')
system('mkdir data')
system('mkdir resources')
system('mkdir report')
system('mkdir images')
system('touch README.md')
download.file("ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/hurdat_format/basin/Basin.NA.ibtracs_hurdat.v03r06.hdat",
              "resources/Basin.NA.ibtracs_hurdat.v03r06.hdat")
download.file('ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.EP.ibtracs_wmo.v03r06.csv',
              'resources/stormsEP.csv')
download.file('ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.NA.ibtracs_wmo.v03r06.csv',
              'resources/stormsNA.csv')
