#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 13 13:29:38 2020

@author: shivam
"""
#importing the libraries
import json
from flask import Flask,request,jsonify,Response
import base64
import numpy as np
import imageio
import soilNET
from matplotlib.pyplot import imshow
from keras.preprocessing import image
from types import SimpleNamespace 
import pandas as pd
import geopandas as gpd
import geopy
import reverse_geocoder as rg
from geopy.geocoders import Nominatim
from geopy.extra.rate_limiter import RateLimiter
import joblib

#initializing flask
app = Flask(__name__)


@app.route("/",methods=["POST"])
def predict():                                      #defining prediction function
    data=request.get_json(force=True)               #requesting data from client
    base64_img=str(data['base64'])                  #extracting data 
    file_name=data["ID"]
    with open(file_name,'wb') as f:
        f.write(base64.b64decode(base64_img))
    image_path= file_name                           #reading the image received from client
    img = image.load_img(image_path)
    img = img.resize((150,150))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0
    #print('Input image shape:', x.shape)
    #my_image = imageio.imread(image_path)
    #imshow(my_image)
    #print("class prediction vector [Alluvial, Black, Clayey, Latterite, Red, Sandy] = ")
    prediction=(soilNET.model.predict(x))*100       #predicting soil type based on SoilNET
    max_i = np.argmax(prediction) 
    if max_i==0:                                    #categorizing soil type based on highest probability obtained using SoilNET prediction
        soil="Alluvial"
    elif max_i==1:
        soil="Black"
    elif max_i==2:
        soil="Clayey"
    elif max_i==3:
        soil="Latterite"
    elif max_i==4:
        soil="Red"
    elif max_i==5:
        soil="Sandy"
        
    types = soil
    
    if types=="Alluvial":                           #Restructuring soil type to specific codes according to model input
        soil_type = 1
    elif types == "Red":
        soil_type = 2
    elif types == "Clayey":
        soil_type = 3
    elif types == "Latterite":
        soil_type = 4
    elif types == "Red":
        soil_type = 5
    elif types == "Sandy":
       soil_type = 6
    
    coordinates = data["Loc_Cordinates"]            #extracting location coordinates
    coordinates = str(coordinates)                  
    locator = Nominatim(user_agent="myGeocoder")    #retrieving name of the state based on coordinates
    location = locator.reverse(coordinates)
    loc_dict=location.raw
    state=(loc_dict.get('address').get('state'))
    
    state_code=0                

    if state=="Andhra Pradesh":                     #converting state name to specific code according to the model input
        state_code=1
    elif state=="Arunachal Pradesh":
        state_code=2 
    elif state=="Assam":
        state_code=3 
    elif state=="Bihar":
        state_code=4 
    elif state=="Chhatisgarh":
        state_code=5 
    elif state=="Goa":
        state_code=6 
    elif state=="Gujarat":
        state_code=7 
    elif state=="Haryana":
        state_code=8 
    elif state=="Himachal Pradesh":
        state_code=9 
    elif state=="Jharkhand":
        state_code=10
    elif state=="Karnataka":
        state_code=11 
    elif state=="Kerela":
        state_code=12
    elif state=="Madhya Pradesh":
        state_code=13
    elif state=="Maharashtra":
        state_code=14
    elif state=="Manipur":
        state_code=15
    elif state=="Meghalaya":
        state_code=16
    elif state=="Mizoram":
        state_code=17
    elif state=="Nagaland":
        state_code=18 
    elif state=="Odisha":
        state_code=19 
    elif state=="Punjab":
        state_code=20
    elif state=="Rajasthan":
        state_code=21
    elif state=="Sikkim":
        state_code=22 
    elif state=="Tamil Nadu":
        state_code=23 
    elif state=="Telangana":
        state_code=24 
    elif state=="Tripura":
        state_code=25 
    elif state=="Uttar Pradesh":
        state_code=26 
    elif state=="Uttarakhand":
        state_code=27 
    elif state=="West Bengal":
        state_code=28 
    elif state=="Andaman and Nicobar Island":
        state_code=29 
    elif state=="Dadra Nagar Haveli and Daman and Diu":
        state_code=30 
    elif state=="Chandigarh":
        state_code=31 
    elif state=="Delhi":
        state_code=32 
    elif state=="Jammu and Kashmir":
        state_code=33 
    elif state=="Lakshadweep":
        state_code=34 
    elif state=="Pudducherry":
        state_code=35 
    elif state=="Ladakh":
        state_code=36
    
    state = state_code
    
    file = pd.read_csv("Cat_Crop.csv")                          #reading csv file into dataframe
    data_frame = file.loc[file["States"]==state, "Rainfall"]    #extracting average rainfall data according to state code
    rain = float(data_frame.unique())
    
    df = file.loc[file["States"]==state,"Ground Water"]         #extracting ground water availability according to state code
    ground_water = float(df.unique())
    
    temp = data["Temperature"]                                  #extracting temperature from data received from the client
    #print(type(temp))
    temp = float(temp)
    
    date = data["date"]                                         #extracting date from data received from the client                                    
    #print(type(date))
    date = str(date)
    month=int(date[5:7])                                        #extracting month from the data received
    #print(month)
    #month=5
    season=4
    if month == 11 or month == 12 or month==1 or month==2:      #converting months to specific code according to the model input
        season=2
        
    elif month==6 or month==7 or month==8 or month==9:
        season=1
    elif month==3 or month==4:
        season=3
    else:
        season = 4
    
    
    input_dict={}                                               #creating  a dictionary of all the data extracted to be fed to the model for crop predictions
    
    input_dict["States"] = state_code
    input_dict["Rainfall"] = rain
    input_dict["Ground Water"] = ground_water
    input_dict["Temperature"] = temp
    input_dict["Soil_type"] = soil_type
    input_dict["Season"] = season
    
    output = json.dumps(input_dict)
    with open("input.json","w") as sout:
        sout.write(output)
    filename = "finalized_model.sav"
    loaded_model = joblib.load(filename)
    
    file_path = "input.json"
    with open(file_path) as f:
      data = json.load(f)
    temp=list(data.values())
    
    
    inp_array=np.array(temp)                                    #restructing data according to model input
    inp_array=inp_array.reshape(1,-1)
    #print(inp_array)
    prediction=loaded_model.predict(inp_array)
    #print(prediction)
    prediction = list(prediction)
    
    pred_crop_name = prediction[0]
   
    jsonFilePath = "Prediction.json"                            #Extracting information related to predicted crop            
    with open (jsonFilePath) as fp:
        Final_rec = json.load(fp)
    final_pred = Final_rec[pred_crop_name]
    #print(final_pred)
    
    Final_dict = {
        "Data" : final_pred
        }
    
    
    output=json.dumps(Final_dict)                               #Exporting the final JSON File back to the client
    with open("final.json","w") as sout:
        sout.write(output)
    return output
    

if __name__ == "__main__":
    app.run()
    
    
    

        
        
        
        
                 
    
