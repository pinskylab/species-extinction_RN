#################################################Getting Started
#just getting started, need to make sure to load things correctly!



#setting the working directory. This is saved on a shared DropBox and accessed via my computer. If used on a different computer will need to reset the working directory to where the file is accessible from there or find some other way to access it.

setwd('C:/Users/missr_000/Dropbox/Extinction Database/Analysis')

#check the directory to make sure the file you want is in there, looking for "RAM_IUCN_DATA" or an updated version of that data if available.
dir()

#read in the data file and specify the header to read at the first row you need, in the version of the datafile I used the column names start at row 1, so header=T. It was originally at row 4 because of some other rows that were included, but we won't need them for this and I went back and deleted them.
datafile<-read.csv(file="RAM_IUCN_DATA.csv", header=T)

#get a look at how R is reading the data, make sure it's organized how you want
str(datafile)
# also type into the console or click on the new data item to open it in a view tab: view(datafile) to look at the data table s R read it


#################################################Practice, might not be used
#trying to work with the data, but not really working on graphs or analysis


#we want to get a subset of the species that are considered under threat, just for reference and to play around with later.
###can we do this? I was trying to use something like                 threatened<-subset(x=datafile, subset=IUCN_codified== c('4','5','6')) but kept getting errors

#!! I figured it out, I need an %in%. I tried just putting it as so: IUCN_codified== %in% C(...)
  #it didn't work, might need to remove the "==" or could maybe try replacing the "==" 
  #the directions I found online removed the x= and subset= but I want to keep that for future reference and to know exactly what I did.
threatened=subset(x=datafile, subset=IUCN_codified %in% c('4','5','6'))
  
 

#find average codified threat level. Might be an indicator of about how threatened the whole set of stocks is
mean(datafile$IUCN_codified)

#na.rm=T means that NA values are not included in any math (if they were, the result would always read NA which it not useful)
mean(datafile$MSYbest, na.rm=T) #for example, try with F instead of T



#################################################Plotting
#let's start trying to plot stuff, see what represents the data well!

#what to plot?
#histogram: final_value=x and anything else that looks interesting/useful

#going to try this and see if that might be good
hist(datafile$IUCN_codified)

####This works fine!
plot(datafile$IUCN_codified)

###This also works, but before I was getting the "+" error? (that's because you need to hit "esc" to get out of the "+" error, it'll show up as an error until you escape even if the thing you just ran actually works)
plot(datafile$final_value)

#managing countries and IUCN status (plots as a cool but weird bar graph?), needs some work to be easily interpreted and understood...
plot(x=datafile$countries, y=datafile$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")

#country and MSY?
plot(x=datafile$countries, y=datafile$MSYbest, xlab="Management Country", ylab="Maximum Sustainable Yield (tons)", main="MSY by Country Manager")

#country and cost/value?
plot(x=datafile$countries, y=datafile$cost_value)

#IUCN status, MSY?
plot(datafile$IUCN_status, y=datafile$MSYbest, xlab="IUCN Status", ylab="MSY (tons)", main="MSY and IUCN Status")

#This also works!
plot(x=datafile$final_value, y=datafile$IUCN_codified)

#plot the reverse of the variables above?
plot(x=datafile$IUCN_codified, y=datafile$final_value)

#idk why this plots as a boxplot? But it's exactly what I want!
plot(x=datafile$IUCN_status, y=datafile$final_value, xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Socioeconomic Value", col=4)

#reverse aves of the above plot (doesn't naturally present as boxplot this way though?) making it a boxplot ends up with NOT what I want...
      #boxplot(x=datafile$final_value, y=datafile$IUCN_status, xlab="((cost+subsidy)/value) * ln(MSY)", ylab="IUCN Status", main="IUCN Status and Socioeconomic Value", col=4)

###make that as a boxplot to show distribution
#boxplot(x=datafile$IUCN_codified, y=datafile$final_value)
###that actually didn't work how I thought it would... Might need to make subsets for each IUCN codes, run for loop?
vulnerable<-subset(x=datafile, subset=IUCN_codified=="4", select=final_value)
endangered<-subset(x=datafile, subset=IUCN_codified=="5", select=final_value)
critical<-subset(x=datafile, subset=IUCN_codified=="6", select=final_value)
#create list of unique stockids
stock=unique(datafile$stockid)
#is a list right, or should I make a vector with the objects I created?

boxplot(x=critical, y=datafile$final_value, ylim=c(0,25))
boxplot(x=endangered, y=datafile$final_value, ylim=c(0,25))
boxplot(x=vulnerable, y=datafile$final_value, ylim=c(0,25))



###Histogram trial and error
#hist(datafile$IUCN_status, breaks=seq(from=0, to=100, by=5), main='column data', xlab='unit(unit)', ylim=c(0,25), col='lightcyan')
#errors solved:   unexpected numeric constant was not having by=5 (I put "by 5")
#unexpected input suggests I', missing some punctuation
#hist(datafile$IUCN_codified, breaks=seq(from=0, to=100, by=5), main='column data', xlab='unit(unit)',ylim=c(0,25), col='lightcyan')

#I got this to work, I guess you have to hit "esc" to get out of being stuck getting the "+" error?
#came up with following errors:
#missing xlim and ylim
#missing titles/axis lables
#should remove the na.rm (I had it at the end in case that was throwing things off, I guess it wasn't needed so I removed it)
hist(datafile$final_value)

#improving the histogram:
    #breaks=5
hist(datafile$final_value,breaks=5, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=5")

    #breaks=10
hist(datafile$final_value,breaks=10, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=10")
 
    #breaks=20
hist(datafile$final_value,breaks=20, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=20")

##I tried breaks at 12,13,15,16,17,25, and 30 but those showed up as either 10 breaks or 20 (12-16 showed up at 10, 17-30 showed up as 20)


#trying things out with density
hist(datafile$final_value, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="density plot")

###
#hist(x=datafile$final_value, prob=T)
#lines(x=datafile$final_value, density(datafile$final_value))
      #ran into error:"Error in density.default
      #(datafile$final_value) : 
      #'x' contains missing values"
#lines(density(datafile$final_value, adjust=2), lty="dotted")

#this is my adaptation of code from https://stackoverflow.com/questions/20078107/overlay-normal-curve-to-histogram-in-r which kind of worked?It put a line over my histogram but IDK if it really works at all... It produces a different looking line with different histogram breaks
  #curve(dnorm(x, mean=datafile$final_value, sd=datafile$final_value), col="black", lwd=2, add=TRUE, yaxt="n")

#adapted from https://www.r-bloggers.com/histogram-density-plot-combo-in-r/:
hist(datafile$final_value,breaks=20, col=4, prob=T,  xlab= "((cost+subsidy)/value)*ln(MSY)", main="Density, Breaks=20", xlim=c(0,30))
lines(density(datafile$final_value, na.rm=T),lwd=2, col="black")
    #error: 'x' contains missing values? (fixed by adding na.rm=T)
