"""
Coded By: Puneet Dheer
Date:2-Jan-2019
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


def variance(X):
    
    X_var = np.sum(np.square(X - np.mean(X) ))
    
    return X_var


def covariance(X, Y):
    
    X_var = (X - np.mean(X))
    Y_var = (Y - np.mean(Y))
    cov = np.sum(X_var * Y_var)
    
    return cov


def coeffs(X, Y):
    
    slope = covariance(X, Y) / variance(X)
    intercept = np.mean(Y) - (slope * np.mean(X))
    
    return slope, intercept


def simple_linear_regression(X, Y):
    
    slope,intercept = coeffs(X, Y)
    coeff = np.array([intercept, slope])
    predicted = (slope * X) + intercept
    
    return coeff, predicted
    

def mse_metric(actual, predicted):
    
    # Mean square error
    error = actual - predicted
    mse = np.mean(np.square(error), axis = 0) # assuming the mean of error is zero ~N(0,var)
    
    return mse


def mae_metric(actual, predicted):
    
    # Mean absolute error
    error = np.abs(actual - predicted)
    mae = np.mean(error, axis = 0)
    
    return mae


def goodness_of_fit(actual, predicted):
    
    explained_variance = np.sum(np.square(predicted - np.mean(actual) )) # sum of squared regression
    unexplained_variance = np.sum(np.square(actual - predicted)) # sum of squared error
    total_variance = explained_variance + unexplained_variance
    gf = 1-(unexplained_variance / total_variance)
    
    return gf


if __name__ == "__main__":
    
    dataset = pd.read_csv('Sample_Data_SLR.csv', header = 0) # dataset column wise
    
    X = dataset.iloc[:, :-1].values # independent variable
    Y = dataset.iloc[:, 1].values # dependent variable
    
    if (Y.shape==(len(Y), 1)):
        pass
    else:
        Y = Y.reshape(len(Y), 1)
    
    coefficients, predicted = simple_linear_regression(X, Y)
    
    print "MS Error: \n", mse_metric(Y, predicted)
    print "RMS Error: \n", np.sqrt(mse_metric(Y, predicted))
    print "MA Error: \n", mae_metric(Y, predicted)
    print "Goodness-of-fit: \n", goodness_of_fit(Y, predicted)
    print "Coefficients: " , coefficients
    
    plt.figure()
    plt.scatter(X, Y, color = 'red')
    plt.plot(X, predicted, color = 'blue')
    plt.title('Simple Linear Regression')
    plt.xlabel('Exogenous Variable [aka. Independent or Predictor]')
    plt.ylabel('Endogenous Variable [aka. Dependent or Response]')
    plt.tight_layout()
    plt.show()
    