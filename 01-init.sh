#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;
  CREATE TABLE IF NOT EXISTS public.mensal_compilado
(
    firstactivitymonthly character varying COLLATE pg_catalog."default",
    period character varying COLLATE pg_catalog."default",
    item character varying COLLATE pg_catalog."default",
    tipo character varying COLLATE pg_catalog."default",
    kpi character varying COLLATE pg_catalog."default",
    acabamento character varying COLLATE pg_catalog."default",
    categoria character varying COLLATE pg_catalog."default",
    capacidade character varying COLLATE pg_catalog."default",
    valor character varying COLLATE pg_catalog."default",
    linha character varying COLLATE pg_catalog."default",
    table_name character varying COLLATE pg_catalog."default",
    grupoproduto character varying COLLATE pg_catalog."default",
    subcategoria character varying COLLATE pg_catalog."default",
    brand character varying COLLATE pg_catalog."default",
    subcategoria2 character varying COLLATE pg_catalog."default",
    CONSTRAINT mensal_compilado_un UNIQUE (item, period, tipo, categoria, brand)
);


CREATE TABLE IF NOT EXISTS public.mensal_compiladobrands
(
    turnover_share_value_1m character varying COLLATE pg_catalog."default",
    period character varying COLLATE pg_catalog."default",
    tipo character varying COLLATE pg_catalog."default",
    sales_per_shop_1m character varying COLLATE pg_catalog."default",
    wgt_avg_distribution_total character varying COLLATE pg_catalog."default",
    categoria character varying COLLATE pg_catalog."default",
    grupos_subcategoria character varying COLLATE pg_catalog."default",
    linha character varying COLLATE pg_catalog."default",
    table_name character varying COLLATE pg_catalog."default",
    unw_avg_distribution_total character varying COLLATE pg_catalog."default",
    grupoproduto character varying COLLATE pg_catalog."default",
    subcategoria character varying COLLATE pg_catalog."default",
    turnover_share_units_1m character varying COLLATE pg_catalog."default",
    brand character varying COLLATE pg_catalog."default",
    CONSTRAINT mensal_compiladobrands_un UNIQUE (categoria, period, tipo, linha, brand)
);


CREATE TABLE IF NOT EXISTS public.semanal_compilado
(
    period character varying COLLATE pg_catalog."default" NOT NULL,
    item character varying COLLATE pg_catalog."default",
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    kpi character varying COLLATE pg_catalog."default" NOT NULL,
    acabamento character varying COLLATE pg_catalog."default",
    categoria character varying COLLATE pg_catalog."default" NOT NULL,
    capacidade character varying COLLATE pg_catalog."default",
    valor character varying COLLATE pg_catalog."default",
    linha character varying COLLATE pg_catalog."default" NOT NULL,
    firstactivity character varying COLLATE pg_catalog."default",
    table_name character varying COLLATE pg_catalog."default",
    grupoproduto character varying COLLATE pg_catalog."default",
    distributio_typ character varying COLLATE pg_catalog."default",
    subcategoria character varying COLLATE pg_catalog."default",
    brand character varying COLLATE pg_catalog."default" NOT NULL,
    subcategoria2 character varying COLLATE pg_catalog."default",
    CONSTRAINT semanal_compilado_pk PRIMARY KEY (tipo, period, kpi, categoria, brand, linha)
);

CREATE TABLE IF NOT EXISTS public.semanal_compiladobrands
(
    period character varying COLLATE pg_catalog."default" NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    kpi character varying COLLATE pg_catalog."default",
    categoria character varying COLLATE pg_catalog."default" NOT NULL,
    capacidade character varying COLLATE pg_catalog."default",
    valor character varying COLLATE pg_catalog."default",
    linha character varying COLLATE pg_catalog."default" NOT NULL,
    table_name character varying COLLATE pg_catalog."default",
    grupoproduto character varying COLLATE pg_catalog."default",
    distributio_typ character varying COLLATE pg_catalog."default",
    subcategoria character varying COLLATE pg_catalog."default",
    brand character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT semanal_compiladobrands_pk PRIMARY KEY (period, linha, tipo, categoria, brand)
);

  COMMIT;
EOSQL

