#This is an attempt to merge the country data from the stock sheet with the MSY and stocks from bioparams sheet. There are fewer stock in the bioparams sheet than the stocks sheet, so it's frustrating to put together manually.

setwd('C:/Users/missr_000/Dropbox/Extinction Database/Analysis')
dir()
bioparams<-read.csv(file="RAM_BIOPARAMSSHEET_DATA.csv", header=T)
fullstock<-read.csv(file="RAM_STOCKSHEET_DATA.csv", header=T)


#What I want to do: get all data for country/region from the stock sheet and merge with the bioparams sheet (without getting all the extra stocks that aren't in bioparams)

integrated<-merge(bioparams,fullstock, by="stockid")


#save the new integrated data as a CSV that I can add the cost data to, I think I should do that manually since it's kind of weird

write.csv(integrated, file="RAM_INTEGRATED_DATA.csv")


#Now for plotting using the edited new integrated file:
integrated<-read.csv(file="RAM_INTEGRATED_DATA.csv", header=T)

#trial to make sure a basic histogram will work (it didn't at first because #VALUE! was still in a cell, glad I went through and corrected those!)
hist(integrated$final_value)

hist(integrated$final_value,breaks=20, col=4, prob=T, xlab= "((cost+subsidy)/value)*ln(MSY)", main="Density, Breaks=20", xlim=c(0,50))
  #lines(density(datafile$final_value, na.rm=T),lwd=2, col="black")



