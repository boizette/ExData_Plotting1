plot3<-function(){
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

##Filtrage des lignes relatives aux deux premiersjours de février 2007
gic<-fic[between(as.Date(fic$Date,"%d/%m/%Y"),"2007-02-01","2007-02-02",incbounds = TRUE), ]

##Mise en conformité des données en abscisse et ordonnée
x<-strptime(paste(gic$Date,gic$Time),"%d/%m/%Y %H:%M:%S")
Gsub1<-as.numeric(gic$Sub_metering_1)
Gsub2<-as.numeric(gic$Sub_metering_2)
Gsub3<-as.numeric(gic$Sub_metering_3)

##Traçage des 3 graphiques
par(mfrow=c(1,1),mar=c(4,4,1,1))
plot(x,Gsub1,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),ylab="Energy sub metering",xlab="",col="black")
par(new=TRUE)
plot(x,Gsub2,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),axes=FALSE,xlab="",ylab="",col="red")
par(new=TRUE)
plot(x,Gsub3,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),axes=FALSE,xlab="",ylab="",col="blue")
##Affichage légende
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1.5,1.5,1.5),col=c("black","red","blue"),cex=0.85)

##Sauvegarde graphe dans le fichier PLOT3.PNG
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()

}

