####################################################################################Getting Started
#just getting started, need to make sure to load things correctly!



#setting the working directory. This is saved on a shared DropBox and accessed via my computer. If used on a different computer will need to reset the working directory to where the file is accessible from there or find some other way to access it.

setwd('C:/Users/missr_000/Dropbox/Extinction Database/Analysis')

#check the directory to make sure the file you want is in there, looking for "RAM_IUCN_DATA" or an updated version of that data if available.
dir()

#read in the data file and specify the header to read at the first row you need, in the version of the datafile I used the column names start at row 1, so header=T. It was originally at row 4 because of some other rows that were included, but we won't need them for this and I went back and deleted them.
datafile<-read.csv(file="RAM_IUCN_DATA.csv", header=T)

#this data file contains the entire list of species/stocks from the RAM database... if possible...

#get a look at how R is reading the data, make sure it's organized how you want
str(datafile)
# also type into the console or click on the new data item to open it in a view tab: view(datafile) to look at the data tables R read it





#################################################Useful Plots and objects
#these are copied from lower in the file and arranged so they're all together

###Not plots, but necessary for plots:
#this makes a subset  of all columns just for IUCN 4,5 and 6
threatened=subset(x=datafile, subset=IUCN_codified %in% c('4','5','6'))

#these are important for box plots
deficient <-subset(x=datafile, subset=IUCN_codified=="1", select=final_value)
least <-subset(x=datafile, subset=IUCN_codified=="2", select=final_value)
near<-subset(x=datafile, subset=IUCN_codified=="3", select=final_value)
vulnerable<-subset(x=datafile, subset=IUCN_codified=="4", select=final_value)
endangered<-subset(x=datafile, subset=IUCN_codified=="5", select=final_value)
critical<-subset(x=datafile, subset=IUCN_codified=="6", select=final_value)

###Plots:

#factor vs factor plot/spineplot:

    #title: spineplot_country_IUCNstatus
#trying out what I found online (source help:https://www.statmethods.net/advgraphs/layout.html   and http://www.sthda.com/english/wiki/add-legends-to-plots-in-r-software-the-easiest-way   and https://stat.ethz.ch/R-manual/R-patched/library/graphics/html/spineplot.html   and https://www.rdocumentation.org/packages/graphics/versions/3.6.0/topics/spineplot  )
par(mfrow=c(1,2)) #set to c(1,2) for this plot
spineplot(x=datafile$countries, y=datafile$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of Status by Country", col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"), ylevels=c("CR", "EN", "VU","NT", "LC", "DD"))
plot.new()
legend(x="left", cex=0.7, title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Least Concern (LC)", "Data Deficient (DD)"), col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"), pch=15)


#Scatterplots:

#what is the "index"(the x axis)?
    #title: scatterplot_xIndex_finalvalue
plot(datafile$final_value, xlab="", ylab="((cost+subsidy)/value) * ln(MSY)", main="Bioeconomic Factor", col="darkcyan")
    #title: scatterplot_xIndex_lnMSY
plot(datafile$lnMSY, xlab="", ylab="ln(MSY)", main="ln(MSY)")
    #title: scatterplot_xIndex_costvalue
plot(datafile$cost_value, xlab="", ylab="(cost+subsidy)/value", main="Cost Over Price", col="darkcyan")

#this shows scatterplot of codified status and ln(MSY)
    #title: scatterplot_IUCNcodified_lnMSY
plot(x=datafile$IUCN_codified, y=datafile$lnMSY, xlab="IUCN Status Code", ylab="ln(MSY)", main="IUCN Status Code and ln(MSY)", col="darkcyan")
#this shows a scatterplot of IUCN code and final_value.
    #Title: scatterplot_IUCNcodified_finalvalue
plot(x=datafile$IUCN_codified, y=datafile$final_value, xlab="IUCN Status Code", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status Code and Bioeconomic Factor", col="darkcyan")


#boxplots:

#this shows a boxplot of country and ln(MSY)
    #Title: boxplot_country_lnMSY
plot(x=datafile$countries, y=datafile$lnMSY, xlab="Management Country", ylab="ln(MSY)", main="ln(MSY) by Country Manager", col="darkcyan")
#this shows country and cost/price. Maybe not the most useful because of the range issues
    #Title: boxplot_country_costvalue
plot(x=datafile$countries, y=datafile$cost_value, xlab="Managing Country", ylab="(cost+subsidy)/value)", main="Cost/Price by Country", col="darkcyan")

#this works,  just need to rename the Y labels!(help from :https://stackoverflow.com/questions/9975789/multiple-boxplots-in-one-in-r  and https://www.datamentor.io/r-programming/box-plot/) and fix colors (see list I made)
    #Title: boxplot_IUCNstatus_finalvalue
boxplot(x=c(critical, endangered, vulnerable, near, least, deficient), y=datafile$final_value, at=c(1,2,3,4,5,6),names=c("Critical", "Endangered", "Vulnerable", "Near Treatened", "Least Concern", "Data Deficient"), xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Bioeconomic Factor",col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"))

#this shows IUCN status and ln(MSY). Need to reorder status for threat level and color, see above
    #Title: boxplot_IUCNstatus_lnMSY
plot(datafile$IUCN_status, y=datafile$lnMSY, xlab="IUCN Status", ylab="ln(MSY)", main="IUCN Status andln(MSY)", col="darkcyan")

#Need to reorder status and fix colors like above
    #Title: boxplot_IUCNstatus_finalvalue
plot(x=datafile$IUCN_status, y=datafile$final_value, xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Bioeconomic Factor", col="blue")



#Histograms:

#this is the base for the final_value histogram. Can manipulate breaks and other factors from there.The density curve isn't needed, but it adds another visual representation.
    #histogram_
hist(datafile$final_value,breaks=20, col=4, prob=T, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Density, Breaks=20", xlim=c(0,50))
lines(density(datafile$final_value, na.rm=T),lwd=2, col="black")

#Histograms to make, try different breaks:
#make CR,EN,VU,NT, LC (NO DD)
hist(c(critical, endangered, vulnerable, near, least),breaks=20, col=4, prob=T, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Density, Breaks=20", xlim=c(0,50))
hist(vulnerable)
    #error: x must be numeric (I think I need to make the subsets without the selection of final_value and then do status$final_value in the histogram function)
#MAKE CR,EN,VU,NT
#MAKE CR,EN
#make VU and EN?
#MAKE CR,EN,VU
hist(threatened$final_value, na.rm=T, freq=F, breaks=20, xlim=c(5,35))
lines(density(datafile$final_value, na.rm=T),lwd=2, col="black")


#################################################Practice, might not be used
#trying to work with the data, but not really working on graphs or analysis


#we want to get a subset of the species that are considered under threat, just for reference and to play around with later.
###can we do this? I was trying to use something like                 
#threatened<-subset(x=datafile, subset=IUCN_codified== c('4','5','6')) but kept getting errors

#!! I figured it out, I need an %in%. I tried just putting it as so: IUCN_codified== %in% C(...)
  #it didn't work, might need to remove the "==" or could maybe try replacing the "==" 
  #the directions I found online removed the x= and subset= but I want to keep that for future reference and to know exactly what I did.
threatened=subset(x=datafile, subset=IUCN_codified %in% c('4','5','6'))
  
##This isn't working but I need a way to get only the final_value values and not all columns
#threatened_final=subset(x=datafile, subset==IUCN_status %in% c("CR", "EN","VU"), select=final_value)

#find average codified threat level. Might be an indicator of about how threatened the whole set of stocks is
mean(datafile$IUCN_codified)

#na.rm=T means that NA values are not included in any math (if they were, the result would always read NA which it not useful)
mean(datafile$lnMSY, na.rm=T) #for example, try with F instead of T



#################################################Plotting
#let's start trying to plot stuff, see what represents the data well!

#This is a dump of all the plots I made, but I have a section above listing all the plots I founde useful or important. I'm cutting out a lot of the spaces between lines to cut down on space.


#going to try this and see if that might be good
hist(datafile$IUCN_codified)
####This works fine!
plot(datafile$IUCN_codified)
###This also works, but before I was getting the "+" error? (that's because you need to hit "esc" to get out of the "+" error, it'll show up as an error until you escape even if the thing you just ran actually works)
plot(datafile$final_value)
#managing countries and IUCN status (plots as a cool but weird bar graph?), needs some work to be easily interpreted and understood...
    #I need to find a way to add a legend for color coding and better configure status to show increasing, not alphabetical order
plot(x=datafile$countries, y=datafile$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")
#factor vs factor plot/spineplot:

#I need to find a way to add a legend for color coding and better configure status to show increasing, not alphabetical order
plot(x=datafile$countries, y=datafile$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")
#legend(x=5, y=2, legend=c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Lease Concern (LC)", "Data Deficient (DD)"))
#so far that legend isn't working, I'll need to figure something else out. the plot also goes blank if I try to change the color or the color is uniform and doesn't change by status
#This didn't work either, x and y not same length:    plot(x=datafile$countries, y=c(critical, endangered, vulnerable, near, least, deficient), xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")
#trying out what I found online:
par(mfrow=c(1,2))
spineplot(x=datafile$countries, y=datafile$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of Status by Country", col=c("turquoise4", "turquoise3", "turquoise2", "turquoise1", "turquoise", "paleturquoise"), ylevels=c("CR", "EN", "VU","NT", "LC", "DD"))
plot.new()
legend(x="left", cex=0.7, title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Least Concern (LC)", "Data Deficient (DD)"), col=c("turquoise4", "turquoise3", "turquoise2", "turquoise1", "turquoise", "paleturquoise"), pch=15)
#country and MSY?
plot(x=datafile$countries, y=datafile$lnMSY, xlab="Management Country", ylab="ln(MSY)", main="ln(MSY) by Country Manager")
#country and cost/value?
plot(x=datafile$countries, y=datafile$cost_value, xlab="Managing Country", ylab="Cost/Price", main="Cost/Price by Country")
#IUCN status, MSY?
plot(datafile$IUCN_status, y=datafile$lnMSY, xlab="IUCN Status", ylab="ln(MSY)", main="ln(MSY) and IUCN Status")
#This also works!
plot(x=datafile$final_value, y=datafile$IUCN_codified)
#plot the reverse of the variables above?
plot(x=datafile$IUCN_codified, y=datafile$final_value, xlab="IUCN Status Code", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status Code and Bioeconomic Factor")
#idk why this plots as a boxplot? But it's exactly what I want!
plot(x=datafile$IUCN_status, y=datafile$final_value, xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Bioeconomic Factor", col=4)
#reverse axes of the above plot (doesn't naturally present as boxplot this way though?) making it a boxplot ends up with NOT what I want...
      #boxplot(x=datafile$final_value, y=datafile$IUCN_status, xlab="((cost+subsidy)/value) * ln(MSY)", ylab="IUCN Status", main="IUCN Status and Socioeconomic Value", col=4)
###make that as a boxplot to show distribution
#boxplot(x=datafile$IUCN_codified, y=datafile$final_value)
###that actually didn't work how I thought it would... Might need to make subsets for each IUCN codes, run for loop?

deficient <-subset(x=datafile, subset=IUCN_codified=="1", select=final_value)
least <-subset(x=datafile, subset=IUCN_codified=="2", select=final_value)
near<-subset(x=datafile, subset=IUCN_codified=="3", select=final_value)
vulnerable<-subset(x=datafile, subset=IUCN_codified=="4", select=final_value)
endangered<-subset(x=datafile, subset=IUCN_codified=="5", select=final_value)
critical<-subset(x=datafile, subset=IUCN_codified=="6", select=final_value)


#create list of unique stockids
stock=unique(datafile$stockid)



##
#is a list right, or should I make a vector with the objects I created?
boxplot(x=critical, y=datafile$final_value, ylim=c(0,35))
boxplot(x=endangered, y=datafile$final_value, ylim=c(0,35))
boxplot(x=vulnerable, y=datafile$final_value, ylim=c(0,35))
boxplot(x=threatened, y=datafile$final_value, ylim=c(0,35))
##
#this works,  just need to rename the Y labels!(help from :https://stackoverflow.com/questions/9975789/multiple-boxplots-in-one-in-r  and https://www.datamentor.io/r-programming/box-plot/)
boxplot(x=c(critical, endangered, vulnerable, near, least, deficient), y=datafile$final_value, at=c(1,2,3,4,5,6),names=c("Critical", "Endangered", "Vulnerable", "Near Treatened", "Least Concern", "Data Deficient"), xlab="IUCN Status", ylab="Bioeconomic Factor", main="IUCN Status and Bioeconomic Factor", col=c("red", "orange", "yellow", "green", "blue", "purple"))

##
boxplot(x=critical, y=datafile$final_value, col="red", horizontal=T, ylim=c(0, 40))
boxplot(x=endangered, y=datafile$final_value, col="orange", add=T, horizontal = T)
boxplot(x=vulnerable, y=datafile$final_value, col="yellow", add=T, horizontal = T)
##
##
boxplot(critical, endangered, vulnerable,
        main="IUCN Status and Bioeconomic Factor",
        las=2,
        col=c("red", "orange", "yellow")
        )
#at=c(1,2,3),
#names=c("Critical", "Endangered", "Vulnerable"),
##



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


#trying things out with density (desity is when freq=F, and frequency is when freq=T)
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



