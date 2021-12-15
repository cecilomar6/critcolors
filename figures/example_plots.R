
library(critcolors)
library(ggplot2)

## Color gradient

plot(rep(1,100),col=(critcolors(100)), pch=15,cex=20, axes = F, ylab =NA, xlab = NA)


## Example 1 

ggplot(mpg, aes(x=class, y=hwy))+ 
  geom_boxplot(outlier.colour = NA, position = "dodge", alpha = 0.3) +
  geom_jitter(aes(color = class), width = 0.3) +
  xlab("Class") + ylab("Highway miles per gallon")+
  scale_color_critcolors(discrete = TRUE)


## Example 2

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col = Petal.Length ))+
  geom_point()+
  scale_color_critcolors()
