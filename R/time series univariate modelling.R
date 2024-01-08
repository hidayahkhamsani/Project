library(readxl)
rice=read_excel(file.choose())
str(rice)
summary(rice)

# Install the tseries package (run this only if you haven't installed it before)
install.packages("tseries")

# Load the tseries package
library(tseries)

# Checking dataset
rice.ts <- ts(rice$Price, start = 2014, frequency = 12)
summary(rice.ts)
str(rice.ts)
plot(rice.ts, col = "purple", main = "Rice Monthly Price in Malaysian Ringgit per
Metric", xlab = "Year", ylab = "Malaysian Ringgit per Metric Ton")

# Define the end of the training dataset (end of 2022)
end_train <- end(rice.ts) - 1  # Set to the end of 2022

# Create training dataset (2014-2021)
rice_train <- window(rice.ts, end = end_train)

# Create test dataset (year 2022)
rice_test <- window(rice.ts, start = end_train + 1)


#check collelogram
win.graph()
par(mfrow=c(1,3))
acf(rice_train, main = "ACF plot for Estimation Part", lag.max= 60)
pacf(rice_train, main = "PACF plot for Estimation Part", lag.max= 60)

#check autocorrelation
Box.test(rice_train, lag=30, type='Ljung-Box') 

#normality
shapiro.test(rice_train)

# Augmented Dickey-Fuller test
adf.test(rice_train)
#time series dataset not stationary. Transform data into log/ differencing to make dataset stationary
#0.4258>0.05

# First Difference
FD <- diff(rice_train)
# Plot and add a horizontal line at y = 0
plot(FD,type='l', main = "First Differencing", col = "purple")
abline(h = 0, col = "blue", lty = 2)

# Augmented Dickey-Fuller test
adf.test(FD)
#stationary since 0.01<0.05

#check autocorrelation
Box.test(FD, lag=30, type='Ljung-Box')

#check collelogram
win.graph()
par(mfrow=c(1,3))
acf(FD, main = "ACF plot After First Differencing", lag.max= 60)
pacf(FD, main = "PACF plot After First Differencing", lag.max= 60)
#From the plot, AR(1) from PACF while MA(2) from ACF. Max ARIMA (1,1,2)

install.packages("forecast")
library(forecast)

# Fit an automatically assigned ARIMA model
M1 <- arima(FD, order = c(1,1,0))
s1=summary(M1)
BIC_value <- BIC(M1)
Box.test(M1$residuals)
#AIC= 1213.83 #BIC= 1219.041	#log likelihood = -604.92 #RMSE = 101.9652  #Box-Pierce Test = 0.3673 


# Fit an automatically assigned ARIMA model
M2 <- arima(FD, order = c(0,1,0))
s2=summary(M2)
BIC_value <- BIC(M2)
Box.test(M2$residuals)
#AIC= 1224.13 #BIC=  1226.74	#log likelihood = -611.07 #RMSE = 108.501  #Box-Pierce Test = 0.0005936

# Fit an automatically assigned ARIMA model
M3 <- arima(FD, order = c(1,1,2))
s3=summary(M3)
BIC_value <- BIC(M3)
Box.test(M3$residuals)
#AIC= 1179.72 #BIC= 1190.141	#log likelihood = -585.86 #RMSE = 82.51898 #Box-Pierce Test = 0.9077

# Fit an automatically assigned ARIMA model
M4 <- arima(FD, order = c(1,1,1))
s5=summary(M4)
BIC_value <- BIC(M4)
Box.test(M4$residuals)
#AIC= 1178.32 #BIC= 1186.134	#log likelihood = -586.16 #RMSE = 82.79281  #Box-Pierce Test = 0.9024 

# Fit an automatically assigned ARIMA model
M5 <- arima(FD, order = c(0,1,1))
s5=summary(M5)
BIC_value <- BIC(M5)
Box.test(M5$residuals)
#AIC= 1179.38 #BIC= 1184.587	#log likelihood = -587.69 #RMSE = 83.92251  #Box-Pierce Test = 0.1011 


#M3 will be used for forecasting
# Forecast future values using the ARIMA model 'M3'
future_forecast <- forecast(M3, h =12)  # Change 'h' to the number of future periods to forecast
summary(future_forecast)

# Plot the forecasted values
plot(future_forecast, main = "Forecast using ARIMA Model M3")

