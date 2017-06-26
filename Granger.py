# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

 -*- coding: utf-8 -*-
"""
Created on Fri Jun 23 11:48:15 2017

@author: makyol
"""

import pandas as pd
import matplotlib.pyplot as plt
import random


plt.style.use('ggplot')
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.stattools import grangercausalitytests
import numpy as np

item30 = pd.read_csv("backtesting_june_16Item30.csv", index_col=0)
item31 = pd.read_csv("backtesting_june_16Item31.csv", index_col=0)

nStocks = 30
nWeeks  = 260

item30 = pd.DataFrame(np.random.randn(nWeeks, nStocks))
item31 = pd.DataFrame(np.random.randn(nWeeks, nStocks))

rating = item30[28]
price =item31[28]

rating.plot()
price.plot()

result = adfuller(rating)
print('ADF Statistic: %f' % result[0])
print('p-value: %f' % result[1])
print('Critical Values:')
for key, value in result[4].items():
	print('\t%s: %.3f' % (key, value))
    
C=np.column_stack((rating,price))
    
result = grangercausalitytests(C,10, addconst=True)    

C=np.column_stack((price,rating))
    
result["1"] = grangercausalitytests(C,10, addconst=True, verbose=False) 
test=result['1'][1][1][2][0][1]
granger_score= result["1"]


D = {"Key1": (1,2,3), "Key2": (4,5,6)}
>>> D["Key2"][2]

tup1 = ('physics', 'chemistry', 1997, 2000);
tup2 = (1, 2, 3, 4, 5, 6, 7 );

print (tup1[0])
print "tup2[1:5]: ", tup2[1:5]