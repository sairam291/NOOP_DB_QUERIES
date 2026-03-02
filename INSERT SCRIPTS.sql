-- NOOP product
INSERT INTO public.tb_mst_products(
	product_id, created_by, created_date, is_deleted, long_name, oc_status, short_name)
	VALUES (23,	99,	"2026-01-23 23:21:00",	false,	"Net Overnight Open Position",	"O",	"NOOP",		);

-- NOOP product_config
INSERT INTO public.tb_mst_product_config
(created_by, created_date, flow_type, is_deleted, key_desc, key_name, key_value, oc_status, product_id)
VALUES
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Mandatory data sources count', 'DATA_SOURCES_COUNT', '2', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Multiples of standard deviation', 'STDDEV', '2', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Minimum no. of trades for processing', 'MIN_TRADES', '5', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Decimals to be rounded post computations', 'DECIMALS', '4', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Minimum Trade Amount Value', 'TRADE_SIZE', '0.5', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'Aggregated Trade Value', 'AGGR_TRADEVAL', '5', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'On a 24 hours scale, we give two numbers between the hyphen. In the example currently the time is 3:25 PM to 3:30 PM', 'TIME_WINDOW', '15:25:00-15:30:00', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'On a 24 hours scale, we give two numbers between the hyphen. In the example currently the time is 3:15 PM to 3:30 PM', 'TIME_WINDOW1', '15:15:00-15:30:00', 'O', 23),
(99, '2026-01-23 14:12:00', 'MAIN', false, 'On a 24 hours scale, we give two numbers between the hyphen. In the example currently the time is 3:00 PM to 3:30 PM', 'TIME_WINDOW2', '15:00:00-15:30:00', 'O', 23),
(99, '2026-01-23 14:12:00', 'ALTERNATE', false, 'Minimum no. of records for polled data processing', 'MIN_QUOTES', '3', 'O', 23);


-- NOOP process
INSERT INTO public.tb_mst_process
(process_id, created_by, created_date, current_exception_count, is_deleted, oc_status, process_desc, process_name, process_param, process_schedule_time, process_status, updated_by, updated_date, product_id)
VALUES
(24, 99, '2026-01-23 14:12:00', 0, false, 'O', 'Net Overnight Open Position (NOOP) Computations', 'NOOP', NULL, NULL, 'SUCCESS', 99, '2026-02-12 16:49:20.968', 23),
(25, 99, '2026-01-23 14:12:00', 0, false, 'O', 'Second Scrutiny NOOP Computations', 'SS_NOOP', NULL, NULL, NULL, NULL, NULL, 23),
(4600, 0, '2026-01-23 14:12:00', 0, false, 'O', 'NOOP benchmark computation process', 'NOOP_PROCESS', NULL, NULL, NULL, NULL, NULL, 23),
(4700, 0, '2026-01-23 14:12:00', 0, false, 'O', 'noop raw data process FXCLR', 'NOOP_FXCLR_UPLOAD', NULL, NULL, NULL, NULL, NULL, 23),
(4800, 0, '2026-01-23 14:12:00', 0, false, 'O', 'noop raw data process LSEG', 'NOOP_LSEG_UPLOAD', NULL, NULL, NULL, NULL, NULL, 23),
(4900, 0, now(), 0, false, 'O', 'NOOP Poll Data raw data upload', 'NOOP_POLLDATA_UPLOAD', NULL, NULL, NULL, NULL, NULL, 23);

-- NOOP process config
INSERT INTO public.tb_mst_process_config
(created_by, created_date, is_deleted, key_desc, key_name, key_value, oc_status, updated_by, updated_date, process_id)
VALUES

(0,'2026-01-23 14:12:00',false,'BenchMarkName','api_name','Noop','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'count record for given date','count_query',
'select count(1) from tb_noop_staging where is_deleted = FALSE and maker_checker_status = ''WaitingForApproval'' and process_run_date::date = ','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop Cron Expression for Monitoring','cron_job_time','0 50 11 ? * MON-FRI','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop Delete Published records Query','Delete_Published_Query',
'delete from tb_noop_published where is_deleted = FALSE and process_run_date::date = :rundate','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP audit data query','fetch_audit_data',
'SELECT process_run_date AS processRunDate, display_time AS displayTime, rate AS rate, comments AS comments, created_date AS createdDate, check_date AS updatedDate, created_by AS createdBy, checked_by AS checkedBy, secondlevel_date AS secondlevelDate, secondlevel_by AS secondlevelBy, maker_checker_status AS status, tenor as tenor FROM tb_noop_staging WHERE is_deleted = FALSE and maker_checker_status in ( :status ) and process_run_date >= :rundate1 and process_run_date <= :rundate2 and created_by<>:createdBy ORDER BY process_run_date DESC, staging_id ASC',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP staged data query','fetch_stageddata',
'SELECT process_run_date AS processRunDate, tenor AS tenor, display_time AS displayTime, rate AS rate, comments AS comments, created_date AS createdDate, check_date AS updatedDate, created_by AS createdBy, checked_by AS checkedBy, secondlevel_date AS secondlevelDate, secondlevel_by AS secondlevelBy, maker_checker_status AS status FROM tb_noop_staging WHERE is_deleted = FALSE AND maker_checker_status IN (:status) AND process_run_date::date = :rundate AND created_by <> :createdBy ORDER BY process_run_date DESC, staging_id ASC',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'file convetor','file_convertor','defaultXlsToCsvConvertor','O',NULL,NULL,4600),
(0,'2026-01-23 14:12:00',false,'file location','file_location','/fbil/inbound/NOOP','O',NULL,NULL,4600),
(0,'2026-01-23 14:12:00',false,'NOOP password','file_password','Noop@2026$','O',NULL,NULL,4600),
(0,'2026-01-23 14:12:00',false,'Noop monitoring time','monitoring_time','11:50 AM','O',NULL,NULL,4600),
(0,'2026-01-23 14:12:00',false,'outbound location','outbound_location','/fbil/outbound/NOOP/','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP Published already Check Query','Publish_Check_Query',
'SELECT COUNT(1) FROM tb_noop_published WHERE is_deleted = FALSE AND process_run_date::date = :rundate;','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP Publish Permisions Check Query','Publish_Permisions_Query',
'SELECT COUNT(1) FROM tb_noop_staging WHERE is_deleted = FALSE AND maker_checker_status = ''WaitingForApproval'' AND created_by = :user AND process_run_date::date = :rundate;','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP Published Query','Publish_Query',
'INSERT INTO tb_noop_published (approved_by, approved_date, comments, created_by, created_date, display_time, is_deleted, process_run_date, rate, standard_deviation, tenor, trade_volume) SELECT checked_by, check_date, comments, created_by, created_date, display_time, is_deleted, process_run_date, rate, standard_deviation, tenor, trade_volume FROM tb_noop_staging WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND maker_checker_status = ''WaitingForApproval'' ORDER BY staging_id ASC;',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop RePublished Query','RePublish_Query',
'UPDATE tb_noop_published p SET approved_by = :user, approved_date = :insertdate, comments = s.comments, created_by = s.created_by, created_date = s.created_date, display_time = s.display_time, is_deleted = s.is_deleted, rate = s.rate, standard_deviation = s.standard_deviation, tenor = s.tenor, trade_volume = s.trade_volume FROM tb_noop_staging s WHERE p.is_deleted = FALSE AND p.process_run_date::date = :rundate AND s.process_run_date::date = :rundate AND s.maker_checker_status = :secondlevelstatus;',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop Second level Staging user data update Query','SecondLevel_Staging_Update_Query',
'UPDATE tb_noop_staging SET maker_checker_status = :apdstatus, secondlevel_by = :user, secondlevel_date = :insertdate WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND maker_checker_status = :secondlevelstatus;',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'sheet name','sheet_name','Final Rate','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP staged file query','Staged_FileName_Query',
'select staging_file from tb_noop_staging where is_deleted = FALSE and process_run_date::date = :rundate limit 1','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop Staging data reject Query','Staging_Reject_Status_Query',
'UPDATE tb_noop_staging SET checked_by = :user, check_date = :insertdate, maker_checker_status = :rejectstatus WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND (maker_checker_status = :currentstatus OR maker_checker_status = :secondlevelstatus);',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP Staging data update Query','Staging_Update_Query',
'UPDATE tb_noop_staging SET checked_by = :user, check_date = :insertdate WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND maker_checker_status = ''WaitingForApproval'';',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'NOOP Staging data update Query','Staging_Update_Status_Query',
'UPDATE tb_noop_staging SET maker_checker_status = ''Approved'' WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND maker_checker_status = ''WaitingForApproval'';',
'O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'table name','table_name','tb_noop_staging','O',NULL,NULL,4600),

(0,'2026-01-23 14:12:00',false,'Noop Staging data update Query','Update_SecondLevel_Status_Query',
'UPDATE tb_noop_staging SET checked_by = :user, check_date = :insertdate, maker_checker_status = :secondlevelstatus WHERE is_deleted = FALSE AND process_run_date::date = :rundate AND maker_checker_status = :currentstatus;',
'O',NULL,NULL,4600),

-- 4700 entries
(0,'2026-01-23 14:12:00',false,'BaseData file location','base_data_location','/FBIL_DEV/inbound/NOOP/Basedata/','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'File Name','benchmark_file_name','TS9350_D_F_F','O',NULL,NULL,4700),
(1,'2026-01-23 14:12:00',false,'FXCLR file convertor','file_convertor','defaultXlsToCsvConvertor','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'file location','location','/FBIL_DEV/inbound/NOOP/','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'outbound location','outbound_location','/fbil/outbound/NOOP/','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'ccli root location','root_folder_location','/apps/fbil/wasdm/ccilinbound/','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'FXCLR sheet name (not used)','sheet_name','Sheet1','O',NULL,NULL,4700),
(0,'2026-01-23 14:12:00',false,'trade table name','table_name','tb_noop_raw_data','O',NULL,NULL,4700),

-- 4800 entries
(0,'2026-01-23 14:12:00',false,'LSEG base data location','base_data_location','/FBIL_DEV/inbound/NOOP/Basedata/','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'File Name','benchmark_file_name','NOOP_REUTERS_INPUT','O',NULL,NULL,4800),
(1,'2026-01-23 14:12:00',false,'LSEG input folder','dob_metadata_loc_key','/apps/fbil/wasdm/ccilinbound/Noop','O',NULL,NULL,4800),
(1,'2026-01-23 14:12:00',false,'LSEG file convertor','file_convertor','NoopLsegXlsToCsvConvertor','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'file format','file_format','XLSX','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'LSEG input file location','location','/FBIL_DEV/inbound/NOOP/','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'LSEG outbound location','outbound_location','/fbil/outbound/NOOP/','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'LSEG root folder location','root_folder_location','/apps/fbil/wasdm/ccilinbound/','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'Excel sheet name','sheet_name','Sheet1','O',NULL,NULL,4800),
(0,'2026-01-23 14:12:00',false,'trade table name','table_name','tb_noop_raw_data','O',NULL,NULL,4800),

-- 4900 entries
(0, '2026-01-23 14:12:00', false, 'trade table name', 'table_name', 'tb_noop_polled_data', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'ccil root location', 'root_folder_location', '/apps/fbil/wasdm/ccilinbound/', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'BaseData file location', 'base_data_location', '/FBIL_DEV/inbound/NOOP/Basedata/', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'outbound location', 'outbound_location', '/fbil/outbound/NOOP/', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'file location', 'location', '/FBIL_DEV/inbound/NOOP/', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'File Name', 'benchmark_file_name', 'Noop_Polldata', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'Poll file convertor', 'file_convertor', 'NoopPollDataXlsToCsvConvertor', 'O', NULL, NULL, 4900),
(0, '2026-01-23 14:12:00', false, 'Sheet Name', 'sheet_name', 'Sheet1', 'O', NULL, NULL, 4900);


-- query store 
INSERT INTO public.tb_mst_query_store
(created_by, created_date, description, identifier, is_deleted, oc_status, query, updated_by, updated_date)
VALUES
(99,'2026-01-23 14:12:00','Returns the working trade dump for a given date','NOOP_FETCHWORKING',false,'O',
'SELECT * FROM tb_noop_raw_data WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','updates final trades for a given date after stamping higher rate outliers column to true','NOOP_UPDHIGHOUTLIERS',false,'O',
'UPDATE tb_noop_raw_data SET outlier = TRUE, updated_by = :updateBy, updated_date = :updatedDate WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND trade_price > :higherRate AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','updates working column in the trade dump for a given date','NOOP_UPDWORKING',false,'O',
'UPDATE tb_noop_raw_data SET working_data = TRUE, updated_by = :updateBy, updated_date = :updatedDate WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','updates final trades for a given date after stamping lower rate outliers column to true','NOOP_UPDLOWOUTLIERS',false,'O',
'UPDATE tb_noop_raw_data SET outlier = TRUE, updated_by = :updateBy, updated_date = :updatedDate WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND trade_price < :lowerRate AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the final trades for a given date after removing outliers','NOOP_FETCHFINAL',false,'O',
'SELECT * FROM tb_noop_raw_data WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND trade_price >= :lowerRate AND trade_price <= :higherRate AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the NOOP Data','NOOP_FETCH',false,'O',
'SELECT process_run_date AS "processRunDate", tenor AS "tenor", created_by AS "createdBy", created_date AS "createdDate", display_time AS "displayTime", is_deleted AS "isDeleted", published AS "published", rate AS "rate", standard_deviation AS "standardDeviation", trade_volume AS "tradeVolume", updated_by AS "updatedBy", updated_date AS "updatedDate", run_id AS "runId" FROM tb_noop WHERE process_run_date = :runDate AND run_id = :runId AND is_deleted = FALSE',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the NOOP Data for the initial page','FETCH_NOOP_INITIALPAGEDATA',false,'O',
'SELECT a.process_run_date AS "processRunDate", a.tenor AS "tenor", a.created_by AS "createdBy", a.created_date AS "createdDate", a.display_time AS "displayTime", a.is_deleted AS "isDeleted", a.rate AS "rate", a.standard_deviation AS "standardDeviation", a.trade_volume AS "tradeVolume", a.updated_by AS "updatedBy", a.updated_date AS "updatedDate", a.approved_by AS "approvedBy", a.approved_date AS "approvedDate" FROM tb_noop_published a, tb_map_process_rundate_runid b WHERE a.process_run_date = b.process_run_date ORDER BY a.process_run_date DESC LIMIT 3',
NULL,NULL),
(99,'2026-01-23 14:12:00','Updates the processed flag to true in the raw data table for the processing date','NOOP_UPDPROCESSEDDATA',false,'O',
'UPDATE tb_noop_raw_data SET processed = TRUE, run_id = :runId, updated_by = :updateBy, updated_date = :updatedDate WHERE trade_date = :tradeDate AND processed = false AND is_deleted = FALSE',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the aggregate trade size','NOOP_FETCHAGGRSIZE',false,'O',
'SELECT SUM(trade_amount) AS "workingTradeSize" FROM tb_noop_raw_data WHERE trade_date = :tradeDate AND processed = FALSE AND trade_amount >= :tradeSize AND trade_time::time >= :lowerTimeStamp AND trade_time::time <= :higherTimeStamp AND is_deleted = false',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the dates which are unprocessed for NOOP computations','NOOP_INITIALIZE',false,'O',
'SELECT trade_date AS "unProcessedDate" FROM tb_noop_raw_data WHERE processed = FALSE AND is_deleted = FALSE AND source_system IN ('FXCLEAR','LSEG') GROUP BY trade_date HAVING COUNT(DISTINCT source_system) = (SELECT CAST(key_value AS INTEGER) FROM tb_mst_product_config WHERE key_name = 'DATA_SOURCES_COUNT' AND flow_type = 'MAIN' AND product_id = 23 AND is_deleted = FALSE) UNION SELECT poll_date AS "unProcessedDate" FROM tb_noop_polled_data WHERE processed = FALSE GROUP BY poll_date ORDER BY "unProcessedDate"',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the polled data for a given date','NOOP_FETCHPOLLEDDATA',false,'O',
'select data_id AS "dataId", outlier AS "outlier", processed AS "processed", poll_price AS "pollPrice", poll_time AS "pollTime", sub_prod_name AS "subProdName", submitted_by AS "submittedBy", volume AS "volume", working_data AS "workingData", poll_date AS "pollDate" from tb_noop_polled_data WHERE poll_date = :processDate AND sub_prod_name = :subProdName AND processed = FALSE',
NULL,NULL),
(99,'2026-01-23 14:12:00','updates working column for a given date in the polled data','NOOP_UPDALTPOLLEDWORKING',false,'O',
'UPDATE tb_noop_polled_data SET working_data = TRUE, processed= TRUE WHERE data_id IN (:dataId)',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the final polled data for a given date after removing outliers','NOOP_FETCHFINALPOLLEDDATA',false,'O',
'select data_id AS "dataId", outlier AS "outlier", processed AS "processed", poll_price AS "pollPrice", poll_time AS "pollTime", sub_prod_name AS "subProdName", submitted_by AS "submittedBy", volume AS "volume", working_data AS "workingData", poll_date AS "pollDate" from tb_noop_polled_data WHERE poll_date = :processDate AND sub_prod_name = :subProdName AND processed = FALSE AND poll_price >= :lowerRate AND poll_price <= :higherRate',
NULL,NULL),
(99,'2026-01-23 14:12:00','updates outliers column for a given date in the polled data','NOOP_UPDALTPOLLEDOUTLIERS',false,'O',
'UPDATE tb_noop_polled_data SET processed = TRUE, run_id = :runId, working_data = TRUE, outlier = FALSE WHERE data_id IN (:dataId) AND processed = false',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','Get recent uploaded file source system','NOOP_SRC_SYSTEM',false,'O',
'SELECT source_system AS "srcSys", trade_date as "tradeDate" FROM tb_noop_raw_data WHERE processed = FALSE   AND is_deleted = FALSE GROUP BY trade_date , source_system',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','updates the column (processed) in poll data table to true','NOOP_UPD_POLL_TABLE',false,'O',
'update tb_noop_polled_data set processed = true where poll_date=:pollDate',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','updates the column (processed) in raw data table to true','NOOP_UPD_RAW_TABLE',false,'O',
'update tb_noop_raw_data set processed = true where trade_date=:tradeDate',
NULL,NULL),
(99,'2026-02-09 13:50:03.696279','Fetch working NOOP trades for SS process','SS_NOOP_FETCHWORKING',false,'O',
'SELECT *, trade_price AS noop_price FROM tb_noop_raw_data WHERE trade_date = :trade_date AND ss_processed = FALSE AND is_deleted = FALSE AND trade_amount >= :trade_size AND trade_time::time >= :lower_timestamp AND trade_time::time <= :higher_timestamp AND run_id IN ( SELECT run_id FROM tb_noop WHERE process_run_date = :trade_date ORDER BY run_id DESC LIMIT 1 )',
NULL,NULL),
(99,'2026-02-09 13:54:42.671817','Fetch aggregate trade size for SS NOOP processing','SS_NOOP_FETCHAGGTRADESIZE',false,'O',
'SELECT SUM(trade_amount) AS aggregate_trade_size FROM tb_noop_raw_data WHERE trade_date = :trade_date AND ss_processed = FALSE AND trade_amount >= :trade_size AND trade_time::time >= :lower_timestamp AND trade_time::time <= :higher_timestamp AND is_deleted = FALSE',
NULL,NULL),
(99,'2026-02-09 13:55:50.799739','Fetch final SS NOOP trades after excluding outliers','SS_NOOP_FETCHFINAL',false,'O',
'SELECT *, trade_price AS noop_price FROM tb_noop_raw_data WHERE trade_date = :trade_date AND ss_processed = FALSE AND is_deleted = FALSE AND ss_working_data = TRUE AND trade_amount >= :trade_size AND trade_time::time >= :lower_timestamp AND trade_time::time <= :higher_timestamp AND trade_price BETWEEN :lower_rate AND :higher_rate AND ss_outlier = FALSE AND run_id IN ( SELECT run_id FROM tb_noop WHERE process_run_date = :trade_date ORDER BY run_id DESC LIMIT 1 )',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','Mark SS NOOP lower price outliers','SS_NOOP_MARKLOWOUTLIER',false,'O',
'UPDATE tb_noop_raw_data SET ss_outlier = TRUE, updated_by = :update_by, updated_date = :updated_date WHERE trade_date = :trade_date AND ss_processed = FALSE AND trade_amount >= :trade_size AND trade_time::time BETWEEN :lower_ts AND :upper_ts AND is_deleted = FALSE AND run_id IN ( SELECT run_id FROM tb_noop WHERE process_run_date = :trade_date ORDER BY run_id DESC LIMIT 1 ) AND trade_price < :rate',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','Mark SS NOOP higher price outliers','SS_NOOP_MARKHIGHOUTLIER',false,'O',
'UPDATE tb_noop_raw_data SET ss_outlier = TRUE, updated_by = :update_by, updated_date = :updated_date WHERE trade_date = :trade_date AND ss_processed = FALSE AND trade_amount >= :trade_size AND trade_time::time BETWEEN :lower_ts AND :upper_ts AND is_deleted = FALSE AND run_id IN ( SELECT run_id FROM tb_noop WHERE process_run_date = :trade_date ORDER BY run_id DESC LIMIT 1 ) AND trade_price > :rate',
NULL,NULL);


-- map headers
INSERT INTO public.tb_mst_map_headers_columns
(created_by, created_date, header_name, is_deleted, mapping_column_name, oc_status, updated_by, updated_date, process_id)
VALUES
(1,'2026-02-13 01:04:31.404087','location_column',false,'staging_file','O',NULL,NULL,4600),
(1,'2026-02-13 01:04:31.404087','Comments',false,'comments','O',NULL,NULL,4600),
(1,'2026-02-13 01:04:31.404087','Tenor',false,'tenor','O',NULL,NULL,4600),
(1,'2026-02-12 23:58:21.257607','created_by',false,'created_by','O',NULL,NULL,4600),
(1,'2026-02-12 17:43:37.871127','USD/INR spot rate for NOOP',false,'rate','O',NULL,NULL,4600),
(1,'2026-02-12 17:43:37.871127','Time',false,'display_time','O',NULL,NULL,4600),
(1,'2026-02-12 17:43:37.871127','Date',false,'process_run_date','O',NULL,NULL,4600),
(1,'2026-01-22 00:51:07.541016','source_system',false,'source_system','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:07.541016','DATE',false,'trade_date','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:07.541016','TIME',false,'trade_time','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:07.541016','TRADE PRICE',false,'trade_price','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:07.541016','VOLUME',false,'trade_amount','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:07.541016','sub_prod_name',false,'sub_prod_name','O',NULL,NULL,4700),
(1,'2026-01-22 00:51:47.069033','source_system',false,'source_system','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','sub_prod_name',false,'sub_prod_name','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','trade_amount',false,'trade_amount','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','trade_price',false,'trade_price','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','trade_time',false,'trade_time','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','trade_date',false,'trade_date','O',NULL,NULL,4800),
(1,'2026-01-22 00:51:47.069033','Poller Name',false,'submitted_by','O',NULL,NULL,4900),
(1,'2026-01-22 00:51:47.069033','Polled Date',false,'poll_date','O',NULL,NULL,4900),
(1,'2026-01-22 00:51:47.069033','Polled Time',false,'poll_time','O',NULL,NULL,4900),
(1,'2026-01-22 00:51:47.069033','Trade Price',false,'poll_price','O',NULL,NULL,4900),
(1,'2026-01-22 00:51:47.069033','Traded Amount',false,'volume','O',NULL,NULL,4900);


-- Root process config
INSERT INTO public.tb_mst_process_config
(created_by, created_date, is_deleted, key_desc, key_name, key_value, oc_status, updated_by, updated_date, process_id)
VALUES
(0,'2026-01-23 00:29:00',false,'Noop file','Noop queries','4600','O',NULL,NULL,5555),
(0,'2026-01-23 00:29:00',false,'Noop file','TS9350_D_F_F','4700','O',NULL,NULL,5555),
(0,'2026-01-23 00:29:00',false,'Noop file','NOOP_REUTERS_INPUT','4800','O',NULL,NULL,5555),
(0,'2026-01-23 00:29:00',false,'Noop Polled data file','Noop_Polldata','4900','O',NULL,NULL,5555);

