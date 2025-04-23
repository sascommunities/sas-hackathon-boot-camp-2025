# Convert cURL Command to PROC HTTP for SAS Viya

## Get Existing Folder ID
```
curl --request GET 
--url 'https://sasserver.demo.sas.com/folders/folders?filter=eq(name,'Public')' \
--header 'Authorization: ••••••' \
--header 'Accept: application/json, application/vnd.sas.collection+json'
```

```
filename resp temp;

proc http
    method = 'GET'
    url = "https://sasserver.demo.sas.com/folders/folders/?filter=eq(name,'Public')"
    headers 'Accept' = 'application/json, application/vnd.sas.collection+json';
    oauth_bearer = sas_services
    out = resp;
run;
```

## Create New Folder
```
curl --request POST 
--url 'https://sasserver.demo.sas.com/folders/folders?parentFolderUri=/folders/folders/F98c7f933-ec70-4736-b56c-bf29489ff03e' \
--header 'Content-Type: application/json' \
--header 'Accept: application/vnd.sas.content.folder+json' \
--header 'Authorization: ••••••' \
--data '{
  "name": "API Job Exec",
  "description": "My API tests folder.",
  "type": "folder"
}'
```


```
filename resp temp;

proc http
    method = 'Post'
    in = '{
          "name": "jobExecution_prochttp",
          "description": "Job Execution for proc http",
          "type": "folder"
    }'
    url = "https://sasserver.demo.sas.com/folders/folders?parentFolderUri=/folders/folders/F98c7f933-ec70-4736-b56c-bf29489ff03e"
    ct = 'application/json'
    oauth_bearer = sas_services
    out = resp;
    headers 'Accept' = 'application/vnd.sas.content.folder+json';
run;
```

## Create Job Definition
```
curl --location --globoff 'https://sasserver.demo.sas.com/jobDefinitions/definitions?parentFolderUri=/folders/folders/F44j5l654-gh47-5846-k36s-lf66624ah96r' \
--header 'Accept: application/json, application/vnd.sas.job.definition+json' \
--header 'Content-Type: application/json' \
--header 'Authorization: ••••••' \
--data '{
  "version":2,
  "name":"Simple proc print",
  "description":"Show the contents of sashelp.class using PROC PRINT",
  "type":"Compute",
  "parameters":[
        {
        "version": 1,
        "name": "_contextName",
        "defaultValue": "SAS Job Execution compute context",
        "type": "CHARACTER",
        "label": "Context Name",
        "required": false
    }
  ],
  "code":"ods html style=HTMLBlue;\nproc print data=sashelp.class; run; quit;\nods html close;"
}'
```

```
filename resp temp;

proc http
    method='Post'
    in='{
          "version": 2,
          "name": "Table Create",
          "description": "Create a simple data set",
          "type": "Compute",
          "parameters": [
            {
                  "version": 1,
                  "name": "_contextName",
                  "defaultValue": "SAS Job Execution compute context",
                  "type": "CHARACTER",
                  "label": "Context Name",
                  "required": false
            }
          ],
           "code": "cas mySess; caslib _all_ assign; data casuser.test(promote=yes); input a b c d; datalines;\n1 2 3 4\n5 6 7 8\n;"
    }'
     ct = 'application/json'
     url = "https://sasserver.demo.sas.com/jobDefinitions/definitions?parentFolderUri=/folders/folders/F44j5l654-gh47-5846-k36s-lf66624ah96r."
     oauth_bearer = sas_services
     out = resp;
     headers 'Accept' = 'application/json, application/vnd.sas.job.definition+json';
run;
```

## Run Job
```
curl --location 'https://sasserver.demo.sas.com/jobExecution/jobs' \
--header 'Accept: application/json, application/vnd.sas.job.execution.job+json, application/vnd.sas.error+json' \
--header 'Content-Type: application/json' \
--header 'Authorization: ••••••' \
--data '{
  "name": "Simple proc print",
  "description": "Execution of the job we previously created",
  "jobDefinitionUri": "/jobDefinitions/definitions/{{job_id}}"
}'
```

```
filename resp temp;

proc http
    method = 'Post'
    in = {
        {
         "name": "Simple proc print",
         "description": "Execution of the job we previously created",
         "jobDefinitionUri": "/jobDefinitions/definitions/{{job_id}}"
}
    }
     ct = 'application/json'
     url = "https://sasserver.demo.sas.com/jobExecution/jobs"
     oauth_bearer = sas_services
     out = resp;
     headers 'Accept' = 'application/json, application/vnd.sas.job.execution.job+json, application/vnd.sas.error+json';
run;
```
