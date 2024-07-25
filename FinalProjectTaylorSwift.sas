libname class "/home/u63866402/Stat Methods II";
proc import datafile="/home/u63866402/Stat Methods II/taylor_swift_spotify.xlsx"
	out=taylor dbms=xlsx replace;
	
*histograms for qualitative data;
title 'Histogram for Tempo';
proc univariate data=taylor noprint;
   histogram tempo ;
title 'Histogram for Valence';
proc univariate data=taylor noprint;
   histogram valence ;
title 'Histogram for Danceability';
proc univariate data=taylor noprint;
   histogram danceability ;
title 'Histogram for Popularity';
proc univariate data=taylor noprint;
   histogram popularity ;
*bar chart for album;
PROC SGPLOT DATA = taylor;
VBAR album;
RUN;
	
*one way anova for popularity based on album;
proc anova data = taylor;
class album;
model popularity = album;
means album;

*now we've determined a difference. where is it?;
proc anova data = taylor;
class album;
model popularity = album;
means album/ tukey lsd;

*multiple regression for danceability as the dependent variable and tempo and valence as the independent variables;
proc reg data=taylor;
	model danceability = tempo valence/clb ;
	id = tempo valence;

*two-sample rank sum test to see if the median popularity for songs on “Midnights” is higher than songs on “Speak Now.” ;
data new_taylor;
   set taylor;
   IF ( album = "Midnights" or album = "Speak Now") THEN OUTPUT;
RUN;

proc npar1way data=new_taylor wilcoxon;
	var popularity;
	class album;