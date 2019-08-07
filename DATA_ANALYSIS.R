###################GETTING STARTED

#SET WORKING DIRECTORY
#This is saved on a shared DropBox and accessed via my computer. If used on a different computer will need to reset the working directory.
setwd('C:/Users/missr_000/Dropbox/Extinction Database/Analysis')

#CHECK DIRECTORY FOR FILES
dir()

#READ IN FILES


  #USED FOR POSTER
#Contains IUCN listing, MSY, country, cost, etc. for 92 stocks
RAMIUCN<-read.csv(file="RAM_IUCN_DATA.csv", header=T)

#(used for the poster) used to make histogram ratio plots, the number in threatened divided by either FULL or IUCN used (breaks starting from 5-10)
histratio5<-read.csv(file="histogram_frequencies_at5.csv", header=T)

#used for poster
weightrisk5<-read.csv(file="histogram_weighted_risk_5.csv", header=T)



  #NOT USED FOR POSTER BUT NECESSARY FOR OTHER PLOTS IF WANT DIFFERENT BREAKS
#(not used for poster, but provides different visuals) used to make histogram ratio plots, the number in threatened divided by either FULL or IUCN used (breaks starting from 6-11)
histratio6<-read.csv(file="histogram_frequencies_at6.csv", header=T)

#contains weighted risk from threatened histogram bins (taken from the ratioplots, break at 6-11, not used)
weightrisk6<-read.csv(file= "histogram_weighted_risk_6.csv", header=T)
 
#Made for threatened only plot (not used)
stackedstatus <-read.csv(file="histogram_IUCNstatus_for-stacked-barplot.csv", header=T)


###SUBSETS:
#this makes a subset  of all columns just for IUCN 4,5 and 6
threatened=subset(x=RAMIUCN, subset=IUCN_codified %in% c('4','5','6'))

#default par margins
#par(mar=c(5.1, 4.1, 4.1, 2.1))



###################USED HISTOGRAMS

    #title: IUCNhistogram_finalvalue_5
hist(RAMIUCN$final_value,breaks=c(5,10,15,20,25,30,35,40,45), col="royalblue4", freq=T, xlab= "productivity/value", main="", xlim=c(0,50), cex.axis=3, cex.lab=3)
IUCNhistinfo<-hist(RAMIUCN$final_value,breaks=c(5,10,15,20,25,30,35,40,45))

    #title: IUCNhistogram_threatenedfinalvalue_5
hist(threatened$final_value, main="", na.rm=T, freq=T, breaks=c(5,10,15,20,25,30,35,40,45), col="royalblue4", xlim=c(0, 45),cex.axis=1.5, cex.lab=1.5, xlab="productivity/value")
threathistinfo<-hist(threatened$final_value, breaks=c(5,10,15,20,25,30,35,40,45))


###################USED RATIO BARPLOTS

par(mar=c(15, 10, 4, 2))
    #title: angled_fixed_barplot_THREATdivIUCN_5
barplot(histratio5$THREATdivIUCN, xlab="", ylab="", col="royalblue4", cex.axis=3, cex.names=3,cex.lab=3)
text(seq(.15, 10, by=1.5), -0.015, srt = 35, labels = c("5-10", "10-15", "15-20", "20-25", "35-30", "35-40", "40-45"), xpd = TRUE, cex=3) 
text(5, -.04, labels="productivity/value", xpd=T, cex=3)
#tried to set up the y axis label so it wasn't so close to the y axis numbers, but couldn' figure it out in time
#text(seq(.000001, .15), labels="Fraction of IUCN Listed Commercial Species Threatened", srt=90, cex=3, xpd=T)
# I'm not sure if this really makes sense here, and i makesthe plot look too busy. I'll add them in powerpoint, less hectic with here
#   text(seq(.5, 10, by=1.4), c(.05, .35, .2, .27, .25, .26, .05,.05), labels = c("n=0/30", "n=13/30", "n=5/30", "n=4/30", "n=2/30", "n=2/30", "n=0/30", "n=0/30"), cex = 1)

    #title: angled_fixed_barplot_THREATdivFULL_5
barplot(histratio5$THREATdivFULL, xlab="", ylab="", col="royalblue4", cex.axis=3, cex.names=3,cex.lab=3)
text(seq(.15, 10, by=1.5), -0.009, srt = 35, labels = c("5-10", "10-15", "15-20", "20-25", "35-30", "35-40", "40-45"), xpd = TRUE, cex=3) 
text(5, -.02, labels="productivity/value", xpd=T, cex=3)


###################USED WEIGHTED BARPLOTS

    #title: angled_fixed_barplot_weightedriskFULL_5 (exact same as the other one, I'll use ths one)
barplot(weightrisk5$FULLrisk, xlab="", ylab="", col="royalblue4", cex.axis=3, cex.names=3,cex.lab=3)
text(seq(.15, 10, by=1.5), -0.0003, srt = 35, labels = c("5-10", "10-15", "15-20", "20-25", "35-30", "35-40", "40-45"), xpd = TRUE, cex=3) 
text(5, -.0007, labels="productivity/value", xpd=T, cex=3)

    #title: barplot_weightedriskIUCN_5 
barplot(weightrisk5$IUCNrisk, names.arg=c("5-10", "10-15","15-20", "20-25", "25-30", "30-35", "35-40", "40-45" ), xlab="productivity/value", ylab="Weighted Fraction of Commercial Species Threatened", col="royalblue4", cex.axis=1.55, cex.names=1.55,cex.lab=1.55)












###################OTHER UNUSED BUT MAYBE INTERESTING PLOTS
#I'm cutting out a lot of spacing between plots in order to keep it all condensed and easier to scroll through. If it has a title, it was considered useful but didn't make the cut for the final poster. Might be worth exploring more? If it doesn't have a title it's probably just from very early plotting and I didn't progress very much with that idea. 

#HISTOGRAMS

#adapted from https://www.r-bloggers.com/histogram-density-plot-combo-in-r/:
hist(RAMIUCN$final_value,breaks=20, col=4, prob=T,  xlab= "((cost+subsidy)/value)*ln(MSY)", main="Density, Breaks=20", xlim=c(0,30))
lines(density(RAMIUCN$final_value, na.rm=T),lwd=2, col="black")
#trying things out with density (desity is when freq=F, and frequency is when freq=T)
hist(RAMIUCN$final_value, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="density plot")
#improving the histogram:
    #breaks=5
hist(RAMIUCN$final_value,breaks=5, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=5")
    #breaks=10
hist(RAMIUCN$final_value,breaks=10, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=10")
    #breaks=20
hist(RAMIUCN$final_value,breaks=20, freq=F, col=4, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Breaks=20")
    #title: IUCNhistogram_finalvalue_6
hist(RAMIUCN$final_value,breaks=c(6,11,16,21,26,31,36,41,46), col="royalblue4", freq=T, xlab= "((cost+subsidy)/value)*ln(MSY)", main="", xlim=c(0,50), cex.axis=2, cex.lab=2)
IUCNhistinfo<-hist(RAMIUCN$final_value,breaks=c(6,11,16,21,26,31,36,41,46))
    #lines(density(RAMIUCN$final_value, na.rm=T),lwd=2, col="black")
#title: IUCNhistogram_threatenedfinalvalue_6
hist(threatened$final_value, main="", na.rm=T, freq=T, breaks=c(6,11,16,21,26,31,36,41,46), col="royalblue4", xlim=c(0, 45),cex.axis=1.5, cex.lab=1.5, xlab="productivity/value")
threathistinfo<-hist(threatened$final_value, breaks=c(6,11,16,21,26,31,36,41,46))
    #lines(density(RAMIUCN$final_value, na.rm=T),lwd=2, col="black")
#going to try this and see if that might be good
hist(RAMIUCN$IUCN_codified)



#BARPLOTS

#Weighted Ratio Barplots:
#title: barplot_weightedriskIUCN_6
barplot(weightrisk$IUCNrisk, names.arg=c("6", "11","16", "21", "26", "31", "35", "41"), xlab="productivity/value", ylab="Weighted Fraction of IUCN Commercial Species Threatened", col="royalblue4", cex.axis=1.55, cex.names=1.55,cex.lab=1.55)
#title: barplot_weightedriskFULL_6
barplot(weightrisk$FULLrisk, names.arg=c("6", "11","16", "21", "26", "31", "36", "41"), xlab="productivity/value", ylab="Weighted Fraction of Commercial Species Threatened", col="royalblue4", cex.axis=1.55, cex.names=1.55,cex.lab=1.55)
    #title: barplot_HistogramFrequency_IUCNdivTHREAT_5
#fix the names.arg, make them the bin ranges and add NA text later
barplot(histratio5$IUCNdivTHREAT, names.arg=c("5", "10","15", "20", "25", "30", "35", "40" ), xlab="Histogram Bin", ylab="Ratio of Histogram Frequency", col="darkcyan", cex.axis=1.5, cex.names=1,cex.lab=2)
    #title: barplot_HistogramFrequency_FULLdivTHREAT_5
barplot(histratio5$FULLdivTHREAT, names.arg=c("5", "10","15", "20", "25", "30", "35", "40"), xlab="Histogram Bin", ylab="Ratio of Histogram Frequency", col="darkcyan", cex.axis=1.5, cex.names=1,cex.lab=2)
    #title:barplot_HistogramFrequency_FULLdivIUCN_5
barplot(histratio5$FULLdivIUCN, names.arg=c("5", "10","15", "20", "25", "30", "35", "40" ), xlab="Histogram Bin", ylab="Ratio of Histogram Frequency", col="darkcyan", cex.axis=1.5, cex.names=1,cex.lab=2)
    #title: barplot_HistogramFrequency_IUCNdivFULL_6
barplot(histratio6$IUCNdivFULL, names.arg=c("6", "11","16", "21", "26", "31", "35", "41"), xlab="Histogram Bin", ylab="Ratio of Histogram Frequency", col="darkcyan", cex.axis=1.5, cex.names=1,cex.lab=2)
    #title: barplot_THREATdivIUCN_6
barplot(histratio6$THREATdivIUCN, names.arg=c("6", "11","16", "21", "26", "31", "36", "41" ), xlab="productivity/value", ylab="Fraction of IUCN Listed Commercial Species Threatened", col="royalblue4", cex.axis=1.55, cex.names=1.55,cex.lab=1.55)
    #title: barplot_THREATdivFULL_6
barplot(histratio6$THREATdivFULL, names.arg=c("6", "11","16", "21", "26", "31", "36", "41"), xlab="productivity/value", ylab="Fraction of Commercial Species Threatened", col="royalblue4", cex.axis=1.55, cex.names=1.55,cex.lab=1.55)
#stacked barplot for threatened only
table1stackedstatus<- table (stackedstatus$status, stackedstatus$bin)
#title: stackedbarplot_threatenedstatus
barplot(table1stackedstatus, names.arg=c("6", "11","16", "21", "31"), col=c("royalblue4", "royalblue3", "cornflowerblue"), xlab="productivity/value", ylab="Frequency of Each Status", cex.axis=1.55, cex.names=1.55,cex.lab=1.55, legend(x="topright", title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)"), col=c("royalblue4", "royalblue3", "cornflowerblue"), pch=15, pt.cex=2))

#SCATTERPLOTS:

#the index is the number along the list(the first in the list is index 1, index is the x axis)
    #title: IUCNscatterplot_xIndex_finalvalue
plot(RAMIUCN$final_value, xlab="", ylab="((cost+subsidy)/value) * ln(MSY)", main="Bioeconomic Factor", col="darkcyan")
    #title: IUCNscatterplot_xIndex_lnMSY
plot(RAMIUCN$lnMSY, xlab="", ylab="ln(MSY)", main="ln(MSY)", col="darkcyan")
    #title: IUCNscatterplot_xIndex_costvalue
plot(RAMIUCN$cost_value, xlab="", ylab="(cost+subsidy)/value", main="Cost Over Price", col="darkcyan")
#this shows scatterplot of codified status and ln(MSY)
    #title: IUCNscatterplot_IUCNcodified_lnMSY
plot(x=RAMIUCN$IUCN_codified, y=RAMIUCN$lnMSY, xlab="IUCN Status Code", ylab="ln(MSY)", main="IUCN Status Code and ln(MSY)", col="darkcyan")
#this shows a scatterplot of IUCN code and final_value.
    #Title: IUCNscatterplot_IUCNcodified_finalvalue
plot(x=RAMIUCN$IUCN_codified, y=RAMIUCN$final_value, xlab="IUCN Status Code", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status Code and Bioeconomic Factor", col="darkcyan")
    #title: IUCNscatterplot_lnMSY_costvalue
plot(x=RAMIUCN$lnMSY, y=RAMIUCN$cost_value, ylab="(cost+subsidy)/value)", xlab="ln(MSY)", main="", col="darkcyan", cex.axis=1.5, cex.lab=2)
    #title: IUCNscatterplot_costvalue_IUCNcodified
plot(x=RAMIUCN$cost_value, y=RAMIUCN$IUCN_codified, xlab="(cost+subsidy)/value)", ylab="IUCN Status Code", col="darkcyan", main="", cex.axis=1.5, cex.lab=2)
    #title: IUCNscatterplot_finalvalue_IUCNcodified
plot(x=RAMIUCN$final_value, y=RAMIUCN$IUCN_codified, xlab="((cost+subsidy)/value) * ln(MSY)", ylab="IUCN Status Code", col="darkcyan", cex.axis=1.5, cex.lab=2)
plot(RAMIUCN$IUCN_codified)
plot(RAMIUCN$final_value)




#SPINEPLOT:

    #title: IUCNspineplot_country_IUCNstatus
#trying out what I found online (source help:https://www.statmethods.net/advgraphs/layout.html   and http://www.sthda.com/english/wiki/add-legends-to-plots-in-r-software-the-easiest-way   and https://stat.ethz.ch/R-manual/R-patched/library/graphics/html/spineplot.html   and https://www.rdocumentation.org/packages/graphics/versions/3.6.0/topics/spineplot  )
par(mfrow=c(1,1)) #set par(mfrow=c())to c(1,2) for this plot
spineplot(x=RAMIUCN$countries, y=RAMIUCN$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of Status by Country", col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"), ylevels=c("CR", "EN", "VU","NT", "LC", "DD"))
plot.new()
legend(x="left", title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Least Concern (LC)", "Data Deficient (DD)"), col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"), pch=15, pt.cex=2)
#I need to find a way to add a legend for color coding and better configure status to show increasing, not alphabetical order
plot(x=RAMIUCN$countries, y=RAMIUCN$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")
#legend(x=5, y=2, legend=c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Lease Concern (LC)", "Data Deficient (DD)"))
#so far that legend isn't working, I'll need to figure something else out. the plot also goes blank if I try to change the color or the color is uniform and doesn't change by status
#This didn't work either, x and y not same length:    plot(x=RAMIUCN$countries, y=c(critical, endangered, vulnerable, near, least, deficient), xlab='Management Country', ylab='IUCN Status', main="Proportion of IUCN Status by Managing Country")
#trying out what I found online:
par(mfrow=c(1,1)) #CHANGE TO C(1,2) TO SHOW THE LEGEND
spineplot(x=RAMIUCN$countries, y=RAMIUCN$IUCN_status, xlab='Management Country', ylab='IUCN Status', main="Proportion of Status by Country", col=c("turquoise4", "turquoise3", "turquoise2", "turquoise1", "turquoise", "paleturquoise"), ylevels=c("CR", "EN", "VU","NT", "LC", "DD")) #with CR at the bottom if in front
plot.new()
legend(x="left", cex=0.7, title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Least Concern (LC)", "Data Deficient (DD)"), col=c("turquoise4", "turquoise3", "turquoise2", "turquoise1", "turquoise", "paleturquoise"), pch=15)



#BOXPLOTS:

#these are important for box plots
deficient <-subset(x=RAMIUCN, subset=IUCN_codified=="1", select=final_value)
least <-subset(x=RAMIUCN, subset=IUCN_codified=="2", select=final_value)
near<-subset(x=RAMIUCN, subset=IUCN_codified=="3", select=final_value)
vulnerable<-subset(x=RAMIUCN, subset=IUCN_codified=="4", select=final_value)
endangered<-subset(x=RAMIUCN, subset=IUCN_codified=="5", select=final_value)
critical<-subset(x=RAMIUCN, subset=IUCN_codified=="6", select=final_value)
#this shows a boxplot of country and ln(MSY)
    #Title: IUCNboxplot_country_lnMSY
plot(x=RAMIUCN$countries, y=RAMIUCN$lnMSY, xlab="Management Country", ylab="ln(MSY)", main="ln(MSY) by Country Manager", col="darkcyan")
#this shows country and cost/price. Maybe not the most useful because of the range issues
    #Title: IUCNboxplot_country_costvalue
plot(x=RAMIUCN$countries, y=RAMIUCN$cost_value, xlab="Managing Country", ylab="(cost+subsidy)/value)", main="Cost/Price by Country", col="darkcyan")
#this works,  just need to rename the Y labels!(help from :https://stackoverflow.com/questions/9975789/multiple-boxplots-in-one-in-r  and https://www.datamentor.io/r-programming/box-plot/) and fix colors (see list I made)
    #Title: IUCNboxplot_IUCNstatus_finalvalue
boxplot(x=c(critical, endangered, vulnerable, near, least, deficient), y=RAMIUCN$final_value, at=c(1,2,3,4,5,6),names=c("Critical", "Endangered", "Vulnerable", "Near Treatened", "Least Concern", "Data Deficient"), xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Bioeconomic Factor",col=c("paleturquoise4", "turquoise4", "lightseagreen","cyan3","cyan", "aquamarine"))
#this shows IUCN status and ln(MSY). Need to reorder status for threat level and color, see above
    #Title: IUCNboxplot_IUCNstatus_lnMSY
plot(RAMIUCN$IUCN_status, y=RAMIUCN$lnMSY, xlab="IUCN Status", ylab="ln(MSY)", main="IUCN Status and ln(MSY)", col="darkcyan")
#Need to reorder status and fix colors like above
    #Title: IUCNboxplot_IUCNstatus_finalvalue
plot(x=RAMIUCN$IUCN_status, y=RAMIUCN$final_value, xlab="IUCN Status", ylab="((cost+subsidy)/value) * ln(MSY)", main="IUCN Status and Bioeconomic Factor", col="darkcyan")
boxplot(x=critical, y=RAMIUCN$final_value, ylim=c(0,35))
boxplot(x=endangered, y=RAMIUCN$final_value, ylim=c(0,35))
boxplot(x=vulnerable, y=RAMIUCN$final_value, ylim=c(0,35))
boxplot(x=threatened, y=RAMIUCN$final_value, ylim=c(0,35))
#this works,  just need to rename the Y labels!(help from :https://stackoverflow.com/questions/9975789/multiple-boxplots-in-one-in-r  and https://www.datamentor.io/r-programming/box-plot/)
boxplot(x=c(critical, endangered, vulnerable, near, least, deficient), y=RAMIUCN$final_value, at=c(1,2,3,4,5,6),names=c("Critical", "Endangered", "Vulnerable", "Near Treatened", "Least Concern", "Data Deficient"), xlab="IUCN Status", ylab="Bioeconomic Factor", main="IUCN Status and Bioeconomic Factor", col=c("red", "orange", "yellow", "green", "blue", "purple"))


#STACKED BARPLOTS:

#Stacked barplot:
#this is a stacked barplot to show how many of each status were in each histogram bin 
#need to make a new data table for this and load it (my data isn't all together nice and neat)
    #title: FULLstackedbarplot_threatenedstatus
#ylevels=c("CR", "EN", "VU","NT", "LC", "DD") #with CR at the bottom if in front, at top if at end of list. Works for spineplot, might for boxplot
table1stackedstatus<- table (stackedstatus$status, stackedstatus$bin)
#title: stackedbarplot_threatenedstatus
barplot(table1stackedstatus, names.arg=c("6", "11","16", "21", "31"), col=c("royalblue4", "royalblue3", "cornflowerblue"), xlab="productivity/value", ylab="Frequency of Each Status", cex.axis=1.55, cex.names=1.55,cex.lab=1.55, legend(x="topright", title="Status Code:", c("Critical (CR)","Endangered (EN)", "Vulnerable (VU)"), col=c("royalblue4", "royalblue3", "cornflowerblue"), pch=15, pt.cex=2))



###################RANDOM OTHER

#we want to get a subset of the species that are considered under threat, just for reference and to play around with later.
###can we do this? I was trying to use something like                 
#threatened<-subset(x=RAMIUCN, subset=IUCN_codified== c('4','5','6')) but kept getting errors

#!! I figured it out, I need an %in%. I tried just putting it as so: IUCN_codified== %in% C(...)
  #it didn't work, might need to remove the "==" or could maybe try replacing the "==" 
  #the directions I found online removed the x= and subset= but I want to keep that for future reference and to know exactly what I did.
threatened=subset(x=RAMIUCN, subset=IUCN_codified %in% c('4','5','6'))
  
##This isn't working but I need a way to get only the final_value values and not all columns
#threatened_final=subset(x=RAMIUCN, subset==IUCN_status %in% c("CR", "EN","VU"), select=final_value)

#find average codified threat level. Might be an indicator of about how threatened the whole set of stocks is
mean(RAMIUCN$IUCN_codified)

#na.rm=T means that NA values are not included in any math (if they were, the result would always read NA which it not useful)
mean(RAMIUCN$lnMSY, na.rm=T) #for example, try with F instead of T

#create list of unique stockids
stock=unique(RAMIUCN$stockid)

###################