REGISTER piggybank.jar;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage;
A = LOAD '/flume_sink2/*' USING CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
B = FOREACH A GENERATE (chararray)$1 AS productType, 
(chararray)$0 AS dateReceived, 
(int)$15 AS complainID, 
SUBSTRING((chararray)$0, 6, 10) AS year;
C = FILTER B BY productType=='Debt collection' AND year=='2015';
D = GROUP C BY productType;
E = FOREACH D GENERATE group AS productType, COUNT(C.complainID) AS complaintCount;
STORE E INTO '/user/acadgild/project/USAConsumer/ProblemStatement4';
