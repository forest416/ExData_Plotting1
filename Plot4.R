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

# Plot 4

par(mfcol=c(2,2))

##1
plot( (cons.work$dt), cons.work$Global_active_power, type='l', ylab = 'Global Active Power', xlab ='')

##2
plot( cons.work$dt, cons.work$Sub_metering_1, type='n', ylab = 'Energy sub metering', xlab ='')
points( cons.work$dt, cons.work$Sub_metering_1, type='l', col = 'black')
points( cons.work$dt, cons.work$Sub_metering_2, type='l', col = 'red')
points( cons.work$dt, cons.work$Sub_metering_3, type='l', col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty= 1)

##3
plot( (cons.work$dt), cons.work$Voltage, type='l', ylab = 'Voltage', xlab ='datetime')
##4
plot( (cons.work$dt), cons.work$Global_reactive_power, type='l', ylab = 'Global_reactive_power', xlab ='datetime')

dev.copy(png, 'Plot4.png', width = 480, height = 480, units ='px')
dev.off()
