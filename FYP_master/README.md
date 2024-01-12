#   FINANCIAL STATEMENT FRAUD DETECTION IN PUBLIC LISTED COMPANIES 

### Background of Study
<p style="text-align: justify;">
The pressure of environmental work causes the increasing fraud cases in Malaysia, the opportunity to excel the performance profit and rationalization. Types of fraud are asset misappropriation, corruption and fraudulent financial statements. Asset misappropriation (16%), bribery and corruption (18%), financial fraud (20%), and cybercrime (16%) are the types of fraud that Malaysian companies have said have caused them the most trouble or damage in the last two years (PwC, 2020).
</p>

### Problem Statement
<p style="text-align: justify;">
The presence of financial statement fraud is hard to detect since it is hidden from the public, accountants and regulators. A little research on this issue compares the important proxies  using feature selection which is to minimize the number of input variables when building the predictive model. Limited studies on utilizing random forest model to detect and predict false financial reporting since most studies in Malaysia used regression analysis. Down below are the research questions and objectives.
  
  ![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Research%20Question%20and%20Objective.png?raw=true)             
</p>
###Data of Study
<p style="text-align: justify;">
Secondary data was collected from the Bursa Malaysia website. The secondary data focuses on annual reports of publicly listed companies in a few sectors from 2012 to 2022.  The secondary data randomly chose four companies using the random generator for each sector (manufacturing, services, agriculture and construction), and the total dataset is 220. The company's name will not be revealed due to ethics. 16 attributes will be used in this study.
  
  ![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Description%20of%20Dataset.png?raw=true) 
             
              Table 1: Description of Dataset
</p>

### Methodology

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Methodology%20Framework.png?raw=true) 
             
              Table 2: Research Methodology Framework

<p style="text-align: justify;">
Secondary data from the Bursa website is used in data collection. Next, this study used the data collection to figure out the variable measurement for proxy in the pressure, opportunity and rationalization in the triangle theory which are financial stability, leverage, financial target, liquidity, the number of audit committees and auditor changes. The Beneish’s M-score variable measurement must be calculated using collected data to determine whether a company's presence is fraud or vice versa. The independent variables used in this study are financial stability, leverage, financial target, liquidity, number of audit committees and auditor changes. The binary dependent variable used in this study is the presence of financial statement fraud. Next, check and fulfil the assumptions of the logistic regression model before starting the analysis. A logistic regression analysis test is used to investigate proxies that affect the presence of financial statement fraud. The proxy is significant if the p-value is less than 0.05.
For comparison classification method between the logistic regression model and the random forest model, RapidMiner software was used in this study. In data preparation, use select attributes, map, set role, normalize, detect outliers (distance) and Synthetic Minority Over-Sampling Technique (SMOTE) upsampling for data ready for analysis. As for the feature selection, utilize three wrapper methods which are backward elimination, forward selection and optimize selection. Next, the dataset will be split into two stages which are 0.8 for training the dataset and 0.2 for testing the dataset. In model evaluation, use the logistic regression model and random forest model to compare the confusion matrix (accuracy, sensitivity, specificity, precision) and receiver operating characteristic (ROC) curve to determine the best classification method for financial statement fraud detection in a few sectors of public listed companies in Malaysia.
</p>
#### Variable Measurement
Data of concern in the annual report of the company in Table 1 used for triangle theory and Beneish’s M-score measurement.

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Calculation%20Triangle%20Theory.png?raw=true) 
             
              Table 3: Calculation of Triangle Theory
              
![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Calculation%20of%20M-scorel.png?raw=true) 
             
              Figure 1: Calculation of Beneish Model  

### Result and Discussion
<p style="text-align: justify;">
  
#### Objective 1: To identify the presence of fraud in companies’ annual reports using the Beinish model. 
By using the M-score formula from Figure 1, if the M-score is higher than -2.22, companies are detected committing fraud.
  
![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/Result%201.png?raw=true) 
             
    Table 4: Distribution Presence of Financial Statement Fraud Companies Among Sector  

After implementing the M-score rule, it determined that 119 companies are not suspected of committing fraud in their financial statements. It indicates that approximately 45% of the samples manipulate their financial statements.

#### Objective 2: To investigate the significant proxies affecting the presence of financial statement fraud.
Check the assumptions of logistic regression analysis.

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/result%204.png?raw=true) 
             
    Figure 2: Linearity of Scatter Plot After Remove Outliers

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/result%205.png?raw=true) 
             
    Table 5: Assumption of Multicollinearity After Remove Outliers

After checking the outliers by using Cook’s distance plot, there were 17 outliers from the dataset. Remove the outliers from the dataset. Figure 2 shows that variables financial stability, leverage, financial target, liquidity and number of commissioners are all quite linearly associated with the presence of fraud outcome in the logit scale after removing outliers. No multicollinearity exists and the sample size is 203 after removing outliers. After checking the assumptions, analyze the dataset by using logistic regression analysis to achieve the second objective.

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/result%206.png?raw=true) 
             
    Table 6: Logistic Regression Analysis
    
Table 6 shows the logistic regression analysis results, and the logistic regression model equation is as follows:
ln (p/1-p) = -0.8087 + 4.6681 financial stability - 1.1473 leverage - 0.3228 financial target + 0.0387 liquidity + 1.2888 number of audit committees + 0.3873 auditor changes
From the result, it can be concluded that only one proxy from the pressure element of triangle theory (AGROW) is significant out of 6 proxies since the p-value (0.05) is less than the significance level which is 0.004. Thus, only financial stability is the proxies that affecting the presence of financial statement fraud. Financially unstable companies may feel pressure to meet market demands and maintain a good reputation. This pressure can lead to financial statement fraud in an attempt to appear stable and satisfy stakeholders.

#### Objective 3: To determine the best classification method for financial statement fraud detection in a few sectors of public listed Malaysian companies.

In this result, Rapidminer software was used to analyze the dataset to achieve the third objective and important attributes.

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/result%207.png?raw=true) 
             
    Table 7: Summary of Important Attributes

Table 7 shows that financial stability is the most important proxies for the presence of financial statement fraud. Based on both models, the variables of auditor changes, financial stability and leverage are identified as common proxies that consistently appear as important for the presence of financial statement fraud.

![](https://github.com/hidayahkhamsani/Project/blob/main/FYP_master/result%208.png?raw=true) 
             
    Table 8: Summary of Performance Measures for All Model

From Table 8, Random Forest using backward elimination is the best model based on the percentage performance measure of the confusion matrix and ROC curve. The non-parametric models have higher accuracy than parametric models. This is because of the ability of the random forest model to handle complex data and is less prone to overfitting than logistic regression (Liu et al.,2017).
</p>





