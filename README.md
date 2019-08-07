# species-extinction_RN
Rondi's RIOS project on species extinction

Project Overview
-   This project follows Ed Tekwa's research published in PNAS (insert link or citation) which found that there are certain stable states where more species persist and state where species are more likely to go extinct. This was found by comapring cost/price ratios and the maximum sustainable yield (MSY). The objective was to see if the trends from previos research hold up, to establish a database that can be used for future studies, and to establish a method of assessing the compiled data. In the future, the findings from this project as well as projects based on this database will be used alongside statisitical models to predict species extinction risk. 

File Descriptions:

DATA_ANALYSIS.R
-   This file is where most of the data analysis was done. There was a lot of trial and error in the process, so the plots and necessary code were moved to the top. s you work your way to the bottom of the code it becomes less relvant to the final product and more about different versions of used plots or simply trial and error early plots.


FULL_RAM_MSY.R
-   This file is where I did the data analysis for the full 628 species list from the RAM database. These species were taken from the "bioparams_values_views sheet", as that's the only one that has MSY values listed. There is another, larger list of stocks in the "stock" sheet but that was larger than I knew how to manage and a very high proprtion of those would not have an MSY value (they would not show up in analysis anyway). In here I created a histogram and stacked barplot that were used for final poster results.
