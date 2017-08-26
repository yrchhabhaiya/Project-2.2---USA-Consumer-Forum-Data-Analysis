REGISTER piggybank.jar;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage;
A = LOAD '/flume_sink2/*' USING CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
B = FOREACH A GENERATE (chararray)$7 AS companyName, (int)$15 AS complainID;
C = GROUP B BY companyName;
D = FOREACH C GENERATE group AS companyName, COUNT(B.complainID) AS complaintCount;
E = ORDER D BY complaintCount DESC;
STORE E INTO '/user/acadgild/project/USAConsumer/ProblemStatement3';
