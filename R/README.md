# FORECASTING RICE MONTHLY PRICE - MALAYSIAN RINGGIT PER METRIC TON USING TIME SERIES ANALYSIS

### Description of Dataset
This study aims to utilize the dataset of monthly rice prices in Malaysian Ringgit to gain insights into the trends and patterns of rice prices over the examined period from January 2014 to December 2022.
The dataset was retrieved from the website IndexMundi: https://www.indexmundi.com/commodities/?commodity=rice&months=120&currency=myr
This study split the original dataset into an estimation (training) dataset and an evaluation dataset. The estimation (training) dataset consisted of 96 observations from January 2014 to December 2021. On the other hand, the evaluation (testing) dataset comprised 12 observations, covering the period from January 2022 to December 2022.

### Original Dataset

![](https://github.com/hidayahkhamsani/Project/blob/main/R/Original%20data%20Plot.png?raw=true)
                     
                      Figure 1: Time Series Plot Original Dataset 

The time series plot above displays occasional fluctuations in the monthly rice price per metric ton over nine years. These fluctuations reflect short-term variations, indicating that the price is not consistent throughout the period. Additionally, the plot indicates a noticeable upward trend, suggesting that the rice price generally increases over time.

## Transformation Data

1) Split the original dataset into an estimation (training) dataset and an evaluation dataset. The estimation (training) dataset consisted of 96 observations from January 2014 to December 2021. On the other hand, the evaluation (testing) dataset comprised 12 observations, covering the period from January 2022 to December 2022.
2) Check the stationarity of the data by using the ADF test and correlogram plot (ACF and PACF plot).

![](https://github.com/hidayahkhamsani/Project/blob/main/R/ACF%26PACF%20(estimation%20data)%20%26%20plot%20after%201st%20Diff.png?raw=true)
               
                Figure 2: ACF and PACF Plot for Estimation Part & Time Series Plot of the Dataset After First Difference

The ACF plot illustrates the general correlation pattern and also checks the stationary of data. While the PACF plot helps to identify the direct relationships between observations at different lags. By examining the significant lags in the ACF and PACF plots, informed decisions can be made about the appropriate time series models, such as autoregressive (AR) and moving average(MA) models. Based on Figure 2, the ACF plot displays numerous lags exhibiting the bend and a gradual decay pattern, whereas the PACF plot does not. Thus, the ACF plot also shows that the time series data is not stationary and there are significant correlations exist. Based on the p-value ADF test (0.2696), it exceeds the significance level of 0.05. This suggests that the data is non-stationary. Thus, in this study transform the dataset by using differencing. After transforming the dataset, a time series plot of the monthly rice price after first differencing reveals that the data fluctuates around a constant mean, indicating stationarity. The fluctuations in the plot indicate that the rice price does not exhibit any long-term or systematic trends, suggesting a stable and stationary behaviour over time. Next, based on the p-value ADF test (0.01) after the first differencing, it did not exceed the significance level of 0.05. This suggests that the data is non-stationary.

![](https://github.com/hidayahkhamsani/Project/blob/main/R/ACF%20%26%20PACF%20plot%20After%20Differencing.png?raw=true)
            
              Figure 3: ACF and PACF Plot After First Difference

From Figure 3, the ACF plot indicates that 2 lags are outside of the confidence bands. PACF plot also shows 1 lag exceeding the confidence bands and the rest of the correlation lies between the confidence bands. This study utilizes the ARIMA model with initial parameters set as AR(1) and MA(2). The suggestions to fit the model are ARIMA(1,1,2), ARIMA(1,1,1), ARIMA(1,1,0), ARIMA(0,1,1) and ARIMA(0,1,0).

##  Model Selection

![](https://github.com/hidayahkhamsani/Project/blob/main/R/Table%20Arima%20Model.png?raw=true)

              Figure 4: Table ARIMA model selection

Figure 4 shows the evaluation metrics and Box-Pierce Test results for all ARIMA models. ARIMA(1,1,2) outperformed all the other models. ARIMA(1,1,2) has the highest log-likelihood and smallest RMSE value. Even though the AIC and BIC values for the ARIMA(1,1,2) model are not the smallest, the values are nearly identical to other models. Hence, ARIMA(1,1,2) is chosen as the best model for forecasting the monthly rice price. The Box-Pierce test indicates that the model has no autocorrelation problem since the p-value is more than 0.05. 

![](https://github.com/hidayahkhamsani/Project/blob/main/R/forecast%20graph.png?raw=true)     

![](https://github.com/hidayahkhamsani/Project/blob/main/R/Table%20Future%20Forecast%202023.png?raw=true)


          Figure 5: Forecast Table and Plot

In conclusion, it is expected that the rice price will rise in 2023.            
















