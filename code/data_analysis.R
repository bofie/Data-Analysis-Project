library('dplyr')
library('stringr')
storms <- read.table("data/storms.csv")
tracks <- read.table("data/tracks.csv")

tracks_anal <- subset(tracks, format(as.Date(tracks$date, "%m/%d/%Y"), '%Y') >= 1980
                      & format(as.Date(tracks$date, "%m/%d/%Y"), '%Y') <= 2010)
tracks_anal$date <- as.Date(tracks_anal$date, "%m/%d/%Y")
wind_year <- data.frame(year = as.numeric(format(tracks_anal$date, '%Y')),
                        id = tracks_anal$id, wind = tracks_anal$wind)
wind_month <- data.frame(month_id = paste0(as.numeric(format(tracks_anal$date, '%m')), ' ', tracks_anal$id),
                         year = as.numeric(format(tracks_anal$date, '%Y')),
                         wind = tracks_anal$wind)

temp <- aggregate(wind_year[, c('wind', 'year')], list(id = wind_year$id), max)
temp1 <- aggregate(wind_month[, c('wind')], list(id = wind_month$month_id), max)
temp2 <- data.frame(month = month.name[as.numeric(str_extract(temp1$id, '.+\\s'))], wind = temp1$x)
temp2$month = factor(temp2$month, levels = month.name)

table1 <- table(temp$year)
table2 <- table(temp$year[temp$wind >= 35])
table3 <- table(temp$year[temp$wind >= 64])
table4 <- table(temp$year[temp$wind >= 96])

table1
barplot(table1)
table2
barplot(table2)
table3
barplot(table3)
table4
barplot(table4)

table(temp2$month)
barplot(table(temp2$month))
table(temp2$month[temp2$wind >= 35])
barplot(table(temp2$month[temp2$wind >= 35]))
table(temp2$month[temp2$wind >= 64])
barplot(table(temp2$month[temp2$wind >= 64]))
table(temp2$month[temp2$wind >= 96])
barplot(table(temp2$month[temp2$wind >= 96]))

all <- list(as.vector(table2), as.vector(table3),
            as.vector(table4))
stats <- data.frame(round(sapply(all, mean), 1),
                    round(sapply(all, sd), 2), 
                    sapply(all, quantile)['25%',],
                    sapply(all, quantile)['50%',],
                    sapply(all, quantile)['75%',])
rownames(stats) <- c('35 knots', '64 knots', '96 knots')
colnames(stats) <- c('Avg', 'Std Dev', '25th', '50th', '75th')
stats

tracks_anal$press[tracks_anal$press == 0] <- NA
mean_pw <- aggregate(tracks_anal[, c('press', 'wind')], list(id = tracks_anal$id), mean)
mean_pw <- subset(mean_pw, press != 0)
plot(mean_pw$id, mean_pw$press)
abline(lm(mean_pw$press ~ mean_pw$id), lwd = 2, col = "red")
plot(mean_pw$id, mean_pw$wind)
abline(lm(mean_pw$wind ~ mean_pw$id), lwd = 2, col = "red")

median_pw <- aggregate(tracks_anal[, c('press', 'wind')], list(id = tracks_anal$id), median)
median_pw <- subset(median_pw, press != 0)
plot(median_pw$id, median_pw$press)
abline(lm(median_pw$press ~ median_pw$id), lwd = 2, col = "red")
plot(median_pw$id, median_pw$wind)
abline(lm(median_pw$wind ~ median_pw$id), lwd = 2, col = "red")

