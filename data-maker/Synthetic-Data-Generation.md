## SAS Data Maker (Synthetic Data Generation) Instructions


**Instructions:** Synthetic Data Generation for Loan Default Modeling

You are acting as a data scientist at a financial institution, working on building a predictive model to identify loan defaults. Using historical loan account data, you've developed an initial version of the model; however, the accuracy doesn't meet your performance expectations.
After analyzing the results, you've determined that a lack of sufficient training data may limit your model’s effectiveness. To address this, your task is to use SAS Data Maker to generate a synthetic dataset with 10 times more borrower account records than your original dataset. This enhanced synthetic dataset will then be used to retrain and improve the default prediction model.

Use SAS Data Maker to generate synthetic borrower data (10x the original volume) that can be used to boost model training and overall predictive performance.

**Step 1: Access SAS Data Maker:**  
•	The URL for the SAS Data Maker environment will be shared with you at the SAS Hackathon Boot Camp  
•	Log in: Once you are added to the environment (24 hours prior to the event), you will receive an email with access instructions.   
•	Sign in using your SAS Profile credentials  

**Step 2: Create New Project:**    
•   Once you sign in, you’ll land on the Projects page. This page provides an overview of all your ongoing and completed synthetic data activities, organized into projects.  
•	To start a “new project”    
      •	Click “Create New Project  
      •	Enter a project name (any name you choose) and proceed  

**Step 3: Source Data:**    
•	Use the “Lending Club” data set provided within the SAS Data Maker environment  
•	Note these details about the dataset (Lending Club)  
•	The ‘Lending Club’ dataset is a real-world, highly imbalanced dataset containing loan application and repayment data from 2007 to 2015. With far more fully paid loans than defaults, it's ideal for testing classification models under imbalanced conditions. It includes detailed borrower and loan features, making it valuable for predicting loan default risk, a key challenge in lending and fintech.  
•	Please ensure that your organization's data usage policies are adhered to when using the “Lending Club” dataset provided in the SAS Data Maker environment.  
•	Select the required tables for synthetic data generation  

**Step 4: Validate Input Data**  
•	Review sample record 
•	Confirm detection of data types, column roles, properties, and PII detection  

**Step 5: Configure the Generator**  
•	Go to the “Generator Setting” tab  
•	Select your preferred generator type (SMOTE, Time Series, etc.)   
•	Adjust parameters as needed  
•	Train the generator model  

**Step 6: Train the Generator**  
•	Click “Train Generator”    

**Step 7: Evaluate the Results**  
After training, evaluation metrics help assess the quality, similarity, and privacy of synthetic data.  
•	Review evaluation scores such as similarity and privacy risk  
•	Use visual summaries to compare performance across training runs  
•	Adjust settings and retrain if needed  

**Step 8: Generate Synthetic Data**  
•	Navigate to the “Generate” tab  
•	Specify the output to your chosen location  
•	Set volume and file format preferences  
•	Click “Generate”  

**Step 9: Review the Output**  
Generation is complete; you can now view a summary profile of the synthetic dataset.  
•	Review key metrics and visual profiles of your generated data  
•	Explore sample records for validation​


**Thank you for exploring SAS Data Maker during the SAS Hackathon Boot Camp! Continue experimenting, provide feedback and share your use cases with the SAS team.**

 **"Keep testing and innovating – your feedback shapes the future of SAS Data Maker."**


