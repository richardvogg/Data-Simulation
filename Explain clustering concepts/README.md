## Clustering with k-means

### What is the correct number of clusters?

Customer segmentation is the key to a successful future of many companies who have to understand their customers' needs and treat each customer as the individual they are. The days of serving the average and having some rough business rules in place are coming to an end. Clustering techniques can help to find groups of similar customers.
But how can we know what is the correct number of clusters? To explain how this can be done, I prepared a few plots with simulated data for a meeting with business partners. I selected variables that they usually work with to make them feel as comfortable as possible in this discussion.

![](../img/clustering_idea.png)

Why do we intuitively say that this is a good clustering, and definitely a better clustering than this?

![](img/clustering_2.png)

What about this version?

![](img/clustering_4.png)

Can we measure this feeling? There is a method...

First, we need some ingredients to measure how similar the customers within a cluster are and how different the customers from two different clusters are:

![](img/WSS.png)

![](img/BSS.png)

Great, now how do these quantities change, when we introduce more clusters?

![](img/different_k.png)

WSS goes down (the more clusters, the closer the points within a cluster get together), BSS goes up (with more clusters, the cluster mid-points are drifting more and more away from each other). Check the extreme cases (1 cluster vs each point is a cluster) to make these concepts clear.

The R Square value is a weighted value of 1-WSS/(WSS+BSS). With an increasing number of clusters, WSS get smaller, so the R Square will increase until finally reach 1. If we plot the R Square value for different numbers of clusters, we obtain a chart. The elbow point is the point after which the addition of new clusters will not improve the separation of the data into groups. It is a good candidate to consider for the number of clusters.

![](img/Elbow_chart.png)

Of course, there are also other considerations from business side that influence the final decision, but this can be helpful to support the decision.
