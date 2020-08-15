# Data-Simulation

When I want to get people enthusiastic about R, I recommend them to find a real world dataset about a topic they are passionate about. The world is full of data and it was never easier to find data related to a certain topic.

Nevertheless, there are situations where simulating your own data is the best option. I want to show three such examples and how R can help in these situations:

1. When explaining basic concepts
2. When the real data is sensitive
3. When another team is waiting for the data

## 1. When explaining basic concepts.

When we move to a more analytical future, we have to replace some things "that have always be done this way" by new methods. In this case, it is important to find a common ground for discussion and explain technical concepts in a compehensible way. When I prepare for such a discussion, I always prepare some simulated datasets which can support the narrative and explain the method.

Two small examples:
* [Explain how we can decide on a good number of clusters when using k-means.](https://github.com/richardvogg/Data-Simulation/tree/master/Explain%20clustering%20concepts)
* [Explain how different classification algorithms find different decision boundaries.](https://github.com/richardvogg/Data-Simulation/tree/master/Explain%20decision%20boundaries)

## 2. When the real data is sensitive
Companies usually protect their customers' data. This is great.

For data analytics companies who put a lot of effort into learning and development it can be challenging to find adecuate datasets with customer datasets to train their employees. Again, data simulation comes to the rescue: We can simulate a complete database with the following properties:

* it is completely made-up, zero risk to use in any initiative.
* it is so sophisticated that young analysts can use it to practice their data analytics and storytelling capabilities.
* it is large, so that analysts learn to write efficient code.
* it is available to everybody in the company, training initiatives and individuals.
* it is accessible from RStudio, Python and pgAdmin containers.

The code file about Data Simulation shows how we can use the great capabilities of R to create such a database.


## 3. When another team is waiting for the data
Pulling together data from several sources, quality checks and processing of the data can take several weeks when working with large corporate databases.
If the end product is an application or a dashboard, and some other team is waiting for the data, with simulated data that has a format close to the real data, they can get started almost at the same time as the data team. This makes projects much more efficient.
