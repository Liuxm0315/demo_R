library(ggplot2)
library(ggjoy)

ggplot(diamonds, aes(x=price, y=color, fill=color,
       group=color, height=..density..)) +
     geom_joy(scale=4) +
     scale_y_discrete(expand=c(0.01, 0)) +
     scale_x_continuous(expand=c(0, 0)) +
     theme_joy()
ggplot(mat_D, aes(x=POS, y=Cancer, group=Cancer, height=Count, fill=Cancer)) + geom_joy(stat = "identity", scale = 3,panel_scaling=F) + sca> _x_continuous()

