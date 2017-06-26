install.packages("swirl")
library(swirl)
swirl
install.packages("swirlify")
library(swirlify)


install_course_zip("C:\\Users\\test\\Downloads\\14_740x_Intro_to_R.zip",multi=FALSE)
swirl()

# READ QUARTERLY DATA FROM CSV
PercRatingUpgrades <- read_csv("~/Zaggle/backtesting_june_16Item30.csv")
PercChangePriceWeek <- read_csv("~/Zaggle/backtesting_june_16Item31.csv")

nStocks <-30
nWeeks<-260

PercRatingUpgrades= matrix(rep(c(rnorm(nWeeks,0,1)),times=nStocks),nrow=nWeeks,ncol=nStocks)
PercChangePriceWeek= matrix(rep(c(rnorm(nWeeks,0,1)),times=nStocks),nrow=nWeeks,ncol=nStocks)



rating = ts(PercRatingUpgrades[,27], start=2012, freq=52)      # yearly temp in col 2
price = ts(PercChangePriceWeek[,27], start=2012, freq=52)      # yearly temp in col 2

par(mfrow=c(2,1))
plot(rating)                                # graph the series (not shown here) 
plot(price)

adf.test(rating)
adf.test(price)


#plot(diff(log(rating)))
#plot(diff(log(price)))
#adf.test(diff(log(rating)))
#adf.test(diff(log(price)))



# METHOD 1: LMTEST PACKAGE
library(lmtest)
p_value=grangertest(rating,price,1)
p_value=grangertest(price,rating,1)
# Granger causality test
#
# Model 1: unemp_rate ~ Lags(unemp_rate, 1:1) + Lags(hpi_rate, 1:1)
# Model 2: unemp_rate ~ Lags(unemp_rate, 1:1)
#   Res.Df Df      F  Pr(>F)
# 1     55
# 2     56 -1 4.5419 0.03756 *
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# METHOD 2: VARS PACKAGE
library(vars)
var <- VAR(ts2, p = 1, type = "const")
causality(var, cause = "hpi_rate")$Granger
#         Granger causality H0: hpi_rate do not Granger-cause unemp_rate
#
# data:  VAR object var
# F-Test = 4.5419, df1 = 1, df2 = 110, p-value = 0.0353

# AUTOMATICALLY SEARCH FOR THE MOST SIGNIFICANT RESULT
for (i in 1:4)
{
  cat("LAG =", i)
  print(causality(VAR(ts2, p = i, type = "const"), cause = "hpi_rate")$Granger)
}