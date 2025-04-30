# Analyzing Universal Studios’ Amusement Park Wait Times with SAS Visual Analytics

## Description
This use case walks through creating visualizations within SAS Visual Analytics that help understand Universal Studios' wait times. Participants will analyze factors such as attractions, temperature, and precipitation to predict which are most related to wait time. To complete the task, hackers will be asked a series of questions about their findings.
## Objectives
* Load the WAITING_TIMES datasets into a SAS Visual Analytics report.
* Analyze trends using point-and-click visualization tools.
* Build models to make predictions.

## Step-by-step instructions
* Log into SAS Viya.
* Navigate to Explore and Visualize (SAS Visual Analytics) within the Application Menu.
* Start a New report.
* Add the WAITING_TIMES dataset to the report. 
* Notice that the variables available in the Data pane are grouped into two main sections: Category and Measure. Take a moment to familiarize yourself with the variables available.
* The response variable for our analysis is *The current waiting time in minutes*.
* Drag *The current waiting time in minutes* onto the canvas to create a histogram.

**QUESTION 1: What is the frequency of the 8-16 minute bin?**

* You likely also noticed that the bins are right-skewed, which is a good thing- Nobody want long wait times!
* Now, the real question is - what makes wait times higher vs. lower? Let's find out!
* Go back to your Data pane and right-click *The current waiting time in minutes* variable. Check out all the options! The one we are looking for is Explain > Explain on a new page.
* Look at that magic! The Automated Explanation is a great object that easily helps you undertsand how your response variable interacts with other variables in your dataset.

**QUESTION 2: Which factor is most related to *The current waiting time in minutes*?**

* Take a few minutes to look through all the factors. You may notice some redundancy (i.e. multiple variables that hold the same information). If these bug you like they do me, you can remove them using the Roles pane on the right sidebar.
* Although Automated Explanations can give you a lot of information, we are still in descriptive statistics mode.
* To dive a little deeper, find the Object menu in the top right corner of the Automated Explanation. Click those three dots then go to Duplicate as > Linear Regression.
* This will create a linear regression with all the variables you had in your automated explanation. Move this to a new page by grabbing the four dots at the top and dragging to the + meaning New Page.
* Throwing all the variables at the model isn't really the best idea, so let's hone down to only the variables we really care about. That means keep:
  - Response: *The current waiting time in minutes*
  - Continuous effects: *Humidity in % from 0 to 100, Temperature in Celcius, Probability of precipitation, This temperature accounts for the human perception of weather, and Wind speed*
  - Classification effects: *Name of the attraction, More detailed description of the weather condition*

**QUESTION 3: What is the Mean Squared Error?**

* Getting closer to making a prediction, but we haven't actually made any predictions yet! We want to create a visualization that can truly give us an estimate for how long we will wait for a particular ride on any given day with certain weather conditions. Sound difficult? With SAS Visual Analytics, it's not!
* Create a new page on your report. From the Objects pane on the left sidebar, drag the Automated Prediction onto the page.
* SAS is ready to make predictions - now we just need to tell it which variables to make predictions based off of.
* Click the Assign data button in the middle of the screen. Let's start with the Underlying factors. On which factors do we, as humans, base our decision to attend an outdoor amusement park? Personally speaking, I'm not outside measuring humidity or noticing which way the wind is blowing.
* Use the + Add button to insert which factors you would use - I'm choosing:
  - Name of the attraction
  - The main weather condition
  - Probability of precipitation
  - This temperature accounts for the human perception of weather
  - Wind speed
 * Add the current waiting time in minutes as your response variable.
 * Now you're ready to make predictions! Feel free to change values for the variables you selected and visualize how the wait time changes.

**QUESTION 4: Keeping all other values the same, which weather condition shows the longest wait time?**
