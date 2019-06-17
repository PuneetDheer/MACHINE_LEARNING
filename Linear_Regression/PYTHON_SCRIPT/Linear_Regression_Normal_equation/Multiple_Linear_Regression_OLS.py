"""
Coded By: Puneet Dheer
Date:4-Jan-2019
"""

import numpy as np
import pandas as pd


def multiple_linear_regression(X, Y):
    
    X = np.insert(X,0,np.ones(1), axis = 1) # insert one's in 1st column for intercept
    coefficients = np.linalg.inv(X.T.dot(X)).dot(X.T).dot(Y)
    predicted = X.dot(coefficients)
    
    return coefficients, predicted


def mse_metric(actual, predicted):
    # Mean square error
    
    error = actual - predicted
    mse = np.mean(np.square(error), axis = 0) # assuming the mean of error is zero ~N(0,var)
    
    return mse


def mae_metric(actual,predicted):
    
    # Mean absolute error
    error = np.abs(actual - predicted)
    mae = np.mean(error, axis = 0)
    
    return mae


def goodness_of_fit(actual, predicted):
    
    explained_variance = np.sum(np.square(predicted - np.mean(actual) )) # sum of squared regression
    unexplained_variance = np.sum(np.square(actual - predicted)) # sum of squared error(residuals)
    total_variance = explained_variance + unexplained_variance
    R_square = 1-(unexplained_variance / total_variance)
    
    return R_square


if __name__ == "__main__":
    
    dataset = pd.read_csv('Sample_Data_MLR.csv', header = 0) # dataset column wise
    
    X = dataset.iloc[:, 0:-1].values # independent variable
    Y = dataset.iloc[:, 4:5].values # dependent variable
    
    if (Y.shape==(len(Y),1)):
        pass
    else:
        Y = Y.reshape(len(Y),1)
    
    coefficients,predicted = multiple_linear_regression(X, Y)
    
    print "MS Error: \n", mse_metric(Y, predicted)
    print "RMS Error: \n", np.sqrt(mse_metric(Y, predicted))
    print "MA Error: \n", mae_metric(Y, predicted)
    print "Goodness-of-fit: \n", goodness_of_fit(Y, predicted)
    print "Coefficients: \n", coefficients
    
