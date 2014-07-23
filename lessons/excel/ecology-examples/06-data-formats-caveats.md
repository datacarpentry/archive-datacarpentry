# Caveats of popular data and file formats #

Materials by: **Jeffrey Hollister**, **Alexander Duryee**, **Jennifer Bryan**, **Daisie Huang**, **Ben Marwick**, **Christie Bahlai**, **Owen Jones**, **Aleksandra Pawlik**

###Commas as part of data values in `*.csv` files

In the [previous lesson](05-exporting-data.md) we discussed how to export Excel file formats into `*.csv`. Whilst Comma Separated Value files are indeed very useful allowing for easily exchanging and sharing data. 

However, there are some significant problems with this particular format. Quite often the data values themselves may include commas ('). In that case, the software which you use (including Excel) will most likely incorrectly display the data in columns. It is because the commas which are a part of the data values will be interpreted as a delimiter.

For example, our data could look like this:
	
		species_id,genus,species,taxa
		AB,Amphispiza,bilineata,Bird
		AH,Ammospermophilus,harrisi,Rodent-not,censused
		AS,Ammodramus,savannarum,Bird

In record `AH,Ammospermophilus,harrisi,Rodent-not,censused` the value for *taxa* includes a comma (`Rodent-not,censused`). 
If we try to read the above into Excel (or other spreadsheet programme), we will get something like this.

Previous: [Exporting data from spreadsheets.](05-exporting-data.md)