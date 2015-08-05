## assume that the source data file is in the current diretory.
##

#cons = read.table('household_power_consumption.txt', colClasses = 'character', nrows=1000, sep=';', header = T)
cons = read.table('household_power_consumption.txt', colClasses = c('character','character',rep('character',7)), sep=';', header = T)

cons$d = as.Date((cons$Date), '%d/%m/%Y' )
d.filter = as.Date(c('2007-02-01','2007-02-02'))

cons.work = (cons[cons$d %in% d.filter,])

#cons.work$Time = strptime(cons.work$Time, format = '%T',tz='')
cons.work$dt = strptime(paste(cons.work$Date, cons.work$Time) ,'%d/%m/%Y %T')
cons.work$Date = NULL
cons.work$Time = NULL
cons.work$d = NULL

cons.work$Global_active_power = as.numeric(cons.work$Global_active_power)
cons.work$Global_reactive_power = as.numeric(cons.work$Global_reactive_power)
cons.work$Voltage = as.numeric(cons.work$Voltage)
cons.work$Global_intensity = as.numeric(cons.work$Global_intensity)
cons.work$Sub_metering_1 = as.numeric(cons.work$Sub_metering_1)
cons.work$Sub_metering_2 = as.numeric(cons.work$Sub_metering_2)
cons.work$Sub_metering_3 = as.numeric(cons.work$Sub_metering_3)

par(mfrow=c(1,1))
par(mfcol=c(1,1))

#Plot 2

png(filename = 'Plot2.png', width = 480, height = 480, units = 'px')
plot( (cons.work$dt), cons.work$Global_active_power, type='l', ylab = 'Global Active Power', xlab ='')
dev.off()

