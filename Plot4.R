
## set date.pattern for filtering 
date.pattern <- '[12]/2/2007'

# check whether file has been downloaded, no need to redo download

if (!file.exists('household_power_consumption.zip')) {
     download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                   'household_power_consumption.zip')   
}

# check whether file has been unzipped, no need to redo
if (!file.exists('household_power_consumption.txt')) {
        unzip('household_power_consumption.zip')
}

print('txt file is read. Load file content to memory ...')

date.pattern <- '[12]/2/2007'



lines<- readLines(('household_power_consumption.txt'))

print('Read txt file completed, Prepare data frame ...')

## extract header

line.header<-head(lines,1)
line.names<- unlist(strsplit(line.header, split=';'))

## handle data

lines.filter<-lines[grep('^[12]/2/2007',lines)]
lines.list<- strsplit(lines.filter,';')
# convert to dataFrame
dat<-as.data.frame(do.call(rbind, lines.list),  stringsAsFactors=F)
# assign name
colnames(dat) <- line.names

#handle datetime

dat$DT <- strptime( paste(dat[,1], dat[,2]), format="%d/%m/%Y %H:%M:%S")

dat[,1]=NULL
dat[,1]=NULL

# re-format measures
for(x in 1:7) { dat[,x] <- as.numeric(dat[,x])}

# data prepartion completed.

print ('data prepartion completed.  Generation graphs ...')



#4.1
 png(filename='plot4.png', width=480, height=480, units='px')
par(mfcol=c(2,2))
par(mar=c(5,4,3,2))
plot(dat$DT,  dat$Global_active_power, type='l', ylab= 'Global Active Power (kilowatts)', xlab='')

#4.2
plot(dat$DT,  dat$Sub_metering_1, type='l', 
     ylab= 'Energy sub metering', xlab=''); 
lines(dat$DT, dat$Sub_metering_1);
lines(dat$DT, dat$Sub_metering_2, col='red');
lines(dat$DT, dat$Sub_metering_3, col = 'blue');
legend('topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'), 
       col=c('black','red','blue'),
       lty=1, 
       bty='n')  # legend no border
#4.3
plot(dat$DT, dat$Voltage, type='l', ylab='Voltage', xlab='datetime')
#4.4
plot(dat$DT, dat$Global_reactive_power, type='l', ylab='Gloabal_reactive_power', xlab='datetime', ylim=c(0,0.5))
dev.off()

print('All done !')
 