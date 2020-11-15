#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 11 22:05:17 2020

@author: shivam
"""
#importing the libraries
import numpy as np     
import pandas as pd
import joblib

df = pd.read_csv('Cat_Crops.csv')       #loading the csv file into dataframe
df=df.dropna()
df.head()
X = np.array(df.drop(['Crop'],1))
Y = np.array(df['Crop'])

#train-test splitting
from sklearn import model_selection
x_train, x_test, y_train, y_test = model_selection.train_test_split(X,Y,test_size=0.20, shuffle = True)


#Training with RandonForest Classifier
"""
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
from sklearn.datasets import make_classification
rfs = RandomForestClassifier(max_depth=9, random_state=40)                      
rfs.fit(x_train,y_train)
predictions=rfs.predict(x_test)
print(predictions)
print(accuracy_score(y_test, predictions)*100)
"""

#Training with KNearestNeighbour Classifier
"""
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score
neigh = KNeighborsClassifier()
neigh.fit(x_train,y_train)
predictions=neigh.predict(x_test)
print(predictions)
print(accuracy_score(y_test, predictions)*100)
"""

#Training with DecisionTree Classifier (Model used for our app)
from sklearn import tree
from sklearn.metrics import accuracy_score
dtree=tree.DecisionTreeClassifier()
dtree.fit(x_train,y_train)
# save the model to disk
filename = 'finalized_model.sav'      
joblib.dump(dtree, filename)

#loading the model
loaded_model = joblib.load(filename)
result = loaded_model.score(x_test, y_test)
predictions=dtree.predict(x_test)                                               
#print(accuracy_score(y_test, predictions)*100)
X_new = np.array([32,100,26.6,6.7,3,2])
X_new = X_new.reshape(1,-1)
new_pred = str(loaded_model.predict(X_new))

#Training with NaiveBayes Classifier
"""
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
clf = GaussianNB()
clf.fit(x_train, y_train)
predictions = clf.predict(x_test)
print(predictions)
print(accuracy_score(y_test, predictions)*100)
print(confusion_matrix(y_test, predictions))
"""
