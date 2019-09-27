library(tidyverse)


# Change here with your own dataset namek
data <- read.csv("C:/Users/corwinlab/Desktop/Mikolaj's 880 Images/Data to analyze/19.01.30 Adults Belts Axiovert/EC/1/Medial/32.csv")
# Change here with your own dataset name

#black box and run them all----
names(data) <- c("V1", "V2") 

ggplot(data, aes(V1/21,V2)) + geom_line()
ggplot(data, aes(V1/21,V2)) + stat_smooth(method = "loess", span = 0.2, se = FALSE)
p <- ggplot(data, aes(V1/21,V2)) + stat_smooth(method = "loess", span = 0.2, se = FALSE)  
pg <- ggplot_build(p)
p[["data"]]
write.csv(pg[["data"]], file = "pg.csv")
pgload <- read.csv("pg.csv")
pgload
ggplot(pgload, aes(x,y)) + geom_line()

deriv <- diff(pgload$y) / diff(pgload$x)
times <- (pgload$x[-1] + pgload$x[-nrow(pgload)])/2 
ddata <- cbind.data.frame(pgload[-1,], times, deriv)
ggplot(ddata, aes(times, deriv)) + 
  geom_line(aes(y=y, color="#AD002D")) +
  geom_line(aes(y=deriv, color="#005B98")) +
  xlab("Length (um)") +
  ylab("Intensity")


write.table(ddata, file="ddata.csv")

min <- min(ddata$deriv)
max <- max(ddata$deriv)

end <- filter(ddata, deriv == min)
beginning <- filter(ddata, deriv == max)
end-beginning