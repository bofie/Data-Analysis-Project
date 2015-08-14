Description of the project:

	This project aims at analyzing the the data of storms in East Pacific and North Atlantic regions between year 1980 and 2010. 
	All data is obtained from IBTrACS.
	The link of data is listed below:
		https://www.ncdc.noaa.gov/ibtracs/index.php?name=wmo-data

Author Info:

	Bofan Chen
	UC Berkeley 17'

The organization of directories and files:

	The whole project contains 6 folders.

	'code' folder contains the code for generating the project. The report.pdf maybe reproduced by running report.Rmd file. Note that report.Rmd should be dragged outside the code folder if it needs to be run. Also note that if the user wishes to generate the pdf file for multiple times, he/she may set the EVAL on line 14 to FALSE so that same source data does not need to be re-downloaded.

	'rawdata' folder contains three files, all of which are raw data necessary for the project.

	'data' folder contains two files, storms.csv and tracks.csv, which are processed data from the downloaded raw data.

	'images' folder contains all the images generated in the report in order to illustrate certain analysis.

	'report' folder contains the final report pdf file.

	'resources' folder currently does not contain anything, but any type of useful resources may be added.
