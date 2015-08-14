
download.file('ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.EP.ibtracs_wmo.v03r06.csv
', 'resources/stormsEP.csv')
headerEP <- read.table('rawdata/stormsEP.csv', skip = 1, nrows = 1, header = FALSE, sep = ',')
stormsEP <- read.table('rawdata/stormsEP.csv', skip = 3, header = FALSE, sep = ',')
colnames(stormsEP) <- unlist(headerEP)
stormsEP <- subset(stormsEP, Season >= 1980 & Season <= 2010)

download.file('ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.NA.ibtracs_wmo.v03r06.csv
', 'resources/stormsNA.csv')
headerNA <- read.table('rawdata/stormsNA.csv', skip = 1, nrows = 1, header = FALSE, sep = ',')
stormsNA <- read.table('rawdata/stormsNA.csv', skip = 3, header = FALSE, sep = ',')
colnames(stormsNA) <- unlist(headerNA)
stormsNA <- subset(stormsNA, Season >= 1980 & Season <= 2010)

combined <- full_join(stormsEP, stormsNA)
combined$Longitude[combined$Longitude > 100] <- combined$Longitude[combined$Longitude > 100] - 360

states_map <- map_data('world')
combined$windc <- round(combined$`Wind(WMO)` / 50) * 50

ggplot(combined, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  geom_polygon(data = states_map, fill = '#666666',
               aes(x = long, y = lat, group = group)) +
  geom_path(aes(col = factor(windc))) +
  scale_color_manual(name = 'Wind (knots)',
                     values = c('0' = '#000066', '50' = '#00007f',
                                '100' = '#0000cc', '150' = '#0000ff')) +
  coord_cartesian(xlim = c(-140, -15), ylim = c(5, 60)) +
  ggtitle('All Storm Trajectories (1980-2010)') +
  theme(axis.ticks=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = '#000000'))

combined$date <- as.Date(str_sub(combined$ISO_time, 1, 10))
combined$month <- factor(format(combined$date, '%B'), levels = month.name)
combined$year <- format(combined$date, '%Y')

ggplot(combined, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  facet_wrap(~ month) +
  geom_polygon(data = states_map, fill = '#666666',
               aes(x = long, y = lat, group = group)) +
  geom_path(aes(col = factor(windc))) +
  scale_color_manual(name = 'Wind (knots)',
                     values = c('0' = '#000066', '50' = '#00007f',
                                '100' = '#0000cc', '150' = '#0000ff')) +
  coord_cartesian(xlim = c(-140, -15), ylim = c(5, 60)) +
  ggtitle('Hurricane Trajectories by Month (1980-2010)') +
  theme(axis.ticks=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = '#000000')) 

combined1980s <- subset(combined, year >= 1980 & year <= 1989)

ggplot(combined1980s, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  facet_wrap(~ year) +
  geom_polygon(data = states_map, fill = '#666666',
               aes(x = long, y = lat, group = group)) +
  geom_path(aes(col = factor(windc))) +
  scale_color_manual(name = 'Wind (knots)',
                     values = c('0' = '#000066', '50' = '#00007f',
                                '100' = '#0000cc', '150' = '#0000ff')) +
  coord_cartesian(xlim = c(-140, -15), ylim = c(5, 60)) +
  ggtitle('Hurricane Trajectories by Year (1980-1989)') +
  theme(axis.ticks=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = '#000000'))

combined1990s <- subset(combined, year >= 1990 & year <= 1999)

ggplot(combined1990s, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  facet_wrap(~ year) +
  geom_polygon(data = states_map, fill = '#666666',
               aes(x = long, y = lat, group = group)) +
  geom_path(aes(col = factor(windc))) +
  scale_color_manual(name = 'Wind (knots)',
                     values = c('0' = '#000066', '50' = '#00007f',
                                '100' = '#0000cc', '150' = '#0000ff')) +
  coord_cartesian(xlim = c(-140, -15), ylim = c(5, 60)) +
  ggtitle('Hurricane Trajectories by Year (1990-1999)') +
  theme(axis.ticks=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = '#000000'))

combined2000s <- subset(combined, year >= 2000 & year <= 2010)

ggplot(combined2000s, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  facet_wrap(~ year) +
  geom_polygon(data = states_map, fill = '#666666',
               aes(x = long, y = lat, group = group)) +
  geom_path(aes(col = factor(windc))) +
  scale_color_manual(name = 'Wind (knots)',
                     values = c('0' = '#000066', '50' = '#00007f',
                                '100' = '#0000cc', '150' = '#0000ff')) +
  coord_cartesian(xlim = c(-140, -15), ylim = c(5, 60)) +
  ggtitle('Hurricane Trajectories by Year (2000-2010)') +
  theme(axis.ticks=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = '#000000'))

