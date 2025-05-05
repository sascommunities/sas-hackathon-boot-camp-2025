# Sentiment Analysis With SAS

## Description  
This use case walks through a sentiment analysis of text strings use case. Participants will access a Jupyter notebook and run through a series of commands that will load data, create a sentiment model, score the model, and then process the results in SAS Studio. To complete the task, hackers will be asked a series of questions about the resulting data set.

## Objectives  
•	Create a data set and apply the sentiment Text Anlytics Models through REST requests using the sentimentAnalysis.applySent CAS action.  
•	Analyze the results in SAS Studio
Step-by-step instructions
Option 1=
1.	Download the Jupyter notebook for the use case from https://github.com/sascommunities/sas-hackathon-boot-camp-2025/blob/main/sentiment/text-analytics-sentiment-hack.ipynb. Another option is to copy the file from the /homes directory to the /data directory (Jupyter Hub connection instructions in step 2 below.)
2.	Log into the Jupyter environment at https://\<viyaserverurl\>/hub.
3.	Upload the notebook downloaded earlier into the /data directory.  
<img src="images/filesystem.png"/>

4.	Fill in the first cell of the notebook with the SAS Viya URL.  
<img src="images/notebook1.png"/>

5.	Step through the notebook, noting the comments in the commands and the resulting output.
6.	The final result of the notebook runs is an output file titled sentiment_data.json. It will be written to the /data directory. This will be visible in SAS Studio.  
<img src="images/sentiment_data.png"/>

7.	Open the SAS Viya environment using the provided URL. 
8.	From the Applications menu (3x3 squares icon in the upper left-hand corner), navigate to Develop Code and Flows.  
<img src="images/menu.png"/>
9. In the left navigation bar select the second icon (Explorer) and follow the path SAS Server-> Home-> data.   
<img src="images/server.png"/>
10. Right-click on the sentiment_data file and select Copy Path.    
<img src="images/copy_path.png"/>
11.	Copy the path.
12.	Create a new SAS code window and enter the following code: libname hack json \<path to the file copied from the previous step\>/sentiment_data.
13.	In the left nav window, go to the Libraries tab and expand the HACK library.  
<img src="images/fetch.png"/>
14.	Double click on the FETCH_ROWS entry.
15.	Answer the following questions:  
a. From the element3 column, how many sentiments are positive, neutral, and negative?  
b.	What is the highest sentiment score?  
c.	What is the lowest sentiment score?  