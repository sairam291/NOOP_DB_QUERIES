ALTER TABLE public.tb_noop
ALTER COLUMN tenor TYPE character varying(12);

alter table tb_noop_published
alter column tenor type character varying(12);

alter table tb_noop_staging
alter COLUMN tenor TYPE character varying(12);

--  replace the initialize query with below query (DONE IN FILE)
SELECT trade_date AS "unProcessedDate" FROM tb_noop_raw_data WHERE processed = FALSE AND is_deleted = FALSE AND source_system IN ('FXCLEAR','LSEG') GROUP BY trade_date HAVING COUNT(DISTINCT source_system) = (SELECT CAST(key_value AS INTEGER) FROM tb_mst_product_config WHERE key_name = 'DATA_SOURCES_COUNT' AND flow_type = 'MAIN' AND product_id = 23 AND is_deleted = FALSE) UNION SELECT poll_date AS "unProcessedDate" FROM tb_noop_polled_data WHERE processed = FALSE GROUP BY poll_date ORDER BY "unProcessedDate"

-- DONE IN FILE
INSERT INTO public.tb_mst_query_store
(created_by, created_date, description, identifier, is_deleted, oc_status, query, updated_by, updated_date)
VALUES
(99,'2026-02-09 15:25:10.377873','Get recent uploaded file source system','NOOP_SRC_SYSTEM',false,'O',
'SELECT source_system AS "srcSys", trade_date as "tradeDate" FROM tb_noop_raw_data WHERE processed = FALSE   AND is_deleted = FALSE GROUP BY trade_date , source_system'
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','updates the column (processed) in poll data table to true','NOOP_UPD_POLL_TABLE',false,'O',
'update tb_noop_polled_data set processed = true where poll_date=:pollDate',
NULL,NULL),
(99,'2026-02-09 15:25:10.377873','updates the column (processed) in raw data table to true','NOOP_UPD_RAW_TABLE',false,'O',
'update tb_noop_raw_data set processed = true where trade_date=:tradeDate',
NULL,NULL);

-- DONE IN FILE
-- remove 2 queries related to noop poll in query store.(already removed in file)
(99,'2026-01-23 14:12:00','Returns the count of distinct sources for unprocessed da for NOOP computations','NOOP_DIST_SRC_COUNT',false,'O',
'SELECT COUNT(DISTINCT source_system)  as "distSrcCount"  FROM tb_noop_raw_data WHERE processed = FALSE AND is_deleted = FALSE GROUP BY trade_date ORDER BY trade_date DESC LIMIT 1',
NULL,NULL),
(99,'2026-01-23 14:12:00','Returns the dates which are unprocessed for NOOP Poll computations','NOOP_INITIALIZE_POLL',false,'O',
'SELECT trade_date AS "unProcessedDate" FROM tb_noop_raw_data WHERE processed = FALSE AND is_deleted = FALSE GROUP BY trade_date UNION ALL SELECT DISTINCT poll_date AS "unProcessedDate" FROM tb_noop_polled_data WHERE processed = FALSE GROUP BY poll_date',
NULL,NULL);