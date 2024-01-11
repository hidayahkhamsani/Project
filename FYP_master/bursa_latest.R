bursa <- read.csv(file.choose(), header = TRUE)
head(bursa)
str(bursa)

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

##checking outliers
boxplot(bursa)
plot(model_1,which = 4, id.n = 6)

##checking outliers
dim(bursa)
# Calculate z-scores for each variable in the dataset
z_scores <- apply(bursa, 2, function(x) scale(x))
# Determine the threshold for considering outliers (e.g., z-score > 3)
threshold <- 3
# Identify the outliers based on the threshold
outlier_indices <- which(abs(z_scores) > threshold, arr.ind = TRUE)
filtered_bursa <- bursa[-outlier_indices, ]
dim(filtered_bursa)

# Select specific columns from the original data frame
num_bursa <- bursa[c("AGROW", "DR", "ROA", "WCTA", "num..commisioners")]

# Create the boxplot 
library(gridExtra)
num_bursa_long <- gather(num_bursa, key = "variable", value = "value")
par(mfrow = c(1, 2))
boxplot_before <- ggplot(num_bursa_long, aes(x = variable, y = value)) +
  geom_boxplot() +
  labs(x = "Numerical Proxies", y = "Value") +
  ggtitle("Boxplot Before Removing Outliers") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

boxplot_after <- ggplot(num_bursa_long, aes(x = variable, y = value)) +
  geom_boxplot(outlier.shape = NA) +
  labs(x = "Numerical Proxies", y = "Value") +
  ggtitle("Boxplot After Removing Outliers") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)

grid.arrange(boxplot_before, boxplot_after, ncol = 2)

##checking linearity between continuous var and logit after remove outliers
model_2 <- glm(Presence.of.fraud ~ auditor.changes + num..commisioners + AGROW + DR + ROA + WCTA,data = filtered_bursa, family = binomial)
library(ggplot2)
library(car)
probabilities=predict(model_2, type = "response")
logit=log(probabilities/(1-probabilities))
library(ggplot2)
ggplot(filtered_bursa, aes(logit, DR))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(filtered_bursa, aes(logit, num..commisioners))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(filtered_bursa, aes(logit, AGROW))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(filtered_bursa, aes(logit, ROA))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()
ggplot(filtered_bursa, aes(logit, WCTA))+
	geom_point(size=0.5, alpha=0.5) +
	geom_smooth(method = "loess") + 
	theme_bw()

##check multicollinearity
library(car)
require(car)
vif(model_2)


#correlation analysis
library(Hmisc)
cor(filtered_bursa)


library(lmtest)
lrtest(model_2)
summary(model_2)


library(ResourceSelection) 
#The Hosmer and Lemeshow Test
hl_gof <- hoslem.test(filtered_bursa$Presence.of.fraud, fitted(model_2), g = 10)
hl_gof


library(rms)
#Omnibus Test
logit2.res <- lrm(Presence.of.fraud ~ auditor.changes + num..commisioners + AGROW + DR + ROA + WCTA,data = filtered_bursa, y = TRUE, x = TRUE)
gof_residuals <- residuals(logit2.res, type = "gof")
gof_residuals

#Cox & Snell R^2; Nagelkerke R^2
rsquared <- function(created_model) {
  dev <- created_model$deviance
  null_dev <- created_model$null.deviance
  model_n <- length(created_model$fitted.values)
  R_l <- 1 - dev / null_dev
  R_cs <- 1 - exp(-(null_dev - dev) / model_n)
  R_n <- R_cs / (1 - exp(-(null_dev / model_n)))
  cat("Pseudo R-squared for logistic regression model\n\n")
  cat("Hosmer and Lemeshow R-squared\t", round(R_l, 3), "\n")
  cat("Cox and Snell R-squared\t\t\t", round(R_cs, 3), "\n")
  cat("Nagelkerke R-squared\t\t\t\t", round(R_n, 3), "\n")
}

rsquared(model_2)



