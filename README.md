# CritColors <img src="https://pbs.twimg.com/profile_images/981201429053497344/l5aYYID5_400x400.jpg" align="right" alt="" width="120" />
Color palette for the Crit Lab corporation

![](../master/figures/colorgradient.jpg)


## Installation

You can install `critcolors` from this GitHub repository by typing the following lines in your R 
console:

```{r}
if (!require("devtools")) 
  install.packages("devtools")
devtools::install_github("cecilomar6/critcolors")
library(critcolors)
```
---

## Examples

```{r}
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col = Petal.Length ))+
  geom_point()+
  scale_color_critcolors()
```
![](../master/figures/example2.png)

```{r}
volcano <- data.frame(
       x = rep(seq_len(ncol(volcano)), each = nrow(volcano)),
       y = rep(seq_len(nrow(volcano)), ncol(volcano)),
       height = as.vector(volcano)
   )
ggplot(volcano, aes(x = x, y = y, fill = height)) + 
       geom_raster() + 
       scale_fill_critcolors()
```
![](../master/figures/example3.png)


```{r}
ggplot(mpg, aes(x=class, y=hwy))+ 
  geom_boxplot(outlier.colour = NA, position = "dodge", alpha = 0.3) +
  geom_jitter(aes(color = class), width = 0.3) +
  xlab("Class") + ylab("Highway miles per gallon")+
  scale_color_critcolors(discrete = TRUE)
```

![](../master/figures/example1.png)
---

## References

The code for `critcolors` was adapted from the package `viridis` developed by Simon Garnier and contributors.


