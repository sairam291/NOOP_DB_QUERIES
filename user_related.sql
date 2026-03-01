ALTER TABLE public.tb_mst_users
ADD COLUMN noop_other_purpose boolean,
ADD COLUMN noop_subscribed boolean,
ADD COLUMN noop_turnover character varying(100),
ADD COLUMN noop_valuation_purpose boolean;

ALTER TABLE public.tb_mst_users_staging
ADD COLUMN noop_other_purpose boolean,
ADD COLUMN noop_subscribed boolean,
ADD COLUMN noop_turnover character varying(100),
ADD COLUMN noop_valuation_purpose boolean;

UPDATE tb_mst_users
SET noop_other_purpose = false,
    noop_subscribed = false,
    noop_valuation_purpose = false;

UPDATE tb_mst_users_staging
SET noop_other_purpose = false,
    noop_subscribed = false,
    noop_valuation_purpose = false;



