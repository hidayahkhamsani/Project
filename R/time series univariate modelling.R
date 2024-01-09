library(readxl)
rice=read_excel(file.choose())
str(rice)
summary(rice)

# Load the tseries package
library(tseries)

# Checking dataset
str(rice)
rice.ts <- ts(rice$Price, start = 2014, frequency = 12)
summary(rice.ts)
str(rice.ts)
plot(rice.ts, col = "purple", main = "Rice Monthly Price in Malaysian Ringgit per
Metric", xlab = "Year", ylab = "Malaysian Ringgit per Metric Ton")

# Convert 'Date' column to Date object
rice$Date <- as.Date(paste("01", rice$Month, sep = "-"), format = "%d-%b-%Y")

# Split the time series data into training (2014-2021) and testing (2022) sets
rice_train <- window(rice.ts, end = c(2021, 12))
rice_test <- window(rice.ts, start = c(2022, 1), end = c(2022, 12))

# Summary or check dimensions of the created datasets
summary(rice_train)
summary(rice_test)

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
#0.2696>0.05

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

library(forecast)

# Fit an automatically assigned ARIMA model
M1 <- arima(FD, order = c(1,1,0))
summary(M1)
BIC(M1)
Box.test(M1$residuals)


# Fit an automatically assigned ARIMA model
M2 <- arima(FD, order = c(0,1,0))
summary(M2)
BIC(M2)
Box.test(M2$residuals)

# Fit an automatically assigned ARIMA model
M3 <- arima(FD, order = c(1,1,2))
summary(M3)
BIC(M3)
Box.test(M3$residuals)

# Fit an automatically assigned ARIMA model
M4 <- arima(FD, order = c(1,1,1))
summary(M4)
BIC(M4)
Box.test(M4$residuals)

# Fit an automatically assigned ARIMA model
M5 <- arima(FD, order = c(0,1,1))
summary(M5)
BIC(M5)
Box.test(M5$residuals)

#M5 will be used for forecasting
# Forecast future values using the ARIMA model 'M3'
future_forecast <- forecast(M5, h =24)  # Change 'h' to the number of future periods to forecast
summary(future_forecast)

# Plot the forecasted values
plot(future_forecast, main = "Forecasted Values", xlab = "Time", ylab = "Values")

