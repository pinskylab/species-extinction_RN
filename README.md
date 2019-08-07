# species-extinction_RN
Rondi's RIOS project on species extinction

Project Overview
-   This project follows Ed Tekwa's research published in PNAS (insert link or citation) which found that there are certain stable states where more species persist and state where species are more likely to go extinct. This was found by comapring cost/price ratios and the maximum sustainable yield (MSY). The objective was to see if the trends from previos research hold up, to establish a database that can be used for future studies, and to establish a method of assessing the compiled data. In the future, the findings from this project as well as projects based on this database will be used alongside statisitical models to predict species extinction risk. 

File Descriptions:

Alternate_Stable_States_Conservation__EdTekwa.pdf
-   My mentor, Ed Tekwa, wrote this paper in PNAS which inspired this project. My is a continuation of the ideas from this paper, but more focused on comparing stock data and known extinction risk.

DATA_ANALYSIS.R
-   This file is where most of the data analysis was done. There was a lot of trial and error in the process, so the plots and necessary code were moved to the top. As you work your way to the bottom of the code it becomes less relevant to the final product and more about different versions of used plots or simply trial and error early plots.

Data_Notes.docx
-   This is the document I kept daily notes in from June 17th to August 8th. These notes include my thoughts and questions, random ideas, notes from meetings, daily to-dos, and the very fine details of what I did.

FULL_RAM_MSY.R
-   This file is where I did the data analysis for the full 628 species list from the RAM database. These species were taken from the "bioparams_values_views sheet", as that's the only one that has MSY values listed. There is another, larger list of stocks in the "stock" sheet but that was larger than I knew how to manage and a very high proprtion of those would not have an MSY value (they would not show up in analysis anyway). In here I created a histogram and stacked barplot that were used for final poster results.

FULL_stacked_barplot_data.csv
-   In order for the stacked barplot to work, I had to rearrange my data in a certain way for the code to run smoothly. Additionally, I added the lowercase letters in front of the status code in order to have them appear in the stacked bars in descending threat level (Rstudio defaults to putting everything in alphabetical order which I don’t want). 	

Lam-etal-2011_Global-cost-fishing-database.pdf
-   This is the paper that talks about the way the cost data was compiled and why. The data I used is in the “RAManalysis data.xlsx” file that I have in here as well. 

RAM_BIOPARAMSSHEET_DATA.csv	
-   This is taken from the “RLSADB v4.44 (assessment data only).xlsx” sheet named “bioparams_values_views” for easier merging with stock data (“RAM_INTEGRATED_DATA.csv”) from “RAM_STOCKSHEET_DATA.csv” to create a merged file that contained what I needed before adding additional data in.

RAM_FULL_DATA.csv
-   This is the list of all 628 stocks and associated values that was used for plots for the final poster.

RAM_INTEGRATED_DATA.csv	
-   The product of the “RAM_BIOPARAMSSHEET_DATA.csv” and “RAM_STOCKSHEET_DATA.csv” merge. 

RAM_IUCN_DATA.csv	
-   This contains data for 118 RAM stocks that had an IUCN status. 

RAM_STOCKSHEET_DATA.csv	
-   This is taken from the “RLSADB v4.44 (assessment data only).xlsx” sheet named “stock” and used alongside the “RAM_BIOPARAMSSHEET_DATA.csv” file to create the “RAM_INTEGRATED_DATA.csv” file.

RAManalysis data.xlsx	
-   This was given to me by Ed Tekwa for use in calculating the (cost+subsidy)/benefit for each stock.

RLSADB v4.44 (assessment data only).xlsx	
-   This is the full RAM file I worked with. Some of the sheets are rearranged and there may be some highlighting I need to remove—also unused sheets that were made. This is the basis of all my data. 

RNordal_RIOS_Poster_Final.pdf
-   This is the final draft of the poster I sent in for printing.	

histogram_IUCNstatus_for-stacked-barplot.csv	
-    This was used to create a stacked barplot for just the IUCN listed stocks. It was not used because it didn’t provide as much information as a possible like the one that was ultimately used.

histogram_frequencies_at5.csv
-   This was used to create the ratio barplots that were used for the poster.	

histogram_frequencies_at6.csv
-   This is to create ratio barplots when the histogram breaks are in a range from 6-11, 11-16, etc. This was not used for the final poster.

histogram_weighted_risk_5.csv
-   This was used to create weighted barplots where the greater the risk, the greater the weighted value. This was used for the final poster.	

histogram_weighted_risk_6.csv
-   This is to create weighted barplots when the histogram breaks are in a range from 6-11, 11-16, etc. This was not used for the final poster.
