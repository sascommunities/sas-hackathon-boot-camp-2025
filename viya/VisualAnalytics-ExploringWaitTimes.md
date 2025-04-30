# Exploring Universal Studios’ Amusement Park Wait Times with SAS Visual Analytics

## Description
This use case walks through a basic visualization task within SAS Visual Analytics. Participants will explore the Universal Studios Wait Time dataset to analyze data about the amusement park, such as attractions, temperature, precipitation, and wait times. To complete the task, hackers will be asked a series of questions about their findings.
## Objectives
* Load the WAITING_TIMES datasets into a SAS Visual Analytics report.
* Explore the variables and trends with point-and-click visualization tools.

## Step-by-step instructions
* Log into SAS Viya.
* Navigate to Explore and Visualize (SAS Visual Analytics) within the Application Menu.
* Start a New report.
* Add the WAITING_TIMES dataset to the report. 
* Notice that the variables available in the Data pane are grouped into two main sections: Category and Measure. Take a moment to familiarize yourself with the variables available.

**QUESTION 1: How many attractions are listed in the data?**

* Many of the variables are far from perfect. To change the name of a variable to make them a bit more useful, click the Edit properties drop down arrows next to the variable name.
* Expand the properties for categorical, datetime, and measure variables – and notice that they have different options for what can be changed.
* For a better visualization, change the Format of “Datetime when the waittime was retrieved” to Date.
* Measure variables have a default aggregation of Sum, which is sometimes helpful… and sometimes leaves us with absurd numbers. Don’t believe me? Select “The main weather condition” and “Humidity in % from 0 to 100” from the Data pane and drag the two variables onto the page. You’ll get a popup saying “+Auto chart” before you drop. 
* I told you it was crazy numbers!
* Take some time adjusting variable names and formats, as well as changing aggregations to Average for all Measure variables except Frequency. Fun fact: You can do this in one swoop by selecting all the variables and right-clicking.
* Note that changing variable names might create discrepancies in further instructions and screenshots.

**QUESTION 2: Looking back at your bar chart for “Humidity in % from 0 to 100 by the main weather condition,” which weather condition has the highest humidity percent?**

* Let’s get down to exploring through visualizations!
* Drag-and-drop your date variable along with Temperature and Current waiting time in minutes variables onto the canvas.
* What do you see?

**QUESTION 3: Do you notice a particular trend between temperature and wait times?**

* Time to finish strong with one more visualization – a bubble plot! This will allow us to see several dimensions of data. You ready?
* From the Objects pane on the left sidebar, right click the Bubble plot object and select Add to new page.
* You’ve added the bubble plot to your canvas, but you need to tell SAS which variables to use. Assign the following:
  - X axis: Probability of precipitation
  - Y axis: Temperature
  - Size: Current Wait Time in minutes
  - Group: Main Weather Condition
  - Animation: Datetime when the waittime was retrieved

* You can now see snapshots of wait times by the temperature and precipitation, grouped by weather conditions – AND you can step throughout time to see how it changes.

**QUESTION 4: Find the snapshot for Monday, March 24, 2025. What were the weather conditions on that day, and which had the longer waittime?**
