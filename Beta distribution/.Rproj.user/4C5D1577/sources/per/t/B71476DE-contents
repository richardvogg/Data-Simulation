### The many faces of the Beta distribution

library(gt)
library(ggplot2)
library(dplyr)

#These are the parameters we are comparing
alpha <- c(0.5,1,2,8)
beta <- c(0.5,1,2,8)

#All combinations, but I filter some of them because their
#densities look very similar
combs <- expand.grid(alpha,beta) %>%
  rename(alpha=Var1,beta=Var2) %>%
  arrange(desc(alpha==beta),desc(alpha<beta)) %>%
  filter(!(alpha==0.5&beta>1),!(alpha>1&beta==0.5))


#This function plots the Beta distribution for a given combination
#of parameters alpha and beta
#Example: plot_group(5,2) - the line is very thick, but in the final
#table it will look much thinner.

plot_group <- function(alpha,beta){
  x <- seq(0,1,0.01)
  data <- data.frame(x=x,y=dbeta(x,alpha,beta))
  
  plot_object <- ggplot(data = data, aes(x = x, y = y,group=1)) +
    geom_area(color = "#7C7287",fill="goldenrod", size = 8) +
    theme_void()
  return(plot_object)
}

#Adding the plots for each combination
final <- combs %>%
  group_by(alpha,beta) %>%
  mutate(plot = purrr::map2(alpha,beta, plot_group))

#Using html(&alpha;) to produce the greek sign in the table.
#We are adding tab rows to add structure
#In the last step we add the density plots with text_transform()
#to the column ggplot

combs %>% 
  mutate(ggplot = NA) %>% 
  gt() %>% 
  tab_header(title = html("<b>The different faces of the  <br> Beta distribution </b>"),
             subtitle = html("Parameter choices for &alpha; and &beta; and corresponding  <br>
                             density bounded between 0 and 1")) %>%
  tab_row_group(group="smaller beta",rows=alpha>beta) %>%
  tab_row_group(group="smaller alpha",rows=alpha<beta) %>%
  tab_row_group(group="equal alpha and beta",rows=alpha==beta) %>%
  fmt_number(columns=vars(alpha,beta),decimals = 1,drop_trailing_zeros = TRUE) %>%
  cols_label(ggplot = "",alpha=html("&alpha;"),beta=html("&beta;")) %>% 
  tab_footnote(footnote =  html("f(x;&alpha;,&beta;)=B(&alpha;,&beta;)<sup>-1</sup>x<sup>&alpha;</sup> (1-x)<sup>&beta;</sup>, <br> 
                                where the Beta function B is a normalizing constant <br> 
                                to ensure that the total probability is 1."), 
                                locations = cells_title(groups="subtitle")) %>%
  text_transform(locations = cells_body(columns = vars(ggplot)),
                 fn = function(x) {purrr::map(final$plot, ggplot_image, height = px(20), aspect_ratio = 5)}) %>%
  gtsave("index.html", path = here::here())
