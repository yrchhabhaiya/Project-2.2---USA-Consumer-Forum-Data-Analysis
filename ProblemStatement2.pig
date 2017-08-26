REGISTER piggybank.jar;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage;
A = LOAD '/flume_sink2/*' USING CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
B = FOREACH A GENERATE (int)$15 AS complainID, 
(chararray)$0 AS datereceived, 
(chararray)$11 AS dateforwarded, 
(chararray)$7 AS companyName;
C = FILTER B BY datereceived==dateforwarded;
D = GROUP C BY companyName;
E = FOREACH D GENERATE group as companyName, COUNT(C.complainID) as complainCount; 
STORE E INTO '/user/acadgild/project/USAConsumer/ProblemStatement2';
