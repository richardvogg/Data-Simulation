library(dplyr)
library(ggplot2)
library(patchwork)


#Creates random normal distributed data around a point
make_cluster <- function(size=100,mean_vec=c(0,0),sd=0.5) {
  coords <- lapply(mean_vec,function(x) rnorm(size,x,sd))
  out <- do.call(cbind,coords)
  
  return(data.frame(out))
}

#Creates a given number of clusters around points
#ndim is for the dimensionality of the data
simulator <- function(size_vec=rep(100,3),
                      mean_vec=c(0,0,2,2,0,3),
                      ndim=2,
                      sd_vec=c(0.5,0.5,0.5)) {
  mean_matrix=matrix(mean_vec,ncol=ndim,byrow=T)
  output <- NULL
  for(i in 1:dim(mean_matrix)[1]) {
    output <- rbind(output,make_cluster(size_vec[i],mean_matrix[i,],sd_vec[i]))
  }
  return(output)
}

#Create an R square plot for a given dataset which should be ready for clustering
rsqplot <- function(data,k_min=1,k_max=8) {
  quo <- NULL
  n <- dim(data)[1]
  for(k in k_min:k_max) {
    a <- kmeans(data,k)
    cat("within: ",a$withinss,"\n")
    cat("between: ",a$betweenss,"\n")
    rsq <- 1-(sum(a$withinss)*(n-1))/(a$totss*(n-k))
    quo <- c(quo,rsq)
  }
  rsq_data <- data.frame(k=k_min:k_max,quo=quo)
  ggplot(rsq_data,aes(x=k,y=quo))+geom_point(size=2,col="red")+
    geom_line(size=1,col="orange")+
    labs(x="Number of clusters",y="R-square",title="Can you find the elbow point?")
}

#Applies clustering on given data and plots clusters.
#If add_ssq is true, it removes axes and shows WSS and BSS for each clustering
plot_clusters <- function(data,k=1,add_ssq=F) {
  set.seed(1)
  
  cluster <- kmeans(data,k)
  
  data$cluster <- factor(cluster$cluster)
  centers <- data.frame(cluster$centers)
  
  if(add_ssq) {
    title=paste("WSS:",paste(round(cluster$withinss),collapse = "   "),
                   paste("\nBSS:",round(cluster$betweenss)))
    text <- ""
    x <- ""
    y <- ""
  }
  else {
    title <- paste("Clustering with",k,"clusters")
    text <- "Each point is\n one customer"
    x <- "Age"
    y <- "Income"
    }
  
  plot <- data %>% 
    ggplot(aes(x=X1,y=X2))+
    geom_point(aes(col=cluster))+
    geom_point(data=centers,size=4,shape=21,fill="black")+
    annotate("text",x=1.5,y=4,label=text)+
    labs(x=x,y=y,title=title)+
    theme(axis.text=element_blank())
  
  return(plot)
  
}


#Create data
data <- simulator()

#Plot examples
data %>% plot_clusters(k=4)


## Within sum of squares

d1 <- make_cluster(size=100)

d1_summ <- d1 %>% summarise(X1=mean(X1),X2=mean(X2))

ggplot(d1,aes(x=X1,y=X2))+geom_point(size=2,col="brown")+
  geom_point(data=d1_summ,size=5,shape=21,fill="black")+
  theme(axis.title = element_blank(),
        axis.text = element_blank())+
  labs(title="Within Sum of Squares (WSS)", 
       subtitle="How far are the points in a cluster from their mid point? \nWe square all the distances and sum them up to calculate WSS.")


## Between sum of squares


cluster <- kmeans(data,3)

data$cluster <- factor(cluster$cluster)
centers <- data.frame(cluster$centers)
center <- data %>% summarise_all(mean)

data %>% 
  ggplot(aes(x=X1,y=X2))+
  geom_point(aes(col=cluster))+
  geom_point(data=centers,size=4,shape=21,fill="black")+
  geom_point(data=center,size=4,shape=15,fill="black")+
  labs(title="Between Sum of Squares",
       subtitle="How far are the cluster midpoints from the midpoint of all data?\nThe distance is multiplied by the number of points in each cluster.")+
  theme(axis.text=element_blank(),
        axis.title=element_blank(),
        legend.position="none")

#Show WSS and BSS for different numbers of clusters

p2 <- data %>% plot_clusters(k=2,add_ssq = T)+theme(legend.position="none")
p3 <- data %>% plot_clusters(k=3,add_ssq = T)+theme(legend.position="none")
p4 <- data %>% plot_clusters(k=4,add_ssq = T)+theme(legend.position="none")
p5 <- data %>% plot_clusters(k=5,add_ssq = T)+theme(legend.position="none")
p6 <- data %>% plot_clusters(k=6,add_ssq = T)+theme(legend.position="none")

(p2+p3+p4)/(p5+p6+plot_spacer())

#Create R Square Plot

rsqplot(data)

## Higher dimensions

library(rgl)
plot3d(x=data[,1],y=data[,2],z=data[,3],col=cluster$cluster)
