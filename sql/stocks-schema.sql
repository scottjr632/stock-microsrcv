--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: stocks; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA stocks;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: stock_history_master; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.stock_history_master (
    id integer NOT NULL,
    symb character varying(5),
    price numeric(8,2),
    "time" timestamp without time zone DEFAULT now()
);


--
-- Name: mu; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.mu (
    CONSTRAINT mu_symb_check CHECK (((symb)::text = 'MU'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: test(); Type: FUNCTION; Schema: stocks; Owner: -
--

CREATE FUNCTION stocks.test() RETURNS stocks.mu
    LANGUAGE sql
    AS $$ select * from mu; $$;


--
-- Name: trg_prc_ins_hist(); Type: FUNCTION; Schema: stocks; Owner: -
--

CREATE FUNCTION stocks.trg_prc_ins_hist() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
execute format(
'create table if not exists %s (check (symb = ''%s'')) inherits (stock_history_master)', NEW.symb, NEW.symb, NEW.symb);
execute format(
 'insert into %s (symb, price, time) values (''%s'',%s, current_timestamp)',NEW.symb, NEW.symb::varchar, NEW.price);
return null;
end;
$$;


--
-- Name: trg_prc_ins_stock(); Type: FUNCTION; Schema: stocks; Owner: -
--

CREATE FUNCTION stocks.trg_prc_ins_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
 insert into stock_history_master (symb, price) values (NEW.symb::varchar, NEW.price::numeric(8,2));
 return null;
end;
$$;


--
-- Name: trg_prc_upd_stock(); Type: FUNCTION; Schema: stocks; Owner: -
--

CREATE FUNCTION stocks.trg_prc_upd_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
 insert into stock_history_master (symb, price) values (NEW.symb::varchar, NEW.price::numeric(8,2));
 return null;
end;
$$;


--
-- Name: aapl; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.aapl (
    CONSTRAINT aapl_symb_check CHECK (((symb)::text = 'AAPL'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: abc; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.abc (
    CONSTRAINT abc_symb_check CHECK (((symb)::text = 'ABC'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: acad; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.acad (
    CONSTRAINT acad_symb_check CHECK (((symb)::text = 'ACAD'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: aciw; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.aciw (
    CONSTRAINT aciw_symb_check CHECK (((symb)::text = 'ACIW'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: alk; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.alk (
    CONSTRAINT alk_symb_check CHECK (((symb)::text = 'ALK'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: amd; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.amd (
    CONSTRAINT amd_symb_check CHECK (((symb)::text = 'AMD'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: amzn; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.amzn (
    CONSTRAINT amzn_symb_check CHECK (((symb)::text = 'AMZN'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: bbc; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.bbc (
    CONSTRAINT bbc_symb_check CHECK (((symb)::text = 'BBC'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: biib; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.biib (
    CONSTRAINT biib_symb_check CHECK (((symb)::text = 'BIIB'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: canf; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.canf (
    CONSTRAINT canf_symb_check CHECK (((symb)::text = 'CANF'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: cldr; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.cldr (
    CONSTRAINT cldr_symb_check CHECK (((symb)::text = 'CLDR'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: dis; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.dis (
    CONSTRAINT dis_symb_check CHECK (((symb)::text = 'DIS'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: el; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.el (
    CONSTRAINT el_symb_check CHECK (((symb)::text = 'EL'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: enph; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.enph (
    CONSTRAINT enph_symb_check CHECK (((symb)::text = 'ENPH'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: esca; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.esca (
    CONSTRAINT esca_symb_check CHECK (((symb)::text = 'ESCA'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: fas; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.fas (
    CONSTRAINT fas_symb_check CHECK (((symb)::text = 'FAS'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: fb; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.fb (
    CONSTRAINT fb_symb_check CHECK (((symb)::text = 'FB'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: gm; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.gm (
    CONSTRAINT gm_symb_check CHECK (((symb)::text = 'GM'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: googl; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.googl (
    CONSTRAINT googl_symb_check CHECK (((symb)::text = 'GOOGL'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: hx; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.hx (
    CONSTRAINT hx_symb_check CHECK (((symb)::text = 'HX'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: iclr; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.iclr (
    CONSTRAINT iclr_symb_check CHECK (((symb)::text = 'ICLR'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: iq; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.iq (
    CONSTRAINT iq_symb_check CHECK (((symb)::text = 'IQ'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: msft; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.msft (
    CONSTRAINT msft_symb_check CHECK (((symb)::text = 'MSFT'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: nsany; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.nsany (
    CONSTRAINT nsany_symb_check CHECK (((symb)::text = 'NSANY'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: ostk; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.ostk (
    CONSTRAINT ostk_symb_check CHECK (((symb)::text = 'OSTK'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: pcrfy; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.pcrfy (
    CONSTRAINT pcrfy_symb_check CHECK (((symb)::text = 'PCRFY'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: rnlsy; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.rnlsy (
    CONSTRAINT rnlsy_symb_check CHECK (((symb)::text = 'RNLSY'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: s; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.s (
    CONSTRAINT s_symb_check CHECK (((symb)::text = 'S'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: seii; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.seii (
    CONSTRAINT seii_symb_check CHECK (((symb)::text = 'SEII'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: sqm; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.sqm (
    CONSTRAINT sqm_symb_check CHECK (((symb)::text = 'SQM'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: stock_history_master_id_seq; Type: SEQUENCE; Schema: stocks; Owner: -
--

CREATE SEQUENCE stocks.stock_history_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_history_master_id_seq; Type: SEQUENCE OWNED BY; Schema: stocks; Owner: -
--

ALTER SEQUENCE stocks.stock_history_master_id_seq OWNED BY stocks.stock_history_master.id;


--
-- Name: stocks; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.stocks (
    id integer NOT NULL,
    symb character varying(5),
    price numeric(8,2) NOT NULL,
    last_update timestamp without time zone DEFAULT now()
);


--
-- Name: stocks_id_seq; Type: SEQUENCE; Schema: stocks; Owner: -
--

CREATE SEQUENCE stocks.stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: stocks; Owner: -
--

ALTER SEQUENCE stocks.stocks_id_seq OWNED BY stocks.stocks.id;


--
-- Name: symc; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.symc (
    CONSTRAINT symc_symb_check CHECK (((symb)::text = 'SYMC'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: tm; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.tm (
    CONSTRAINT tm_symb_check CHECK (((symb)::text = 'TM'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: tsla; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.tsla (
    CONSTRAINT tsla_symb_check CHECK (((symb)::text = 'TSLA'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: ttmi; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.ttmi (
    CONSTRAINT ttmi_symb_check CHECK (((symb)::text = 'TTMI'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: ttwo; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.ttwo (
    CONSTRAINT ttwo_symb_check CHECK (((symb)::text = 'TTWO'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: vrtx; Type: TABLE; Schema: stocks; Owner: -
--

CREATE TABLE stocks.vrtx (
    CONSTRAINT vrtx_symb_check CHECK (((symb)::text = 'VRTX'::text))
)
INHERITS (stocks.stock_history_master);


--
-- Name: aapl id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.aapl ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: aapl time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.aapl ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: abc id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.abc ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: abc time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.abc ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: acad id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.acad ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: acad time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.acad ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: aciw id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.aciw ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: aciw time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.aciw ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: alk id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.alk ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: alk time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.alk ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: amd id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.amd ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: amd time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.amd ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: amzn id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.amzn ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: amzn time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.amzn ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: bbc id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.bbc ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: bbc time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.bbc ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: biib id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.biib ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: biib time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.biib ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: canf id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.canf ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: canf time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.canf ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: cldr id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.cldr ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: cldr time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.cldr ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: dis id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.dis ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: dis time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.dis ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: el id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.el ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: el time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.el ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: enph id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.enph ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: enph time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.enph ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: esca id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.esca ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: esca time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.esca ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: fas id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.fas ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: fas time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.fas ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: fb id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.fb ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: fb time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.fb ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: gm id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.gm ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: gm time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.gm ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: googl id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.googl ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: googl time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.googl ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: hx id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.hx ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: hx time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.hx ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: iclr id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.iclr ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: iclr time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.iclr ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: iq id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.iq ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: iq time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.iq ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: msft id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.msft ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: msft time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.msft ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: mu id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.mu ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: mu time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.mu ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: nsany id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.nsany ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: nsany time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.nsany ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: ostk id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ostk ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: ostk time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ostk ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: pcrfy id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.pcrfy ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: pcrfy time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.pcrfy ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: rnlsy id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.rnlsy ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: rnlsy time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.rnlsy ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: s id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.s ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: s time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.s ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: seii id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.seii ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: seii time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.seii ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: sqm id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.sqm ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: sqm time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.sqm ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: stock_history_master id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.stock_history_master ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: stocks id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.stocks ALTER COLUMN id SET DEFAULT nextval('stocks.stocks_id_seq'::regclass);


--
-- Name: symc id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.symc ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: symc time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.symc ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: tm id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.tm ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: tm time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.tm ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: tsla id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.tsla ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: tsla time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.tsla ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: ttmi id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ttmi ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: ttmi time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ttmi ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: ttwo id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ttwo ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: ttwo time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.ttwo ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: vrtx id; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.vrtx ALTER COLUMN id SET DEFAULT nextval('stocks.stock_history_master_id_seq'::regclass);


--
-- Name: vrtx time; Type: DEFAULT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.vrtx ALTER COLUMN "time" SET DEFAULT now();


--
-- Name: stock_history_master stock_history_master_pkey; Type: CONSTRAINT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.stock_history_master
    ADD CONSTRAINT stock_history_master_pkey PRIMARY KEY (id);


--
-- Name: stocks stocks_pkey; Type: CONSTRAINT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.stocks
    ADD CONSTRAINT stocks_pkey PRIMARY KEY (id);


--
-- Name: stocks symb_unq; Type: CONSTRAINT; Schema: stocks; Owner: -
--

ALTER TABLE ONLY stocks.stocks
    ADD CONSTRAINT symb_unq UNIQUE (symb);


--
-- Name: symb_hist_idx; Type: INDEX; Schema: stocks; Owner: -
--

CREATE INDEX symb_hist_idx ON stocks.stock_history_master USING btree (symb);


--
-- Name: stock_history_master trg_ins_hist; Type: TRIGGER; Schema: stocks; Owner: -
--

CREATE TRIGGER trg_ins_hist BEFORE INSERT ON stocks.stock_history_master FOR EACH ROW EXECUTE PROCEDURE stocks.trg_prc_ins_hist();


--
-- Name: stocks trg_ins_stock; Type: TRIGGER; Schema: stocks; Owner: -
--

CREATE TRIGGER trg_ins_stock AFTER INSERT ON stocks.stocks FOR EACH ROW EXECUTE PROCEDURE stocks.trg_prc_ins_stock();


--
-- Name: stocks trg_upd_stock; Type: TRIGGER; Schema: stocks; Owner: -
--

CREATE TRIGGER trg_upd_stock AFTER UPDATE ON stocks.stocks FOR EACH ROW EXECUTE PROCEDURE stocks.trg_prc_upd_stock();


--
-- Name: SCHEMA stocks; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA stocks TO lindsey_dev;


--
-- Name: TABLE stock_history_master; Type: ACL; Schema: stocks; Owner: -
--

REVOKE ALL ON TABLE stocks.stock_history_master FROM stocks;
GRANT SELECT,INSERT,UPDATE ON TABLE stocks.stock_history_master TO stocks;
GRANT SELECT,INSERT,UPDATE ON TABLE stocks.stock_history_master TO lindsey_dev;


--
-- Name: TABLE mu; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.mu TO lindsey_dev;


--
-- Name: TABLE aapl; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.aapl TO lindsey_dev;


--
-- Name: TABLE abc; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.abc TO lindsey_dev;


--
-- Name: TABLE acad; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.acad TO lindsey_dev;


--
-- Name: TABLE aciw; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.aciw TO lindsey_dev;


--
-- Name: TABLE alk; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.alk TO lindsey_dev;


--
-- Name: TABLE amd; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.amd TO lindsey_dev;


--
-- Name: TABLE amzn; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.amzn TO lindsey_dev;


--
-- Name: TABLE bbc; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.bbc TO lindsey_dev;


--
-- Name: TABLE biib; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.biib TO lindsey_dev;


--
-- Name: TABLE canf; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.canf TO lindsey_dev;


--
-- Name: TABLE cldr; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.cldr TO lindsey_dev;


--
-- Name: TABLE dis; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.dis TO lindsey_dev;


--
-- Name: TABLE el; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.el TO lindsey_dev;


--
-- Name: TABLE enph; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.enph TO lindsey_dev;


--
-- Name: TABLE esca; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.esca TO lindsey_dev;


--
-- Name: TABLE fas; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.fas TO lindsey_dev;


--
-- Name: TABLE fb; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.fb TO lindsey_dev;


--
-- Name: TABLE gm; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.gm TO lindsey_dev;


--
-- Name: TABLE googl; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.googl TO lindsey_dev;


--
-- Name: TABLE hx; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.hx TO lindsey_dev;


--
-- Name: TABLE iclr; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.iclr TO lindsey_dev;


--
-- Name: TABLE iq; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.iq TO lindsey_dev;


--
-- Name: TABLE msft; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.msft TO lindsey_dev;


--
-- Name: TABLE nsany; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.nsany TO lindsey_dev;


--
-- Name: TABLE ostk; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.ostk TO lindsey_dev;


--
-- Name: TABLE pcrfy; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.pcrfy TO lindsey_dev;


--
-- Name: TABLE rnlsy; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.rnlsy TO lindsey_dev;


--
-- Name: TABLE s; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.s TO lindsey_dev;


--
-- Name: TABLE seii; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.seii TO lindsey_dev;


--
-- Name: TABLE sqm; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.sqm TO lindsey_dev;


--
-- Name: TABLE stocks; Type: ACL; Schema: stocks; Owner: -
--

REVOKE ALL ON TABLE stocks.stocks FROM stocks;
GRANT SELECT,INSERT,UPDATE ON TABLE stocks.stocks TO stocks;
GRANT SELECT,INSERT,UPDATE ON TABLE stocks.stocks TO lindsey_dev;


--
-- Name: TABLE symc; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.symc TO lindsey_dev;


--
-- Name: TABLE tm; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.tm TO lindsey_dev;


--
-- Name: TABLE tsla; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.tsla TO lindsey_dev;


--
-- Name: TABLE ttmi; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.ttmi TO lindsey_dev;


--
-- Name: TABLE ttwo; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.ttwo TO lindsey_dev;


--
-- Name: TABLE vrtx; Type: ACL; Schema: stocks; Owner: -
--

GRANT SELECT,INSERT,UPDATE ON TABLE stocks.vrtx TO lindsey_dev;


--
-- PostgreSQL database dump complete
--

