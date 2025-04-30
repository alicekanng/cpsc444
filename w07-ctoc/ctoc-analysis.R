library(ez)
library(ggplot2)

participantData <- read.csv(file="allParticipants.csv", header=T, sep=",")

#filter out incorrect trials
correct.data <- participantData[participantData$correct==TRUE, ]

#using the correct.data frame, compute the mean time for each experimental   
#image size (width). Store this in a new data frame called meantime.size.
meantime.size <- aggregate(time ~ width, correct.data, mean)

#plot our the mean time for each image width
print(qplot(width, time, data=meantime.size, geom=c("line","point"),ylim=c(0,1300)))

#using the correct.data frame, compute the mean time across the trials for 
#each image size (width) for EACH participant. Store this in a new data frame 
meantimeByPID.size <- aggregate(time ~ pid + width, correct.data, mean)

#Calculate the paired T-test. Confidence level is default of 0.05. 
t.test(meantimeByPID.size$time[meantimeByPID.size$width == 100],
       meantimeByPID.size$time[meantimeByPID.size$width == 250],
       paired=TRUE)

#make sure R recognizes our image sizes as factors
correct.data$width <- ordered(correct.data$width)

#Calculate a two-factor ANOVA. Your confidence level is the default 0.05.    
anovaResult <- ezANOVA(
  data = correct.data, 
  dv = time, 
  wid = pid, # participant id column
  between = device,
  within = width
)
print(anovaResult)

#using the correct.data frame, compute the mean time across the trials for 
#each image size (width) for each input device type (device) and store it.
meantime.devicebywidth <- aggregate(time ~ device+width, correct.data, mean)

#plot a graph to more easily compare by device
print(ggplot(data=meantime.devicebywidth, aes(x=device, y=time, colour=width))+
  geom_point() + # Use points
  geom_line(aes(group=width)) + # use lines to connect width means
  expand_limits(y = c(500,1200)))

print(#plot our interactions to more easily compare image sizes
  ggplot(data=meantime.devicebywidth, aes(x=width, y=time, colour=device))+
    geom_point() + # Use points
    geom_line(aes(group=device)) + # use lines to connect width means
    expand_limits(y = c(800,1200)))