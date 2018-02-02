plot2<-function(){
##Initialisations diverses
##install.packages("data.table")
  library(data.table)
  Sys.setlocale("LC_TIME", "English")
  
##Récupération des données   
f_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile()
download.file(f_url,temp)
unzip(temp,"household_power_consumption.txt")
  ColNames=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
fic<-read.table("household_power_consumption.txt",stringsAsFactors=FALSE,header=TRUE,col.names=ColNames,sep=";" )

##Filtrage des lignes relatives aux deux premiers jours de février 2007
gic<-fic[between(as.Date(fic$Date,"%d/%m/%Y"),"2007-02-01","2007-02-02",incbounds = TRUE), ]

##Mise en conformité des données en abscisse et ordonnée
x<-strptime(paste(gic$Date,gic$Time),"%d/%m/%Y %H:%M:%S")
G_A_POW<-as.numeric(gic$Global_active_power)

##Traçage graphique
par(mfrow=c(1,1),mar=c(4,4,1,1))
plot(x,G_A_POW,type="l",ylab="Globale Active Power (kilowatts)",xlab="")

##Sauvegarde graphe dans le fichier PLOT2.PNG
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()

}

