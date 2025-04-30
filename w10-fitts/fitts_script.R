library(ggplot2)

data <- read.csv(file="fittsData_allParticipants.csv", header=T, sep=",")

#Convert correct to boolean. 
data$correct <- as.logical(data$correct)

# Calculate index of difficulty (ID), round to 2 decimal places. 
data$ID.F <- log2(2*data$amplitude/data$width)

# Calculate the Shannon ID (ID.S), round to 2 decimal places. 
data$ID.S <- log2(data$amplitude/data$width + 1)

# Calculate mean task completion time by condition for correct trials. 
mean.time <- aggregate(time~amplitude+width+ID.F+ID.S, data[data$correct, ], mean)
print(mean.time)

# Generate Fitts’s model 
model.Fitts <- lm(time ~ ID.F, mean.time)
summary(model.Fitts)$r.squared #find R^2

# Generate Shannon model 
model.shannon <- lm(time ~ ID.S, mean.time)
summary(model.shannon)$r.squared #find R^2 

#Plot both models 
ggplot(mean.time, aes(y = time)) + # Specify data source and y axis 
  geom_point(aes(x = ID.F),          # Add points for Fitts’model 
             shape = 1) +                       # Use hollow circles 
  geom_point(aes(x = ID.S),          # Add points for shannon model 
             shape = 1) +                       # Use hollow circles 
  geom_smooth(aes(x = ID.F,          # Regression line for Fitts’model 
                  colour="Fitts"),                   # Set colour via label 
              method = lm,                       # calculate using linear model 
              se = FALSE) +                      # [optional] Shaded confidence region 
  geom_smooth(aes(x = ID.S,          # Regression line for Shannon model 
                  colour="Shannon"),                 # Set colour via label 
              method = lm,                       # calculate using linear model 
              se = FALSE) +                      # [optional] Shaded confidence region 
  scale_colour_manual("Formulation", # Add Legend, set legend title 
                      values = c("Shannon"="green",      # Set colours to assigned labels 
                                 "Fitts"="blue")) + 
  expand_limits(y = 0) +             # Start y-axis from 0 
  ylab(label="Mean Time") +          # Label y axis 
  xlab("Index of Difficulty (ID)")   # Label x-axis