plot1<-function(){
##Initialisations diverses
##install.packages("data.table")
library(data.table)

##Récupération des données   
f_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile()
download.file(f_url,temp)
unzip(temp,"household_power_consumption.txt")
ColNames=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
fic<-read.table("household_power_consumption.txt",stringsAsFactors=FALSE,header=TRUE,col.names=ColNames,sep=";" )

##Filtrage des lignes relatives aux deux premiers jours de février 2007
gic<-fic[between(as.Date(fic$Date,"%d/%m/%Y"),"2007-02-01","2007-02-02",incbounds = TRUE), ]

##Mise en conformité des données en abscisse
G_A_POW<-as.numeric(gic$Global_active_power)

##Traçage graphique
par(mfrow=c(1,1),mar=c(4,4,1,1))
hist(G_A_POW,main="Globale Active Power",xlab="Globale Active Power (kilowatts)",yaxt="n",col="red")
##Modification axe des y
ytick<-seq(0,1200,by=200)
axis(side=2,at=ytick,labels=FALSE)
text(par("usr")[1],ytick,labels=ytick,pos=2,xpd=TRUE,xpd=TRUE,col="black")

##Sauvegarde graphe dans le fichier PLOT1.PNG
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()

}
