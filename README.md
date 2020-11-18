# Maati-
## AI BASED CROP RECOMMENDATION SYSTEM

### Developers- 
Rashi Srivastava, IIIrd Semester - rashisrivastava@ieee.org

Ankit Jailwal, IIIrd Semester - jailwalankit@gmail.com

Shivam Sawarn, IIIrd Semester - shivamsawarn@ieee.org


#### Problem Statement - 
Selecting Crops for farmers is a hectic job as they have to consider many different factors. Hence, developing an app which will help farmers in making their jobs easy.

#### Aim - 
The aim is to design an AI based crop recommendation application which can recommend different crops to the farmers by analysing all the relevant factors for a particular land area such as rainfall, temperature, season, ground water available, soil type and location. The application is based on Deep Learning and Machine Learning algorithms to detect the soil type given an image and recommend the best fit crop along with further suggestions for that very crop such as expected revenue generated per hectare, demand of the crop, required fertilizers, cost of cultivation per hectare, quantity of seeds per hectare, duration of cultivation and the crops which can be used for mixed cropping with the primary crop.

#### Datasets used - 
Multiple datasets have been used for training and obtaining relevant output purposes. All the datasets used are custom datsets; constructed and structured according to the algorithm requirements and proposed test cases. Following is the list and types of the datasets used-

1.) **Soils.zip(Soil Image Dataset)** - Contains around 600-700 images of different soil types which are used for agriculture and generally found in Indian-Subcontinent.
    https://github.com/Rashi-Srivastava/Maati-/blob/main/Datasets/Soils.zip
    
2.) **Cat_crop.csv** - The mentioned CSV file contains data related to various parameters which have been taken into account while training the Crop recommendation System Machine Learning Model.
    https://github.com/Rashi-Srivastava/Maati-/blob/main/Datasets/Cat_Crop.csv
    
3.) **Prediction.csv, Prediction.json** - This dataset contains additional information about the crops used in training of the model and are fetched in real time after crop prediction to give the user a better idea about the requirements of crops and their needs. 
    https://github.com/Rashi-Srivastava/Maati-/blob/main/Datasets/Prediction.json
    
#### Working of Maati App - 
- The app starts after an easy user login using mobile number but for the prototype the mobile number feature hasn't been implemented completely and the app is currently working on a dummy user name and phone number. 

- After login the user is taken to the main menu page where, the user can navigate through different features of MAATI APP.

- For Crop prediction, the user is required to click the image of the land on which the farming has to be done and send it to the server for processing and to predict soil type using Deep learning model.

- The predicted soil type will be used as a parameter for crop recommendation.

- User's current location and weather conditions will also be sent to the server for crop prediction and altogether all the parameters will be used to predict the crop which is suitable for cultivation.

- After crop prediction the relevant details related to the crops will be fetched and shown as the output to the users.
- Users can also access other features of the app such as: Kisan Call Centre, Maati News for agriculture news and happenings, Maati analysis for weather updates, History of previous recommendations etc. 

All the files related to frontend can be found here: https://github.com/Rashi-Srivastava/Maati-/tree/frontend

**Screenshots and app related images can be found here: https://github.com/Rashi-Srivastava/Maati-/tree/main/Images**

**All the videos can be found here: https://github.com/Rashi-Srivastava/Maati-/tree/main/Video**

#### Individual contribution from Team members - 

Frontend Development - Ankit Jailwal

Backend Development - Shivam Sawarn and Rashi Srivastava

### UPDATE-
#### Multi Language support is available for 10+ languages in this prototype.

## "The whole app works on Cloud Backend powered by AI"

##### The whole app is a prototype which has been made for project purposes only.
