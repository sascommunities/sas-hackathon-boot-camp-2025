******************************************************;
*** TEST sasioduk vs sas7bdat performance on OMOP data ;
*** ;
*** Initial Release****************
samiul.haque@sas.com
******************************************************;

/**Establish duckdb connection*****/

libname duklib sasioduk file_type="parquet" file_path="/workspaces/myfolder/sas-hackathon-boot-camp-2025/data/kidney.parquet";