#This is an attempt to merge the country data from the stock sheet with the MSY and stocks from bioparams sheet. There are fewer stocks in the bioparams sheet than the stocks sheet, so it's frustrating to put together manually.

setwd('C:/Users/missr_000/Dropbox/Extinction Database/Analysis')
dir()
#this has the data from the bioparams sheet
bioparams<-read.csv(file="RAM_BIOPARAMSSHEET_DATA.csv", header=T)
#this has the full list of stocks from the stock sheet
fullstock<-read.csv(file="RAM_STOCKSHEET_DATA.csv", header=T)

#What I want to do: get all data for country/region from the stock sheet and merge with the bioparams sheet (without getting all the extra stocks that aren't in bioparams)
integrateddata<-merge(bioparams,fullstock, by="stockid")

#save the new integrateddata as a CSV that I can add the cost data to, I think I should do that manually since it's kind of weird
write.csv(integrateddata, file="RAM_INTEGRATED_DATA.csv")

#Now for plotting using the edited new file. I made a new file with updated information to leave RAM_INTEGRATED_DATA.CSV as an intermediate (if I run this code again I can start new, if I had the new file be the same name if I ran the above code, I'd lose the new data unless I could retrieve a previous file version):
RAMFULL<-read.csv(file="RAM_FULL_DATA.csv", header=T)


#basis of the histograms we're looking for:
#title: FULL_histogram_finalvalue_5b
hist(RAMFULL$final_value,breaks=c(5,10,15,20,25,30,35,40,45), col="royalblue4", freq=T, xlab= "productivity/value", main="", xlim=c(0,50), cex.axis=1.55, cex.lab=1.55)
fullhistinfo<-hist(RAMFULL$final_value, breaks=c(5,10,15,20,25,30,35,40,45))
#lines(density(integrated$final_value, na.rm=T),lwd=2, col="black")  



stackedstatusFULL <- read.csv("FULL_stacked_barplot_data.csv")
#stacked barplot:
  table2stackedstatus<- table (stackedstatusFULL$status, stackedstatusFULL$bin)
  #title: fixed_angled_stackedbarplot_FULLstatus
par(mar=c(10, 10, 2, 2))
  barplot(table2stackedstatus, xlab="",ylab="", cex.axis=3, cex.names=3,cex.lab=3, col=c("darkblue","blue3","lightslateblue","mediumorchid3","plum","maroon3","red4"), names.arg=c("", "", "", "", "", "", "", ""))
text(seq(.15, 10, by=1.3), -15, srt = 35, labels = c("5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45"), xpd = TRUE, cex=3)
text(5, -45, labels="productivity/value", xpd=T, cex=3)
par(mar=c(2, 2, 2, 2))
plot.new()
#title: legend_stackedbarplot_FULLstatus
legend(x="center", title="Status Code:", c("Critically Endangered (CR)","Endangered (EN)", "Vulnerable (VU)","Near Threatened (NT)", "Least Concern (LC)", "Data Deficient (DD)", "No Status (NS)"), pch=15, pt.cex=4, cex=2, col=c("red4", "maroon3","plum", "mediumorchid3", "lightslateblue", "blue3", "darkblue"), bty="n")

  


###UNUSED PLOTS:

#HISTOGRAM:
#title: FULL_histogram_finalvalue_6b
hist(RAMFULL$final_value,breaks=c(6,11,16,21,26,31,36,41,46), col="royalblue4", freq=T, xlab= "productivity/value", main="", xlim=c(0,50), cex.axis=1.55, cex.lab=1.55)
fullhistinfo<-hist(RAMFULL$final_value, breaks=c(6,11,16,21,26,31,36,41,46))
##lines(density(integrated$final_value, na.rm=T),lwd=2, col="black")  




#BOXPLOTS:
  #this shows a boxplot of country and ln(MSY)
  #Title: FULLboxplot_country_lnMSY
  plot(x=RAMFULL$countries, y=RAMFULL$lnMSY, xlab="Management Country", ylab="ln(MSY)", main="ln(MSY) by Country Manager", col="darkcyan")
  #this shows country and cost/price. Maybe not the most useful because of the range issues
  #Title: FULLboxplot_country_costvalue
  plot(x=RAMFULL$countries, y=RAMFULL$cost_value, xlab="Managing Country", ylab="(cost+subsidy)/value)", main="Cost/Price by Country", col="darkcyan")
#this is of countries and finalvalue
  #title: FULL_boxplot_countries_finalvalue
  plot(x=RAMFULL$countries, y=RAMFULL$final_value, xlab="Managing Country", ylab="((cost+subsidy)/value)*ln(MSY)", main="Country and Bioeconomic Factor", col="darkcyan")  



#SCATTERPLOTS:
  
  #what is the "index"(the x axis)?
  #title: FULLscatterplot_xIndex_finalvalue
  plot(RAMFULL$final_value, xlab="", ylab="((cost+subsidy)/value) * ln(MSY)", main="Bioeconomic Factor", col="darkcyan")
  #title: FULLscatterplot_xIndex_lnMSY
  plot(RAMFULL$lnMSY, xlab="", ylab="ln(MSY)", main="ln(MSY)", col="darkcyan")
  #title: FULLscatterplot_xIndex_costvalue
  plot(RAMFULL$cost_value, xlab="", ylab="(cost+subsidy)/value", main="Cost Over Price", col="darkcyan") 


