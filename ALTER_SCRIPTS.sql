ALTER TABLE tb_ss_noop 
ALTER COLUMN tenor TYPE varchar(12);

ALTER TABLE tb_noop 
ALTER COLUMN tenor TYPE varchar(12);

ALTER TABLE tb_noop_staging 
ALTER COLUMN tenor TYPE varchar(12);

ALTER TABLE tb_noop_published 
ALTER COLUMN tenor TYPE varchar(12);