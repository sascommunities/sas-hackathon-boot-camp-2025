* Adjust the path for the environment;
%let pathToData = /path/to/data;

libname amusp "&pathToData.";

cas mySess;

proc casUtil inCASLib='Public' outCASLib='Public';
    dropTable casData='coaster_information' quiet;
    dropTable casData='coaster_walking_time' quiet;
    dropTable casData='waiting_times' quiet;
    dropTable casData='weather_data' quiet;
    load data=amusp.coaster_information casOut='coaster_information';
    load data=amusp.coaster_walking_time casOut='coaster_walking_time';
    load data=amusp.waiting_times casOut='waiting_times';
    load data=amusp.weather_data casOut='weather_data';
    promote casData='coaster_information' casOut='coaster_information';
    promote casData='coaster_walking_time' casOut='coaster_walking_time';
    promote casData='waiting_times' casOut='waiting_times';
    promote casData='weather_data' casOut='weather_data';
    save casData='coaster_information' casOut='coaster_information' replace;
    save casData='coaster_walking_time' casOut='coaster_walking_time' replace;
    save casData='waiting_times' casOut='waiting_times' replace;
    save casData='weather_data' casOut='weather_data' replace;
run; quit;