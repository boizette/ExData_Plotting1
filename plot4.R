plot4<-function(){
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
write.table(gic,file="test.txt")
##Mise en conformité des données en abscisse et ordonnée
x<-strptime(paste(gic$Date,gic$Time),"%d/%m/%Y %H:%M:%S")





##Mise en conformité des données en abscisse et ordonnée
x<-strptime(paste(gic$Date,gic$Time),"%d/%m/%Y %H:%M:%S")
G_A_POW<-as.numeric(gic$Global_active_power)
G_R_POW<-as.numeric(gic$Global_reactive_power)
G_V<-as.numeric(gic$Voltage)
Gsub1<-as.numeric(gic$Sub_metering_1)
Gsub2<-as.numeric(gic$Sub_metering_2)
Gsub3<-as.numeric(gic$Sub_metering_3)


##Traçage graphique
par(mfrow=c(2,2),mar=c(4,4,1,1),oma=c(0,1,0,0))
plot(x,G_A_POW,type="l",ylab="Globale Active Power",xlab="")
plot(x,G_V,type="l",ylab="Voltage",xlab="datetime")
plot(x,Gsub1,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),ylab="Energy sub metering",xlab="",col="black")
par(new=TRUE)
plot(x,Gsub2,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),axes=FALSE,xlab="",ylab="",col="red")
par(new=TRUE)
plot(x,Gsub3,type="l",ylim=range(c(Gsub1,Gsub2,Gsub3)),axes=FALSE,xlab="",ylab="",col="blue")
##Affichage légende
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",lty=c(1,1,1),lwd=c(1.5,1.5,1.5),col=c("black","red","blue"),cex=0.65)

plot(x,G_R_POW,type="l",ylab="Globale reactive Power",xlab="datetime",yaxt="n")
ytick<-seq(0,0.5,by=0.1)
axis(side=2,at=ytick,labels=FALSE)
text(par("usr")[1],ytick,labels=ytick,pos=2,xpd=TRUE)


##Sauvegarde graphe dans le fichier PLOT4.PNG
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()

}

