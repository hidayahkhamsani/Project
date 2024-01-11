bursa <- read.csv(file.choose(), header = TRUE)
head(bursa)
str(bursa)

# Calculate mean and standard deviation by group
library(dplyr)
WCTA_summary <- bursa %>%
  group_by(Presence.of.fraud) %>%
summarise(mean = mean(WCTA),
            sd = sd(WCTA),
		min= min(WCTA),
		max= max(WCTA))

# View the summary
print(WCTA_summary)
colnames(bursa)

## check dependent variable is binary
View(bursa)

## check sample size
dim(bursa)

## check multicollinearity
model_1 <- glm(Presence.of.fraud ~ auditor.changes + num..commisioners + AGROW + DR + ROA + WCTA,data = bursa, family = binomial)
library(car)
require(car)
vif(model_1)

##checking linearity between continuous variable and logit dependent variable
library(ggplot2)
library(car)
probabilities=predict(model_1, type = "response")
logit=log(probabilities/(1-probabilities))
library(ggplot2)
ggplot(bursa, aes(logit, DR))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(bursa, aes(logit, num..commisioners))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(bursa, aes(logit, AGROW))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(bursa, aes(logit, ROA))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(bursa, aes(logit, WCTA))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
summary(model_1)

##checking outliers
boxplot(bursa)
plot(model_1,which = 4, id.n = 6)

#export data
write.table(filtered_bursa, file ="ExportedBursa.csv", sep=",")
