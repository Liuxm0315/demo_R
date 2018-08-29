link = "http://img.dafont.com/dl/?f=wm_people_1";
download.file(link, "wmpeople1.zip", mode = "wb");
unzip("wmpeople1.zip");

library(showtext);
font.add("wmpeople1", "wmpeople1.TTF");

library(ggplot2);
library(plyr);
library(Cairo);

dat = read.csv(textConnection('
 edu,educode,gender,population
 N,1,m,17464
 N,1,f,41268
 P,2,m,139378
 P,2,f,154854
 M,3,m,236369
 M,3,f,205537
 H,4,m,94528
 H,4,f,70521
 U,5,m,57013
 U,5,f,50334
'));


pdf("draw.pdf")
showtext.begin();
theme_set(theme_grey(base_size = 15));
ggplot(gdat, aes(x = x, y = educode)) +
    geom_text(aes(label = char, colour = gender),
              family = "wmpeople1", size = 8) +
    scale_x_continuous("People no.") +
    scale_y_discrete("edu",
        labels = unique(dat$edu[order(dat$educode)])) +
    scale_colour_hue(guide = FALSE) +
    ggtitle("2012 population");
showtext.end();
dev.off()

