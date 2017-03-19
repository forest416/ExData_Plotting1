
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


#Plot 1
png(filename='plot1.png', width=480, height=480, units='px')
 hist(dat$Global_active_power, col = 'red', xlab='Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()


print('All done !')
 