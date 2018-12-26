install.packages("RMySQL")
install.packages('dBI')
install.packages('rJava')

library(rJava)
library(dBI)
library(RMySQL)

drv = dbDriver('MySQL')
con = dbConnect(drv, host='127.0.0.1', dbname='mysql', user='root', pass='qwer1234')

dbListTables(con)
dbListFields(con, 'bike')

dfbike <- dbReadTable(con, 'bike')
dfbike

dfbike_1 <- dbGetQuery(con, 'select * from bike') 
dfbike_1

dfbike_1 <- dbGetQuery(con, 'select * from bike where season="1";')
dfbike_1

dfbike_2 <- dbGetQuery(con, 'select * from bike where substr(dt, 6, 2) in ("01","02");')
dfbike_2
head(dfbike_2)
tail(dfbike_2)

data(iris)
colnames(iris)
c<-read.table('https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data',
              header = FALSE, sep=',', stringsAsFactor=F)

c
coln <- c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width', 'Species')

colnames(c) <- coln
colnames(c)

dfiris<-dbReadTable(con, 'iris')
dfiris

write.csv(iris, 'E:/Bigdata/dataset/iris.csv')

##
#library(RODBC)
dfiris<-dbGetQuery(con, 'select * from iris')
dfiris

library(ggplot2)

#install.packages('gridExtra')
library('gridExtra')

#par(mfrow=c(2,1))

p1 <- ggplot(dfiris, aes(x=SepalL, y=SepalW))
p11<-p1+geom_point(aes(color=Species, shape=Species)) +
  xlab('Sepal Length') + ylab('Sepal Width') + 
  ggtitle('Sepal Length-Width')

p2 <- ggplot(dfiris, aes(x=PetalL, y=PetalW))
p22<-p2+geom_point(aes(color=Species, shape=Species)) + 
  xlab('Petal Length') + ylab('Petal Width') +
  ggtitle('Petal Length-Width')

grid.arrange(p11, p22, ncol=2)

p3 <- ggplot(dfiris, aes(x=Species, y=SepalL)) +
  geom_boxplot(aes(fill=Species)) + 
  ylab('Sepal Length') + ggtitle('Sepal Length') +
  theme(plot.title=element_text(hjust=0.5)) +
  stat_summary(fun.y=mean, geom='point', shape=5, size=4)

p4 <- ggplot(dfiris, aes(x=Species, y=PetalL)) +
  geom_boxplot(aes(fill=Species)) +
  ylab('Petal Length') + ggtitle('Petal Length') +
  theme(plot.title=element_text(hjust=0.5)) +
  stat_summary(fun.y=mean, geom = 'point', shape=5, size=4)

p5 <- ggplot(dfiris, aes(x=Species, y=SepalW)) +
  geom_boxplot(aes(fill=Species)) + 
  ylab('Sepal Width') + ggtitle('Sepal Width') +
  theme(plot.title=element_text(hjust=0.5)) +
  stat_summary(fun.y=mean, geom='point', shape=5, size=4)

p6 <- ggplot(dfiris, aes(x=Species, y=PetalL)) +
  geom_boxplot(aes(fill=Species)) +
  ylab('Petal Width') + ggtitle('Petal Width') +
  theme(plot.title=element_text(hjust=0.5)) +
  stat_summary(fun.y=mean, geom = 'point', shape=5, size=4)


grid.arrange(p3, p5, p4, p6, ncol=2, nrow=2)
