--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: clinlims; Type: SCHEMA; Schema: -; Owner: clinlims
--

CREATE SCHEMA clinlims;


ALTER SCHEMA clinlims OWNER TO clinlims;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: breakpoint; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE breakpoint AS (
	func oid,
	linenumber integer,
	targetname text
);


ALTER TYPE public.breakpoint OWNER TO clinlims;

--
-- Name: dblink_pkey_results; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE dblink_pkey_results AS (
	"position" integer,
	colname text
);


ALTER TYPE public.dblink_pkey_results OWNER TO clinlims;

--
-- Name: frame; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE frame AS (
	level integer,
	targetname text,
	func oid,
	linenumber integer,
	args text
);


ALTER TYPE public.frame OWNER TO clinlims;

--
-- Name: proxyinfo; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE proxyinfo AS (
	serverversionstr text,
	serverversionnum integer,
	proxyapiver integer,
	serverprocessid integer
);


ALTER TYPE public.proxyinfo OWNER TO clinlims;

--
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO postgres;

--
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO postgres;

--
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO postgres;

--
-- Name: targetinfo; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE targetinfo AS (
	target oid,
	schema oid,
	nargs integer,
	argtypes oidvector,
	targetname name,
	argmodes "char"[],
	argnames text[],
	targetlang oid,
	fqname text,
	returnsset boolean,
	returntype oid
);


ALTER TYPE public.targetinfo OWNER TO clinlims;

--
-- Name: var; Type: TYPE; Schema: public; Owner: clinlims
--

CREATE TYPE var AS (
	name text,
	varclass character(1),
	linenumber integer,
	isunique boolean,
	isconst boolean,
	isnotnull boolean,
	dtype oid,
	value text
);


ALTER TYPE public.var OWNER TO clinlims;

--
-- Name: xpath_list(text, text); Type: FUNCTION; Schema: public; Owner: clinlims
--

CREATE FUNCTION xpath_list(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_list($1,$2,',')$_$;


ALTER FUNCTION public.xpath_list(text, text) OWNER TO clinlims;

--
-- Name: xpath_nodeset(text, text); Type: FUNCTION; Schema: public; Owner: clinlims
--

CREATE FUNCTION xpath_nodeset(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'','')$_$;


ALTER FUNCTION public.xpath_nodeset(text, text) OWNER TO clinlims;

--
-- Name: xpath_nodeset(text, text, text); Type: FUNCTION; Schema: public; Owner: clinlims
--

CREATE FUNCTION xpath_nodeset(text, text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'',$3)$_$;


ALTER FUNCTION public.xpath_nodeset(text, text, text) OWNER TO clinlims;

SET search_path = clinlims, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: action; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE action (
    id numeric(10,0) NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(256) NOT NULL,
    type character varying(10) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.action OWNER TO clinlims;

--
-- Name: action_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE action_seq
    START WITH 45
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.action_seq OWNER TO clinlims;

--
-- Name: address_part; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE address_part (
    id numeric(10,0) NOT NULL,
    part_name character varying(20) NOT NULL,
    display_order numeric(4,0),
    display_key character varying(20),
    type character(1) DEFAULT 'T'::bpchar NOT NULL
);


ALTER TABLE clinlims.address_part OWNER TO clinlims;

--
-- Name: TABLE address_part; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE address_part IS 'Holds the different parts of an address';


--
-- Name: COLUMN address_part.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN address_part.id IS 'Unique id genereated from address_part seq';


--
-- Name: COLUMN address_part.part_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN address_part.part_name IS 'What part of the address is this, street, commune state etc.';


--
-- Name: COLUMN address_part.display_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN address_part.display_order IS 'The order in which they are listed in the standardard address format';


--
-- Name: COLUMN address_part.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN address_part.display_key IS 'The display key for localization';


--
-- Name: address_part_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE address_part_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.address_part_seq OWNER TO clinlims;

--
-- Name: analysis; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analysis (
    id numeric(10,0) NOT NULL,
    sampitem_id numeric(10,0),
    test_sect_id numeric(10,0),
    test_id numeric(10,0),
    revision numeric,
    status character varying(1),
    started_date timestamp without time zone,
    completed_date timestamp without time zone,
    released_date timestamp without time zone,
    printed_date timestamp without time zone,
    is_reportable character varying(1),
    so_send_ready_date timestamp without time zone,
    so_client_reference character varying(240),
    so_notify_received_date timestamp without time zone,
    so_notify_send_date timestamp without time zone,
    so_send_date timestamp without time zone,
    so_send_entry_by character varying(240),
    so_send_entry_date timestamp without time zone,
    analysis_type character varying(10) NOT NULL,
    lastupdated timestamp(6) without time zone,
    parent_analysis_id numeric(10,0),
    parent_result_id numeric(10,0),
    reflex_trigger boolean DEFAULT false,
    status_id numeric(10,0),
    entry_date timestamp with time zone,
    panel_id numeric(10,0),
    comment character varying(1024)
);


ALTER TABLE clinlims.analysis OWNER TO clinlims;

--
-- Name: COLUMN analysis.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.id IS 'Sequential number';


--
-- Name: COLUMN analysis.sampitem_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.sampitem_id IS 'Sample source write in if not already defined';


--
-- Name: COLUMN analysis.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.test_id IS 'Sequential value assigned on insert';


--
-- Name: COLUMN analysis.revision; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.revision IS 'revision number';


--
-- Name: COLUMN analysis.status; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.status IS 'Analysis Status; logged in, initiated, completed, released';


--
-- Name: COLUMN analysis.started_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.started_date IS 'Date and time analysis started';


--
-- Name: COLUMN analysis.completed_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.completed_date IS 'Date and time analysis completed';


--
-- Name: COLUMN analysis.released_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.released_date IS 'Date and time analysis was released; basically verified and ready to report';


--
-- Name: COLUMN analysis.printed_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.printed_date IS 'Date and time analysis was last printed for sending out';


--
-- Name: COLUMN analysis.is_reportable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.is_reportable IS 'Indicates if this analysis should be reported';


--
-- Name: COLUMN analysis.so_send_ready_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.so_send_ready_date IS 'Send out ready date';


--
-- Name: COLUMN analysis.so_notify_received_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.so_notify_received_date IS 'Date that send out facility notificed MDH that they had received the specimen';


--
-- Name: COLUMN analysis.so_notify_send_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.so_notify_send_date IS 'Date that MDH sent out the specimen to a sendout facility';


--
-- Name: COLUMN analysis.so_send_entry_by; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.so_send_entry_by IS 'User name who entered sendout';


--
-- Name: COLUMN analysis.reflex_trigger; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.reflex_trigger IS 'True if this analysis has triggered a reflex test';


--
-- Name: COLUMN analysis.status_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.status_id IS 'foriegn key to status of analysis ';


--
-- Name: COLUMN analysis.entry_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.entry_date IS 'Date on which the results for this analysis was first entered';


--
-- Name: COLUMN analysis.panel_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis.panel_id IS 'If this analysis is part of a panel then this is the id';


--
-- Name: analysis_qaevent; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analysis_qaevent (
    id numeric(10,0) NOT NULL,
    qa_event_id numeric(10,0),
    analysis_id numeric(10,0),
    lastupdated timestamp(6) without time zone,
    completed_date timestamp without time zone
);


ALTER TABLE clinlims.analysis_qaevent OWNER TO clinlims;

--
-- Name: analysis_qaevent_action; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analysis_qaevent_action (
    id numeric(10,0) NOT NULL,
    analysis_qaevent_id numeric(10,0) NOT NULL,
    action_id numeric(10,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    lastupdated timestamp(6) without time zone,
    sys_user_id numeric(10,0)
);


ALTER TABLE clinlims.analysis_qaevent_action OWNER TO clinlims;

--
-- Name: analysis_qaevent_action_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analysis_qaevent_action_seq
    START WITH 221
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.analysis_qaevent_action_seq OWNER TO clinlims;

--
-- Name: analysis_qaevent_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analysis_qaevent_seq
    START WITH 326
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.analysis_qaevent_seq OWNER TO clinlims;

--
-- Name: analysis_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analysis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.analysis_seq OWNER TO clinlims;

--
-- Name: analysis_storages; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analysis_storages (
    id numeric(10,0) NOT NULL,
    storage_id numeric(10,0),
    checkin timestamp without time zone,
    checkout timestamp without time zone,
    analysis_id numeric(10,0)
);


ALTER TABLE clinlims.analysis_storages OWNER TO clinlims;

--
-- Name: COLUMN analysis_storages.checkin; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis_storages.checkin IS 'Date and time sample was moved to this storage_location';


--
-- Name: COLUMN analysis_storages.checkout; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis_storages.checkout IS 'Date and time sample was removed from this storage location';


--
-- Name: analysis_users; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analysis_users (
    id numeric(10,0) NOT NULL,
    action character varying(1),
    analysis_id numeric(10,0),
    system_user_id numeric(10,0)
);


ALTER TABLE clinlims.analysis_users OWNER TO clinlims;

--
-- Name: COLUMN analysis_users.action; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analysis_users.action IS 'Type of action performed such as test request, complete, release';


--
-- Name: analyte; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analyte (
    id numeric(10,0) NOT NULL,
    analyte_id numeric(10,0),
    name character varying(60),
    is_active character varying(1),
    external_id character varying(20),
    lastupdated timestamp(6) without time zone,
    local_abbrev character varying(10)
);


ALTER TABLE clinlims.analyte OWNER TO clinlims;

--
-- Name: COLUMN analyte.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyte.name IS 'Name of analyte';


--
-- Name: COLUMN analyte.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyte.is_active IS 'Flag indicating if the test is active';


--
-- Name: COLUMN analyte.external_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyte.external_id IS 'External ID such as CAS #';


--
-- Name: analyte_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analyte_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.analyte_seq OWNER TO clinlims;

--
-- Name: analyzer; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analyzer (
    id numeric(10,0) NOT NULL,
    scrip_id numeric(10,0),
    name character varying(20),
    machine_id character varying(20),
    description character varying(60),
    analyzer_type character varying(30),
    is_active boolean,
    location character varying(60),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.analyzer OWNER TO clinlims;

--
-- Name: COLUMN analyzer.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.name IS 'Short name for analyzer';


--
-- Name: COLUMN analyzer.machine_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.machine_id IS 'id which uniquely matches a machine, descriminates between duplicate analyzers';


--
-- Name: COLUMN analyzer.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.description IS 'analyzer description';


--
-- Name: COLUMN analyzer.analyzer_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.analyzer_type IS 'Type of analyzer: Mass Spec, HPLC, etc.';


--
-- Name: COLUMN analyzer.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.is_active IS 'Flag indicating if the analyzer is active';


--
-- Name: COLUMN analyzer.location; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer.location IS 'Location of analyzer';


--
-- Name: analyzer_result_status; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analyzer_result_status (
    id numeric(10,0) NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(60)
);


ALTER TABLE clinlims.analyzer_result_status OWNER TO clinlims;

--
-- Name: analyzer_results; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analyzer_results (
    id numeric(10,0) NOT NULL,
    analyzer_id numeric(10,0) NOT NULL,
    accession_number character varying(20) NOT NULL,
    test_name character varying(20) NOT NULL,
    result character varying(20) NOT NULL,
    units character varying(10),
    status_id numeric(10,0) DEFAULT 1 NOT NULL,
    iscontrol boolean DEFAULT false NOT NULL,
    lastupdated timestamp(6) without time zone,
    read_only boolean DEFAULT false,
    test_id numeric(10,0),
    duplicate_id numeric(10,0),
    positive boolean DEFAULT false,
    complete_date timestamp with time zone,
    test_result_type character varying(1)
);


ALTER TABLE clinlims.analyzer_results OWNER TO clinlims;

--
-- Name: TABLE analyzer_results; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE analyzer_results IS 'A holding table for analyzer results ';


--
-- Name: COLUMN analyzer_results.analyzer_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.analyzer_id IS 'Reference to analyzer table';


--
-- Name: COLUMN analyzer_results.accession_number; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.accession_number IS 'The display version of the accession number.  May be either the extended or normal accession number';


--
-- Name: COLUMN analyzer_results.test_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.test_name IS 'The test name, if a mapping is found then the mapping will be used, if not then the analyzer test name will be useds';


--
-- Name: COLUMN analyzer_results.result; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.result IS 'The result of the test, the meaning depends on the test itself';


--
-- Name: COLUMN analyzer_results.units; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.units IS 'The units as sent from the analyzer';


--
-- Name: COLUMN analyzer_results.status_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.status_id IS 'The status for the this analyzer result';


--
-- Name: COLUMN analyzer_results.iscontrol; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.iscontrol IS 'Is this result a control';


--
-- Name: COLUMN analyzer_results.read_only; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.read_only IS 'Is this result read only';


--
-- Name: COLUMN analyzer_results.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.test_id IS 'Test this is result is mapped to';


--
-- Name: COLUMN analyzer_results.duplicate_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.duplicate_id IS 'Reference to another analyzer result with the same analyzer and analyzer test';


--
-- Name: COLUMN analyzer_results.positive; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.positive IS 'Is the test positive';


--
-- Name: COLUMN analyzer_results.complete_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_results.complete_date IS 'The time stamp for when the analyzsis was done';


--
-- Name: analyzer_results_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analyzer_results_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.analyzer_results_seq OWNER TO clinlims;

--
-- Name: analyzer_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE analyzer_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.analyzer_seq OWNER TO clinlims;

--
-- Name: analyzer_test_map; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE analyzer_test_map (
    analyzer_id numeric(10,0) NOT NULL,
    analyzer_test_name character varying(30) NOT NULL,
    test_id numeric(10,0) NOT NULL,
    lastupdated timestamp with time zone DEFAULT '2012-04-24 00:30:14.130688+00'::timestamp with time zone
);


ALTER TABLE clinlims.analyzer_test_map OWNER TO clinlims;

--
-- Name: TABLE analyzer_test_map; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE analyzer_test_map IS 'Maps the analyzers names to the tests in database';


--
-- Name: COLUMN analyzer_test_map.analyzer_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_test_map.analyzer_id IS 'foriegn key to analyzer table';


--
-- Name: COLUMN analyzer_test_map.analyzer_test_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_test_map.analyzer_test_name IS 'The name the analyzer uses for the test';


--
-- Name: COLUMN analyzer_test_map.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN analyzer_test_map.test_id IS 'foriegn key to test table';


--
-- Name: animal_common_name; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE animal_common_name (
    id numeric(10,0) NOT NULL,
    name character varying(30)
);


ALTER TABLE clinlims.animal_common_name OWNER TO clinlims;

--
-- Name: COLUMN animal_common_name.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN animal_common_name.name IS 'Lists the animal common name';


--
-- Name: animal_scientific_name; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE animal_scientific_name (
    id numeric(10,0) NOT NULL,
    comm_anim_id numeric(10,0) NOT NULL,
    name character varying(30)
);


ALTER TABLE clinlims.animal_scientific_name OWNER TO clinlims;

--
-- Name: COLUMN animal_scientific_name.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN animal_scientific_name.id IS 'Sequential Number';


--
-- Name: COLUMN animal_scientific_name.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN animal_scientific_name.name IS 'May include Genus and Species';


--
-- Name: attachment; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE attachment (
    id numeric(10,0) NOT NULL,
    attach_type character varying(20),
    filename character varying(60),
    description character varying(80),
    storage_reference character varying(255)
);


ALTER TABLE clinlims.attachment OWNER TO clinlims;

--
-- Name: attachment_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE attachment_item (
    id numeric(10,0) NOT NULL,
    reference_id numeric,
    reference_table_id numeric,
    attachment_id numeric
);


ALTER TABLE clinlims.attachment_item OWNER TO clinlims;

--
-- Name: aux_data; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE aux_data (
    id numeric(10,0) NOT NULL,
    sort_order numeric,
    is_reportable character varying(1),
    auxdata_type character varying(1),
    value character varying(80),
    reference_id numeric,
    reference_table numeric,
    aux_field_id numeric(10,0)
);


ALTER TABLE clinlims.aux_data OWNER TO clinlims;

--
-- Name: COLUMN aux_data.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.sort_order IS 'The order the analytes (questions) are displayed';


--
-- Name: COLUMN aux_data.is_reportable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.is_reportable IS 'Flag indicating if this entry is reportable';


--
-- Name: COLUMN aux_data.auxdata_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.auxdata_type IS 'Type of value: Dictionary, Titer range, Number, Date, String';


--
-- Name: COLUMN aux_data.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.value IS 'Actual value';


--
-- Name: COLUMN aux_data.reference_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.reference_id IS 'Link to record in table to which this entry pertains';


--
-- Name: COLUMN aux_data.reference_table; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_data.reference_table IS 'Link to table that this entry belongs to';


--
-- Name: aux_field; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE aux_field (
    id numeric(10,0) NOT NULL,
    sort_order numeric,
    auxfld_type character varying(1),
    is_active character varying(1),
    is_reportable character varying(1),
    reference_table numeric,
    analyte_id numeric(10,0),
    scriptlet_id numeric(10,0)
);


ALTER TABLE clinlims.aux_field OWNER TO clinlims;

--
-- Name: COLUMN aux_field.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.id IS 'Sequential Identifier';


--
-- Name: COLUMN aux_field.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.sort_order IS 'The order the analystes (questions) are displayed';


--
-- Name: COLUMN aux_field.auxfld_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.auxfld_type IS 'Type of field: Required...';


--
-- Name: COLUMN aux_field.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.is_active IS 'Flag indicating is this entry is active';


--
-- Name: COLUMN aux_field.is_reportable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.is_reportable IS 'Default value to reportable flag';


--
-- Name: COLUMN aux_field.reference_table; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field.reference_table IS 'Link to table in which this entity can be used.';


--
-- Name: aux_field_values; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE aux_field_values (
    id numeric(10,0) NOT NULL,
    auxfldval_type character varying(1),
    value character varying(80),
    aux_field_id numeric(10,0)
);


ALTER TABLE clinlims.aux_field_values OWNER TO clinlims;

--
-- Name: COLUMN aux_field_values.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field_values.id IS 'Sequential Identifier';


--
-- Name: COLUMN aux_field_values.auxfldval_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field_values.auxfldval_type IS 'Type of value: Dictionary, titer range, number, date, string';


--
-- Name: COLUMN aux_field_values.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN aux_field_values.value IS 'A permissible field value';


--
-- Name: chunking_history; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE chunking_history (
    id integer NOT NULL,
    chunk_length bigint,
    start bigint NOT NULL
);


ALTER TABLE clinlims.chunking_history OWNER TO clinlims;

--
-- Name: chunking_history_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE chunking_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.chunking_history_id_seq OWNER TO clinlims;

--
-- Name: chunking_history_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE chunking_history_id_seq OWNED BY chunking_history.id;


--
-- Name: city_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE city_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.city_seq OWNER TO clinlims;

--
-- Name: city_state_zip; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE city_state_zip (
    id numeric(10,0),
    city character varying(30),
    state character varying(2),
    zip_code character varying(10),
    county_fips numeric(3,0),
    county character varying(25),
    region_id numeric(3,0),
    region character varying(30),
    state_fips numeric(3,0),
    state_name character varying(30),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.city_state_zip OWNER TO clinlims;

--
-- Name: code_element_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE code_element_type (
    id numeric(10,0) NOT NULL,
    text character varying(60),
    lastupdated timestamp(6) without time zone,
    local_reference_table numeric(10,0)
);


ALTER TABLE clinlims.code_element_type OWNER TO clinlims;

--
-- Name: code_element_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE code_element_type_seq
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.code_element_type_seq OWNER TO clinlims;

--
-- Name: code_element_xref; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE code_element_xref (
    id numeric(10,0) NOT NULL,
    message_org_id numeric(10,0),
    code_element_type_id numeric(10,0),
    receiver_code_element_id numeric(10,0),
    local_code_element_id numeric(10,0),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.code_element_xref OWNER TO clinlims;

--
-- Name: code_element_xref_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE code_element_xref_seq
    START WITH 41
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.code_element_xref_seq OWNER TO clinlims;

--
-- Name: contact_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE contact_type (
    id numeric(10,0) NOT NULL,
    description character varying(20),
    ct_type character varying(4),
    is_unique character varying(1)
);


ALTER TABLE clinlims.contact_type OWNER TO clinlims;

--
-- Name: COLUMN contact_type.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN contact_type.id IS 'sequential field';


--
-- Name: COLUMN contact_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN contact_type.description IS 'Can include such things as "Operator", "Accounting"';


--
-- Name: COLUMN contact_type.ct_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN contact_type.ct_type IS 'Type code';


--
-- Name: COLUMN contact_type.is_unique; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN contact_type.is_unique IS 'Indicates if only 1 of this contact type is allowed per organization';


--
-- Name: county_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE county_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.county_seq OWNER TO clinlims;

--
-- Name: databasechangelog; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE databasechangelog (
    id character varying(63) NOT NULL,
    author character varying(63) NOT NULL,
    filename character varying(200) NOT NULL,
    dateexecuted timestamp with time zone NOT NULL,
    md5sum character varying(32),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(10)
);


ALTER TABLE clinlims.databasechangelog OWNER TO clinlims;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp with time zone,
    lockedby character varying(255)
);


ALTER TABLE clinlims.databasechangeloglock OWNER TO clinlims;

--
-- Name: dictionary; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE dictionary (
    id numeric(10,0) NOT NULL,
    is_active character varying(1),
    dict_entry character varying(4000),
    lastupdated timestamp(6) without time zone,
    local_abbrev character varying(10),
    dictionary_category_id numeric(10,0),
    display_key character varying(60)
);


ALTER TABLE clinlims.dictionary OWNER TO clinlims;

--
-- Name: COLUMN dictionary.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN dictionary.is_active IS 'Flag indicating if the analyte is active';


--
-- Name: COLUMN dictionary.dict_entry; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN dictionary.dict_entry IS 'Finding, result, interpretation';


--
-- Name: COLUMN dictionary.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN dictionary.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: dictionary_category; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE dictionary_category (
    id numeric(10,0) NOT NULL,
    description character varying(60),
    lastupdated timestamp(6) without time zone,
    local_abbrev character varying(10),
    name character varying(50)
);


ALTER TABLE clinlims.dictionary_category OWNER TO clinlims;

--
-- Name: COLUMN dictionary_category.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN dictionary_category.id IS 'A unique auto generated integer number assigned by database';


--
-- Name: COLUMN dictionary_category.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN dictionary_category.description IS 'Human readable description';


--
-- Name: dictionary_category_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE dictionary_category_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.dictionary_category_seq OWNER TO clinlims;

--
-- Name: dictionary_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.dictionary_seq OWNER TO clinlims;

--
-- Name: district; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE district (
    id numeric(10,0) NOT NULL,
    city_id numeric(10,0) NOT NULL,
    dist_entry character varying(300),
    lastupdated timestamp without time zone,
    description character varying(50)
);


ALTER TABLE clinlims.district OWNER TO clinlims;

--
-- Name: COLUMN district.dist_entry; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN district.dist_entry IS 'Finding, result, interpretation';


--
-- Name: district_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE district_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.district_seq OWNER TO clinlims;

--
-- Name: document_track; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE document_track (
    id numeric(10,0) NOT NULL,
    table_id numeric(10,0) NOT NULL,
    row_id numeric(10,0) NOT NULL,
    document_type_id numeric(10,0) NOT NULL,
    parent_id numeric(10,0),
    report_generation_time timestamp with time zone,
    lastupdated timestamp with time zone,
    name character varying(80)
);


ALTER TABLE clinlims.document_track OWNER TO clinlims;

--
-- Name: TABLE document_track; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE document_track IS 'Table to track operations on documents.  Expected use is for has a document of some been printed for a sample, qa_event etc';


--
-- Name: COLUMN document_track.table_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.table_id IS 'The table to which the row_id references';


--
-- Name: COLUMN document_track.row_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.row_id IS 'The particular record for which a document has been generated';


--
-- Name: COLUMN document_track.document_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.document_type_id IS 'References the type of document which the record has been generated for';


--
-- Name: COLUMN document_track.parent_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.parent_id IS 'If the document has been generated more than once for this record then this will point to the previous record';


--
-- Name: COLUMN document_track.report_generation_time; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.report_generation_time IS 'When this report was generated';


--
-- Name: COLUMN document_track.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.lastupdated IS 'Last time this record was updated';


--
-- Name: COLUMN document_track.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_track.name IS 'The name of the report if there is more than one of the type';


--
-- Name: document_track_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE document_track_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.document_track_seq OWNER TO clinlims;

--
-- Name: document_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE document_type (
    id numeric(10,0) NOT NULL,
    name character varying(40) NOT NULL,
    description character varying(80),
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.document_type OWNER TO clinlims;

--
-- Name: TABLE document_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE document_type IS 'Table which describes document types to be tracked by document_track table';


--
-- Name: COLUMN document_type.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_type.name IS 'The name of the document';


--
-- Name: COLUMN document_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_type.description IS 'The description of the document';


--
-- Name: COLUMN document_type.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN document_type.lastupdated IS 'Last time this record was updated';


--
-- Name: document_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE document_type_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.document_type_seq OWNER TO clinlims;

--
-- Name: ethnicity; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE ethnicity (
    id numeric(10,0) NOT NULL,
    ethnic_type character varying(1) NOT NULL,
    description character varying(20),
    is_active character varying(1)
);


ALTER TABLE clinlims.ethnicity OWNER TO clinlims;

--
-- Name: COLUMN ethnicity.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN ethnicity.id IS 'Any code values in tables.';


--
-- Name: COLUMN ethnicity.ethnic_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN ethnicity.ethnic_type IS 'Ethnicity of Patient';


--
-- Name: event_records; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE event_records (
    id integer NOT NULL,
    uuid character varying(40),
    title character varying(255),
    "timestamp" timestamp with time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    uri character varying(255),
    object character varying(1000),
    category character varying(255),
    date_created timestamp with time zone DEFAULT now(),
    tags character varying(255)
);


ALTER TABLE clinlims.event_records OWNER TO clinlims;

--
-- Name: event_records_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE event_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.event_records_id_seq OWNER TO clinlims;

--
-- Name: event_records_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE event_records_id_seq OWNED BY event_records.id;


--
-- Name: event_records_offset_marker; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE event_records_offset_marker (
    id integer NOT NULL,
    event_id integer,
    event_count integer,
    category character varying(255)
);


ALTER TABLE clinlims.event_records_offset_marker OWNER TO clinlims;

--
-- Name: event_records_offset_marker_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE event_records_offset_marker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.event_records_offset_marker_id_seq OWNER TO clinlims;

--
-- Name: event_records_offset_marker_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE event_records_offset_marker_id_seq OWNED BY event_records_offset_marker.id;


--
-- Name: event_records_queue; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE event_records_queue (
    id integer NOT NULL,
    uuid character varying(40),
    title character varying(255),
    "timestamp" timestamp with time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    uri character varying(255),
    object character varying(1000),
    category character varying(255),
    tags character varying(255)
);


ALTER TABLE clinlims.event_records_queue OWNER TO clinlims;

--
-- Name: event_records_queue_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE event_records_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.event_records_queue_id_seq OWNER TO clinlims;

--
-- Name: event_records_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE event_records_queue_id_seq OWNED BY event_records_queue.id;


--
-- Name: external_reference; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE external_reference (
    id integer NOT NULL,
    item_id numeric(10,0) NOT NULL,
    external_id character varying(50) NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE clinlims.external_reference OWNER TO clinlims;

--
-- Name: external_reference_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE external_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.external_reference_id_seq OWNER TO clinlims;

--
-- Name: external_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE external_reference_id_seq OWNED BY external_reference.id;


--
-- Name: failed_event_retry_log; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE failed_event_retry_log (
    id integer NOT NULL,
    feed_uri character varying(255),
    failed_at timestamp with time zone,
    error_message character varying(4000),
    event_id character varying(255),
    event_content character varying(4000),
    error_hash_code integer
);


ALTER TABLE clinlims.failed_event_retry_log OWNER TO clinlims;

--
-- Name: failed_event_retry_log_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE failed_event_retry_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.failed_event_retry_log_id_seq OWNER TO clinlims;

--
-- Name: failed_event_retry_log_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE failed_event_retry_log_id_seq OWNED BY failed_event_retry_log.id;


--
-- Name: failed_events; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE failed_events (
    id integer NOT NULL,
    feed_uri character varying(255),
    error_message character varying(4000),
    event_id character varying(255),
    event_content character varying(4000),
    failed_at timestamp with time zone,
    error_hash_code integer,
    title character varying(255),
    retries integer DEFAULT 0 NOT NULL,
    tags character varying(255)
);


ALTER TABLE clinlims.failed_events OWNER TO clinlims;

--
-- Name: failed_events_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE failed_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.failed_events_id_seq OWNER TO clinlims;

--
-- Name: failed_events_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE failed_events_id_seq OWNED BY failed_events.id;


--
-- Name: gender; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE gender (
    id numeric(10,0) NOT NULL,
    gender_type character varying(1),
    description character varying(20),
    lastupdated timestamp(6) without time zone,
    name_key character varying(60)
);


ALTER TABLE clinlims.gender OWNER TO clinlims;

--
-- Name: COLUMN gender.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN gender.id IS 'A unique auto generated integer number assigned by database';


--
-- Name: COLUMN gender.gender_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN gender.gender_type IS 'Gender code (M, F, U)';


--
-- Name: COLUMN gender.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN gender.description IS 'Human readable description';


--
-- Name: gender_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE gender_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.gender_seq OWNER TO clinlims;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.hibernate_sequence OWNER TO clinlims;

--
-- Name: history; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE history (
    id numeric(10,0) NOT NULL,
    sys_user_id numeric(10,0) NOT NULL,
    reference_id numeric NOT NULL,
    reference_table numeric NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    activity character varying(1) NOT NULL,
    changes bytea
);


ALTER TABLE clinlims.history OWNER TO clinlims;

--
-- Name: COLUMN history.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.id IS 'Sequential number for audit records';


--
-- Name: COLUMN history.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN history.reference_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.reference_id IS 'Links to record in table to which this entry pertains';


--
-- Name: COLUMN history.reference_table; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.reference_table IS 'Link to table that this entity belongs to';


--
-- Name: COLUMN history."timestamp"; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history."timestamp" IS 'Date of history record';


--
-- Name: COLUMN history.activity; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.activity IS 'U for update, D for delete';


--
-- Name: COLUMN history.changes; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN history.changes IS 'XML image of record prior to change';


--
-- Name: history_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE history_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.history_seq OWNER TO clinlims;

--
-- Name: hl7_encoding_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE hl7_encoding_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.hl7_encoding_type_seq OWNER TO clinlims;

--
-- Name: htmldb_plan_table; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE htmldb_plan_table (
    statement_id character varying(30),
    plan_id numeric,
    "timestamp" timestamp without time zone,
    remarks character varying(4000),
    operation character varying(30),
    options character varying(255),
    object_node character varying(128),
    object_owner character varying(30),
    object_name character varying(30),
    object_alias character varying(65),
    object_instance numeric,
    object_type character varying(30),
    optimizer character varying(255),
    search_columns numeric,
    id numeric,
    parent_id numeric,
    depth numeric,
    "position" numeric,
    cost numeric,
    cardinality numeric,
    bytes numeric,
    other_tag character varying(255),
    partition_start character varying(255),
    partition_stop character varying(255),
    partition_id numeric,
    other text,
    distribution character varying(30),
    cpu_cost numeric,
    io_cost numeric,
    temp_space numeric,
    access_predicates character varying(4000),
    filter_predicates character varying(4000),
    projection character varying(4000),
    "time" numeric,
    qblock_name character varying(30)
);


ALTER TABLE clinlims.htmldb_plan_table OWNER TO clinlims;

--
-- Name: import_status; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE import_status (
    id integer NOT NULL,
    original_file_name text NOT NULL,
    saved_file_name text NOT NULL,
    error_file_name text,
    type character varying(10) NOT NULL,
    status character varying(25) NOT NULL,
    successful_records numeric(6,0),
    failed_records numeric(6,0),
    stage_name character varying(10),
    uploaded_by character varying(20) NOT NULL,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    stack_trace text
);


ALTER TABLE clinlims.import_status OWNER TO clinlims;

--
-- Name: import_status_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE import_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.import_status_id_seq OWNER TO clinlims;

--
-- Name: import_status_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE import_status_id_seq OWNED BY import_status.id;


--
-- Name: instrument; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE instrument (
    id numeric(10,0) NOT NULL,
    scrip_id numeric(10,0),
    name character varying(20),
    description character varying(60),
    instru_type character varying(30),
    is_active character varying(1),
    location character varying(60)
);


ALTER TABLE clinlims.instrument OWNER TO clinlims;

--
-- Name: COLUMN instrument.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument.name IS 'Short name for instrument';


--
-- Name: COLUMN instrument.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument.description IS 'Instrument description';


--
-- Name: COLUMN instrument.instru_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument.instru_type IS 'Type of instrument: Mass Spec, HPLC, etc.';


--
-- Name: COLUMN instrument.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument.is_active IS 'Flag indicating if the instrument is active';


--
-- Name: COLUMN instrument.location; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument.location IS 'Location of instrument';


--
-- Name: instrument_analyte; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE instrument_analyte (
    id numeric(10,0) NOT NULL,
    analyte_id numeric(10,0),
    instru_id numeric(10,0),
    method_id numeric(10,0),
    result_group numeric
);


ALTER TABLE clinlims.instrument_analyte OWNER TO clinlims;

--
-- Name: COLUMN instrument_analyte.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_analyte.id IS 'Sequential Identifier';


--
-- Name: COLUMN instrument_analyte.method_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_analyte.method_id IS 'Sequential number';


--
-- Name: COLUMN instrument_analyte.result_group; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_analyte.result_group IS 'A program generated group number';


--
-- Name: instrument_log; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE instrument_log (
    id numeric(10,0) NOT NULL,
    instru_id numeric(10,0),
    instlog_type character varying(1),
    event_begin timestamp without time zone,
    event_end timestamp without time zone
);


ALTER TABLE clinlims.instrument_log OWNER TO clinlims;

--
-- Name: COLUMN instrument_log.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_log.id IS 'Sequential Identifier';


--
-- Name: COLUMN instrument_log.instlog_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_log.instlog_type IS 'type of log entry: downtime, maintenance';


--
-- Name: COLUMN instrument_log.event_begin; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_log.event_begin IS 'date-time logged event started';


--
-- Name: COLUMN instrument_log.event_end; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN instrument_log.event_end IS 'Date-time logged event ended';


--
-- Name: inventory_component; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE inventory_component (
    id numeric(10,0) NOT NULL,
    invitem_id numeric(10,0),
    quantity numeric,
    material_component_id numeric(10,0)
);


ALTER TABLE clinlims.inventory_component OWNER TO clinlims;

--
-- Name: COLUMN inventory_component.quantity; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_component.quantity IS 'Quantity of material required';


--
-- Name: inventory_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE inventory_item (
    id numeric(10,0) NOT NULL,
    uom_id numeric(10,0),
    name character varying(20),
    description character varying(60),
    quantity_min_level numeric,
    quantity_max_level numeric,
    quantity_to_reorder numeric,
    is_reorder_auto character varying(1),
    is_lot_maintained character varying(1),
    is_active character varying(1),
    average_lead_time numeric,
    average_cost numeric,
    average_daily_use numeric
);


ALTER TABLE clinlims.inventory_item OWNER TO clinlims;

--
-- Name: COLUMN inventory_item.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.name IS 'Unique Short Name for this item ie "Red Top Tube"';


--
-- Name: COLUMN inventory_item.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.description IS 'Description of Item';


--
-- Name: COLUMN inventory_item.quantity_min_level; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.quantity_min_level IS 'Minimum inventory level';


--
-- Name: COLUMN inventory_item.quantity_max_level; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.quantity_max_level IS 'Maximum Inventory Level';


--
-- Name: COLUMN inventory_item.quantity_to_reorder; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.quantity_to_reorder IS 'Amount to reorder';


--
-- Name: COLUMN inventory_item.is_reorder_auto; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.is_reorder_auto IS 'Flag indicating system should automatically reorder';


--
-- Name: COLUMN inventory_item.is_lot_maintained; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.is_lot_maintained IS 'Indicates if individual lot information is maintained for this item';


--
-- Name: COLUMN inventory_item.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.is_active IS 'Indicates if this item is available for use.';


--
-- Name: COLUMN inventory_item.average_lead_time; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.average_lead_time IS 'Average lead time in days';


--
-- Name: COLUMN inventory_item.average_cost; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.average_cost IS 'Average cost per unit';


--
-- Name: COLUMN inventory_item.average_daily_use; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_item.average_daily_use IS 'Seasonally adjusted average usage per day';


--
-- Name: inventory_item_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE inventory_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.inventory_item_seq OWNER TO clinlims;

--
-- Name: inventory_location; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE inventory_location (
    id numeric(10,0) NOT NULL,
    storage_id numeric(10,0),
    lot_number character varying(20),
    quantity_onhand numeric,
    expiration_date timestamp without time zone,
    inv_item_id numeric(10,0)
);


ALTER TABLE clinlims.inventory_location OWNER TO clinlims;

--
-- Name: COLUMN inventory_location.lot_number; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_location.lot_number IS 'Lot number';


--
-- Name: COLUMN inventory_location.quantity_onhand; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_location.quantity_onhand IS 'Number of units onhand';


--
-- Name: inventory_location_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE inventory_location_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.inventory_location_seq OWNER TO clinlims;

--
-- Name: inventory_receipt; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE inventory_receipt (
    id numeric(10,0) NOT NULL,
    invitem_id numeric(10,0) NOT NULL,
    received_date timestamp without time zone,
    quantity_received numeric,
    unit_cost numeric,
    qc_reference character varying(20),
    external_reference character varying(20),
    org_id numeric(10,0)
);


ALTER TABLE clinlims.inventory_receipt OWNER TO clinlims;

--
-- Name: COLUMN inventory_receipt.received_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_receipt.received_date IS 'Date and time item was received';


--
-- Name: COLUMN inventory_receipt.quantity_received; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_receipt.quantity_received IS 'Number of units received';


--
-- Name: COLUMN inventory_receipt.unit_cost; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_receipt.unit_cost IS 'Cost per unit item';


--
-- Name: COLUMN inventory_receipt.qc_reference; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_receipt.qc_reference IS 'External QC reference number';


--
-- Name: COLUMN inventory_receipt.external_reference; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN inventory_receipt.external_reference IS 'External reference to purchase order, invoice number.';


--
-- Name: inventory_receipt_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE inventory_receipt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.inventory_receipt_seq OWNER TO clinlims;

--
-- Name: lab_order_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE lab_order_item (
    id numeric(10,0) NOT NULL,
    lab_order_type_id numeric(10,0) NOT NULL,
    table_ref numeric(10,0),
    record_id numeric(10,0),
    identifier character varying(20),
    action character varying(20),
    lastupdated timestamp with time zone DEFAULT now()
);


ALTER TABLE clinlims.lab_order_item OWNER TO clinlims;

--
-- Name: TABLE lab_order_item; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE lab_order_item IS 'Association table between lab order type and the thing they affect';


--
-- Name: COLUMN lab_order_item.lab_order_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_item.lab_order_type_id IS 'The lab order type this refers to';


--
-- Name: COLUMN lab_order_item.table_ref; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_item.table_ref IS 'If the thing it refers to is a db object what table is it in';


--
-- Name: COLUMN lab_order_item.record_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_item.record_id IS 'If the thing it refers to is a db object what record in the table is it';


--
-- Name: COLUMN lab_order_item.identifier; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_item.identifier IS 'If this is not a db object then another way to identify it.  could be a class name on a form';


--
-- Name: COLUMN lab_order_item.action; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_item.action IS 'What should happen if this is in a lab order type';


--
-- Name: lab_order_item_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE lab_order_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.lab_order_item_seq OWNER TO clinlims;

--
-- Name: lab_order_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE lab_order_type (
    id numeric(10,0) NOT NULL,
    domain character varying(20) NOT NULL,
    type character varying(40) NOT NULL,
    context character varying(60),
    description character varying(60),
    sort_order numeric,
    lastupdated timestamp with time zone,
    display_key character varying(60)
);


ALTER TABLE clinlims.lab_order_type OWNER TO clinlims;

--
-- Name: TABLE lab_order_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE lab_order_type IS 'If lab differentiates based on the type of order i.e. first visit, follow-up.  The types are defined here';


--
-- Name: COLUMN lab_order_type.domain; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_type.domain IS 'Refers to Human, Environmental, New born etc';


--
-- Name: COLUMN lab_order_type.type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_type.type IS 'The lab order type i.e. first visit, follow-up etc';


--
-- Name: COLUMN lab_order_type.context; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_type.context IS 'What is the context that this type is significant. i.e. Sample Entry, confirmation entry';


--
-- Name: COLUMN lab_order_type.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_type.sort_order IS 'What is the order when displayed to the user';


--
-- Name: COLUMN lab_order_type.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN lab_order_type.display_key IS 'Localization information.  Match found in MessageResource.properties';


--
-- Name: lab_order_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE lab_order_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.lab_order_type_seq OWNER TO clinlims;

--
-- Name: label; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE label (
    id numeric(10,0) NOT NULL,
    name character varying(30),
    description character varying(60),
    printer_type character(1),
    scriptlet_id numeric(10,0),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.label OWNER TO clinlims;

--
-- Name: label_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE label_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.label_seq OWNER TO clinlims;

--
-- Name: login_user; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE login_user (
    id numeric(10,0) NOT NULL,
    login_name character varying(20) NOT NULL,
    password character varying(256) NOT NULL,
    password_expired_dt date NOT NULL,
    account_locked character varying(1) NOT NULL,
    account_disabled character varying(1) NOT NULL,
    is_admin character varying(1) NOT NULL,
    user_time_out character varying(3) NOT NULL
);


ALTER TABLE clinlims.login_user OWNER TO clinlims;

--
-- Name: COLUMN login_user.login_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.login_name IS 'User LOGIN_NAME from SYSTEM_USER table';


--
-- Name: COLUMN login_user.password; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.password IS 'User password';


--
-- Name: COLUMN login_user.password_expired_dt; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.password_expired_dt IS 'Password expiration date';


--
-- Name: COLUMN login_user.account_locked; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.account_locked IS 'Account locked (Y/N)';


--
-- Name: COLUMN login_user.account_disabled; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.account_disabled IS 'Account disabled (Y/N)';


--
-- Name: COLUMN login_user.is_admin; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.is_admin IS 'Indicates if this user is administrator (Y/N)';


--
-- Name: COLUMN login_user.user_time_out; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN login_user.user_time_out IS 'User session time out in minute';


--
-- Name: login_user_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE login_user_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.login_user_seq OWNER TO clinlims;

--
-- Name: markers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE markers (
    id integer NOT NULL,
    feed_uri_for_last_read_entry character varying(250),
    feed_uri character varying(250) NOT NULL,
    last_read_entry_id character varying(250)
);


ALTER TABLE clinlims.markers OWNER TO clinlims;

--
-- Name: markers_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE markers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.markers_id_seq OWNER TO clinlims;

--
-- Name: markers_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE markers_id_seq OWNED BY markers.id;


--
-- Name: menu; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE menu (
    id numeric(10,0) NOT NULL,
    parent_id numeric(10,0),
    presentation_order numeric,
    element_id character varying(40) NOT NULL,
    action_url character varying(120),
    click_action character varying(120),
    display_key character varying(60),
    tool_tip_key character varying(60),
    new_window boolean DEFAULT false
);


ALTER TABLE clinlims.menu OWNER TO clinlims;

--
-- Name: TABLE menu; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE menu IS 'Table for menuing system';


--
-- Name: COLUMN menu.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.id IS 'primary key';


--
-- Name: COLUMN menu.parent_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.parent_id IS 'If this is a submenu then the parent menu id';


--
-- Name: COLUMN menu.presentation_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.presentation_order IS 'For top level menus the order across the page for sub menu the order in the popup menu.  If there is a collision then the order is alphebetical';


--
-- Name: COLUMN menu.element_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.element_id IS 'The element id in the context of HTML.';


--
-- Name: COLUMN menu.action_url; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.action_url IS 'If clicking on the element moves to a new page, the url of that page';


--
-- Name: COLUMN menu.click_action; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.click_action IS 'If clicking on the element calls javascript then the javascript call';


--
-- Name: COLUMN menu.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.display_key IS 'The message key for what will be displayed in the menu';


--
-- Name: COLUMN menu.tool_tip_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.tool_tip_key IS 'The message key for the tool-tip';


--
-- Name: COLUMN menu.new_window; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN menu.new_window IS 'If true the menu action will be done in a new window';


--
-- Name: menu_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE menu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.menu_seq OWNER TO clinlims;

--
-- Name: message_org; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE message_org (
    id numeric(10,0) NOT NULL,
    org_id character varying(60),
    is_active character varying(1),
    active_begin timestamp without time zone,
    active_end timestamp without time zone,
    description character varying(60),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.message_org OWNER TO clinlims;

--
-- Name: message_org_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE message_org_seq
    START WITH 41
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.message_org_seq OWNER TO clinlims;

--
-- Name: messagecontrolidseq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE messagecontrolidseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.messagecontrolidseq OWNER TO clinlims;

--
-- Name: method; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE method (
    id numeric(10,0) NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(60) NOT NULL,
    reporting_description character varying(60),
    is_active character varying(1),
    active_begin timestamp without time zone,
    active_end timestamp without time zone,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.method OWNER TO clinlims;

--
-- Name: COLUMN method.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.id IS 'Sequential number';


--
-- Name: COLUMN method.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.name IS 'Sort name for method';


--
-- Name: COLUMN method.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.description IS 'Description for Method';


--
-- Name: COLUMN method.reporting_description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.reporting_description IS 'Description that appears on reports';


--
-- Name: COLUMN method.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.is_active IS 'Flag indicating if the test is active';


--
-- Name: COLUMN method.active_begin; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.active_begin IS 'Date test was moved into production';


--
-- Name: COLUMN method.active_end; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method.active_end IS 'Date test was removed from production';


--
-- Name: method_analyte; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE method_analyte (
    id numeric(10,0) NOT NULL,
    method_id numeric(10,0),
    analyte_id numeric(10,0),
    result_group numeric,
    sort_order numeric,
    ma_type character varying(1)
);


ALTER TABLE clinlims.method_analyte OWNER TO clinlims;

--
-- Name: COLUMN method_analyte.method_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_analyte.method_id IS 'Sequential number';


--
-- Name: COLUMN method_analyte.result_group; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_analyte.result_group IS 'a program generated group (sequence) number';


--
-- Name: COLUMN method_analyte.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_analyte.sort_order IS 'The order the analytes are displayed (sort order)';


--
-- Name: COLUMN method_analyte.ma_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_analyte.ma_type IS 'type of analyte';


--
-- Name: method_result; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE method_result (
    id numeric(10,0) NOT NULL,
    scrip_id numeric(10,0),
    result_group numeric,
    flags character varying(10),
    methres_type character varying(1),
    value character varying(80),
    quant_limit character varying(30),
    cont_level character varying(30),
    method_id numeric(10,0)
);


ALTER TABLE clinlims.method_result OWNER TO clinlims;

--
-- Name: COLUMN method_result.result_group; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.result_group IS 'The method analyte result group number';


--
-- Name: COLUMN method_result.flags; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.flags IS 'A string of 1 character codes: Positive, Reportable';


--
-- Name: COLUMN method_result.methres_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.methres_type IS 'Type of parameter: Dictionary, Titer-range, Number-range, date';


--
-- Name: COLUMN method_result.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.value IS 'A possible result value based on type';


--
-- Name: COLUMN method_result.quant_limit; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.quant_limit IS 'Quantitation Limit (if any)';


--
-- Name: COLUMN method_result.cont_level; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN method_result.cont_level IS 'Contaminant level (if any)';


--
-- Name: method_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE method_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.method_seq OWNER TO clinlims;

--
-- Name: mls_lab_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE mls_lab_type (
    id numeric(10,0) NOT NULL,
    description character varying(50) NOT NULL,
    org_mlt_org_mlt_id numeric(10,0)
);


ALTER TABLE clinlims.mls_lab_type OWNER TO clinlims;

--
-- Name: COLUMN mls_lab_type.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN mls_lab_type.id IS 'Sequential ID';


--
-- Name: COLUMN mls_lab_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN mls_lab_type.description IS 'Used to define MLS lab types including Level A, Urine, Virology';


--
-- Name: note; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE note (
    id numeric(10,0) NOT NULL,
    sys_user_id numeric(10,0),
    reference_id numeric,
    reference_table numeric,
    note_type character varying(1),
    subject character varying(60),
    text text,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.note OWNER TO clinlims;

--
-- Name: COLUMN note.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN note.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN note.reference_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN note.reference_id IS 'Link to record in table to which this entry pertains.';


--
-- Name: COLUMN note.reference_table; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN note.reference_table IS 'Link to table that this entity belongs to';


--
-- Name: COLUMN note.note_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN note.note_type IS 'Type of comment such as external, internal';


--
-- Name: COLUMN note.subject; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN note.subject IS 'Comment subject';


--
-- Name: note_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE note_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.note_seq OWNER TO clinlims;

--
-- Name: observation_history; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE observation_history (
    id numeric(10,0) NOT NULL,
    patient_id numeric(10,0) NOT NULL,
    sample_id numeric(10,0) NOT NULL,
    observation_history_type_id numeric(10,0) NOT NULL,
    value_type character varying(5) NOT NULL,
    value character varying(80),
    lastupdated timestamp with time zone,
    sample_item_id numeric(10,0)
);


ALTER TABLE clinlims.observation_history OWNER TO clinlims;

--
-- Name: TABLE observation_history; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE observation_history IS 'defines the answer at the time of a interview (with sample) to a demographic question.';


--
-- Name: COLUMN observation_history.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.id IS 'primary key';


--
-- Name: COLUMN observation_history.patient_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.patient_id IS 'FK linking this information to a patient';


--
-- Name: COLUMN observation_history.sample_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.sample_id IS 'FK linking this information to a sample (and a collection date).';


--
-- Name: COLUMN observation_history.observation_history_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.observation_history_type_id IS 'FK to type table to define what is contained in the value column';


--
-- Name: COLUMN observation_history.value_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.value_type IS 'L=local or literal, a value right here in the history table. D=Defined/Dictionary, the value is a foreign key to the Dictionary table. For multiple choice questions with fixed answers.';


--
-- Name: COLUMN observation_history.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.value IS 'either a literal value for this demo. type, or a Foreign key to dictionary';


--
-- Name: COLUMN observation_history.sample_item_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history.sample_item_id IS 'Optional refereence to sample item';


--
-- Name: observation_history_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE observation_history_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.observation_history_seq OWNER TO clinlims;

--
-- Name: observation_history_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE observation_history_type (
    id numeric(10,0) NOT NULL,
    type_name character varying(30) NOT NULL,
    description character varying(400),
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.observation_history_type OWNER TO clinlims;

--
-- Name: TABLE observation_history_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE observation_history_type IS 'defines the possible classes of values allowed in the demo. history table.';


--
-- Name: COLUMN observation_history_type.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history_type.id IS 'primary key';


--
-- Name: COLUMN observation_history_type.type_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history_type.type_name IS 'a short tag (1 word) for this type. What was asked "Gender", "HIVPositive" etc.';


--
-- Name: COLUMN observation_history_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history_type.description IS 'a long description of this type.';


--
-- Name: COLUMN observation_history_type.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN observation_history_type.lastupdated IS 'the last time this item was written to the database.';


--
-- Name: observation_history_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE observation_history_type_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.observation_history_type_seq OWNER TO clinlims;

--
-- Name: occupation; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE occupation (
    id numeric(10,0) NOT NULL,
    occupation character varying(300),
    lastupdated timestamp without time zone
);


ALTER TABLE clinlims.occupation OWNER TO clinlims;

--
-- Name: occupation_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE occupation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.occupation_seq OWNER TO clinlims;

--
-- Name: or_properties; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE or_properties (
    property_id integer NOT NULL,
    property_key character varying(255) NOT NULL,
    property_value character varying(255)
);


ALTER TABLE clinlims.or_properties OWNER TO clinlims;

--
-- Name: or_tags; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE or_tags (
    tag_id integer NOT NULL,
    tagged_object_id integer NOT NULL,
    tagged_object_class character varying(255) NOT NULL,
    tag_value character varying(255) NOT NULL,
    tag_type character varying(255) NOT NULL
);


ALTER TABLE clinlims.or_tags OWNER TO clinlims;

--
-- Name: order_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE order_item (
    id numeric(10,0) NOT NULL,
    ord_id numeric(10,0) NOT NULL,
    quantity_requested numeric,
    quantity_received numeric,
    inv_loc_id numeric(10,0)
);


ALTER TABLE clinlims.order_item OWNER TO clinlims;

--
-- Name: COLUMN order_item.quantity_requested; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN order_item.quantity_requested IS 'Quantity requested by organization';


--
-- Name: COLUMN order_item.quantity_received; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN order_item.quantity_received IS 'Quantity received';


--
-- Name: orders; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE orders (
    id numeric(10,0) NOT NULL,
    org_id numeric(10,0) NOT NULL,
    sys_user_id numeric(10,0),
    ordered_date timestamp without time zone,
    neededby_date timestamp without time zone,
    requested_by character varying(30),
    cost_center character varying(15),
    shipping_type character varying(2),
    shipping_carrier character varying(2),
    shipping_cost numeric,
    delivered_date timestamp without time zone,
    is_external character varying(1),
    external_order_number character varying(20),
    is_filled character varying(1)
);


ALTER TABLE clinlims.orders OWNER TO clinlims;

--
-- Name: COLUMN orders.org_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.org_id IS 'Sequential Numbering Field';


--
-- Name: COLUMN orders.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN orders.neededby_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.neededby_date IS 'Date-time the order must be received by client';


--
-- Name: COLUMN orders.requested_by; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.requested_by IS 'Name of person/entity who placed the order';


--
-- Name: COLUMN orders.cost_center; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.cost_center IS 'Entity or project the order will be charged against';


--
-- Name: COLUMN orders.shipping_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.shipping_type IS 'Type of shipping such as: Air, ground, First Class, Bulk....';


--
-- Name: COLUMN orders.shipping_carrier; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.shipping_carrier IS 'Company used for shipping: UPS, FedEx, USPS...';


--
-- Name: COLUMN orders.shipping_cost; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.shipping_cost IS 'Shipping Cost';


--
-- Name: COLUMN orders.delivered_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.delivered_date IS 'Date-time shipment received by client (including us)';


--
-- Name: COLUMN orders.is_external; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.is_external IS 'Indicates if current order will be filled by an external vendor';


--
-- Name: COLUMN orders.external_order_number; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.external_order_number IS 'External order number';


--
-- Name: COLUMN orders.is_filled; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN orders.is_filled IS 'Flag indicating if the order has been filled';


--
-- Name: org_hl7_encoding_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE org_hl7_encoding_type (
    organization_id numeric(10,0) NOT NULL,
    encoding_type_id numeric(10,0) NOT NULL,
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.org_hl7_encoding_type OWNER TO clinlims;

--
-- Name: TABLE org_hl7_encoding_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE org_hl7_encoding_type IS 'mapping table to identify which organization uses which hly encoding schema';


--
-- Name: org_mls_lab_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE org_mls_lab_type (
    org_id numeric NOT NULL,
    mls_lab_id numeric NOT NULL,
    org_mlt_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.org_mls_lab_type OWNER TO clinlims;

--
-- Name: COLUMN org_mls_lab_type.org_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN org_mls_lab_type.org_id IS 'foreign key from organization table';


--
-- Name: COLUMN org_mls_lab_type.mls_lab_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN org_mls_lab_type.mls_lab_id IS 'foreign key from MLS lab type table';


--
-- Name: organization; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE organization (
    id numeric(10,0) NOT NULL,
    name character varying(80) NOT NULL,
    city character varying(30),
    zip_code character varying(10),
    mls_sentinel_lab_flag character varying(1) DEFAULT 'N'::character varying NOT NULL,
    org_mlt_org_mlt_id numeric(10,0),
    org_id numeric(10,0),
    short_name character varying(15),
    multiple_unit character varying(30),
    street_address character varying(30),
    state character varying(2),
    internet_address character varying(40),
    clia_num character varying(12),
    pws_id character varying(15),
    lastupdated timestamp(6) without time zone,
    mls_lab_flag character(1),
    is_active character(1),
    local_abbrev character varying(10)
);


ALTER TABLE clinlims.organization OWNER TO clinlims;

--
-- Name: COLUMN organization.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.id IS 'Sequential Numbering Field';


--
-- Name: COLUMN organization.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.name IS 'The full name of an organization';


--
-- Name: COLUMN organization.city; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.city IS 'City';


--
-- Name: COLUMN organization.zip_code; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.zip_code IS 'Zip code';


--
-- Name: COLUMN organization.mls_sentinel_lab_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.mls_sentinel_lab_flag IS 'Yes or No field indicating that the submitter is an Minnesota Laboratory System Lab';


--
-- Name: COLUMN organization.org_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.org_id IS 'Sequential Numbering Field';


--
-- Name: COLUMN organization.short_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.short_name IS 'A shortened or abbreviated name of an organization. For example "BCBSM" is the short name for Blue Cross Blue Shield Minnesota';


--
-- Name: COLUMN organization.multiple_unit; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.multiple_unit IS 'Apartment number or unit information';


--
-- Name: COLUMN organization.street_address; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.street_address IS 'Street address for this organization';


--
-- Name: COLUMN organization.state; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.state IS 'State or Province';


--
-- Name: COLUMN organization.internet_address; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.internet_address IS 'A uniform resource locator (URL), ie a website address assigned to an entity or pager.';


--
-- Name: COLUMN organization.clia_num; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.clia_num IS 'Clinical Laboratory Improvement Amendments number';


--
-- Name: COLUMN organization.pws_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization.pws_id IS 'Public water supply id (SDWIS)';


--
-- Name: organization_address; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE organization_address (
    organization_id numeric(10,0) NOT NULL,
    address_part_id numeric(10,0) NOT NULL,
    type character(1) DEFAULT 'T'::bpchar,
    value character varying(120)
);


ALTER TABLE clinlims.organization_address OWNER TO clinlims;

--
-- Name: TABLE organization_address; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE organization_address IS 'Join table between address parts and an organization';


--
-- Name: COLUMN organization_address.organization_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_address.organization_id IS 'The id of the organization who this address is attached to';


--
-- Name: COLUMN organization_address.address_part_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_address.address_part_id IS 'The id of the address part for which we have a value';


--
-- Name: COLUMN organization_address.type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_address.type IS 'The type of the value, either D for dictionary or T for text';


--
-- Name: COLUMN organization_address.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_address.value IS 'The actual value for this part of the address';


--
-- Name: organization_contact; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE organization_contact (
    id numeric(10,0) NOT NULL,
    organization_id numeric(10,0) NOT NULL,
    person_id numeric(10,0) NOT NULL,
    "position" character varying(32)
);


ALTER TABLE clinlims.organization_contact OWNER TO clinlims;

--
-- Name: TABLE organization_contact; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE organization_contact IS 'A join table between organizations and persons';


--
-- Name: COLUMN organization_contact.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_contact.id IS 'Unique key for each row';


--
-- Name: COLUMN organization_contact.organization_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_contact.organization_id IS 'The id of the organization being referred to';


--
-- Name: COLUMN organization_contact.person_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_contact.person_id IS 'The id of the person being referred to';


--
-- Name: COLUMN organization_contact."position"; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_contact."position" IS 'The position of the person within the organization';


--
-- Name: organization_contact_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE organization_contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.organization_contact_seq OWNER TO clinlims;

--
-- Name: organization_organization_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE organization_organization_type (
    org_id numeric(10,0) NOT NULL,
    org_type_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.organization_organization_type OWNER TO clinlims;

--
-- Name: TABLE organization_organization_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE organization_organization_type IS 'many to many mapping table between organization and orginaztion type';


--
-- Name: organization_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE organization_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.organization_seq OWNER TO clinlims;

--
-- Name: organization_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE organization_type (
    id numeric(10,0) NOT NULL,
    short_name character varying(20) NOT NULL,
    description character varying(60),
    name_display_key character varying(60),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.organization_type OWNER TO clinlims;

--
-- Name: TABLE organization_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE organization_type IS 'The type of an organization.  Releationship will be many to many';


--
-- Name: COLUMN organization_type.short_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_type.short_name IS 'The name to be displayed in when organization type is to be associated with an organization';


--
-- Name: COLUMN organization_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_type.description IS 'Optional longer description of the type';


--
-- Name: COLUMN organization_type.name_display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN organization_type.name_display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: organization_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE organization_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.organization_type_seq OWNER TO clinlims;

--
-- Name: package_1; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE package_1 (
    id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.package_1 OWNER TO clinlims;

--
-- Name: panel; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE panel (
    id numeric(10,0) NOT NULL,
    name character varying(64),
    description character varying(64) NOT NULL,
    lastupdated timestamp(6) without time zone,
    display_key character varying(60),
    sort_order numeric DEFAULT 2147483647,
    is_active character varying(1) DEFAULT 'Y'::character varying
);


ALTER TABLE clinlims.panel OWNER TO clinlims;

--
-- Name: COLUMN panel.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN panel.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: COLUMN panel.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN panel.is_active IS 'Is this panel currently active';


--
-- Name: panel_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE panel_item (
    id numeric(10,0) NOT NULL,
    panel_id numeric(10,0) NOT NULL,
    sort_order numeric,
    test_local_abbrev character varying(100),
    method_name character varying(20),
    lastupdated timestamp(6) without time zone,
    test_name character varying(20),
    test_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.panel_item OWNER TO clinlims;

--
-- Name: COLUMN panel_item.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN panel_item.sort_order IS 'The order the tests are displayed (sort order)';


--
-- Name: COLUMN panel_item.test_local_abbrev; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN panel_item.test_local_abbrev IS 'Short test name';


--
-- Name: COLUMN panel_item.method_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN panel_item.method_name IS 'Short method name';


--
-- Name: panel_item_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE panel_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.panel_item_seq OWNER TO clinlims;

--
-- Name: panel_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE panel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.panel_seq OWNER TO clinlims;

--
-- Name: patient; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient (
    id numeric(10,0) NOT NULL,
    person_id numeric(10,0) NOT NULL,
    race character varying(5),
    gender character varying(1),
    birth_date timestamp without time zone,
    epi_first_name character varying(25),
    epi_middle_name character varying(25),
    epi_last_name character varying(240),
    birth_time timestamp without time zone,
    death_date timestamp without time zone,
    national_id character varying(240),
    ethnicity character varying(1),
    school_attend character varying(240),
    medicare_id character varying(240),
    medicaid_id character varying(240),
    birth_place character varying(35),
    lastupdated timestamp(6) without time zone,
    external_id character varying(20),
    chart_number character varying(20),
    entered_birth_date character varying(10),
    uuid character varying(100)
);


ALTER TABLE clinlims.patient OWNER TO clinlims;

--
-- Name: COLUMN patient.race; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.race IS 'A string of 1 character race code(s)';


--
-- Name: COLUMN patient.gender; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.gender IS 'A one character gender code';


--
-- Name: COLUMN patient.birth_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.birth_date IS 'Date of birth';


--
-- Name: COLUMN patient.birth_time; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.birth_time IS 'Time of birth for newborn patients';


--
-- Name: COLUMN patient.death_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.death_date IS 'Date of death if unexplained illness or death';


--
-- Name: COLUMN patient.national_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.national_id IS 'National Patient ID or SSN';


--
-- Name: COLUMN patient.medicare_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.medicare_id IS 'Medicare Number';


--
-- Name: COLUMN patient.medicaid_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.medicaid_id IS 'Medicaid Number';


--
-- Name: COLUMN patient.entered_birth_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient.entered_birth_date IS 'Persons birthdate may not be known and it will be entered with XX for date and/or month';


--
-- Name: patient_identity; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_identity (
    id numeric(10,0) NOT NULL,
    identity_type_id numeric(10,0),
    patient_id numeric(10,0),
    identity_data character varying(255),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.patient_identity OWNER TO clinlims;

--
-- Name: patient_identity_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_identity_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_identity_seq OWNER TO clinlims;

--
-- Name: patient_identity_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_identity_type (
    id numeric(10,0) NOT NULL,
    identity_type character varying(30),
    description character varying(400),
    lastupdated timestamp without time zone
);


ALTER TABLE clinlims.patient_identity_type OWNER TO clinlims;

--
-- Name: patient_identity_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_identity_type_seq
    START WITH 30
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_identity_type_seq OWNER TO clinlims;

--
-- Name: patient_occupation; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_occupation (
    id numeric(10,0) NOT NULL,
    patient_id numeric(10,0),
    occupation character varying(400),
    lastupdated timestamp without time zone
);


ALTER TABLE clinlims.patient_occupation OWNER TO clinlims;

--
-- Name: patient_occupation_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_occupation_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_occupation_seq OWNER TO clinlims;

--
-- Name: patient_patient_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_patient_type (
    id numeric(10,0) NOT NULL,
    patient_type_id numeric(10,0),
    patient_id numeric(10,0),
    lastupdated timestamp without time zone
);


ALTER TABLE clinlims.patient_patient_type OWNER TO clinlims;

--
-- Name: patient_patient_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_patient_type_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_patient_type_seq OWNER TO clinlims;

--
-- Name: patient_relation_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_relation_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_relation_seq OWNER TO clinlims;

--
-- Name: patient_relations; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_relations (
    id numeric(10,0) NOT NULL,
    pat_id_source numeric(10,0) NOT NULL,
    pat_id numeric(10,0),
    relation character varying(1)
);


ALTER TABLE clinlims.patient_relations OWNER TO clinlims;

--
-- Name: COLUMN patient_relations.relation; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN patient_relations.relation IS 'Type of relation (mother to child, parent to child, sibling)';


--
-- Name: patient_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.patient_seq OWNER TO clinlims;

--
-- Name: patient_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE patient_type (
    id numeric(10,0) NOT NULL,
    type character varying(300),
    description character varying(4000),
    lastupdated timestamp without time zone
);


ALTER TABLE clinlims.patient_type OWNER TO clinlims;

--
-- Name: patient_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE patient_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.patient_type_seq OWNER TO clinlims;

--
-- Name: payment_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE payment_type (
    id numeric(10,0) NOT NULL,
    type character varying(300),
    description character varying(4000)
);


ALTER TABLE clinlims.payment_type OWNER TO clinlims;

--
-- Name: payment_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE payment_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.payment_type_seq OWNER TO clinlims;

--
-- Name: person; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE person (
    id numeric(10,0) NOT NULL,
    last_name character varying(50),
    first_name character varying(50),
    middle_name character varying(50),
    multiple_unit character varying(30),
    street_address character(30),
    city character(30),
    state character(2),
    zip_code character(10),
    country character varying(20),
    work_phone character varying(17),
    home_phone character(12),
    cell_phone character varying(17),
    fax character varying(17),
    email character varying(60),
    lastupdated timestamp(6) without time zone,
    is_active boolean DEFAULT true
);


ALTER TABLE clinlims.person OWNER TO clinlims;

--
-- Name: COLUMN person.last_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person.last_name IS 'Last name';


--
-- Name: COLUMN person.first_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person.first_name IS 'Person Name';


--
-- Name: COLUMN person.middle_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person.middle_name IS 'Middle Name';


--
-- Name: COLUMN person.multiple_unit; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person.multiple_unit IS 'Designates a specific part of a building, such as "APT 212"';


--
-- Name: person_address; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE person_address (
    person_id numeric(10,0) NOT NULL,
    address_part_id numeric(10,0) NOT NULL,
    type character(1) DEFAULT 'T'::bpchar,
    value character varying(120)
);


ALTER TABLE clinlims.person_address OWNER TO clinlims;

--
-- Name: TABLE person_address; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE person_address IS 'Join table between address parts and a person';


--
-- Name: COLUMN person_address.person_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person_address.person_id IS 'The id of the person who this address is attached to';


--
-- Name: COLUMN person_address.address_part_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person_address.address_part_id IS 'The id of the address part for which we have a value';


--
-- Name: COLUMN person_address.type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person_address.type IS 'The type of the value, either D for dictionary or T for text';


--
-- Name: COLUMN person_address.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN person_address.value IS 'The actual value for this part of the address';


--
-- Name: person_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE person_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.person_seq OWNER TO clinlims;

--
-- Name: program; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE program (
    id numeric(10,0) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(50) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.program OWNER TO clinlims;

--
-- Name: COLUMN program.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN program.name IS 'EPI PROGRAM NAME';


--
-- Name: program_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE program_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.program_seq OWNER TO clinlims;

--
-- Name: project; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE project (
    id numeric(10,0) NOT NULL,
    name character varying(50) NOT NULL,
    sys_user_id numeric(10,0),
    description character varying(60),
    started_date timestamp without time zone,
    completed_date timestamp without time zone,
    is_active character varying(1),
    reference_to character varying(20),
    program_code character varying(10),
    lastupdated timestamp(6) without time zone,
    scriptlet_id numeric(10,0),
    local_abbrev numeric(10,0),
    display_key character varying(60)
);


ALTER TABLE clinlims.project OWNER TO clinlims;

--
-- Name: COLUMN project.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.id IS 'Sequential number assigned by sequence';


--
-- Name: COLUMN project.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.name IS 'Short name of Project';


--
-- Name: COLUMN project.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN project.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.description IS 'Description of Project';


--
-- Name: COLUMN project.started_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.started_date IS 'Start date of project';


--
-- Name: COLUMN project.completed_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.completed_date IS 'End date of project';


--
-- Name: COLUMN project.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.is_active IS 'Flag indicating if project is active';


--
-- Name: COLUMN project.reference_to; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.reference_to IS 'External reference information such as Grant number, contract number or purchase order number associated with this project.';


--
-- Name: COLUMN project.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: project_organization; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE project_organization (
    project_id numeric(10,0) NOT NULL,
    org_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.project_organization OWNER TO clinlims;

--
-- Name: TABLE project_organization; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE project_organization IS 'many to many mapping table between project and organization';


--
-- Name: project_parameter; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE project_parameter (
    id numeric(10,0) NOT NULL,
    projparam_type character varying(1),
    operation character varying(2),
    value character varying(256),
    project_id numeric(10,0),
    param_name character varying(80)
);


ALTER TABLE clinlims.project_parameter OWNER TO clinlims;

--
-- Name: COLUMN project_parameter.projparam_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project_parameter.projparam_type IS 'Type of parameter: apply-parameter or search-parameter';


--
-- Name: COLUMN project_parameter.operation; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project_parameter.operation IS 'Operation to be performed: =, <, <=, >, >=,in,!=';


--
-- Name: COLUMN project_parameter.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN project_parameter.value IS 'Query or Set value';


--
-- Name: project_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE project_seq
    START WITH 13
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.project_seq OWNER TO clinlims;

--
-- Name: provider; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE provider (
    id numeric(10,0) NOT NULL,
    npi character varying(10),
    person_id numeric(10,0) NOT NULL,
    external_id character varying(50),
    provider_type character varying(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.provider OWNER TO clinlims;

--
-- Name: COLUMN provider.npi; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN provider.npi IS 'Unique National Provider ID';


--
-- Name: COLUMN provider.external_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN provider.external_id IS 'National/Local provider reference number such as UPIN or MINC#NIMC';


--
-- Name: COLUMN provider.provider_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN provider.provider_type IS 'Type of Provider (physician, nurse)';


--
-- Name: provider_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE provider_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.provider_seq OWNER TO clinlims;

--
-- Name: qa_event; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qa_event (
    id numeric(10,0) NOT NULL,
    name character varying(20),
    description character varying(120),
    is_billable character varying(1),
    reporting_sequence numeric,
    reporting_text character varying(1000),
    test_id numeric(10,0),
    is_holdable character varying(1) NOT NULL,
    lastupdated timestamp(6) without time zone,
    type numeric(10,0),
    category numeric(10,0),
    display_key character varying(60)
);


ALTER TABLE clinlims.qa_event OWNER TO clinlims;

--
-- Name: COLUMN qa_event.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.name IS 'Short Name';


--
-- Name: COLUMN qa_event.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.description IS 'Description of the QA event';


--
-- Name: COLUMN qa_event.is_billable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.is_billable IS 'Indicates if analysis with this QA Event is billable';


--
-- Name: COLUMN qa_event.reporting_sequence; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.reporting_sequence IS 'An overall number that orders the print sequence';


--
-- Name: COLUMN qa_event.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.test_id IS 'Reported/printed text';


--
-- Name: COLUMN qa_event.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_event.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: qa_event_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE qa_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.qa_event_seq OWNER TO clinlims;

--
-- Name: qa_observation; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qa_observation (
    id numeric(10,0) NOT NULL,
    observed_id numeric(10,0) NOT NULL,
    observed_type character varying(30) NOT NULL,
    qa_observation_type_id numeric(10,0) NOT NULL,
    value_type character varying(1) NOT NULL,
    value character varying(30) NOT NULL,
    lastupdated timestamp with time zone DEFAULT now()
);


ALTER TABLE clinlims.qa_observation OWNER TO clinlims;

--
-- Name: TABLE qa_observation; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE qa_observation IS 'The observation that are about sample/analysis qa_events.  Does not include data about the sample';


--
-- Name: COLUMN qa_observation.observed_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_observation.observed_id IS 'The row id for either sample_qaEvent or analysis_qaEvent';


--
-- Name: COLUMN qa_observation.observed_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_observation.observed_type IS 'One of ANALYSIS or SAMPLE';


--
-- Name: COLUMN qa_observation.qa_observation_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_observation.qa_observation_type_id IS 'The type of observation this is';


--
-- Name: COLUMN qa_observation.value_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_observation.value_type IS 'Dictionary or literal, D or L';


--
-- Name: COLUMN qa_observation.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qa_observation.value IS 'The actual value';


--
-- Name: qa_observation_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE qa_observation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.qa_observation_seq OWNER TO clinlims;

--
-- Name: qa_observation_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qa_observation_type (
    id numeric(10,0) NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(60),
    lastupdated timestamp with time zone DEFAULT now()
);


ALTER TABLE clinlims.qa_observation_type OWNER TO clinlims;

--
-- Name: TABLE qa_observation_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE qa_observation_type IS 'The types of observation that are about sample/analysis qa_events ';


--
-- Name: qa_observation_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE qa_observation_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.qa_observation_type_seq OWNER TO clinlims;

--
-- Name: qc; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qc (
    id numeric NOT NULL,
    uom_id numeric(10,0),
    sys_user_id numeric(10,0),
    name character varying(30),
    source character varying(30),
    lot_number character varying(30),
    prepared_date timestamp without time zone,
    prepared_volume numeric,
    usable_date timestamp without time zone,
    expire_date timestamp without time zone
);


ALTER TABLE clinlims.qc OWNER TO clinlims;

--
-- Name: COLUMN qc.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN qc.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.name IS 'Descriptive QC name: Positive control for CHL';


--
-- Name: COLUMN qc.source; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.source IS 'Name of supplier such as company or in-house';


--
-- Name: COLUMN qc.lot_number; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.lot_number IS 'Lot number';


--
-- Name: COLUMN qc.prepared_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.prepared_date IS 'Date QC was prepared';


--
-- Name: COLUMN qc.prepared_volume; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.prepared_volume IS 'Amount prepared';


--
-- Name: COLUMN qc.usable_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.usable_date IS 'Cannot be used before this date';


--
-- Name: COLUMN qc.expire_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc.expire_date IS 'Cannot be used after this date';


--
-- Name: qc_analytes; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qc_analytes (
    id numeric(10,0) NOT NULL,
    qcanaly_type character varying(1),
    value character varying(80),
    analyte_id numeric(10,0)
);


ALTER TABLE clinlims.qc_analytes OWNER TO clinlims;

--
-- Name: COLUMN qc_analytes.qcanaly_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc_analytes.qcanaly_type IS 'Type of value: dictionary, titer range, number range, true value';


--
-- Name: COLUMN qc_analytes.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN qc_analytes.value IS 'Min max,, true value & % if type is any range';


--
-- Name: qrtz_blob_triggers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_blob_triggers (
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    blob_data bytea
);


ALTER TABLE clinlims.qrtz_blob_triggers OWNER TO clinlims;

--
-- Name: qrtz_calendars; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_calendars (
    calendar_name character varying(80) NOT NULL,
    calendar bytea NOT NULL
);


ALTER TABLE clinlims.qrtz_calendars OWNER TO clinlims;

--
-- Name: qrtz_cron_triggers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_cron_triggers (
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    cron_expression character varying(80) NOT NULL,
    time_zone_id character varying(80)
);


ALTER TABLE clinlims.qrtz_cron_triggers OWNER TO clinlims;

--
-- Name: qrtz_fired_triggers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_fired_triggers (
    entry_id character varying(95) NOT NULL,
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    is_volatile boolean NOT NULL,
    instance_name character varying(80) NOT NULL,
    fired_time bigint NOT NULL,
    priority integer NOT NULL,
    state character varying(16) NOT NULL,
    job_name character varying(80),
    job_group character varying(80),
    is_stateful boolean,
    requests_recovery boolean
);


ALTER TABLE clinlims.qrtz_fired_triggers OWNER TO clinlims;

--
-- Name: qrtz_job_details; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_job_details (
    job_name character varying(80) NOT NULL,
    job_group character varying(80) NOT NULL,
    description character varying(120),
    job_class_name character varying(128) NOT NULL,
    is_durable boolean NOT NULL,
    is_volatile boolean NOT NULL,
    is_stateful boolean NOT NULL,
    requests_recovery boolean NOT NULL,
    job_data bytea
);


ALTER TABLE clinlims.qrtz_job_details OWNER TO clinlims;

--
-- Name: qrtz_job_listeners; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_job_listeners (
    job_name character varying(80) NOT NULL,
    job_group character varying(80) NOT NULL,
    job_listener character varying(80) NOT NULL
);


ALTER TABLE clinlims.qrtz_job_listeners OWNER TO clinlims;

--
-- Name: qrtz_locks; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_locks (
    lock_name character varying(40) NOT NULL
);


ALTER TABLE clinlims.qrtz_locks OWNER TO clinlims;

--
-- Name: qrtz_paused_trigger_grps; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_paused_trigger_grps (
    trigger_group character varying(80) NOT NULL
);


ALTER TABLE clinlims.qrtz_paused_trigger_grps OWNER TO clinlims;

--
-- Name: qrtz_scheduler_state; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_scheduler_state (
    instance_name character varying(80) NOT NULL,
    last_checkin_time bigint NOT NULL,
    checkin_interval bigint NOT NULL
);


ALTER TABLE clinlims.qrtz_scheduler_state OWNER TO clinlims;

--
-- Name: qrtz_simple_triggers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_simple_triggers (
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    repeat_count bigint NOT NULL,
    repeat_interval bigint NOT NULL,
    times_triggered bigint NOT NULL
);


ALTER TABLE clinlims.qrtz_simple_triggers OWNER TO clinlims;

--
-- Name: qrtz_trigger_listeners; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_trigger_listeners (
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    trigger_listener character varying(80) NOT NULL
);


ALTER TABLE clinlims.qrtz_trigger_listeners OWNER TO clinlims;

--
-- Name: qrtz_triggers; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE qrtz_triggers (
    trigger_name character varying(80) NOT NULL,
    trigger_group character varying(80) NOT NULL,
    job_name character varying(80) NOT NULL,
    job_group character varying(80) NOT NULL,
    is_volatile boolean NOT NULL,
    description character varying(120),
    next_fire_time bigint,
    prev_fire_time bigint,
    priority integer,
    trigger_state character varying(16) NOT NULL,
    trigger_type character varying(8) NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint,
    calendar_name character varying(80),
    misfire_instr smallint,
    job_data bytea
);


ALTER TABLE clinlims.qrtz_triggers OWNER TO clinlims;

--
-- Name: quartz_cron_scheduler; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE quartz_cron_scheduler (
    id numeric(10,0) NOT NULL,
    cron_statement character varying(32) DEFAULT 'never'::character varying NOT NULL,
    last_run timestamp with time zone,
    active boolean DEFAULT true,
    run_if_past boolean DEFAULT true,
    name character varying(40),
    job_name character varying(60) NOT NULL,
    display_key character varying(60),
    description_key character varying(60)
);


ALTER TABLE clinlims.quartz_cron_scheduler OWNER TO clinlims;

--
-- Name: TABLE quartz_cron_scheduler; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE quartz_cron_scheduler IS 'Sets up the quartz scheduler for cron jobs';


--
-- Name: COLUMN quartz_cron_scheduler.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.id IS 'Id for this schedule';


--
-- Name: COLUMN quartz_cron_scheduler.cron_statement; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.cron_statement IS 'The cron statement for when the job should run. N.B. the default is not a valid cron expression';


--
-- Name: COLUMN quartz_cron_scheduler.last_run; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.last_run IS 'The last time this job was run';


--
-- Name: COLUMN quartz_cron_scheduler.active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.active IS 'True if the schedule is active, false if it is suspended';


--
-- Name: COLUMN quartz_cron_scheduler.run_if_past; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.run_if_past IS 'True if the job should be run if the application is started after the run time and it has not run yet that day';


--
-- Name: COLUMN quartz_cron_scheduler.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.name IS 'The name for this job';


--
-- Name: COLUMN quartz_cron_scheduler.job_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.job_name IS 'The internal job name, should not be editible by end user';


--
-- Name: COLUMN quartz_cron_scheduler.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN quartz_cron_scheduler.display_key IS 'The localized name for this job';


--
-- Name: quartz_cron_scheduler_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE quartz_cron_scheduler_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.quartz_cron_scheduler_seq OWNER TO clinlims;

--
-- Name: race; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE race (
    id numeric(10,0) NOT NULL,
    description character varying(20) NOT NULL,
    race_type character varying(1),
    is_active character(1)
);


ALTER TABLE clinlims.race OWNER TO clinlims;

--
-- Name: receiver_code_element; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE receiver_code_element (
    id numeric(10,0) NOT NULL,
    identifier character varying(20),
    text character varying(60),
    code_system character varying(20),
    lastupdated timestamp(6) without time zone,
    message_org_id numeric(10,0),
    code_element_type_id numeric(10,0)
);


ALTER TABLE clinlims.receiver_code_element OWNER TO clinlims;

--
-- Name: receiver_code_element_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE receiver_code_element_seq
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.receiver_code_element_seq OWNER TO clinlims;

--
-- Name: reference_tables; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE reference_tables (
    id numeric(10,0) NOT NULL,
    name character varying(40),
    keep_history character varying(1),
    is_hl7_encoded character varying(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.reference_tables OWNER TO clinlims;

--
-- Name: COLUMN reference_tables.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN reference_tables.name IS 'Name of table or module';


--
-- Name: reference_tables_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE reference_tables_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.reference_tables_seq OWNER TO clinlims;

--
-- Name: referral; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE referral (
    id numeric(10,0) NOT NULL,
    analysis_id numeric(10,0),
    organization_id numeric(10,0),
    organization_name character varying(30),
    send_ready_date timestamp with time zone,
    sent_date timestamp with time zone,
    result_recieved_date timestamp with time zone,
    referral_reason_id numeric(10,0),
    referral_type_id numeric(10,0) NOT NULL,
    requester_name character varying(60),
    lastupdated timestamp with time zone,
    canceled boolean DEFAULT false,
    referral_request_date timestamp with time zone
);


ALTER TABLE clinlims.referral OWNER TO clinlims;

--
-- Name: TABLE referral; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE referral IS 'Tracks referrals made to and from the lab.  If referrals should be attached to samples add another column for sample and edit this comment';


--
-- Name: COLUMN referral.analysis_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.analysis_id IS 'The analysis which will be duplicated at other lab when refering out or which will be be done at this lab when referred in.  ';


--
-- Name: COLUMN referral.organization_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.organization_id IS 'The organization the sample was sent to or from';


--
-- Name: COLUMN referral.organization_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.organization_name IS 'The organiztion the sample was sent to or from, if busness rules allow them not to be in the organization table';


--
-- Name: COLUMN referral.send_ready_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.send_ready_date IS 'The date the referral out results are ready to be sent';


--
-- Name: COLUMN referral.sent_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.sent_date IS 'The date the referral out results are actually sent';


--
-- Name: COLUMN referral.result_recieved_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.result_recieved_date IS 'If this was a referral out then the date the results were recieved from the external lab';


--
-- Name: COLUMN referral.referral_reason_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.referral_reason_id IS 'Why was this referral done';


--
-- Name: COLUMN referral.requester_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.requester_name IS 'The name of the person who requested that the referral be done';


--
-- Name: COLUMN referral.referral_request_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral.referral_request_date IS 'The date the referral request was made';


--
-- Name: referral_reason; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE referral_reason (
    id numeric(10,0) NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(60),
    display_key character varying(60),
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.referral_reason OWNER TO clinlims;

--
-- Name: TABLE referral_reason; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE referral_reason IS 'The reason a referral was made to or from the lab';


--
-- Name: COLUMN referral_reason.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_reason.name IS 'The name of the reason, default value displayed to user if no display_key value';


--
-- Name: COLUMN referral_reason.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_reason.description IS 'Clarification of the reason';


--
-- Name: COLUMN referral_reason.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_reason.display_key IS 'Key for localization files to display locale appropriate reasons';


--
-- Name: referral_reason_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE referral_reason_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.referral_reason_seq OWNER TO clinlims;

--
-- Name: referral_result; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE referral_result (
    id numeric(10,0) NOT NULL,
    referral_id numeric(10,0) NOT NULL,
    test_id numeric(10,0),
    result_id numeric(10,0),
    referral_report_date timestamp with time zone,
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.referral_result OWNER TO clinlims;

--
-- Name: TABLE referral_result; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE referral_result IS 'A referral may have one or more results';


--
-- Name: COLUMN referral_result.referral_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_result.referral_id IS 'The referral for which this is a result. May be one to many';


--
-- Name: COLUMN referral_result.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_result.test_id IS 'When the referral lab reported the results back';


--
-- Name: COLUMN referral_result.result_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_result.result_id IS 'The result returned by the referral lab';


--
-- Name: referral_result_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE referral_result_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.referral_result_seq OWNER TO clinlims;

--
-- Name: referral_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE referral_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.referral_seq OWNER TO clinlims;

--
-- Name: referral_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE referral_type (
    id numeric(10,0) NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(60),
    display_key character varying(60),
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.referral_type OWNER TO clinlims;

--
-- Name: TABLE referral_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE referral_type IS 'The type of referral. i.e. a referral into the lab or a referral out of the lab';


--
-- Name: COLUMN referral_type.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_type.name IS 'The name of the type, default value displayed to user if no display_key value';


--
-- Name: COLUMN referral_type.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_type.description IS 'Clarification of the type';


--
-- Name: COLUMN referral_type.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN referral_type.display_key IS 'Key for localization files to display locale appropriate types';


--
-- Name: referral_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE referral_type_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.referral_type_seq OWNER TO clinlims;

--
-- Name: region; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE region (
    id numeric(10,0) NOT NULL,
    region character varying(240) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.region OWNER TO clinlims;

--
-- Name: COLUMN region.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN region.id IS 'Sequential Number';


--
-- Name: COLUMN region.region; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN region.region IS 'Epidemiology Region Description used for MLS';


--
-- Name: region_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE region_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.region_seq OWNER TO clinlims;

--
-- Name: report_external_export; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE report_external_export (
    id numeric(10,0) NOT NULL,
    event_date timestamp with time zone NOT NULL,
    collection_date timestamp with time zone NOT NULL,
    sent_date timestamp with time zone,
    type numeric(10,0) NOT NULL,
    data text,
    lastupdated timestamp with time zone,
    send_flag boolean DEFAULT true,
    bookkeeping text
);


ALTER TABLE clinlims.report_external_export OWNER TO clinlims;

--
-- Name: TABLE report_external_export; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE report_external_export IS 'Table for holding aggregated results to be sent to an external application';


--
-- Name: COLUMN report_external_export.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.id IS 'primary key';


--
-- Name: COLUMN report_external_export.event_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.event_date IS 'The date for which the information was collected.  Granularity assumed to be one day';


--
-- Name: COLUMN report_external_export.collection_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.collection_date IS 'The date on which the information was collected.';


--
-- Name: COLUMN report_external_export.sent_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.sent_date IS 'The date which the data was successfully sent';


--
-- Name: COLUMN report_external_export.type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.type IS 'The type of report this is';


--
-- Name: COLUMN report_external_export.data; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.data IS 'Formated data.  May be either JASON or xml.  Many datapoints per row';


--
-- Name: COLUMN report_external_export.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.lastupdated IS 'The last time the row was updated for any reason';


--
-- Name: COLUMN report_external_export.send_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.send_flag IS 'The data is ready to be sent.  It may have already been sent once';


--
-- Name: COLUMN report_external_export.bookkeeping; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_export.bookkeeping IS 'Data which the application will need to record that this document has been sent';


--
-- Name: report_external_import; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE report_external_import (
    id numeric(10,0) NOT NULL,
    sending_site character varying(20) NOT NULL,
    event_date timestamp with time zone NOT NULL,
    recieved_date timestamp with time zone,
    type character varying(32) NOT NULL,
    updated_flag boolean DEFAULT false,
    data text,
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.report_external_import OWNER TO clinlims;

--
-- Name: TABLE report_external_import; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE report_external_import IS 'Table for holding aggregated results sent by an external application';


--
-- Name: COLUMN report_external_import.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.id IS 'primary key';


--
-- Name: COLUMN report_external_import.sending_site; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.sending_site IS 'The site which is sending the info';


--
-- Name: COLUMN report_external_import.event_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.event_date IS 'The date for which the information was collected.  Granularity assumed to be one day';


--
-- Name: COLUMN report_external_import.recieved_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.recieved_date IS 'The date which the data was received';


--
-- Name: COLUMN report_external_import.type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.type IS 'The type of report this is';


--
-- Name: COLUMN report_external_import.data; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.data IS 'Formated data.  May be either JASON or xml.  Many datapoints per row';


--
-- Name: COLUMN report_external_import.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN report_external_import.lastupdated IS 'The last time the row was updated for any reason';


--
-- Name: report_external_import_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE report_external_import_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.report_external_import_seq OWNER TO clinlims;

--
-- Name: report_queue_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE report_queue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.report_queue_seq OWNER TO clinlims;

--
-- Name: report_queue_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE report_queue_type (
    id numeric(10,0) NOT NULL,
    name character varying(32) NOT NULL,
    description character varying(60)
);


ALTER TABLE clinlims.report_queue_type OWNER TO clinlims;

--
-- Name: report_queue_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE report_queue_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.report_queue_type_seq OWNER TO clinlims;

--
-- Name: requester_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE requester_type (
    id numeric(10,0) NOT NULL,
    requester_type character varying(20) NOT NULL
);


ALTER TABLE clinlims.requester_type OWNER TO clinlims;

--
-- Name: TABLE requester_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE requester_type IS 'The types of entities which can request test.  This table will be used by sample_requester so the type should map to table';


--
-- Name: COLUMN requester_type.requester_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN requester_type.requester_type IS 'The type. i.e. organization or provider';


--
-- Name: requester_type_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE requester_type_seq
    START WITH 2
    INCREMENT BY 1
    MINVALUE 2
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.requester_type_seq OWNER TO clinlims;

--
-- Name: result; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE result (
    id numeric(10,0) NOT NULL,
    analysis_id numeric(10,0),
    sort_order numeric,
    is_reportable character varying(1),
    result_type character varying(1),
    value text,
    analyte_id numeric(10,0),
    test_result_id numeric(10,0),
    lastupdated timestamp(6) without time zone,
    min_normal double precision,
    max_normal double precision,
    parent_id numeric(10,0),
    abnormal boolean DEFAULT false,
    uploaded_file_name character varying(500),
    result_limit_id numeric
);


ALTER TABLE clinlims.result OWNER TO clinlims;

--
-- Name: COLUMN result.analysis_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.analysis_id IS 'Sequential number';


--
-- Name: COLUMN result.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.sort_order IS 'The order the results are displayed (sort order)';


--
-- Name: COLUMN result.is_reportable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.is_reportable IS 'Indicates if the result is reportable.';


--
-- Name: COLUMN result.result_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.result_type IS 'Type of result: Dictionary, titer, number, date';


--
-- Name: COLUMN result.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.value IS 'Actual result value.';


--
-- Name: COLUMN result.min_normal; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.min_normal IS 'The min normal value for this result. (May vary by patient sex and age)';


--
-- Name: COLUMN result.max_normal; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.max_normal IS 'The max normal value for this result. (May vary by patient sex and age)';


--
-- Name: COLUMN result.parent_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result.parent_id IS 'The id of the result that this result is dependent on';


--
-- Name: result_inventory; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE result_inventory (
    id numeric(10,0) NOT NULL,
    inventory_location_id numeric(10,0) NOT NULL,
    result_id numeric(10,0) NOT NULL,
    description character varying(20),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.result_inventory OWNER TO clinlims;

--
-- Name: TABLE result_inventory; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE result_inventory IS 'Table to link analyte, inventory_items and results.  This is to tie a specific test kit to HIV or syphilis test result.';


--
-- Name: COLUMN result_inventory.inventory_location_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_inventory.inventory_location_id IS 'The specific identifiable inventory.  For Haiti this should be a test kit in inventory';


--
-- Name: COLUMN result_inventory.result_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_inventory.result_id IS 'The result which is tied to the inventory';


--
-- Name: COLUMN result_inventory.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_inventory.description IS 'The description of inventory the result refers to.';


--
-- Name: result_inventory_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE result_inventory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.result_inventory_seq OWNER TO clinlims;

--
-- Name: result_limits; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE result_limits (
    id numeric(10,0) NOT NULL,
    test_id numeric(10,0) NOT NULL,
    test_result_type_id numeric NOT NULL,
    min_age double precision DEFAULT 0,
    max_age double precision DEFAULT 'Infinity'::double precision,
    gender character(1),
    low_normal double precision DEFAULT '-Infinity'::double precision,
    high_normal double precision DEFAULT 'Infinity'::double precision,
    low_valid double precision DEFAULT '-Infinity'::double precision,
    high_valid double precision DEFAULT 'Infinity'::double precision,
    lastupdated timestamp(6) without time zone,
    normal_dictionary_id numeric(10,0),
    always_validate boolean DEFAULT false
);


ALTER TABLE clinlims.result_limits OWNER TO clinlims;

--
-- Name: TABLE result_limits; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE result_limits IS 'This is a mainly read only table for normal and valid limits for given tests.  Currently it assumes that only age and gender matter.  If more criteria matter then refactor';


--
-- Name: COLUMN result_limits.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.test_id IS 'Refers to the test table, this is additional information';


--
-- Name: COLUMN result_limits.test_result_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.test_result_type_id IS 'The data type of the results';


--
-- Name: COLUMN result_limits.min_age; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.min_age IS 'Should be null or less than max age';


--
-- Name: COLUMN result_limits.max_age; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.max_age IS 'Should be null or greater than min age';


--
-- Name: COLUMN result_limits.gender; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.gender IS 'Should be F or M or null if gender is not a criteria';


--
-- Name: COLUMN result_limits.low_normal; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.low_normal IS 'Low end of normal range';


--
-- Name: COLUMN result_limits.high_normal; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.high_normal IS 'High end of the normal range';


--
-- Name: COLUMN result_limits.low_valid; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.low_valid IS 'Low end of the valid range, any result value lower should be considered suspect';


--
-- Name: COLUMN result_limits.high_valid; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.high_valid IS 'high end of the valid range, any result value higher should be considered suspect';


--
-- Name: COLUMN result_limits.normal_dictionary_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.normal_dictionary_id IS 'Reference to the dictionary value which is normal for test';


--
-- Name: COLUMN result_limits.always_validate; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_limits.always_validate IS 'Is further validation always required no matter what the results';


--
-- Name: result_limits_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE result_limits_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.result_limits_seq OWNER TO clinlims;

--
-- Name: result_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE result_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.result_seq OWNER TO clinlims;

--
-- Name: result_signature; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE result_signature (
    id numeric(10,0) NOT NULL,
    result_id numeric(10,0) NOT NULL,
    system_user_id numeric(10,0),
    is_supervisor boolean DEFAULT false NOT NULL,
    lastupdated timestamp(6) without time zone,
    non_user_name character varying(20)
);


ALTER TABLE clinlims.result_signature OWNER TO clinlims;

--
-- Name: TABLE result_signature; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE result_signature IS 'This matches the person who signed the result form with the result.';


--
-- Name: COLUMN result_signature.result_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_signature.result_id IS 'The result which is being signed';


--
-- Name: COLUMN result_signature.system_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_signature.system_user_id IS 'The signer of the result';


--
-- Name: COLUMN result_signature.is_supervisor; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_signature.is_supervisor IS 'Is the signer a supervisor';


--
-- Name: COLUMN result_signature.non_user_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN result_signature.non_user_name IS 'For signers that are not systemUsers';


--
-- Name: result_signature_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE result_signature_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.result_signature_seq OWNER TO clinlims;

--
-- Name: sample; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample (
    id numeric(10,0) NOT NULL,
    accession_number character varying(20),
    package_id numeric(10,0),
    domain character varying(1),
    next_item_sequence numeric(10,0),
    revision numeric,
    entered_date timestamp without time zone NOT NULL,
    received_date timestamp without time zone NOT NULL,
    collection_date timestamp without time zone,
    client_reference character varying(20),
    status character varying(1),
    released_date timestamp without time zone,
    sticker_rcvd_flag character varying(1),
    sys_user_id numeric(10,0),
    barcode character varying(20),
    transmission_date timestamp without time zone,
    lastupdated timestamp(6) without time zone,
    spec_or_isolate character varying(1),
    priority numeric(1,0),
    status_id numeric(10,0),
    sample_source_id integer,
    uuid character varying(100)
);


ALTER TABLE clinlims.sample OWNER TO clinlims;

--
-- Name: COLUMN sample.status_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample.status_id IS 'foriegn key to status of analysis ';


--
-- Name: sample_animal; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_animal (
    id numeric(10,0) NOT NULL,
    sci_name_id numeric(10,0) NOT NULL,
    comm_anim_id numeric(10,0) NOT NULL,
    sampling_location character varying(40),
    collector character varying(40),
    samp_id numeric(10,0) NOT NULL,
    multiple_unit character varying(30),
    street_address character varying(30),
    city character varying(30),
    state character varying(2),
    country character varying(20),
    zip_code character varying(10)
);


ALTER TABLE clinlims.sample_animal OWNER TO clinlims;

--
-- Name: COLUMN sample_animal.sci_name_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_animal.sci_name_id IS 'Sequential Number';


--
-- Name: COLUMN sample_animal.sampling_location; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_animal.sampling_location IS 'Sampling location - name of farm';


--
-- Name: COLUMN sample_animal.collector; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_animal.collector IS 'Person collecting sample';


--
-- Name: COLUMN sample_animal.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_animal.samp_id IS 'MDH Specimen Number';


--
-- Name: COLUMN sample_animal.street_address; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_animal.street_address IS 'Address of animal';


--
-- Name: sample_domain; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_domain (
    id numeric(10,0) NOT NULL,
    domain_description character varying(20),
    domain character varying(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_domain OWNER TO clinlims;

--
-- Name: COLUMN sample_domain.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_domain.id IS 'A unique auto generated integer number assigned by the database.';


--
-- Name: COLUMN sample_domain.domain_description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_domain.domain_description IS 'Type of sample this can be applied to:environ, human, animal, rabies, bt, newborn.';


--
-- Name: COLUMN sample_domain.domain; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_domain.domain IS 'Code for description: E-Environmental, A-Animal, C-Clinical';


--
-- Name: sample_domain_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_domain_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_domain_seq OWNER TO clinlims;

--
-- Name: sample_environmental; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_environmental (
    id numeric(10,0) NOT NULL,
    samp_id numeric(10,0) NOT NULL,
    is_hazardous character varying(1),
    lot_nbr character varying(30),
    description character varying(40),
    chem_samp_num character varying(240),
    street_address character varying(30),
    multiple_unit character varying(30),
    city character varying(30),
    state character varying(2),
    zip_code character varying(10),
    country character varying(20),
    collector character varying(40),
    sampling_location character varying(40)
);


ALTER TABLE clinlims.sample_environmental OWNER TO clinlims;

--
-- Name: COLUMN sample_environmental.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.samp_id IS 'MDH Specimen Number';


--
-- Name: COLUMN sample_environmental.lot_nbr; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.lot_nbr IS 'If sample is unopened package of food then include the lot number from the package';


--
-- Name: COLUMN sample_environmental.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.description IS 'Additional description field for sample attributes.';


--
-- Name: COLUMN sample_environmental.zip_code; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.zip_code IS 'Zip +4 code';


--
-- Name: COLUMN sample_environmental.collector; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.collector IS 'Person collecting the sample';


--
-- Name: COLUMN sample_environmental.sampling_location; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_environmental.sampling_location IS 'Sampling location - name of restaurant, store, farm';


--
-- Name: sample_human; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_human (
    id numeric(10,0) NOT NULL,
    provider_id numeric(10,0),
    samp_id numeric(10,0) NOT NULL,
    patient_id numeric(10,0),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_human OWNER TO clinlims;

--
-- Name: COLUMN sample_human.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_human.samp_id IS 'MDH Specimen Number';


--
-- Name: sample_human_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_human_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_human_seq OWNER TO clinlims;

--
-- Name: sample_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_item (
    id numeric(10,0) NOT NULL,
    sort_order numeric NOT NULL,
    sampitem_id numeric(10,0),
    samp_id numeric(10,0),
    source_id numeric(10,0),
    typeosamp_id numeric(10,0),
    uom_id numeric(10,0),
    source_other character varying(40),
    quantity numeric,
    lastupdated timestamp(6) without time zone,
    external_id character varying(20),
    collection_date timestamp with time zone,
    status_id numeric(10,0) NOT NULL,
    collector character varying(60)
);


ALTER TABLE clinlims.sample_item OWNER TO clinlims;

--
-- Name: COLUMN sample_item.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.id IS 'Sample source write in if not already defined';


--
-- Name: COLUMN sample_item.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.sort_order IS 'Sample items unique sequence number for this sample';


--
-- Name: COLUMN sample_item.sampitem_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.sampitem_id IS 'Sample source write in if not already defined';


--
-- Name: COLUMN sample_item.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.samp_id IS 'MDH Specimen Number';


--
-- Name: COLUMN sample_item.source_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.source_id IS 'A unique auto generated integer number assigned by the database.';


--
-- Name: COLUMN sample_item.typeosamp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.typeosamp_id IS 'A unique auto generated integer number assigned by the database';


--
-- Name: COLUMN sample_item.source_other; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.source_other IS 'Sample source write in if not already defined';


--
-- Name: COLUMN sample_item.quantity; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.quantity IS 'Amount of sample';


--
-- Name: COLUMN sample_item.external_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.external_id IS 'An external id that may have been attached to the sample item before it came to the lab';


--
-- Name: COLUMN sample_item.collection_date; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.collection_date IS 'The date this sample_item was collected or seperated from other part of sample';


--
-- Name: COLUMN sample_item.status_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.status_id IS 'The status of this sample item';


--
-- Name: COLUMN sample_item.collector; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_item.collector IS 'The name of the person who collected the sample';


--
-- Name: sample_item_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_item_seq OWNER TO clinlims;

--
-- Name: sample_newborn; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_newborn (
    id numeric(10,0) NOT NULL,
    weight numeric(5,0),
    multi_birth character(1),
    birth_order numeric(2,0),
    gestational_week numeric(5,2),
    date_first_feeding date,
    breast character(1),
    tpn character(1),
    formula character(1),
    milk character(1),
    soy character(1),
    jaundice character(1),
    antibiotics character(1),
    transfused character(1),
    date_transfusion date,
    medical_record_numeric character varying(18),
    nicu character(1),
    birth_defect character(1),
    pregnancy_complication character(1),
    deceased_sibling character(1),
    cause_of_death character varying(50),
    family_history character(1),
    other character varying(100),
    y_numeric character varying(18),
    yellow_card character(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_newborn OWNER TO clinlims;

--
-- Name: sample_org_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_org_seq
    START WITH 112
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_org_seq OWNER TO clinlims;

--
-- Name: sample_organization; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_organization (
    id numeric(10,0) NOT NULL,
    org_id numeric(10,0),
    samp_id numeric(10,0),
    samp_org_type character varying(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_organization OWNER TO clinlims;

--
-- Name: COLUMN sample_organization.org_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_organization.org_id IS 'Sequential Numbering Field';


--
-- Name: COLUMN sample_organization.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_organization.samp_id IS 'MDH Specimen Number';


--
-- Name: COLUMN sample_organization.samp_org_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_organization.samp_org_type IS 'Type of organization: Primary, Secondary, Billing';


--
-- Name: sample_pdf; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_pdf (
    id numeric(10,0) NOT NULL,
    accession_number numeric(10,0) NOT NULL,
    allow_view character varying(1),
    barcode character varying(20)
);


ALTER TABLE clinlims.sample_pdf OWNER TO clinlims;

--
-- Name: sample_pdf_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_pdf_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.sample_pdf_seq OWNER TO clinlims;

--
-- Name: sample_proj_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_proj_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_proj_seq OWNER TO clinlims;

--
-- Name: sample_projects; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_projects (
    samp_id numeric(10,0) NOT NULL,
    proj_id numeric(10,0),
    is_permanent character varying(1),
    id numeric(10,0) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_projects OWNER TO clinlims;

--
-- Name: COLUMN sample_projects.samp_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_projects.samp_id IS 'MDH Specimen Number';


--
-- Name: COLUMN sample_projects.proj_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_projects.proj_id IS 'Sequential number assigned by sequence';


--
-- Name: COLUMN sample_projects.is_permanent; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_projects.is_permanent IS 'Indicates if project is assigned to this sample permanently (Y/N)';


--
-- Name: sample_qaevent; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_qaevent (
    id numeric(10,0) NOT NULL,
    qa_event_id numeric(10,0),
    sample_id numeric(10,0),
    completed_date date,
    lastupdated timestamp without time zone,
    sampleitem_id numeric(10,0),
    entered_date timestamp with time zone
);


ALTER TABLE clinlims.sample_qaevent OWNER TO clinlims;

--
-- Name: COLUMN sample_qaevent.sampleitem_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_qaevent.sampleitem_id IS 'If the qaevent refers to a sampleitem of the sample use this column';


--
-- Name: sample_qaevent_action; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_qaevent_action (
    id numeric(10,0) NOT NULL,
    sample_qaevent_id numeric(10,0) NOT NULL,
    action_id numeric(10,0) NOT NULL,
    created_date date NOT NULL,
    lastupdated timestamp(6) without time zone,
    sys_user_id numeric(10,0)
);


ALTER TABLE clinlims.sample_qaevent_action OWNER TO clinlims;

--
-- Name: sample_qaevent_action_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_qaevent_action_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_qaevent_action_seq OWNER TO clinlims;

--
-- Name: sample_qaevent_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_qaevent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_qaevent_seq OWNER TO clinlims;

--
-- Name: sample_requester; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_requester (
    sample_id numeric(10,0) NOT NULL,
    requester_id numeric(10,0) NOT NULL,
    requester_type_id numeric(10,0) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.sample_requester OWNER TO clinlims;

--
-- Name: TABLE sample_requester; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE sample_requester IS 'Links a sample to the entity which requested it';


--
-- Name: COLUMN sample_requester.sample_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_requester.sample_id IS 'The sample';


--
-- Name: COLUMN sample_requester.requester_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_requester.requester_id IS 'The requester_id.  The exact table row depends on the requester type';


--
-- Name: COLUMN sample_requester.requester_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN sample_requester.requester_type_id IS 'The type from the requester_type table';


--
-- Name: sample_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_seq OWNER TO clinlims;

--
-- Name: sample_source; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sample_source (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(50),
    active boolean,
    display_order integer
);


ALTER TABLE clinlims.sample_source OWNER TO clinlims;

--
-- Name: sample_source_id_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_source_id_seq OWNER TO clinlims;

--
-- Name: sample_source_id_seq; Type: SEQUENCE OWNED BY; Schema: clinlims; Owner: clinlims
--

ALTER SEQUENCE sample_source_id_seq OWNED BY sample_source.id;


--
-- Name: sample_type_panel_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_type_panel_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_type_panel_seq OWNER TO clinlims;

--
-- Name: sample_type_test_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE sample_type_test_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.sample_type_test_seq OWNER TO clinlims;

--
-- Name: source_of_sample; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE source_of_sample (
    id numeric(10,0) NOT NULL,
    description character varying(40),
    domain character varying(1),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.source_of_sample OWNER TO clinlims;

--
-- Name: COLUMN source_of_sample.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN source_of_sample.id IS 'A unique auto generated integer number assigned by the database.';


--
-- Name: COLUMN source_of_sample.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN source_of_sample.description IS 'Description such as left ear, right hand, kitchen sink.';


--
-- Name: COLUMN source_of_sample.domain; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN source_of_sample.domain IS 'Type of sample this can be applied to: Environ, Animal, Clinical';


--
-- Name: type_of_sample; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE type_of_sample (
    id numeric(10,0) NOT NULL,
    description character varying(40) NOT NULL,
    domain character varying(1),
    lastupdated timestamp(6) without time zone,
    local_abbrev character varying(40),
    display_key character varying(60),
    is_active boolean DEFAULT true,
    sort_order numeric DEFAULT 2147483647,
    uuid character varying(40)
);


ALTER TABLE clinlims.type_of_sample OWNER TO clinlims;

--
-- Name: COLUMN type_of_sample.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_sample.id IS 'A unique auto generated integer number assigned by the database';


--
-- Name: COLUMN type_of_sample.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_sample.description IS 'Description such as water, tissue, sludge, etc.';


--
-- Name: COLUMN type_of_sample.domain; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_sample.domain IS 'Type of sample this can be applied to : Environ, Animal, Clinical';


--
-- Name: COLUMN type_of_sample.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_sample.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: sampletracking; Type: VIEW; Schema: clinlims; Owner: clinlims
--

CREATE VIEW sampletracking AS
    SELECT organizationinfo.accnum, patientinfo.patientid, organizationinfo.cliref, patientinfo.patientlastname, patientinfo.patientfirstname, patientinfo.dateofbirth, organizationinfo.orglocalabbrev AS org_local_abbrev, organizationinfo.orgname, organizationinfo.recddate, typeinfo.tosid, typeinfo.tosdesc, sourceinfo.sosid, sourceinfo.sosdesc, organizationinfo.colldate, sampleinfo.si AS sori FROM (SELECT s.accession_number AS accnum, p.last_name AS patientlastname, p.first_name AS patientfirstname, pt.external_id AS patientid, pt.birth_date AS dateofbirth FROM (((sample s LEFT JOIN sample_human samphum ON ((s.id = samphum.samp_id))) LEFT JOIN patient pt ON ((samphum.patient_id = pt.id))) LEFT JOIN person p ON ((pt.person_id = p.id)))) patientinfo, (SELECT s.accession_number AS accnum, sos.id AS sosid, sos.description AS sosdesc FROM ((sample s LEFT JOIN sample_item sampitem ON ((s.id = sampitem.samp_id))) LEFT JOIN source_of_sample sos ON ((sampitem.source_id = sos.id)))) sourceinfo, (SELECT s.accession_number AS accnum, tos.id AS tosid, tos.description AS tosdesc FROM ((sample s LEFT JOIN sample_item sampitem ON ((s.id = sampitem.samp_id))) LEFT JOIN type_of_sample tos ON ((sampitem.typeosamp_id = tos.id)))) typeinfo, (SELECT s.accession_number AS accnum, org.local_abbrev AS orglocalabbrev, org.name AS orgname, s.received_date AS recddate, s.collection_date AS colldate, s.client_reference AS cliref FROM ((sample s LEFT JOIN sample_organization samporg ON ((s.id = samporg.samp_id))) LEFT JOIN organization org ON ((samporg.org_id = org.id)))) organizationinfo, (SELECT s.accession_number AS accnum, s.spec_or_isolate AS si FROM sample s) sampleinfo WHERE (((((typeinfo.accnum)::text = (organizationinfo.accnum)::text) AND ((sourceinfo.accnum)::text = (organizationinfo.accnum)::text)) AND ((patientinfo.accnum)::text = (organizationinfo.accnum)::text)) AND ((sampleinfo.accnum)::text = (organizationinfo.accnum)::text)) ORDER BY organizationinfo.orglocalabbrev, organizationinfo.recddate, organizationinfo.colldate, typeinfo.tosdesc, sourceinfo.sosdesc;


ALTER TABLE clinlims.sampletracking OWNER TO clinlims;

--
-- Name: sampletype_panel; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sampletype_panel (
    id numeric(10,0) NOT NULL,
    sample_type_id numeric(10,0) NOT NULL,
    panel_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.sampletype_panel OWNER TO clinlims;

--
-- Name: sampletype_test; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sampletype_test (
    id numeric(10,0) NOT NULL,
    sample_type_id numeric(10,0) NOT NULL,
    test_id numeric(10,0) NOT NULL,
    is_panel boolean DEFAULT false
);


ALTER TABLE clinlims.sampletype_test OWNER TO clinlims;

--
-- Name: scriptlet; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE scriptlet (
    id numeric(10,0) NOT NULL,
    name character varying(40),
    code_type character varying(1),
    code_source character varying(4000),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.scriptlet OWNER TO clinlims;

--
-- Name: COLUMN scriptlet.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN scriptlet.name IS 'Script name';


--
-- Name: COLUMN scriptlet.code_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN scriptlet.code_type IS 'Flag indicating type of script code : Java, Basic, PLSQL';


--
-- Name: COLUMN scriptlet.lastupdated; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN scriptlet.lastupdated IS 'Body of Source Code';


--
-- Name: scriptlet_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE scriptlet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.scriptlet_seq OWNER TO clinlims;

--
-- Name: sequence; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE sequence (
    seq_name character varying(30),
    seq_count numeric
);


ALTER TABLE clinlims.sequence OWNER TO clinlims;

--
-- Name: site_information; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE site_information (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    lastupdated timestamp with time zone,
    description character varying(120),
    value character varying(200),
    encrypted boolean DEFAULT false,
    domain_id numeric(10,0),
    value_type character varying(10) DEFAULT 'text'::character varying NOT NULL,
    instruction_key character varying(40),
    "group" numeric DEFAULT (0)::numeric,
    schedule_id numeric(10,0),
    tag character varying(20),
    dictionary_category_id numeric(10,0)
);


ALTER TABLE clinlims.site_information OWNER TO clinlims;

--
-- Name: TABLE site_information; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE site_information IS 'Information about a specific installation at a site, seperate from an implimentation';


--
-- Name: COLUMN site_information.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.name IS 'Name by which this information will be found';


--
-- Name: COLUMN site_information.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.description IS 'Clarification of the name';


--
-- Name: COLUMN site_information.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.value IS 'Value for the named information';


--
-- Name: COLUMN site_information.encrypted; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.encrypted IS 'Is the value an encrypted value.  Used for passwords';


--
-- Name: COLUMN site_information.value_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.value_type IS 'The type of value which can be specified for the value. Currently either ''boolean'',''text'' or ''dictionary''';


--
-- Name: COLUMN site_information.instruction_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.instruction_key IS 'The key in Message_Resource which give the user the text for the meaning and consequences of the information';


--
-- Name: COLUMN site_information."group"; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information."group" IS 'If items should be grouped together when displaying they should have the same group number';


--
-- Name: COLUMN site_information.schedule_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.schedule_id IS 'quartz_cron_scheduler id if the item is associated with a scheduler ';


--
-- Name: COLUMN site_information.tag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.tag IS 'A tag to help determine how the information should be used';


--
-- Name: COLUMN site_information.dictionary_category_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN site_information.dictionary_category_id IS 'Value of the dictionary category if the type of record is dictionary';


--
-- Name: site_information_domain; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE site_information_domain (
    id numeric(10,0) NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(120)
);


ALTER TABLE clinlims.site_information_domain OWNER TO clinlims;

--
-- Name: TABLE site_information_domain; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE site_information_domain IS 'Marks the domains to which site information belongs.  Intended use is administration pages';


--
-- Name: site_information_domain_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE site_information_domain_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.site_information_domain_seq OWNER TO clinlims;

--
-- Name: site_information_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE site_information_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.site_information_seq OWNER TO clinlims;

--
-- Name: source_of_sample_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE source_of_sample_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.source_of_sample_seq OWNER TO clinlims;

--
-- Name: state_code; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE state_code (
    id numeric(10,0) NOT NULL,
    code character varying(240),
    description character varying(240),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.state_code OWNER TO clinlims;

--
-- Name: COLUMN state_code.code; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN state_code.code IS 'State abbreviation';


--
-- Name: COLUMN state_code.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN state_code.description IS 'State Name';


--
-- Name: state_code_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE state_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.state_code_seq OWNER TO clinlims;

--
-- Name: status_of_sample; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE status_of_sample (
    id numeric(10,0) NOT NULL,
    description character varying(240),
    code numeric(3,0) NOT NULL,
    status_type character varying(10) NOT NULL,
    lastupdated timestamp(6) without time zone,
    name character varying(30),
    display_key character varying(60),
    is_active character varying(1) DEFAULT 'Y'::character varying
);


ALTER TABLE clinlims.status_of_sample OWNER TO clinlims;

--
-- Name: COLUMN status_of_sample.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN status_of_sample.is_active IS 'Either Y or N';


--
-- Name: status_of_sample_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE status_of_sample_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.status_of_sample_seq OWNER TO clinlims;

--
-- Name: storage_location; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE storage_location (
    id numeric(10,0) NOT NULL,
    sort_order numeric,
    name character varying(20),
    location character varying(80),
    is_available character varying(1),
    parent_storageloc_id numeric(10,0),
    storage_unit_id numeric(10,0)
);


ALTER TABLE clinlims.storage_location OWNER TO clinlims;

--
-- Name: COLUMN storage_location.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_location.sort_order IS 'The sequence order of this item; sort order used for display';


--
-- Name: COLUMN storage_location.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_location.name IS 'Name of unit: Virology Fridge #1';


--
-- Name: COLUMN storage_location.location; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_location.location IS 'Location of storage';


--
-- Name: COLUMN storage_location.is_available; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_location.is_available IS 'Indicates if storage is available for use.';


--
-- Name: storage_unit; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE storage_unit (
    id numeric(10,0) NOT NULL,
    category character varying(15),
    description character varying(60),
    is_singular character varying(1)
);


ALTER TABLE clinlims.storage_unit OWNER TO clinlims;

--
-- Name: COLUMN storage_unit.category; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_unit.category IS 'type of storage unit: box, fridge, shelf, tube';


--
-- Name: COLUMN storage_unit.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_unit.description IS 'Description of unit: 10 mL tube, 5 shelf fridge.';


--
-- Name: COLUMN storage_unit.is_singular; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN storage_unit.is_singular IS 'Y, N flag indicating if this unit can contain more than one item.';


--
-- Name: system_module; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_module (
    id numeric(10,0) NOT NULL,
    name character varying(40),
    description character varying(80),
    has_select_flag character varying(1),
    has_add_flag character varying(1),
    has_update_flag character varying(1),
    has_delete_flag character varying(1)
);


ALTER TABLE clinlims.system_module OWNER TO clinlims;

--
-- Name: COLUMN system_module.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.name IS 'Name of security module';


--
-- Name: COLUMN system_module.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.description IS 'Description for this security module';


--
-- Name: COLUMN system_module.has_select_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.has_select_flag IS 'Flag indicating if this module can be assigned to a user';


--
-- Name: COLUMN system_module.has_add_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.has_add_flag IS 'Flag indicating if this module has add capability';


--
-- Name: COLUMN system_module.has_update_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.has_update_flag IS 'Flag indicating if this module has update capability';


--
-- Name: COLUMN system_module.has_delete_flag; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_module.has_delete_flag IS 'Flag indicating if this module has delete capability';


--
-- Name: system_module_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE system_module_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.system_module_seq OWNER TO clinlims;

--
-- Name: system_role; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_role (
    id numeric(10,0) NOT NULL,
    name character(20) NOT NULL,
    description character varying(80),
    is_grouping_role boolean DEFAULT false,
    grouping_parent numeric(10,0),
    display_key character varying(60),
    active boolean DEFAULT true,
    editable boolean DEFAULT false
);


ALTER TABLE clinlims.system_role OWNER TO clinlims;

--
-- Name: TABLE system_role; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE system_role IS 'Describes the roles a user may have.  ';


--
-- Name: COLUMN system_role.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.name IS 'The name of the role, this is how it will appear to the user';


--
-- Name: COLUMN system_role.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.description IS 'Notes about the role';


--
-- Name: COLUMN system_role.is_grouping_role; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.is_grouping_role IS 'Indicates that this role is only for grouping other roles.  It should not have modules assigned to it';


--
-- Name: COLUMN system_role.grouping_parent; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.grouping_parent IS 'Should only refer to a grouping role';


--
-- Name: COLUMN system_role.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.display_key IS 'key for localizing dropdown lists';


--
-- Name: COLUMN system_role.active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.active IS 'Is this role active for this installation';


--
-- Name: COLUMN system_role.editable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_role.editable IS 'Is this a role that can be de/activated by the user';


--
-- Name: system_role_module; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_role_module (
    id numeric(10,0) NOT NULL,
    has_select character varying(1),
    has_add character varying(1),
    has_update character varying(1),
    has_delete character varying(1),
    system_role_id numeric(10,0) NOT NULL,
    system_module_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.system_role_module OWNER TO clinlims;

--
-- Name: system_role_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE system_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.system_role_seq OWNER TO clinlims;

--
-- Name: system_user; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_user (
    id numeric(10,0) NOT NULL,
    external_id character varying(80),
    login_name character varying(20) NOT NULL,
    last_name character varying(30) NOT NULL,
    first_name character varying(20) NOT NULL,
    initials character varying(3),
    is_active character varying(1) NOT NULL,
    is_employee character varying(1) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.system_user OWNER TO clinlims;

--
-- Name: COLUMN system_user.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.id IS 'Sequential Identifier';


--
-- Name: COLUMN system_user.external_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.external_id IS 'External ID such as employee number or external system ID.';


--
-- Name: COLUMN system_user.login_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.login_name IS 'User''s system log in name.';


--
-- Name: COLUMN system_user.last_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.last_name IS 'Last name of person';


--
-- Name: COLUMN system_user.first_name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.first_name IS 'Person Name';


--
-- Name: COLUMN system_user.initials; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.initials IS 'Middle Initial';


--
-- Name: COLUMN system_user.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.is_active IS 'Indicates the status of active or inactive for user';


--
-- Name: COLUMN system_user.is_employee; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user.is_employee IS 'Indicates if user is an MDH employee';


--
-- Name: system_user_module; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_user_module (
    id numeric(10,0) NOT NULL,
    has_select character varying(1),
    has_add character varying(1),
    has_update character varying(1),
    has_delete character varying(1),
    system_user_id numeric(10,0),
    system_module_id numeric(10,0)
);


ALTER TABLE clinlims.system_user_module OWNER TO clinlims;

--
-- Name: COLUMN system_user_module.has_select; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_module.has_select IS 'Flag indicating if this user has permission to enter this module';


--
-- Name: COLUMN system_user_module.has_add; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_module.has_add IS 'Flag indicating if this user has permission to add a record';


--
-- Name: COLUMN system_user_module.has_update; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_module.has_update IS 'Flag indicating if this person has permission to update a record';


--
-- Name: COLUMN system_user_module.has_delete; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_module.has_delete IS 'Flag indicating if this person has permission to remove a record';


--
-- Name: system_user_module_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE system_user_module_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.system_user_module_seq OWNER TO clinlims;

--
-- Name: system_user_role; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_user_role (
    system_user_id numeric(10,0) NOT NULL,
    role_id numeric(10,0) NOT NULL
);


ALTER TABLE clinlims.system_user_role OWNER TO clinlims;

--
-- Name: system_user_section; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE system_user_section (
    id numeric NOT NULL,
    has_view character varying(1),
    has_assign character varying(1),
    has_complete character varying(1),
    has_release character varying(1),
    has_cancel character varying(1),
    system_user_id numeric(10,0),
    test_section_id numeric(10,0)
);


ALTER TABLE clinlims.system_user_section OWNER TO clinlims;

--
-- Name: COLUMN system_user_section.has_view; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_section.has_view IS 'Flag indicating if user has permission to iew this sections''s records';


--
-- Name: COLUMN system_user_section.has_assign; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_section.has_assign IS 'Flag indicating if user has permission to assign this section''s tests';


--
-- Name: COLUMN system_user_section.has_complete; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_section.has_complete IS 'Flag indicating if user has permission to complete this section''s tests';


--
-- Name: COLUMN system_user_section.has_release; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_section.has_release IS 'Flag indicating if user has permission to release this section''s tests';


--
-- Name: COLUMN system_user_section.has_cancel; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN system_user_section.has_cancel IS 'Flag indicating if user has permission to cancel this section''s tests';


--
-- Name: system_user_section_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE system_user_section_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.system_user_section_seq OWNER TO clinlims;

--
-- Name: system_user_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE system_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.system_user_seq OWNER TO clinlims;

--
-- Name: test; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test (
    id numeric(10,0) NOT NULL,
    method_id numeric(10,0),
    uom_id numeric(10,0),
    description character varying(120) NOT NULL,
    loinc character varying(240),
    reporting_description character varying(60),
    sticker_req_flag character varying(1),
    is_active character varying(1),
    active_begin timestamp without time zone,
    active_end timestamp without time zone,
    is_reportable character varying(1),
    time_holding numeric,
    time_wait numeric,
    time_ta_average numeric,
    time_ta_warning numeric,
    time_ta_max numeric,
    label_qty numeric,
    lastupdated timestamp(6) without time zone,
    label_id numeric(10,0),
    test_trailer_id numeric(10,0),
    test_section_id numeric(10,0),
    scriptlet_id numeric(10,0),
    test_format_id numeric(10,0),
    local_abbrev character varying(50),
    sort_order numeric DEFAULT 2147483647,
    name character varying(60) NOT NULL,
    display_key character varying(60),
    orderable boolean DEFAULT true,
    is_referred_out boolean DEFAULT false
);


ALTER TABLE clinlims.test OWNER TO clinlims;

--
-- Name: COLUMN test.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.id IS 'Sequential value assigned on insert';


--
-- Name: COLUMN test.method_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.method_id IS 'Sequential number';


--
-- Name: COLUMN test.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.description IS 'Description for test';


--
-- Name: COLUMN test.reporting_description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.reporting_description IS 'Description for test that appears on reports';


--
-- Name: COLUMN test.is_active; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.is_active IS 'Active status flag';


--
-- Name: COLUMN test.active_begin; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.active_begin IS 'Active end date';


--
-- Name: COLUMN test.active_end; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.active_end IS 'Active begin date';


--
-- Name: COLUMN test.is_reportable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.is_reportable IS 'The default flag indicating if ths test is reportable';


--
-- Name: COLUMN test.time_holding; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.time_holding IS 'Max hours between collection and received time';


--
-- Name: COLUMN test.time_wait; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.time_wait IS 'Hours to wait before analysis can begin';


--
-- Name: COLUMN test.time_ta_average; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.time_ta_average IS 'Average hours for test to be reported';


--
-- Name: COLUMN test.time_ta_warning; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.time_ta_warning IS 'Hours before issuing touraround warning for test not reported';


--
-- Name: COLUMN test.time_ta_max; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.time_ta_max IS 'Max hours test should be in laboratory';


--
-- Name: COLUMN test.label_qty; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.label_qty IS 'Number of labels to print';


--
-- Name: COLUMN test.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: COLUMN test.orderable; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test.orderable IS 'Should this test show in list of tests which can be ordered.  If not it is a reflex only test';


--
-- Name: test_analyte; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_analyte (
    id numeric(10,0) NOT NULL,
    test_id numeric(10,0),
    analyte_id numeric(10,0),
    result_group numeric,
    sort_order numeric,
    testalyt_type character varying(1),
    lastupdated timestamp(6) without time zone,
    is_reportable character varying(1)
);


ALTER TABLE clinlims.test_analyte OWNER TO clinlims;

--
-- Name: COLUMN test_analyte.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_analyte.test_id IS 'Sequential value assigned on insert';


--
-- Name: COLUMN test_analyte.result_group; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_analyte.result_group IS 'A program generated group number';


--
-- Name: COLUMN test_analyte.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_analyte.sort_order IS 'The order in which the analytes are displayed (sort order)';


--
-- Name: COLUMN test_analyte.testalyt_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_analyte.testalyt_type IS 'Type of analyte: required...';


--
-- Name: test_analyte_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_analyte_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.test_analyte_seq OWNER TO clinlims;

--
-- Name: test_code; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_code (
    test_id numeric(10,0) NOT NULL,
    code_type_id numeric(10,0) NOT NULL,
    value character varying(20) NOT NULL,
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.test_code OWNER TO clinlims;

--
-- Name: TABLE test_code; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE test_code IS 'For a given test and schema it gives the encoding';


--
-- Name: COLUMN test_code.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_code.test_id IS 'The test for which the coding supports. FK to test table.';


--
-- Name: COLUMN test_code.code_type_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_code.code_type_id IS 'The coding type id of the code';


--
-- Name: COLUMN test_code.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_code.value IS 'The actual code';


--
-- Name: test_code_type; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_code_type (
    id numeric(10,0) NOT NULL,
    schema_name character varying(32) NOT NULL,
    lastupdated timestamp with time zone
);


ALTER TABLE clinlims.test_code_type OWNER TO clinlims;

--
-- Name: TABLE test_code_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON TABLE test_code_type IS 'The names of the encoding schems supported (SNOMWD, LOINC etc)';


--
-- Name: test_formats; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_formats (
    id numeric(10,0) NOT NULL,
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.test_formats OWNER TO clinlims;

--
-- Name: test_reflex; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_reflex (
    id numeric(10,0) NOT NULL,
    tst_rslt_id numeric,
    flags character varying(10),
    lastupdated timestamp(6) without time zone,
    test_analyte_id numeric(10,0),
    test_id numeric(10,0),
    add_test_id numeric(10,0),
    sibling_reflex numeric(10,0),
    scriptlet_id numeric(10,0)
);


ALTER TABLE clinlims.test_reflex OWNER TO clinlims;

--
-- Name: COLUMN test_reflex.flags; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_reflex.flags IS 'A string of 1 character codes: duplicate, auto-add';


--
-- Name: COLUMN test_reflex.sibling_reflex; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_reflex.sibling_reflex IS 'Reference to tests and results for reflexes with more than one condition.  All add_test_ids should be the same';


--
-- Name: COLUMN test_reflex.scriptlet_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_reflex.scriptlet_id IS 'If a non-test action should be taken then reference the scriptlet which says what to do';


--
-- Name: test_reflex_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_reflex_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.test_reflex_seq OWNER TO clinlims;

--
-- Name: test_result; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_result (
    id numeric NOT NULL,
    test_id numeric(10,0) NOT NULL,
    result_group numeric,
    flags character varying(10),
    tst_rslt_type character varying(1),
    value character varying(80),
    significant_digits numeric DEFAULT 0,
    quant_limit character varying(30),
    cont_level character varying(30),
    lastupdated timestamp(6) without time zone,
    scriptlet_id numeric(10,0),
    sort_order numeric(22,0),
    abnormal boolean DEFAULT false,
    is_active boolean DEFAULT true
);


ALTER TABLE clinlims.test_result OWNER TO clinlims;

--
-- Name: COLUMN test_result.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.test_id IS 'Sequential value assigned on insert';


--
-- Name: COLUMN test_result.result_group; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.result_group IS 'the test_analyte result_group number';


--
-- Name: COLUMN test_result.flags; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.flags IS 'a string of 1 character codes: Positive, Reportable...';


--
-- Name: COLUMN test_result.tst_rslt_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.tst_rslt_type IS 'Type of parameter: Dictionary, Titer Range, Number Range, Date';


--
-- Name: COLUMN test_result.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.value IS 'Possible result value based on type';


--
-- Name: COLUMN test_result.significant_digits; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.significant_digits IS 'Number of decimal digits';


--
-- Name: COLUMN test_result.quant_limit; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.quant_limit IS 'Quantitation Limit (if any)';


--
-- Name: COLUMN test_result.cont_level; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_result.cont_level IS 'Contamination Level (if any)';


--
-- Name: test_result_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_result_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.test_result_seq OWNER TO clinlims;

--
-- Name: test_section; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_section (
    id numeric(10,0) NOT NULL,
    name character varying(40),
    description character varying(60) NOT NULL,
    org_id numeric(10,0),
    is_external character varying(1),
    lastupdated timestamp(6) without time zone,
    parent_test_section numeric(10,0),
    display_key character varying(60),
    sort_order numeric DEFAULT 2147483647,
    is_active character varying(1) DEFAULT 'Y'::character varying,
    uuid character varying(40)
);


ALTER TABLE clinlims.test_section OWNER TO clinlims;

--
-- Name: COLUMN test_section.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_section.name IS 'Short section name';


--
-- Name: COLUMN test_section.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_section.description IS 'MDH Locations including various labs';


--
-- Name: COLUMN test_section.org_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_section.org_id IS 'Sequential Numbering Field';


--
-- Name: COLUMN test_section.is_external; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_section.is_external IS 'Flag indicating if section is external to organization (Y/N)';


--
-- Name: COLUMN test_section.display_key; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_section.display_key IS 'Resource file lookup key for localization of displaying the name';


--
-- Name: test_section_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_section_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;


ALTER TABLE clinlims.test_section_seq OWNER TO clinlims;

--
-- Name: test_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.test_seq OWNER TO clinlims;

--
-- Name: test_trailer; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_trailer (
    id numeric(10,0) NOT NULL,
    name character varying(20),
    description character varying(60),
    text character varying(4000),
    lastupdated timestamp(6) without time zone
);


ALTER TABLE clinlims.test_trailer OWNER TO clinlims;

--
-- Name: test_trailer_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE test_trailer_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.test_trailer_seq OWNER TO clinlims;

--
-- Name: test_worksheet_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_worksheet_item (
    id numeric(10,0) NOT NULL,
    tw_id numeric(10,0) NOT NULL,
    qc_id numeric,
    "position" numeric,
    cell_type character varying(2)
);


ALTER TABLE clinlims.test_worksheet_item OWNER TO clinlims;

--
-- Name: COLUMN test_worksheet_item."position"; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheet_item."position" IS 'Well location or position within the batch';


--
-- Name: COLUMN test_worksheet_item.cell_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheet_item.cell_type IS 'Cell/position type: First, random, duplicate last, last run';


--
-- Name: test_worksheets; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE test_worksheets (
    id numeric(10,0) NOT NULL,
    test_id numeric(10,0),
    batch_capacity numeric,
    total_capacity numeric,
    number_format character varying(1)
);


ALTER TABLE clinlims.test_worksheets OWNER TO clinlims;

--
-- Name: COLUMN test_worksheets.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheets.test_id IS 'Sequential value assigned on insert';


--
-- Name: COLUMN test_worksheets.batch_capacity; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheets.batch_capacity IS 'number of samples (including QC) per batch/plate';


--
-- Name: COLUMN test_worksheets.total_capacity; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheets.total_capacity IS 'Number of samples (including QC) per worksheet';


--
-- Name: COLUMN test_worksheets.number_format; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN test_worksheets.number_format IS 'Specifies the numbering scheme for worksheet cell';


--
-- Name: tobereomved_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE tobereomved_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.tobereomved_seq OWNER TO clinlims;

--
-- Name: type_of_provider; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE type_of_provider (
    id numeric(10,0) NOT NULL,
    description character varying(240),
    tp_code character varying(1)
);


ALTER TABLE clinlims.type_of_provider OWNER TO clinlims;

--
-- Name: COLUMN type_of_provider.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_provider.id IS 'A unique auto generated integer number assigned by the database.';


--
-- Name: COLUMN type_of_provider.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_provider.description IS 'Description such as doctor, nurse, clinician, veteranarian.';


--
-- Name: type_of_sample_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE type_of_sample_seq
    START WITH 80
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.type_of_sample_seq OWNER TO clinlims;

--
-- Name: type_of_test_result; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE type_of_test_result (
    id numeric(10,0) NOT NULL,
    test_result_type character varying(1),
    description character varying(20),
    lastupdated timestamp(6) without time zone,
    hl7_value character varying(20)
);


ALTER TABLE clinlims.type_of_test_result OWNER TO clinlims;

--
-- Name: COLUMN type_of_test_result.id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_test_result.id IS 'A unique auto generated integer number assigned by database';


--
-- Name: COLUMN type_of_test_result.test_result_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_test_result.test_result_type IS 'Test Result Type (T, N, D)';


--
-- Name: COLUMN type_of_test_result.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN type_of_test_result.description IS 'Human readable description';


--
-- Name: type_of_test_result_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE type_of_test_result_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.type_of_test_result_seq OWNER TO clinlims;

--
-- Name: unit_of_measure; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE unit_of_measure (
    id numeric(10,0) NOT NULL,
    name character varying(20),
    description character varying(60),
    lastupdated timestamp(6) without time zone,
    uuid character varying(40)
);


ALTER TABLE clinlims.unit_of_measure OWNER TO clinlims;

--
-- Name: COLUMN unit_of_measure.name; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN unit_of_measure.name IS 'Name of Unit';


--
-- Name: COLUMN unit_of_measure.description; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN unit_of_measure.description IS 'Description of Unit';


--
-- Name: unit_of_measure_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE unit_of_measure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.unit_of_measure_seq OWNER TO clinlims;

--
-- Name: user_alert_map; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE user_alert_map (
    user_id integer NOT NULL,
    alert_id integer,
    report_id integer,
    alert_limit integer,
    alert_operator character varying(255),
    map_id integer NOT NULL
);


ALTER TABLE clinlims.user_alert_map OWNER TO clinlims;

--
-- Name: user_group_map; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE user_group_map (
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    map_id integer NOT NULL
);


ALTER TABLE clinlims.user_group_map OWNER TO clinlims;

--
-- Name: user_security; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE user_security (
    user_id integer NOT NULL,
    role_name character varying(255)
);


ALTER TABLE clinlims.user_security OWNER TO clinlims;

--
-- Name: worksheet_analysis; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheet_analysis (
    id numeric(10,0) NOT NULL,
    reference_type character(1),
    reference_id numeric,
    worksheet_item_id numeric(10,0)
);


ALTER TABLE clinlims.worksheet_analysis OWNER TO clinlims;

--
-- Name: COLUMN worksheet_analysis.reference_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_analysis.reference_type IS 'Flag indicating if reference points to analysis or QC';


--
-- Name: COLUMN worksheet_analysis.reference_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_analysis.reference_id IS 'ID of analysis or QC';


--
-- Name: worksheet_analyte; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheet_analyte (
    id numeric NOT NULL,
    wrkst_anls_id numeric(10,0),
    sort_order numeric,
    result_id numeric(10,0)
);


ALTER TABLE clinlims.worksheet_analyte OWNER TO clinlims;

--
-- Name: COLUMN worksheet_analyte.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_analyte.sort_order IS 'The order worksheet analytes are displayed (sort order)';


--
-- Name: worksheet_heading; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheet_heading (
    id numeric(10,0),
    worksheet_name character varying(20),
    rownumber numeric(10,0),
    column1 character varying(50),
    column2 character varying(50),
    column3 character varying(50),
    column4 character varying(50),
    column5 character varying(50),
    column6 character varying(50),
    column7 character varying(50),
    column8 character varying(50),
    column9 character varying(50),
    column10 character varying(50),
    type character varying(20)
);


ALTER TABLE clinlims.worksheet_heading OWNER TO clinlims;

--
-- Name: worksheet_item; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheet_item (
    id numeric(10,0) NOT NULL,
    "position" numeric,
    worksheet_id numeric(10,0)
);


ALTER TABLE clinlims.worksheet_item OWNER TO clinlims;

--
-- Name: worksheet_qc; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheet_qc (
    id numeric NOT NULL,
    sort_order numeric,
    wq_type character varying(1),
    value character varying(80),
    worksheet_analysis_id numeric(10,0),
    qc_analyte_id numeric(10,0)
);


ALTER TABLE clinlims.worksheet_qc OWNER TO clinlims;

--
-- Name: COLUMN worksheet_qc.sort_order; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_qc.sort_order IS 'The order worksheet analystes are displayed (sort order)';


--
-- Name: COLUMN worksheet_qc.wq_type; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_qc.wq_type IS 'Type of result: dictionary, titer, number...';


--
-- Name: COLUMN worksheet_qc.value; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheet_qc.value IS 'Result value';


--
-- Name: worksheets; Type: TABLE; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE TABLE worksheets (
    id numeric(10,0) NOT NULL,
    sys_user_id numeric(10,0) NOT NULL,
    test_id numeric(10,0),
    created timestamp without time zone,
    status character varying(1),
    number_format character varying(1)
);


ALTER TABLE clinlims.worksheets OWNER TO clinlims;

--
-- Name: COLUMN worksheets.sys_user_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheets.sys_user_id IS 'Sequential Identifier';


--
-- Name: COLUMN worksheets.test_id; Type: COMMENT; Schema: clinlims; Owner: clinlims
--

COMMENT ON COLUMN worksheets.test_id IS 'Sequential value assigned on insert';


--
-- Name: zip_code_seq; Type: SEQUENCE; Schema: clinlims; Owner: clinlims
--

CREATE SEQUENCE zip_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clinlims.zip_code_seq OWNER TO clinlims;

--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY chunking_history ALTER COLUMN id SET DEFAULT nextval('chunking_history_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY event_records ALTER COLUMN id SET DEFAULT nextval('event_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY event_records_offset_marker ALTER COLUMN id SET DEFAULT nextval('event_records_offset_marker_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY event_records_queue ALTER COLUMN id SET DEFAULT nextval('event_records_queue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY external_reference ALTER COLUMN id SET DEFAULT nextval('external_reference_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY failed_event_retry_log ALTER COLUMN id SET DEFAULT nextval('failed_event_retry_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY failed_events ALTER COLUMN id SET DEFAULT nextval('failed_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY import_status ALTER COLUMN id SET DEFAULT nextval('import_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY markers ALTER COLUMN id SET DEFAULT nextval('markers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_source ALTER COLUMN id SET DEFAULT nextval('sample_source_id_seq'::regclass);


--
-- Data for Name: action; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY action (id, code, description, type, lastupdated) FROM stdin;
1	FSR	Fee sticker received	resolving	2007-08-21 16:48:38.434
2	CDC	Collection date corrected	resolving	2007-08-21 15:58:29.117
3	RQSOC	Request source corrected	resolving	2007-08-21 14:11:01.737
4	SNAC	Submitter name corrected	resolving	2007-08-21 14:21:11.696
26	DLRQR	Delayed request form received	internal	2008-01-11 04:17:09.054
25	CMRE	Communication reviewed	internal	2008-05-01 21:38:41.775
27	DURPS	Duplicate report to submitter	message	2008-01-11 04:22:59.507
28	SPDC	Specimen discarded	internal	2008-01-11 04:20:13.235
29	SCL	Submitter was called	message	2008-01-11 04:22:33.637
30	SPSOC	Specimen source corrected	internal	2008-01-11 04:24:33.863
31	DLRQRQ	Delayed request form requested	message	2008-01-11 04:46:58.057
32	RPDF	Report placed in dead file	internal	2008-01-11 04:47:25.498
33	RQIDC	Request form ID corrected	internal	2008-01-11 04:47:57.136
34	SPCA	Specimen canceled	internal	2008-01-11 04:48:25.614
35	SPIDC	Specimen ID corrected	internal	2008-01-11 04:48:47.451
36	SPUNS	Specimen declared unsatisfactory	internal	2008-01-11 04:49:13.262
\.


--
-- Name: action_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('action_seq', 45, false);


--
-- Data for Name: address_part; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY address_part (id, part_name, display_order, display_key, type) FROM stdin;
7	level1	1	address.level1	T
8	level2	2	address.level2	T
9	level3	3	address.level3	T
10	level4	4	address.level4	T
11	level5	5	address.level5	T
12	level6	6	address.level6	T
\.


--
-- Name: address_part_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('address_part_seq', 12, true);


--
-- Data for Name: analysis; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analysis (id, sampitem_id, test_sect_id, test_id, revision, status, started_date, completed_date, released_date, printed_date, is_reportable, so_send_ready_date, so_client_reference, so_notify_received_date, so_notify_send_date, so_send_date, so_send_entry_by, so_send_entry_date, analysis_type, lastupdated, parent_analysis_id, parent_result_id, reflex_trigger, status_id, entry_date, panel_id, comment) FROM stdin;
\.


--
-- Data for Name: analysis_qaevent; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analysis_qaevent (id, qa_event_id, analysis_id, lastupdated, completed_date) FROM stdin;
\.


--
-- Data for Name: analysis_qaevent_action; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analysis_qaevent_action (id, analysis_qaevent_id, action_id, created_date, lastupdated, sys_user_id) FROM stdin;
\.


--
-- Name: analysis_qaevent_action_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analysis_qaevent_action_seq', 221, false);


--
-- Name: analysis_qaevent_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analysis_qaevent_seq', 326, false);


--
-- Name: analysis_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analysis_seq', 931, true);


--
-- Data for Name: analysis_storages; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analysis_storages (id, storage_id, checkin, checkout, analysis_id) FROM stdin;
\.


--
-- Data for Name: analysis_users; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analysis_users (id, action, analysis_id, system_user_id) FROM stdin;
\.


--
-- Data for Name: analyte; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analyte (id, analyte_id, name, is_active, external_id, lastupdated, local_abbrev) FROM stdin;
44	\N	HIV-2 Result	Y	\N	2007-05-15 13:29:44.989	\N
62	\N	MEP Agar	Y	\N	2007-10-09 08:38:25.01	\N
63	\N	MYP Agar	Y	\N	2007-10-09 08:38:31.459	\N
64	\N	PLET Agar	Y	\N	2007-10-09 08:38:41.299	\N
65	\N	SBA Agar	Y	\N	2007-10-09 08:38:49.58	\N
67	\N	Extraction Kit	Y	\N	2007-12-10 09:04:09.124	\N
68	\N	Amplification Kit	Y	\N	2007-12-10 09:04:16.37	\N
69	\N	Light Cycler	Y	\N	2007-12-10 09:04:24.964	\N
70	\N	ABI 7000	Y	\N	2007-12-10 09:04:36.709	\N
71	\N	i Cycler	Y	\N	2007-12-10 09:04:56.821	\N
72	\N	ABI 7500	Y	\N	2007-12-10 09:05:04.01	\N
73	\N	DFA Capsule Antigen Detection	Y	\N	2007-12-10 09:05:41.24	\N
74	\N	DFA Cell Wall Detection	Y	\N	2007-12-10 09:06:56.313	\N
78	\N	Dilution 1:10	N	\N	2007-12-27 03:05:58.517	\N
89	\N	TRF Spore Detection Interpretation	Y	\N	2007-12-27 05:34:16.557	\N
90	\N	TRF Cell Detection Data Value	Y	\N	2007-12-27 05:34:57.18	\N
91	\N	TRF Cell Detection Result	Y	\N	2007-12-27 05:35:11.751	\N
92	\N	TRF Cell Detection Interpretation	Y	\N	2007-12-27 05:35:25.667	\N
1	\N	Influenza Virus B RNA	Y	\N	2007-02-02 14:09:33.524	\N
45	\N	Final HIV Interpretation 	Y	\N	2007-05-15 13:30:15.23	\N
47	\N	Penicillin	Y	\N	2007-05-18 09:41:04.107	\N
48	\N	Ceftriaxone	Y	\N	2007-05-18 09:41:14.295	\N
49	\N	Ciprofloxacin 	Y	\N	2007-05-18 09:43:17.764	\N
50	\N	Spectinomycin	Y	\N	2007-05-18 09:43:30.214	\N
43	\N	HIV-1 Result	Y	\N	2007-05-15 13:29:33.206	\N
51	\N	Tetracycline	Y	\N	2007-05-18 09:43:37.86	\N
52	\N	Cefixime	Y	\N	2007-05-18 09:43:52.144	\N
53	\N	Azithromycin	Y	\N	2007-05-18 09:44:01.789	\N
15	\N	Isoniazid 0.4 mcg.ml	Y	\N	2007-02-13 14:30:20.194	\N
16	\N	Streptomycin 2.0 mcg/ml	Y	\N	2007-02-13 14:30:43.17	\N
17	\N	Ethambutol 2.5 mcg/ml	Y	\N	2007-02-13 14:30:58.832	\N
18	\N	Pyrazinamide 100 mcg/ml	Y	\N	2007-02-13 14:32:46.073	\N
19	\N	DFA Capsule Antigen Detection from Isolate	Y	\N	2007-12-11 03:56:08.454	\N
8	\N	Respiratory Syncytial Virus A RNA	Y	\N	2007-02-02 14:13:44.532	\N
9	\N	Respiratory Syncytial Virus B RNA	Y	\N	2007-02-02 14:13:56.705	\N
20	\N	DFA Cell Wall Detection from Isolate	Y	\N	2007-12-11 03:56:47.987	\N
38	\N	Comment 8	Y	\N	2007-04-02 09:05:17.216	\N
41	\N	Titer	Y	\N	2007-05-03 15:59:07.522	\N
22	\N	Preliminary Result	Y	\N	2007-03-28 14:00:45.933	\N
23	\N	Result 4	Y	\N	2007-03-28 14:00:51.064	\N
24	\N	Result 5	Y	\N	2007-03-28 14:01:00.965	\N
25	\N	Result 6	Y	\N	2007-03-28 14:01:05.352	\N
26	\N	Result 7	Y	\N	2007-03-28 14:01:16.014	\N
27	\N	Result 8	Y	\N	2007-03-28 14:01:20.594	\N
28	\N	Result 9	Y	\N	2007-03-28 14:01:31.066	\N
29	\N	Preliminary Result Modifier	Y	\N	2007-03-28 16:22:57.579	\N
30	\N	Final Result Modifier	Y	\N	2007-03-28 16:22:21.34	\N
208	\N	Influenza Virus A/H3 RNA	Y	\N	2006-09-07 08:32:05	\N
209	\N	Influenza Virus A/H5 RNA	Y	\N	2006-09-07 08:32:21	\N
210	\N	Influenza Virus A/H7 RNA	Y	\N	2006-10-13 10:34:13.207	\N
211	\N	Influenza Virus A/H9 RNA	Y	\N	2008-01-23 08:02:52.021	\N
212	\N	Final Result	Y	\N	2006-09-07 08:34:31	\N
213	\N	Presumptive Result	Y	\N	2006-09-07 08:34:40	\N
214	\N	Result 1	Y	\N	2006-11-07 08:11:16	\N
215	\N	Result 2	Y	\N	2006-10-20 13:28:24	\N
216	\N	Result 3	Y	\N	2006-10-20 13:28:30	\N
217	\N	Interpretation	Y	\N	2006-09-07 08:35:29	\N
21	\N	Comment	Y	\N	2007-02-27 11:09:27.335	\N
54	\N	Gentamycin Interpretation	Y	\N	2007-06-20 10:01:45.134	\N
220	\N	BAND GP160	Y	\N	2006-10-18 09:19:37.724	\N
221	\N	BAND GP120	Y	\N	2006-10-18 09:19:38.505	\N
222	\N	BAND P65	Y	\N	2006-09-07 08:39:02	\N
223	\N	BAND P55	Y	\N	2006-09-07 08:39:12	\N
224	\N	BAND P51	Y	\N	2006-09-07 08:39:22	\N
225	\N	BAND GP41	Y	\N	2006-10-18 09:19:37.302	\N
226	\N	BAND P40	Y	\N	2006-11-07 13:55:36.669	\N
227	\N	BAND P31	Y	\N	2006-11-06 13:15:38.449	\N
228	\N	BAND P24	Y	\N	2006-11-06 13:15:29.222	\N
229	\N	BAND P18	Y	\N	2006-11-08 08:09:44.805	\N
246	\N	Rnase P Interpretation	Y	\N	2006-09-18 10:27:21	\N
251	\N	Result Status	Y	\N	2006-10-10 09:27:45	\N
252	\N	Probability	Y	\N	2006-10-03 10:24:02	\N
271	\N	Modifier 1	Y	\N	2006-10-20 09:28:32	\N
272	\N	Modifier 2	Y	\N	2006-10-20 09:28:37	\N
273	\N	Modifier 3	Y	\N	2006-10-20 09:28:42	\N
274	\N	Result Status 1	Y	\N	2006-10-20 09:28:51	\N
275	\N	Result Status 2	Y	\N	2006-10-20 09:28:59	\N
276	\N	Result Status 3	Y	\N	2006-10-20 09:29:06	\N
206	\N	Influenza Virus A RNA	Y	\N	2007-02-02 14:19:32.675	\N
207	\N	Influenza Virus A/H1 RNA	Y	\N	2006-09-07 08:31:50	\N
240	\N	BA2 CT value	Y	\N	2006-10-18 09:19:43.005	\N
244	\N	Extraction Method	Y	\N	2006-09-20 16:26:23	\N
245	\N	16S Interpretation	Y	\N	2006-10-25 11:21:09.457	\N
40	\N	Agent	Y	\N	2007-04-12 09:42:50.799	\N
249	\N	Modifier	Y	\N	2006-10-02 10:23:08	\N
250	\N	Quantity	Y	\N	2006-10-03 09:12:43	\N
253	\N	Method	Y	\N	2006-11-08 10:28:43	\N
266	\N	Capsule M-Fadyean	Y	\N	2006-10-11 13:51:30	\N
234	\N	BA3 interpretation	Y	\N	2006-10-18 09:19:39.302	\N
235	\N	16S CT value	Y	\N	2007-06-18 08:49:51.801	\N
232	\N	BA1 interpretation	Y	\N	2006-10-18 09:19:44.442	\N
233	\N	BA2 interpretation	Y	\N	2006-10-18 09:19:42.067	\N
236	\N	Rnase P CT value	Y	\N	2006-10-13 09:57:57.558	\N
237	\N	Result	Y	\N	2006-09-18 10:03:34	\N
46	\N	Western Blot Interpretation	Y	\N	2007-05-15 13:48:03.305	\N
239	\N	BA1 CT value	Y	\N	2006-10-23 14:12:56.284	\N
241	\N	BA3 CT value	Y	\N	2006-10-18 09:19:40.583	\N
242	\N	TRF Spore Detection Dilution	Y	\N	2007-12-27 05:33:28.883	\N
243	\N	TRF Cell Detection Dilution	Y	\N	2007-12-27 05:34:38.238	\N
247	\N	Disclaimer	Y	\N	2006-09-20 16:26:06	\N
256	\N	Rifampin 2.0 mcg/ml	Y	\N	2006-10-10 09:29:37	\N
55	\N	Kanamycin Interpretation	Y	\N	2007-06-20 10:02:26.74	\N
255	\N	Rifampin 1.0 mcg/ml	Y	\N	2006-10-10 09:29:21	\N
257	\N	Isoniazid 0.1 mcg/ml	Y	\N	2006-10-10 09:29:54	\N
258	\N	Colony Morphology	Y	\N	2006-10-11 13:49:58	\N
259	\N	Hemolysis	Y	\N	2006-10-11 13:50:05	\N
260	\N	Gram stain	Y	\N	2006-10-11 13:50:12	\N
261	\N	Motility wet mount	Y	\N	2006-10-11 13:50:35	\N
262	\N	Gamma phage	Y	\N	2006-10-11 13:50:43	\N
263	\N	DFA capsule from specimen	N	\N	2007-12-10 09:06:14.825	\N
264	\N	DFA cell wall from specimen	N	\N	2007-12-10 09:06:14.846	\N
265	\N	Capsule India Ink	Y	\N	2006-10-11 13:51:06	\N
267	\N	Capsule bicarbonate	Y	\N	2006-10-11 13:51:40	\N
268	\N	Catalase	Y	\N	2006-10-11 13:51:46	\N
269	\N	Malachite green for spores	Y	\N	2006-10-11 13:51:57	\N
270	\N	Wet mount for spores	Y	\N	2006-10-11 13:52:38	\N
31	\N	Comment 1	Y	\N	2007-04-02 09:04:22.529	\N
32	\N	Comment 2	Y	\N	2007-04-02 09:04:28.801	\N
33	\N	Comment 3	Y	\N	2007-04-02 09:04:41.088	\N
34	\N	Comment 4	Y	\N	2007-04-02 09:04:46.92	\N
35	\N	Comment 5	Y	\N	2007-04-02 09:04:56.112	\N
36	\N	Comment 6	Y	\N	2007-04-02 09:05:01.84	\N
37	\N	Comment 7	Y	\N	2007-04-02 09:05:08.789	\N
39	\N	Comment 9	Y	\N	2007-04-02 09:05:21.5	\N
56	\N	Gentamycin	Y	\N	2007-06-20 10:02:52.199	\N
57	\N	Kanamycin	Y	\N	2007-06-20 10:03:02.449	\N
58	\N	Motility Standard Media	Y	\N	2007-10-02 08:38:33.138	\N
59	\N	Standard Motility Media	Y	\N	2007-10-09 08:37:56.727	\N
60	\N	Chocolate Agar	Y	\N	2007-10-09 08:38:11.08	\N
61	\N	DEA Agar	Y	\N	2007-10-09 08:38:17.659	\N
66	\N	Test Moiety	Y	\N	2007-12-10 09:03:38.415	\N
75	\N	Choose Equipment	Y	\N	2007-12-11 05:35:57.035	\N
76	\N	Previous FTA Reactivity	Y	\N	2007-12-27 02:40:54.886	\N
77	\N	Fluorescence Grading	Y	\N	2007-12-27 02:41:18.215	\N
79	\N	E. coli 25922	Y	\N	2007-12-27 03:34:33.647	\N
80	\N	P. aeruginosa	Y	\N	2007-12-27 03:39:41.842	\N
81	\N	S. aureus	Y	\N	2007-12-27 03:34:57.55	\N
82	\N	Susceptible	N	\N	2007-12-27 03:41:45.362	\N
83	\N	Nonsusceptible - Contact CDC for confirmation of resistance	N	\N	2007-12-27 03:41:30.012	\N
84	\N	Test Not Performed	N	\N	2007-12-27 03:41:50.671	\N
85	\N	No Pass	Y	\N	2007-12-27 03:36:31.375	\N
86	\N	Pass	Y	\N	2007-12-27 03:36:35.561	\N
87	\N	TRF Spore Detection Date Value	Y	\N	2007-12-27 05:33:47.18	\N
88	\N	TRF Spore Detection Result	Y	\N	2007-12-27 05:34:05.441	\N
93	\N	test kit	Y		2009-04-03 10:15:45.64	TESTKIT
94	\N	Conclusion	Y	\N	2010-10-28 06:12:42.031482	\N
95	\N	generated CD4 Count	Y	\N	2010-10-28 06:13:55.508252	\N
96	\N	VIH Test - Collodial Gold/Shangai Kehua Result	Y	\N	2011-02-02 11:55:53.383208	\N
97	\N	Determine Result	Y	\N	2011-02-02 11:55:53.383208	\N
\.


--
-- Name: analyte_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analyte_seq', 97, true);


--
-- Data for Name: analyzer; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analyzer (id, scrip_id, name, machine_id, description, analyzer_type, is_active, location, lastupdated) FROM stdin;
1	\N	sysmex	1	bootstrap machine	\N	t	\N	2009-11-25 15:35:31.343118
3	\N	cobas_integra	\N	cobas_integra	\N	t	\N	2009-12-14 15:35:31.34118
\.


--
-- Data for Name: analyzer_result_status; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analyzer_result_status (id, name, description) FROM stdin;
1	NOT_REVIEWED	The result has not yet been reviewed by the user
2	ACCEPTED	The result has been reviewed and accepted by the user
3	DECLINED	The result has been reviewed and not accepted by the user
4	MATCHING_ACCESSION_NOT_FOUND	The Lab No does not exist in the system
5	MATCHING_TEST_NOT_FOUND	The Lab No exists but the test has not been entered
6	TEST_MAPPING_NOT_FOUND	The test name from the analyzer is not recognized
7	ERROR	The result sent from the analyzer can not be understood
\.


--
-- Data for Name: analyzer_results; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analyzer_results (id, analyzer_id, accession_number, test_name, result, units, status_id, iscontrol, lastupdated, read_only, test_id, duplicate_id, positive, complete_date, test_result_type) FROM stdin;
\.


--
-- Name: analyzer_results_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analyzer_results_seq', 1, false);


--
-- Name: analyzer_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('analyzer_seq', 1, true);


--
-- Data for Name: analyzer_test_map; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY analyzer_test_map (analyzer_id, analyzer_test_name, test_id, lastupdated) FROM stdin;
\.


--
-- Data for Name: animal_common_name; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY animal_common_name (id, name) FROM stdin;
\.


--
-- Data for Name: animal_scientific_name; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY animal_scientific_name (id, comm_anim_id, name) FROM stdin;
\.


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY attachment (id, attach_type, filename, description, storage_reference) FROM stdin;
\.


--
-- Data for Name: attachment_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY attachment_item (id, reference_id, reference_table_id, attachment_id) FROM stdin;
\.


--
-- Data for Name: aux_data; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY aux_data (id, sort_order, is_reportable, auxdata_type, value, reference_id, reference_table, aux_field_id) FROM stdin;
\.


--
-- Data for Name: aux_field; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY aux_field (id, sort_order, auxfld_type, is_active, is_reportable, reference_table, analyte_id, scriptlet_id) FROM stdin;
\.


--
-- Data for Name: aux_field_values; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY aux_field_values (id, auxfldval_type, value, aux_field_id) FROM stdin;
\.


--
-- Data for Name: chunking_history; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY chunking_history (id, chunk_length, start) FROM stdin;
1	5	1
\.


--
-- Name: chunking_history_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('chunking_history_id_seq', 1, true);


--
-- Name: city_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('city_seq', 1, false);


--
-- Data for Name: city_state_zip; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY city_state_zip (id, city, state, zip_code, county_fips, county, region_id, region, state_fips, state_name, lastupdated) FROM stdin;
\.


--
-- Data for Name: code_element_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY code_element_type (id, text, lastupdated, local_reference_table) FROM stdin;
1	TEST	2007-03-07 15:27:58.72	5
2	STATUS OF SAMPLE	2007-03-07 15:28:22.718	40
\.


--
-- Name: code_element_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('code_element_type_seq', 21, false);


--
-- Data for Name: code_element_xref; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY code_element_xref (id, message_org_id, code_element_type_id, receiver_code_element_id, local_code_element_id, lastupdated) FROM stdin;
\.


--
-- Name: code_element_xref_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('code_element_xref_seq', 41, false);


--
-- Data for Name: contact_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY contact_type (id, description, ct_type, is_unique) FROM stdin;
\.


--
-- Name: county_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('county_seq', 1, false);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY databasechangelog (id, author, filename, dateexecuted, md5sum, description, comments, tag, liquibase) FROM stdin;
1	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.155211+00	fbb3d826689c8079383f8966ab37a40	Update Data, Insert Row	Adds Bahmni specific configuration to SiteInfo	\N	1.9.5
2	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.164572+00	9fdf1988edc356d939fb5b19f6159f2	Update Data (x2)	Change default locale to en-GB	\N	1.9.5
3	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.17214+00	d098e13cd4046e6c19a1fad7321f0df	Update Data		\N	1.9.5
4	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.194828+00	7b9e9a516c21e28d94c2e39187d51b6f	Update Data, Delete Data (x2), Insert Row (x6)	Create address fields for Bahmni	\N	1.9.5
5	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.221163+00	8528b491a9adeec15cc65da9e8e111ce	Add Column	Add type to address_part table	\N	1.9.5
6	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.226384+00	8af6aa37796c6f9b93f452ff85488d5e	Update Data	Set address part type to D for department	\N	1.9.5
7	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.26134+00	1dcb504c8dd711c5821f644e7b454443	Create Table (x3)	Adding changes to support openelis atom feed	\N	1.9.5
8	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.274154+00	95743476e0eaa7b9f4ac637baf753042	Add Unique Constraint		\N	1.9.5
9	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.281558+00	12e54dfdf40ef9687b83505587475f	Update Data	Stop the schedulers not required for bahmni	\N	1.9.5
10	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.289483+00	51cafbf15b83cbcd9ffb8682623c7d5	Insert Row		\N	1.9.5
11	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.307095+00	db20a3a4517ec0935f2629547cbed050	Insert Row		\N	1.9.5
12	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.324988+00	dbcf46fdb9d9409e1ea1a7ec655ec7be	Insert Row, Create Table		\N	1.9.5
13	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.337488+00	6530b8fe6597f68c71e3e442c033ceb	Insert Row (x6)		\N	1.9.5
14	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.34544+00	d72983705e445daa95e1964ed3628b12	Insert Row		\N	1.9.5
15	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.364131+00	c117c485e50f7bf2d477caad6b7886	Create Table (x2)		\N	1.9.5
16	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.370526+00	d4f77cf8e7b534b1b48b871bb9b493	Insert Row		\N	1.9.5
17	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.375892+00	3d04e51d52a399d3d4b648c81c15e1e	Add Column		\N	1.9.5
18	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.381586+00	6811141e230d820ac428c1cfd4e4d2f	Add Column		\N	1.9.5
19	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.388796+00	ff83a64a965cf660bf6894e3db880ad	Add Foreign Key Constraint		\N	1.9.5
20	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.395795+00	3d76e547a2a0641b65b672b0e7378ee3	Drop Not-Null Constraint (x2), Insert Row		\N	1.9.5
21	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.421813+00	b6cdf43bf25f3a845f969087a661ac30	Create Table, Add Column, Add Foreign Key Constraint	Add new table sample_source and link to sample table	\N	1.9.5
22	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.43431+00	894861a63f30fe7e96e64ffd433b615	Insert Row (x5)	Data required for sample_source	\N	1.9.5
23	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.439207+00	7352f64602939506841834943dca34	Add Column	Add new column to sample_source for ordering the dropdown display	\N	1.9.5
24	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.446605+00	585f3b499830db5eb6b8120215cac5c	Update Data (x5)	setting values for ordering the sample_sources	\N	1.9.5
25	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.457282+00	9adf28b1628995782f9674c5ff87b34d	Insert Row	Adds the menu items for Validate 'All Test Sections'	\N	1.9.5
26	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.467269+00	7015f392507d7b83e4e698c2b4d4dd6	Update Data (x3), Insert Row, Update Data, Insert Row, Add Column		\N	1.9.5
27	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.47266+00	251f64a93f13df7d5a42376ced4ed342	Insert Row	Add primary relative	\N	1.9.5
28	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.477568+00	888544fe15beb6060dee237783c1b18	Update Data	Make validation of results compulsory	\N	1.9.5
29	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.496412+00	48297d26de5b5eccac6c34c3f7df3caf	Add Column	Add isActive column to Person	\N	1.9.5
30	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.507584+00	12d2aadc4cc456a77445ad2083bc360	Insert Row	Adds referral types	\N	1.9.5
31	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.530751+00	d9f5c984235f6f66087ff6bf81715c1	Update Data, Insert Row	Adding labDashboard menu	\N	1.9.5
32	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.536201+00	4c70d45ef353eed968defa695e14d825	Add Column	Adds uuid for the patient	\N	1.9.5
33	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.544261+00	617f7ee6ab9fa6abf1c1266fd8787	Update Data	Change frequency of patient runs	\N	1.9.5
34	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.549693+00	5018a6c2d6a179c973f056e59ad14e	Update Data	Sets the default for showing the invalid results icon to true	\N	1.9.5
35	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.560612+00	6a32f48c2b8954077897aad23935eb	Insert Row (x2)		\N	1.9.5
36	marks	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.567456+00	98b4f1e285ff50e28bacb2b0ef51bfe8	Insert Row	Adds the upload menu item for Bahmni	\N	1.9.5
37	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.573188+00	f0ea9e1a51c16823072d31ce4a2ce7	Update Data	Validation fails if active inventory items dont have receipt. Inactivating the inventory items	\N	1.9.5
38	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.580894+00	d269c8527ffb1f9555efc54a9e5dfa30	Delete Data (x2)	Remove haiti test section menus for Test Results and Validation	\N	1.9.5
39	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.588444+00	12805cd8ca8c1d735ae85e7be52ee46	Delete Data (x3)	Removing menus not needed for Bahmni	\N	1.9.5
40	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.595336+00	e8ff848c9c216c84404443e15f8441a3	Insert Row	Adds the referredOut menu item for Bahmni	\N	1.9.5
41	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.602485+00	6be8a544315b66d8312e812af42a35	Insert Row (x2)		\N	1.9.5
42	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.612047+00	1aaae69b35317096d42961f3c8b6b71	Insert Row		\N	1.9.5
43	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.621171+00	5917775a48be31488a915e41b538ffc	Update Data	Remove logo in reports	\N	1.9.5
44	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.654201+00	8a2d5752e1d32b8f49e77f3d2483fab1	Create Table		\N	1.9.5
45	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.666661+00	e6baa294c3b1aa33df2673f090c5ea46	Drop Column, Add Column		\N	1.9.5
46	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.673136+00	e7e107053ae43eb4cd6ad7e6a37c8ff	Update Data		\N	1.9.5
47	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.681646+00	a66ff54cc2e52933346841d5b27ba44e	Insert Row (x2)		\N	1.9.5
48	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.68632+00	dc25a6c2c5f6e3385184fd34f1bf1684	Update Data	Set site name	\N	1.9.5
49	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.691624+00	c14e6e9daf5838392a0b09a9d91dd95	Insert Row		\N	1.9.5
50	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.702309+00	5ee6815888a4bdde797d4325649470	Insert Row (x4), Custom SQL (x2)	Adjust modules and roles for the new pages	\N	1.9.5
51	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.708101+00	5c6d25fc2dca78ff406412d24d47dbba	Custom SQL	Increase the column size for panel_item	\N	1.9.5
52	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.718044+00	36fd130967c6682bab92bce958ba2	Update Data, Custom SQL	Fix changeset 50	\N	1.9.5
53	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.730348+00	9b41b352ca5092b2dba895f21b6e6b	Insert Row, Custom SQL	Add module for validation of all sections	\N	1.9.5
54	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.736929+00	842f674f3b3cb019fdbfd3ff2ede7ac3	Insert Row	Add Bahmni Lab Dictionary category	\N	1.9.5
55	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.753658+00	6715f229e975853ebecacb41b6fd4	Update Data (x2), Insert Row		\N	1.9.5
56	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.759728+00	146d4fe87022ab30736691f81dcd505c	Custom SQL (x2)	Increase the column size for result and notes column	\N	1.9.5
57	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.766273+00	e6da70772b21a5c0f633e7244b4dac4b	Insert Row		\N	1.9.5
58	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.77372+00	3f359a4878769e6ef16239635d04f90	Insert Row		\N	1.9.5
59	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.78152+00	f73b81f43c6a8f4960e0f22ec98114e2	Insert Row, Custom SQL	Add health center to list of pages	\N	1.9.5
rel3-57	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.788281+00	d51af10bc22b4992687c5231e1c9ec4	Insert Row (x2)		\N	1.9.5
rel3-58	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.79295+00	42b9d33a45862441b65268fb2e847eb	Add Column	Adds uuid for the sample	\N	1.9.5
60	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.801278+00	3cef778933d433c63e25678377233781	Update Data (x3)	Remove all report senders	\N	1.9.5
61	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.808151+00	3e7bb5d920c8f2aa695ed5b403be11a	Modify Column		\N	1.9.5
62	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.815968+00	5114137b658ea3eff32d1d89e2bb59b	Add Column, Update Data	Add new column to Health Center	\N	1.9.5
63	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.822991+00	31e2978fbb06f8a8b7a658fe2e15ae8	Add Column	Add Abnormal Column to Test Result	\N	1.9.5
64	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.829577+00	958ea25b0be90d745f27ce1eb555b89	Add Column	Add Abnormal Column to Result	\N	1.9.5
65	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.836719+00	95e7c7e911da974716a99edb42afd43	Add Default Value		\N	1.9.5
66	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.841964+00	f71a85ff1cfab5e46527546f917d47	Add Default Value		\N	1.9.5
67	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.848294+00	c36b9624606ff3fa43aedb537229e48e	Update Data		\N	1.9.5
68	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.85304+00	856184dc76f5bd8f1b0b31b2544a11	Update Data		\N	1.9.5
69	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.865672+00	9d47a92a50737b95440d7f6af1ed23	Update Data		\N	1.9.5
70	ict4h	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.883128+00	2cd78aa135eb58cb87939259f7ff89a3	Create Table		\N	1.9.5
71	ict4h	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.888997+00	9fb19a37181d98a114acb757f7a58454	Add Column		\N	1.9.5
72	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.893399+00	58902e1256d5b686f1a35f826d0b2d9	Update Data	Fix changeset 50	\N	1.9.5
73	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.90045+00	e919753073f336be3ca10afb3817db	Custom SQL	Ensure uuid present in sample table	\N	1.9.5
74	ict4h	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.905699+00	1f70ce6b8944c7a10fb24b7b8d2f0a8	Add Column		\N	1.9.5
75	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.911309+00	e460ef295f5bc95048672ca9e4272b6a	Custom SQL	Ensure uuid present in test_section table	\N	1.9.5
76	ict4h	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.917901+00	bcf237419bc957d654bb2262db5ca9b	Add Column		\N	1.9.5
77	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.922261+00	afbfeee908a94b37157b192b8d574bd	Custom SQL	Ensure uuid present in unit_of_measure table	\N	1.9.5
78	ict4h	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.927983+00	d7fdb431abaacf4c76b8dbf89ebba68	Add Column		\N	1.9.5
79	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.932811+00	e78c7a787271c5d765e449b943176	Custom SQL	Ensure uuid present in type_of_sample table	\N	1.9.5
80	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.938557+00	bc99606e1142cc802f80bfc9be249616	Custom SQL	Add event records for existing accession	\N	1.9.5
81	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.94384+00	5a496cfa721934a14fb96f6cbc7d5e0	Insert Row (x2)		\N	1.9.5
82	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.948568+00	2cc73c35d1b716c96085dc23b0e685	Insert Row		\N	1.9.5
83	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.95317+00	d83b4323783eefe889ba1d4b20464def	Delete Data		\N	1.9.5
84	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.957114+00	4e713be5877ee164bed0beb8356442	Custom SQL	Set system user id from non_user_name	\N	1.9.5
85	tw	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.960936+00	a835911eaabff25468bfd3c9a867b775	Custom SQL	Remove all event records incorrectly created with category result	\N	1.9.5
86	Banka	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.984214+00	40e91b9ce8694773c5192adea9aa3d2d	Add Unique Constraint	Add unique constraint for uuid in patient	\N	1.9.5
87	arathy	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.990953+00	6868deb3523648b86efcd7427a0b6af	Update Data	Adding site information for logo image name	\N	1.9.5
88	arathy	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:53.996358+00	b66de51c225873cba68bbc3d6eaeb3	Update Data	Changing value_type of additional info	\N	1.9.5
89	rohan	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.00213+00	8558363928649f3534f1b4b381e89155	Custom SQL	Change duplicate unit of measures	\N	1.9.5
90	rohan	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.006839+00	d9335ad1e2ecd9272c376a47d84110	Delete Data (x4)	Remove duplicate unit of measures	\N	1.9.5
91	Neha	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.016536+00	a7456a8243b171bce968f99e305bc36f	Custom SQL	Update gender_seq to the latest value	\N	1.9.5
92	Rohan,Neha	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.023891+00	e337dc7d06bc31173bc804a3036a98b	Add Column	Add the uploaded_file_name column to the result table	\N	1.9.5
93	Rohan,Neha	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.031564+00	58adb8ac461ce2bc58d2e81be272eab8	Insert Row	Add uploaded results directory path in site information	\N	1.9.5
94	Arathy	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.036947+00	c68c967d96328a6cb1bd91731f85e2	Add Column	Add result limit id column to the result table	\N	1.9.5
95	Bharti,Arathy	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.044369+00	7b1d768561ead1ffd58388ccbd512b2b	Custom SQL	Adding Hospital name and address	\N	1.9.5
96	Bharti, Arathy	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.048029+00	1c53b5123773829851e5e0622fa69485	Custom SQL	Update gender_seq to the latest value	\N	1.9.5
97	Chethan, Mihir	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.056218+00	656891fd6124062737d415d32b4399	Insert Row (x2)		\N	1.9.5
98	Mihir	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.061816+00	77a3c5fe5ef0f8d671f86fa551c0e3	Custom SQL	Update cron_statement to correct cron schedule	\N	1.9.5
99	Mihir	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.067995+00	7925275d70b5a17c6daa409a59a1b	Custom SQL	Delete reference data atom feed scheduler	\N	1.9.5
100	Mihir, Sravanthi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.075646+00	20c5a6c93e83e86a7cc396c92864ec3f	Custom SQL	Delete view hiv_patients	\N	1.9.5
101	Mihir, Sravanthi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.100759+00	381a2449367bedd6383bac4d5c898cc1	Custom SQL	Resize test_section name column	\N	1.9.5
102	Mihir, Hemanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.107364+00	c7deddfddad7e4b12fc6cb13a6c7ff7	Custom SQL	Resize type_of_sample local_abbrev column	\N	1.9.5
103	Chethan, Hemanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.119375+00	e77af5f1a2ae188dd0129ecd38ff283	Drop View, Modify Column, Custom SQL	altering the data type of name fields to accept 50 characters in person table and sampletracking view	\N	1.9.5
104	Charles, Sravanthi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.124266+00	6abe62cbbf20be79c4626dea168a4982	Drop Not-Null Constraint		\N	1.9.5
105	Preethi, Sandeep	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.144342+00	2d8debf96edbac8845362b10e0aea4	Add Column		\N	1.9.5
106	Preethi, Sandeep	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.149906+00	bddbd04fe4a918a3fab7715ad4f9b77c	Custom SQL	set active flag for all test results	\N	1.9.5
108	Sudhakar, Abishek	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.172149+00	5cea549b48745cd8dde63cf6f5d1f27f	Add Column, Create Table		\N	1.9.5
109	Shan, Sandeep	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.182496+00	35592da18b4b0f2e8593daf8d8e5e34	Add Column		\N	1.9.5
110	Padma, Hemanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.188117+00	a07a406d22de70583646b0c578414	Insert Row		\N	1.9.5
14092015080113	Hemanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.216835+00	d11cd9dc4ae9d2b3f3ed627eff6c66	Create Table		\N	1.9.5
06102015170630	Achinta, Sudhakar	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.225902+00	2fc695cbf4bbd47824d1e58182f6385e	Create Index	Add index to the category column in event_records table for performance (if it is not already present)	\N	1.9.5
151120151208	Sourav	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.230626+00	564baeb237118b7a64e85742a271924	Modify Column	altering the data type of identity_data to accept 50 characters in patient_identity table	\N	1.9.5
115420153112	Hanisha,Shashi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.268639+00	7f1ab3e5dff1a49e4432bfc925fbdf19	Add Column	Add isReferredOut Column to Test	\N	1.9.5
120020160501	Hanisha, Shashi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.2776+00	6bf7837debee7b3eab677fe6a3b49b6b	Insert Row	Adding new organization External Lab	\N	1.9.5
042120160501	Hanisha,Shashi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.282362+00	d0b8bef9aecd9c47cd777ce5e067336d	Insert Row		\N	1.9.5
042220160501	Hanisha,Shashi	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.291085+00	f8f5ddf4963253bed788489816ba89	Custom SQL	Adding new organization External Lab to organization_organization_type	\N	1.9.5
2016-01-12-1202	Jaswanth, JP	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:54.296128+00	63ed66a6ed7f1cf38d548a189dbf946	Update Data		\N	1.9.5
011920161233	Shashi, Hanisha	./Bahmni/BahmniConfig.xml	2017-02-28 15:47:58.564148+00	479b2fbfdca83dac49acedbb89bf337	Add Column	Creating column date_created for queue table. This indicates the time event was raised or created.	\N	1.9.5
0119290161232	Shashi, Hanisha	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:02.605745+00	b04bc0a48aa3cacd63689d68c76cb78	Add Column	Creating column tags for failed_events table. This is same as atom spec feed.entry.categories.	\N	1.9.5
240220161208	Vinay	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:02.612793+00	fd3a6b69eafdb73e127aab76f370f1	Modify Column	Identity data should contain full length of a concept name, which is 255 characters	\N	1.9.5
140320161800	Vinay	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:06.689141+00	769a8ce4ad984daa9726b39ef8110c	Create Index	Add index on lastupdated for sample	\N	1.9.5
140320161801	Vinay	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:10.697991+00	a97b4bdbe7e96423eacdb3c851159af	Create Index	Add index on lastupdated for analysis	\N	1.9.5
150320161101	Vinay	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:14.737895+00	79f2bbb916f6a5b9fb4550c72740bc3a	Create Index	Add index on patient_id for patient_identity table	\N	1.9.5
201603171606	Jaswanth,Swathi	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:14.743041+00	c9f8cdeaa83559436ee8de2baf33	Update Data	Increase schedule interval to 24 hours	\N	1.9.5
2016-03-24-9732	Jaswanth, Hemanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:14.753434+00	c07143d7f2a7b69023c5d77dc9757a67	Update Data		\N	1.9.5
201615041044	Chethan	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:14.757959+00	7fb860ef31724fce990557b9e84a1a4	Update Data	atom-feed-events-offset-marker job should be run on 12 am everyday	\N	1.9.5
20160714-2017-1	Jaswanth,Padma	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:18.728449+00	aebd75a4dca25f94963c13fbe2fb2b5	Add Column	Creating column tags for queue table. Each event can be tagged with multiple tags; as comma separated strings	\N	1.9.5
20160714-2017-2	Jaswanth,Padma	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.685786+00	7a1b3b77f7815cfc87985879c2f960ab	Add Column	Creating column tags for event_records table. Each event can be tagged with multiple tags; as comma separated strings	\N	1.9.5
030820161209	Hanisha	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.692022+00	9996261a4d9b449f1e7d2f83795d23d8	Custom SQL	Adding the visit location for lab(Used in sync)	\N	1.9.5
230820161641	Jaswanth,Kaustav	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.70127+00	9c562532ebf92aeeaeb687883d648dd	Drop Column, Drop Table		\N	1.9.5
20160809	Bindu,Gurpreet	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.705369+00	ab9a36cb4dd89b68f9894e7736cc91	Custom SQL	Update allowLanguageChange to true to enable Internationalization in Login page	\N	1.9.5
add-atomfeed-user	Jaswanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.710342+00	a8d3a4ca961a7bc2697889db54a967c1	Custom SQL	Add user for accessing atomfeed	\N	1.9.5
update-admin-user-password-expiry-date	Jaswanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.713328+00	f09ccd7a6d790c7fde3af5216ed3aca	Custom SQL	Update admin user password expiry date	\N	1.9.5
assign-module-to-atomfeed-user	Jaswanth	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.718443+00	45842815bc6181e5976a93d5bbcfd	Custom SQL	Assign LabDashboard module to atomfeed user	\N	1.9.5
remove-lab-location-config	Padma, Salauddin	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.72269+00	1f9b3c3fb1ff1cf19c2bb952b283	Custom SQL	Removing the lab location configuration	\N	1.9.5
configure-default-sample-source	Padma, Salauddin	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.727026+00	4ae635a8ea129e917af0e3c3745bfbd7	Custom SQL	Adding the default Sample source configuration	\N	1.9.5
change-sample-source-name-length	Salauddin	./Bahmni/BahmniConfig.xml	2017-02-28 15:48:22.731615+00	8ac795f75b79aa797394e95269224b7	Custom SQL	change sample source name to accept 50 characters	\N	1.9.5
201509011514	Preethi,Sourav	liquibase.xml	2017-02-28 15:48:25.735924+00	9b1915750c122248053ca77acb2b454	Custom SQL	Add default organization name for openelis	\N	1.9.5
201510121504	Preethi,Sourav	liquibase.xml	2017-02-28 15:48:25.747157+00	fa29db543fe7e71a53198478c477b1	Custom SQL	Add Bahmni organization	\N	1.9.5
201603021148	Preethi,Vikash	liquibase.xml	2017-02-28 15:48:25.753895+00	7eaa3f242fc04e5f3cb9ab26a704bda	Custom SQL	Update Active Flag for Bahmni Organization	\N	1.9.5
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: dictionary; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY dictionary (id, is_active, dict_entry, lastupdated, local_abbrev, dictionary_category_id, display_key) FROM stdin;
1206	\N	MP Seen	2017-04-24 15:08:45.479	\N	\N	\N
1207	\N	MP not seen	2017-04-24 15:08:45.482	\N	\N	\N
1208	\N	Nil	2017-04-24 15:08:45.717	\N	\N	\N
1209	\N	Trace	2017-04-24 15:08:45.721	\N	\N	\N
1220	\N	<80	2017-04-24 15:08:45.746	\N	\N	\N
1221	\N	1:80	2017-04-24 15:08:45.749	\N	\N	\N
1222	\N	1:160	2017-04-24 15:08:45.753	\N	\N	\N
1223	\N	1:320	2017-04-24 15:08:45.756	\N	\N	\N
1215	\N	No AFB Seen	2017-04-24 15:08:45.777	\N	\N	\N
1216	\N	SCANTY	2017-04-24 15:08:45.78	\N	\N	\N
1210	\N	1+	2017-04-24 15:08:45.784	\N	\N	\N
1211	\N	2+	2017-04-24 15:08:45.787	\N	\N	\N
1212	\N	3+	2017-04-24 15:08:45.791	\N	\N	\N
1203	\N	AB	2017-04-24 15:08:45.805	\N	\N	\N
1200	\N	A	2017-04-24 15:08:45.809	\N	\N	\N
1201	\N	B	2017-04-24 15:08:45.813	\N	\N	\N
1202	\N	O	2017-04-24 15:08:45.816	\N	\N	\N
1204	\N	Positive	2017-04-24 15:08:45.926	\N	\N	\N
1205	\N	Negative	2017-04-24 15:08:45.93	\N	\N	\N
1213	\N	Reactive	2017-04-24 15:08:45.979	\N	\N	\N
1214	\N	Non Reactive	2017-04-24 15:08:45.983	\N	\N	\N
\.


--
-- Data for Name: dictionary_category; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY dictionary_category (id, description, lastupdated, local_abbrev, name) FROM stdin;
197	Bahmni Lab	2017-02-28 15:47:53.734343	\N	Bahmni Lab
\.


--
-- Name: dictionary_category_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('dictionary_category_seq', 216, true);


--
-- Name: dictionary_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('dictionary_seq', 1239, true);


--
-- Data for Name: district; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY district (id, city_id, dist_entry, lastupdated, description) FROM stdin;
\.


--
-- Name: district_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('district_seq', 1, false);


--
-- Data for Name: document_track; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY document_track (id, table_id, row_id, document_type_id, parent_id, report_generation_time, lastupdated, name) FROM stdin;
58	1	35	4	\N	2017-04-11 09:37:14.711+00	2017-04-11 09:37:14.714+00	patientHaitiClinical
59	1	35	4	58	2017-04-11 09:48:05.356+00	2017-04-11 09:48:05.358+00	patientHaitiClinical
60	1	33	4	\N	2017-04-11 09:48:51.946+00	2017-04-11 09:48:51.947+00	patientHaitiClinical
61	1	35	4	59	2017-04-11 09:59:42.743+00	2017-04-11 09:59:42.745+00	patientHaitiClinical
62	1	36	4	\N	2017-04-11 12:27:38.483+00	2017-04-11 12:27:38.486+00	patientHaitiClinical
63	1	50	4	\N	2017-04-20 11:59:21.032+00	2017-04-20 11:59:21.053+00	patientHaitiClinical
64	1	55	4	\N	2017-04-21 05:11:41.141+00	2017-04-21 05:11:41.144+00	patientHaitiClinical
65	1	55	4	64	2017-04-21 05:16:26.423+00	2017-04-21 05:16:26.424+00	patientHaitiClinical
66	1	68	4	\N	2017-04-25 05:00:58.083+00	2017-04-25 05:00:58.091+00	patientHaitiClinical
67	1	68	4	66	2017-04-25 05:21:25.217+00	2017-04-25 05:21:25.219+00	patientHaitiClinical
68	1	89	4	\N	2017-05-02 11:14:02.582+00	2017-05-02 11:14:02.585+00	patientHaitiClinical
69	1	89	4	68	2017-05-02 11:14:20.356+00	2017-05-02 11:14:20.357+00	patientHaitiClinical
70	1	54	4	\N	2017-05-08 05:07:46.245+00	2017-05-08 05:07:46.246+00	patientHaitiClinical
71	1	53	4	\N	2017-05-09 11:22:41.865+00	2017-05-09 11:22:41.866+00	patientHaitiClinical
72	1	52	4	\N	2017-05-09 11:33:20.414+00	2017-05-09 11:33:20.415+00	patientHaitiClinical
73	1	54	4	70	2017-05-09 12:32:40.66+00	2017-05-09 12:32:40.662+00	patientHaitiClinical
74	1	54	4	73	2017-05-09 12:37:49.474+00	2017-05-09 12:37:49.475+00	patientHaitiClinical
75	1	87	4	\N	2017-05-10 23:33:47.122+00	2017-05-10 23:33:47.123+00	patientHaitiClinical
76	1	48	4	\N	2017-05-10 23:44:42.121+00	2017-05-10 23:44:42.122+00	patientHaitiClinical
77	1	51	4	\N	2017-05-10 23:44:42.124+00	2017-05-10 23:44:42.125+00	patientHaitiClinical
78	1	52	4	72	2017-05-10 23:44:42.126+00	2017-05-10 23:44:42.127+00	patientHaitiClinical
79	1	53	4	71	2017-05-10 23:44:42.13+00	2017-05-10 23:44:42.131+00	patientHaitiClinical
80	1	54	4	74	2017-05-10 23:44:42.132+00	2017-05-10 23:44:42.133+00	patientHaitiClinical
81	1	55	4	65	2017-05-10 23:44:42.134+00	2017-05-10 23:44:42.135+00	patientHaitiClinical
82	1	96	4	\N	2017-05-17 04:59:49.482+00	2017-05-17 04:59:49.484+00	patientHaitiClinical
83	1	54	4	80	2017-05-22 06:11:40.632+00	2017-05-22 06:11:40.633+00	patientHaitiClinical
84	1	107	4	\N	2017-05-29 09:18:19.484+00	2017-05-29 09:18:19.485+00	patientHaitiClinical
85	1	109	4	\N	2017-05-30 04:43:30.389+00	2017-05-30 04:43:30.391+00	patientHaitiClinical
86	1	109	4	85	2017-05-30 04:51:55.66+00	2017-05-30 04:51:55.662+00	patientHaitiClinical
87	1	109	4	86	2017-05-30 05:00:04.824+00	2017-05-30 05:00:04.826+00	patientHaitiClinical
88	1	114	4	\N	2017-05-30 11:33:14.995+00	2017-05-30 11:33:15.018+00	patientHaitiClinical
89	1	114	4	\N	2017-05-30 11:33:14.995+00	2017-05-30 11:33:15.034+00	patientHaitiClinical
90	1	114	4	89	2017-05-30 11:34:18.505+00	2017-05-30 11:34:18.507+00	patientHaitiClinical
91	1	119	4	\N	2017-06-09 16:38:07.351+00	2017-06-09 16:38:07.352+00	patientHaitiClinical
92	1	111	4	\N	2017-06-13 06:26:57.759+00	2017-06-13 06:26:57.76+00	patientHaitiClinical
93	1	121	4	\N	2017-08-02 08:51:13.148+00	2017-08-02 08:51:13.151+00	patientHaitiClinical
\.


--
-- Name: document_track_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('document_track_seq', 93, true);


--
-- Data for Name: document_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY document_type (id, name, description, lastupdated) FROM stdin;
1	nonConformityNotification	Non_Conformity reports to be sent to clinic	2012-04-24 00:30:14.523972+00
2	resultExport	Results sent electronically to other systems	2012-04-24 00:30:14.678323+00
3	malariaCase	malaria case report sent	2012-05-01 16:46:25.085126+00
4	patientReport	Any patient report, name in report_tracker	2013-08-08 08:02:35.04225+00
\.


--
-- Name: document_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('document_type_seq', 4, true);


--
-- Data for Name: ethnicity; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY ethnicity (id, ethnic_type, description, is_active) FROM stdin;
\.


--
-- Data for Name: event_records; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY event_records (id, uuid, title, "timestamp", uri, object, category, date_created, tags) FROM stdin;
\.


--
-- Name: event_records_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('event_records_id_seq', 184, true);


--
-- Data for Name: event_records_offset_marker; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY event_records_offset_marker (id, event_id, event_count, category) FROM stdin;
\.


--
-- Name: event_records_offset_marker_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('event_records_offset_marker_id_seq', 1, false);


--
-- Data for Name: event_records_queue; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY event_records_queue (id, uuid, title, "timestamp", uri, object, category, tags) FROM stdin;
\.


--
-- Name: event_records_queue_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('event_records_queue_id_seq', 184, true);


--
-- Data for Name: external_reference; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY external_reference (id, item_id, external_id, type) FROM stdin;
\.


--
-- Name: external_reference_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('external_reference_id_seq', 125, true);


--
-- Data for Name: failed_event_retry_log; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY failed_event_retry_log (id, feed_uri, failed_at, error_message, event_id, event_content, error_hash_code) FROM stdin;
\.


--
-- Name: failed_event_retry_log_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('failed_event_retry_log_id_seq', 70, true);


--
-- Data for Name: failed_events; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY failed_events (id, feed_uri, error_message, event_id, event_content, failed_at, error_hash_code, title, retries, tags) FROM stdin;
\.


--
-- Name: failed_events_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('failed_events_id_seq', 7, true);


--
-- Data for Name: gender; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY gender (id, gender_type, description, lastupdated, name_key) FROM stdin;
145	M	MALE	2006-10-10 13:18:40.094	gender.male
146	F	FEMALE	2006-11-21 12:04:02.372	gender.female
147	O	Other	\N	gender.other
\.


--
-- Name: gender_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('gender_seq', 147, true);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('hibernate_sequence', 4819, true);


--
-- Data for Name: history; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY history (id, sys_user_id, reference_id, reference_table, "timestamp", activity, changes) FROM stdin;
1401	1	10	16	2017-03-01 11:03:45.213	I	\N
1402	1	8	15	2017-03-01 11:03:45.329	I	\N
1403	1	12	112	2017-03-01 11:03:45.369	I	\N
1421	1	82	36	2017-04-10 14:52:15.223	I	\N
1422	1	784	5	2017-04-10 14:52:15.231	I	\N
1423	1	785	5	2017-04-10 14:52:15.342	I	\N
1424	1	2587	32	2017-04-10 14:52:15.348	I	\N
1441	1	786	5	2017-04-10 14:52:15.367	I	\N
1442	1	2588	32	2017-04-10 14:52:15.375	I	\N
1425	1	83	36	2017-04-10 14:52:15.401	I	\N
1426	1	787	5	2017-04-10 14:52:15.402	I	\N
1427	1	788	5	2017-04-10 14:52:15.42	I	\N
1428	1	789	5	2017-04-10 14:52:15.437	I	\N
1429	1	790	5	2017-04-10 14:52:15.498	I	\N
1443	1	791	5	2017-04-10 14:52:15.518	I	\N
1444	1	792	5	2017-04-10 14:52:15.536	I	\N
1445	1	84	36	2017-04-10 14:52:15.555	I	\N
1446	1	793	5	2017-04-10 14:52:15.557	I	\N
1430	1	794	5	2017-04-10 14:52:15.571	I	\N
1431	1	795	5	2017-04-10 14:52:15.612	I	\N
1447	1	85	36	2017-04-10 14:52:15.626	I	\N
1448	1	796	5	2017-04-10 14:52:15.628	I	\N
1449	1	797	5	2017-04-10 14:52:15.646	I	\N
1450	1	86	36	2017-04-10 14:52:15.66	I	\N
1451	1	798	5	2017-04-10 14:52:15.661	I	\N
1452	1	87	36	2017-04-10 14:52:15.686	I	\N
1453	1	799	5	2017-04-10 14:52:15.688	I	\N
1432	1	800	5	2017-04-10 14:52:15.731	I	\N
1454	1	801	5	2017-04-10 14:52:15.746	I	\N
1433	1	802	5	2017-04-10 14:52:15.76	I	\N
1455	1	803	5	2017-04-10 14:52:15.774	I	\N
1434	1	804	5	2017-04-10 14:52:15.789	I	\N
1435	1	88	36	2017-04-10 14:52:15.829	I	\N
1436	1	805	5	2017-04-10 14:52:15.831	I	\N
1456	1	806	5	2017-04-10 14:52:15.845	I	\N
1437	1	807	5	2017-04-10 14:52:15.861	I	\N
1438	1	1200	9	2017-04-10 14:52:15.87	I	\N
1439	1	2589	32	2017-04-10 14:52:15.877	I	\N
1440	1	1201	9	2017-04-10 14:52:15.878	I	\N
1461	1	2590	32	2017-04-10 14:52:15.884	I	\N
1462	1	1202	9	2017-04-10 14:52:15.886	I	\N
1463	1	2591	32	2017-04-10 14:52:15.889	I	\N
1464	1	1203	9	2017-04-10 14:52:15.89	I	\N
1465	1	2592	32	2017-04-10 14:52:15.894	I	\N
1466	1	1204	9	2017-04-10 14:52:15.896	I	\N
1467	1	2593	32	2017-04-10 14:52:15.899	I	\N
1468	1	1205	9	2017-04-10 14:52:15.901	I	\N
1469	1	2594	32	2017-04-10 14:52:15.902	I	\N
1457	1	89	36	2017-04-10 14:52:15.916	I	\N
1458	1	808	5	2017-04-10 14:52:15.919	I	\N
1470	1	809	5	2017-04-10 14:52:15.933	I	\N
1471	1	1206	9	2017-04-10 14:52:15.936	I	\N
1472	1	2595	32	2017-04-10 14:52:15.938	I	\N
1473	1	1207	9	2017-04-10 14:52:15.939	I	\N
1474	1	2596	32	2017-04-10 14:52:15.941	I	\N
1475	1	810	5	2017-04-10 14:52:15.985	I	\N
1476	1	1208	9	2017-04-10 14:52:15.987	I	\N
1477	1	2597	32	2017-04-10 14:52:15.989	I	\N
1478	1	1209	9	2017-04-10 14:52:15.991	I	\N
1479	1	2598	32	2017-04-10 14:52:15.992	I	\N
1480	1	1210	9	2017-04-10 14:52:15.996	I	\N
1481	1	2599	32	2017-04-10 14:52:15.999	I	\N
1482	1	1211	9	2017-04-10 14:52:16	I	\N
1483	1	2600	32	2017-04-10 14:52:16.004	I	\N
1484	1	1212	9	2017-04-10 14:52:16.005	I	\N
1485	1	2601	32	2017-04-10 14:52:16.007	I	\N
1486	1	90	36	2017-04-10 14:52:16.029	I	\N
1487	1	811	5	2017-04-10 14:52:16.03	I	\N
1488	1	812	5	2017-04-10 14:52:16.051	I	\N
1489	1	2602	32	2017-04-10 14:52:16.098	I	\N
1490	1	2603	32	2017-04-10 14:52:16.102	I	\N
1491	1	2604	32	2017-04-10 14:52:16.104	I	\N
1492	1	2605	32	2017-04-10 14:52:16.111	I	\N
1493	1	2606	32	2017-04-10 14:52:16.116	I	\N
1494	1	813	5	2017-04-10 14:52:16.135	I	\N
1459	1	814	5	2017-04-10 14:52:16.15	I	\N
1460	1	815	5	2017-04-10 14:52:16.196	I	\N
1495	1	816	5	2017-04-10 14:52:16.215	I	\N
1496	1	2607	32	2017-04-10 14:52:16.219	I	\N
1497	1	2608	32	2017-04-10 14:52:16.221	I	\N
1498	1	817	5	2017-04-10 14:52:16.239	I	\N
1499	1	2609	32	2017-04-10 14:52:16.242	I	\N
1500	1	2610	32	2017-04-10 14:52:16.244	I	\N
1501	1	818	5	2017-04-10 14:52:16.259	I	\N
1502	1	2611	32	2017-04-10 14:52:16.262	I	\N
1503	1	2612	32	2017-04-10 14:52:16.264	I	\N
1521	1	819	5	2017-04-10 14:52:16.278	I	\N
1522	1	2613	32	2017-04-10 14:52:16.282	I	\N
1523	1	2614	32	2017-04-10 14:52:16.288	I	\N
1524	1	820	5	2017-04-10 14:52:16.328	I	\N
1504	1	821	5	2017-04-10 14:52:16.352	I	\N
1525	1	822	5	2017-04-10 14:52:16.368	I	\N
1505	1	823	5	2017-04-10 14:52:16.387	I	\N
1506	1	2615	32	2017-04-10 14:52:16.39	I	\N
1507	1	2616	32	2017-04-10 14:52:16.393	I	\N
1526	1	91	36	2017-04-10 14:52:16.416	I	\N
1527	1	824	5	2017-04-10 14:52:16.417	I	\N
1528	1	825	5	2017-04-10 14:52:16.477	I	\N
1508	1	92	36	2017-04-10 14:52:16.494	I	\N
1509	1	826	5	2017-04-10 14:52:16.496	I	\N
1529	1	827	5	2017-04-10 14:52:16.515	I	\N
1510	1	828	5	2017-04-10 14:52:16.529	I	\N
1530	1	93	36	2017-04-10 14:52:16.544	I	\N
1531	1	829	5	2017-04-10 14:52:16.545	I	\N
1532	1	830	5	2017-04-10 14:52:16.611	I	\N
1511	1	831	5	2017-04-10 14:52:16.655	I	\N
1512	1	832	5	2017-04-10 14:52:16.673	I	\N
1533	1	833	5	2017-04-10 14:52:16.69	I	\N
1513	1	834	5	2017-04-10 14:52:16.706	I	\N
1514	1	835	5	2017-04-10 14:52:16.749	I	\N
1534	1	836	5	2017-04-10 14:52:16.767	I	\N
1535	1	837	5	2017-04-10 14:52:16.782	I	\N
1536	1	838	5	2017-04-10 14:52:16.809	I	\N
1537	1	839	5	2017-04-10 14:52:16.823	I	\N
1538	1	94	36	2017-04-10 14:52:16.864	I	\N
1539	1	840	5	2017-04-10 14:52:16.865	I	\N
1515	1	841	5	2017-04-10 14:52:16.884	I	\N
1540	1	842	5	2017-04-10 14:52:16.907	I	\N
1516	1	843	5	2017-04-10 14:52:16.926	I	\N
1541	1	844	5	2017-04-10 14:52:16.942	I	\N
1517	1	845	5	2017-04-10 14:52:16.983	I	\N
1518	1	846	5	2017-04-10 14:52:17.002	I	\N
1519	1	95	36	2017-04-10 14:52:17.026	I	\N
1520	1	847	5	2017-04-10 14:52:17.027	I	\N
1561	1	96	36	2017-04-10 14:52:17.055	I	\N
1562	1	849	5	2017-04-10 14:52:17.056	I	\N
1563	1	850	5	2017-04-10 14:52:17.098	I	\N
1564	1	851	5	2017-04-10 14:52:17.113	I	\N
1565	1	97	36	2017-04-10 14:52:17.134	I	\N
1566	1	852	5	2017-04-10 14:52:17.135	I	\N
1567	1	853	5	2017-04-10 14:52:17.148	I	\N
1568	1	854	5	2017-04-10 14:52:17.162	I	\N
1569	1	855	5	2017-04-10 14:52:17.205	I	\N
1570	1	856	5	2017-04-10 14:52:17.227	I	\N
1571	1	2617	32	2017-04-10 14:52:17.234	I	\N
1572	1	2618	32	2017-04-10 14:52:17.242	I	\N
1573	1	858	5	2017-04-10 14:52:17.285	I	\N
1574	1	1213	9	2017-04-10 14:52:17.287	I	\N
1575	1	2621	32	2017-04-10 14:52:17.288	I	\N
1576	1	1214	9	2017-04-10 14:52:17.289	I	\N
1577	1	2622	32	2017-04-10 14:52:17.29	I	\N
1578	1	859	5	2017-04-10 14:52:17.306	I	\N
1579	1	2623	32	2017-04-10 14:52:17.309	I	\N
1580	1	2624	32	2017-04-10 14:52:17.311	I	\N
1581	1	860	5	2017-04-10 14:52:17.354	I	\N
1582	1	2625	32	2017-04-10 14:52:17.362	I	\N
1583	1	2626	32	2017-04-10 14:52:17.364	I	\N
1584	1	865	5	2017-04-10 14:52:17.486	I	\N
1585	1	2635	32	2017-04-10 14:52:17.489	I	\N
1586	1	2636	32	2017-04-10 14:52:17.491	I	\N
1587	1	867	5	2017-04-10 14:52:17.529	I	\N
1588	1	868	5	2017-04-10 14:52:17.551	I	\N
1589	1	1215	9	2017-04-10 14:52:17.552	I	\N
1590	1	2639	32	2017-04-10 14:52:17.554	I	\N
1591	1	1216	9	2017-04-10 14:52:17.555	I	\N
1592	1	2640	32	2017-04-10 14:52:17.556	I	\N
1593	1	2641	32	2017-04-10 14:52:17.559	I	\N
1594	1	2642	32	2017-04-10 14:52:17.565	I	\N
1595	1	2643	32	2017-04-10 14:52:17.567	I	\N
1542	1	848	5	2017-04-10 14:52:17.042	I	\N
1543	1	857	5	2017-04-10 14:52:17.259	I	\N
1544	1	2619	32	2017-04-10 14:52:17.263	I	\N
1545	1	2620	32	2017-04-10 14:52:17.265	I	\N
1546	1	861	5	2017-04-10 14:52:17.379	I	\N
1547	1	2627	32	2017-04-10 14:52:17.382	I	\N
1548	1	2628	32	2017-04-10 14:52:17.385	I	\N
1549	1	862	5	2017-04-10 14:52:17.401	I	\N
1550	1	2629	32	2017-04-10 14:52:17.404	I	\N
1551	1	2630	32	2017-04-10 14:52:17.406	I	\N
1552	1	863	5	2017-04-10 14:52:17.421	I	\N
1553	1	2631	32	2017-04-10 14:52:17.425	I	\N
1554	1	2632	32	2017-04-10 14:52:17.429	I	\N
1555	1	864	5	2017-04-10 14:52:17.445	I	\N
1556	1	2633	32	2017-04-10 14:52:17.448	I	\N
1557	1	2634	32	2017-04-10 14:52:17.45	I	\N
1558	1	866	5	2017-04-10 14:52:17.505	I	\N
1559	1	2637	32	2017-04-10 14:52:17.508	I	\N
1560	1	2638	32	2017-04-10 14:52:17.51	I	\N
1601	1	85	13	2017-04-10 14:53:15.108	I	\N
1602	1	518	14	2017-04-10 14:53:15.134	I	\N
1603	1	519	14	2017-04-10 14:53:15.137	I	\N
1604	1	520	14	2017-04-10 14:53:15.14	I	\N
1605	1	521	14	2017-04-10 14:53:15.142	I	\N
1606	1	522	14	2017-04-10 14:53:15.144	I	\N
1607	1	523	14	2017-04-10 14:53:15.146	I	\N
1608	1	524	14	2017-04-10 14:53:15.148	I	\N
1609	1	525	14	2017-04-10 14:53:15.15	I	\N
1610	1	526	14	2017-04-10 14:53:15.152	I	\N
1611	1	527	14	2017-04-10 14:53:15.153	I	\N
1612	1	528	14	2017-04-10 14:53:15.155	I	\N
1613	1	529	14	2017-04-10 14:53:15.157	I	\N
1614	1	530	14	2017-04-10 14:53:15.158	I	\N
1615	1	531	14	2017-04-10 14:53:15.16	I	\N
1616	1	532	14	2017-04-10 14:53:15.162	I	\N
1617	1	533	14	2017-04-10 14:53:15.166	I	\N
1618	1	534	14	2017-04-10 14:53:15.169	I	\N
1619	1	535	14	2017-04-10 14:53:15.17	I	\N
1620	1	536	14	2017-04-10 14:53:15.172	I	\N
1621	1	86	13	2017-04-10 14:53:15.218	I	\N
1622	1	537	14	2017-04-10 14:53:15.22	I	\N
1623	1	538	14	2017-04-10 14:53:15.227	I	\N
1624	1	539	14	2017-04-10 14:53:15.228	I	\N
1625	1	540	14	2017-04-10 14:53:15.229	I	\N
1626	1	541	14	2017-04-10 14:53:15.23	I	\N
1627	1	542	14	2017-04-10 14:53:15.233	I	\N
1628	1	543	14	2017-04-10 14:53:15.242	I	\N
1641	1	87	13	2017-04-10 14:53:15.257	I	\N
1642	1	544	14	2017-04-10 14:53:15.262	I	\N
1643	1	545	14	2017-04-10 14:53:15.265	I	\N
1644	1	546	14	2017-04-10 14:53:15.267	I	\N
1645	1	547	14	2017-04-10 14:53:15.269	I	\N
1646	1	548	14	2017-04-10 14:53:15.272	I	\N
1647	1	88	13	2017-04-10 14:53:15.288	I	\N
1648	1	549	14	2017-04-10 14:53:15.291	I	\N
1649	1	550	14	2017-04-10 14:53:15.293	I	\N
1650	1	551	14	2017-04-10 14:53:15.294	I	\N
1651	1	552	14	2017-04-10 14:53:15.296	I	\N
1652	1	553	14	2017-04-10 14:53:15.297	I	\N
1629	1	89	13	2017-04-10 14:53:15.31	I	\N
1630	1	554	14	2017-04-10 14:53:15.312	I	\N
1631	1	555	14	2017-04-10 14:53:15.313	I	\N
1632	1	556	14	2017-04-10 14:53:15.315	I	\N
1633	1	557	14	2017-04-10 14:53:15.316	I	\N
1634	1	558	14	2017-04-10 14:53:15.317	I	\N
1653	1	90	13	2017-04-10 14:53:15.33	I	\N
1654	1	559	14	2017-04-10 14:53:15.332	I	\N
1655	1	560	14	2017-04-10 14:53:15.333	I	\N
1656	1	91	13	2017-04-10 14:53:15.38	I	\N
1657	1	561	14	2017-04-10 14:53:15.383	I	\N
1635	1	92	13	2017-04-10 14:53:15.397	I	\N
1636	1	562	14	2017-04-10 14:53:15.405	I	\N
1637	1	563	14	2017-04-10 14:53:15.406	I	\N
1638	1	564	14	2017-04-10 14:53:15.413	I	\N
1639	1	565	14	2017-04-10 14:53:15.414	I	\N
1658	1	93	13	2017-04-10 14:53:15.433	I	\N
1659	1	566	14	2017-04-10 14:53:15.436	I	\N
1640	1	94	13	2017-04-10 14:53:15.45	I	\N
1661	1	567	14	2017-04-10 14:53:15.452	I	\N
1681	1	82	34	2017-04-10 14:54:30.152	I	\N
1682	1	1220	211	2017-04-10 14:54:30.183	I	\N
1683	1	1221	211	2017-04-10 14:54:30.188	I	\N
1684	1	1222	211	2017-04-10 14:54:30.195	I	\N
1685	1	1223	211	2017-04-10 14:54:30.198	I	\N
1686	1	1224	211	2017-04-10 14:54:30.201	I	\N
1687	1	1225	211	2017-04-10 14:54:30.204	I	\N
1688	1	1226	211	2017-04-10 14:54:30.206	I	\N
1689	1	1227	211	2017-04-10 14:54:30.213	I	\N
1690	1	1228	211	2017-04-10 14:54:30.218	I	\N
1691	1	1229	211	2017-04-10 14:54:30.224	I	\N
1692	1	1230	211	2017-04-10 14:54:30.226	I	\N
1693	1	1231	211	2017-04-10 14:54:30.229	I	\N
1694	1	1232	211	2017-04-10 14:54:30.231	I	\N
1695	1	1233	211	2017-04-10 14:54:30.233	I	\N
1696	1	1234	211	2017-04-10 14:54:30.236	I	\N
1697	1	1235	211	2017-04-10 14:54:30.238	I	\N
1698	1	1236	211	2017-04-10 14:54:30.243	I	\N
1699	1	1237	211	2017-04-10 14:54:30.246	I	\N
1700	1	1238	211	2017-04-10 14:54:30.248	I	\N
1701	1	1239	211	2017-04-10 14:54:30.25	I	\N
1702	1	1240	211	2017-04-10 14:54:30.26	I	\N
1703	1	1241	211	2017-04-10 14:54:30.262	I	\N
1704	1	107	212	2017-04-10 14:54:30.269	I	\N
1705	1	83	34	2017-04-10 14:54:30.316	I	\N
1706	1	1242	211	2017-04-10 14:54:30.32	I	\N
1707	1	1243	211	2017-04-10 14:54:30.324	I	\N
1708	1	1244	211	2017-04-10 14:54:30.326	I	\N
1709	1	1245	211	2017-04-10 14:54:30.327	I	\N
1710	1	1246	211	2017-04-10 14:54:30.329	I	\N
1711	1	1247	211	2017-04-10 14:54:30.33	I	\N
1712	1	1248	211	2017-04-10 14:54:30.332	I	\N
1713	1	1249	211	2017-04-10 14:54:30.334	I	\N
1714	1	1250	211	2017-04-10 14:54:30.336	I	\N
1715	1	1251	211	2017-04-10 14:54:30.337	I	\N
1716	1	1252	211	2017-04-10 14:54:30.339	I	\N
1717	1	108	212	2017-04-10 14:54:30.342	I	\N
1660	1	84	34	2017-04-10 14:54:30.356	I	\N
1721	1	1253	211	2017-04-10 14:54:30.36	I	\N
1722	1	1254	211	2017-04-10 14:54:30.363	I	\N
1723	1	1255	211	2017-04-10 14:54:30.365	I	\N
1724	1	1256	211	2017-04-10 14:54:30.367	I	\N
1725	1	1257	211	2017-04-10 14:54:30.369	I	\N
1726	1	1258	211	2017-04-10 14:54:30.371	I	\N
1727	1	109	212	2017-04-10 14:54:30.374	I	\N
1728	1	86	34	2017-04-10 14:54:30.502	I	\N
1729	1	1299	211	2017-04-10 14:54:30.505	I	\N
1730	1	1300	211	2017-04-10 14:54:30.506	I	\N
1731	1	115	212	2017-04-10 14:54:30.508	I	\N
1732	1	89	34	2017-04-10 14:54:30.566	I	\N
1733	1	1303	211	2017-04-10 14:54:30.568	I	\N
1734	1	561	14	2017-04-10 14:54:45.931	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3338333c2f6c617374757064617465643e0a
1735	1	568	14	2017-04-10 14:54:45.958	I	\N
1736	1	567	14	2017-04-10 14:54:45.968	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642203f3f20333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3435323c2f6c617374757064617465643e0a
1737	1	569	14	2017-04-10 14:54:45.971	I	\N
1738	1	558	14	2017-04-10 14:54:45.98	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3331373c2f6c617374757064617465643e0a
1739	1	557	14	2017-04-10 14:54:45.981	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3331363c2f6c617374757064617465643e0a
1740	1	556	14	2017-04-10 14:54:45.983	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3331353c2f6c617374757064617465643e0a
1801	1	555	14	2017-04-10 14:54:45.984	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3331333c2f6c617374757064617465643e0a
1802	1	554	14	2017-04-10 14:54:45.986	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3331323c2f6c617374757064617465643e0a
1803	1	570	14	2017-04-10 14:54:45.993	I	\N
1804	1	571	14	2017-04-10 14:54:45.996	I	\N
1805	1	572	14	2017-04-10 14:54:46	I	\N
1806	1	573	14	2017-04-10 14:54:46.004	I	\N
1807	1	574	14	2017-04-10 14:54:46.009	I	\N
1808	1	553	14	2017-04-10 14:54:46.018	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3239373c2f6c617374757064617465643e0a
1809	1	552	14	2017-04-10 14:54:46.02	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3239363c2f6c617374757064617465643e0a
1810	1	551	14	2017-04-10 14:54:46.021	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3239343c2f6c617374757064617465643e0a
1811	1	550	14	2017-04-10 14:54:46.022	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3239333c2f6c617374757064617465643e0a
1812	1	549	14	2017-04-10 14:54:46.024	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3239313c2f6c617374757064617465643e0a
1813	1	575	14	2017-04-10 14:54:46.03	I	\N
1814	1	576	14	2017-04-10 14:54:46.034	I	\N
1815	1	577	14	2017-04-10 14:54:46.037	I	\N
1816	1	578	14	2017-04-10 14:54:46.04	I	\N
1817	1	579	14	2017-04-10 14:54:46.043	I	\N
1818	1	536	14	2017-04-10 14:54:46.053	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3137323c2f6c617374757064617465643e0a
1819	1	535	14	2017-04-10 14:54:46.054	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e31373c2f6c617374757064617465643e0a
1820	1	534	14	2017-04-10 14:54:46.056	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3136393c2f6c617374757064617465643e0a
1821	1	533	14	2017-04-10 14:54:46.057	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3136363c2f6c617374757064617465643e0a
1822	1	532	14	2017-04-10 14:54:46.059	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3136323c2f6c617374757064617465643e0a
1823	1	531	14	2017-04-10 14:54:46.06	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e31363c2f6c617374757064617465643e0a
1824	1	530	14	2017-04-10 14:54:46.061	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3135383c2f6c617374757064617465643e0a
1825	1	529	14	2017-04-10 14:54:46.063	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3135373c2f6c617374757064617465643e0a
1826	1	528	14	2017-04-10 14:54:46.064	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3135353c2f6c617374757064617465643e0a
1827	1	527	14	2017-04-10 14:54:46.066	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3135333c2f6c617374757064617465643e0a
1828	1	526	14	2017-04-10 14:54:46.067	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3135323c2f6c617374757064617465643e0a
1829	1	525	14	2017-04-10 14:54:46.069	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e31353c2f6c617374757064617465643e0a
1830	1	524	14	2017-04-10 14:54:46.07	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3134383c2f6c617374757064617465643e0a
1831	1	523	14	2017-04-10 14:54:46.072	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3134363c2f6c617374757064617465643e0a
1832	1	522	14	2017-04-10 14:54:46.073	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3134343c2f6c617374757064617465643e0a
1833	1	521	14	2017-04-10 14:54:46.075	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3134323c2f6c617374757064617465643e0a
1834	1	520	14	2017-04-10 14:54:46.076	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e31343c2f6c617374757064617465643e0a
1835	1	519	14	2017-04-10 14:54:46.078	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3133373c2f6c617374757064617465643e0a
1836	1	518	14	2017-04-10 14:54:46.079	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3133343c2f6c617374757064617465643e0a
1837	1	580	14	2017-04-10 14:54:46.097	I	\N
1838	1	581	14	2017-04-10 14:54:46.1	I	\N
1839	1	582	14	2017-04-10 14:54:46.103	I	\N
1840	1	583	14	2017-04-10 14:54:46.106	I	\N
1841	1	584	14	2017-04-10 14:54:46.109	I	\N
1842	1	585	14	2017-04-10 14:54:46.112	I	\N
1843	1	586	14	2017-04-10 14:54:46.115	I	\N
1844	1	587	14	2017-04-10 14:54:46.118	I	\N
1845	1	588	14	2017-04-10 14:54:46.121	I	\N
1846	1	589	14	2017-04-10 14:54:46.124	I	\N
1847	1	590	14	2017-04-10 14:54:46.127	I	\N
1848	1	591	14	2017-04-10 14:54:46.13	I	\N
1849	1	592	14	2017-04-10 14:54:46.133	I	\N
1850	1	593	14	2017-04-10 14:54:46.136	I	\N
1851	1	594	14	2017-04-10 14:54:46.139	I	\N
1852	1	595	14	2017-04-10 14:54:46.143	I	\N
1853	1	596	14	2017-04-10 14:54:46.146	I	\N
1854	1	597	14	2017-04-10 14:54:46.149	I	\N
1855	1	598	14	2017-04-10 14:54:46.152	I	\N
1718	1	85	34	2017-04-10 14:54:30.392	I	\N
1719	1	1259	211	2017-04-10 14:54:30.394	I	\N
1720	1	1260	211	2017-04-10 14:54:30.396	I	\N
1741	1	1261	211	2017-04-10 14:54:30.398	I	\N
1742	1	1262	211	2017-04-10 14:54:30.399	I	\N
1743	1	1263	211	2017-04-10 14:54:30.401	I	\N
1744	1	1264	211	2017-04-10 14:54:30.402	I	\N
1745	1	1265	211	2017-04-10 14:54:30.404	I	\N
1746	1	1266	211	2017-04-10 14:54:30.406	I	\N
1747	1	1267	211	2017-04-10 14:54:30.407	I	\N
1748	1	1268	211	2017-04-10 14:54:30.409	I	\N
1749	1	1269	211	2017-04-10 14:54:30.413	I	\N
1750	1	1270	211	2017-04-10 14:54:30.415	I	\N
1751	1	1271	211	2017-04-10 14:54:30.417	I	\N
1752	1	1272	211	2017-04-10 14:54:30.419	I	\N
1753	1	1273	211	2017-04-10 14:54:30.421	I	\N
1754	1	1274	211	2017-04-10 14:54:30.422	I	\N
1755	1	1275	211	2017-04-10 14:54:30.424	I	\N
1756	1	1276	211	2017-04-10 14:54:30.426	I	\N
1757	1	1277	211	2017-04-10 14:54:30.428	I	\N
1758	1	1278	211	2017-04-10 14:54:30.43	I	\N
1759	1	1279	211	2017-04-10 14:54:30.432	I	\N
1760	1	1280	211	2017-04-10 14:54:30.434	I	\N
1761	1	1281	211	2017-04-10 14:54:30.437	I	\N
1762	1	1282	211	2017-04-10 14:54:30.439	I	\N
1763	1	1283	211	2017-04-10 14:54:30.441	I	\N
1764	1	1284	211	2017-04-10 14:54:30.443	I	\N
1765	1	1285	211	2017-04-10 14:54:30.445	I	\N
1766	1	1286	211	2017-04-10 14:54:30.447	I	\N
1767	1	1287	211	2017-04-10 14:54:30.45	I	\N
1768	1	1288	211	2017-04-10 14:54:30.452	I	\N
1769	1	1289	211	2017-04-10 14:54:30.454	I	\N
1770	1	1290	211	2017-04-10 14:54:30.456	I	\N
1771	1	1291	211	2017-04-10 14:54:30.459	I	\N
1772	1	1292	211	2017-04-10 14:54:30.461	I	\N
1773	1	1293	211	2017-04-10 14:54:30.463	I	\N
1774	1	1294	211	2017-04-10 14:54:30.466	I	\N
1775	1	1295	211	2017-04-10 14:54:30.468	I	\N
1776	1	1296	211	2017-04-10 14:54:30.47	I	\N
1777	1	1297	211	2017-04-10 14:54:30.473	I	\N
1778	1	1298	211	2017-04-10 14:54:30.475	I	\N
1779	1	110	212	2017-04-10 14:54:30.478	I	\N
1780	1	111	212	2017-04-10 14:54:30.481	I	\N
1781	1	112	212	2017-04-10 14:54:30.484	I	\N
1782	1	113	212	2017-04-10 14:54:30.486	I	\N
1783	1	114	212	2017-04-10 14:54:30.489	I	\N
1784	1	87	34	2017-04-10 14:54:30.519	I	\N
1785	1	1301	211	2017-04-10 14:54:30.522	I	\N
1786	1	88	34	2017-04-10 14:54:30.551	I	\N
1787	1	1302	211	2017-04-10 14:54:30.554	I	\N
1788	1	90	34	2017-04-10 14:54:30.586	I	\N
1789	1	1304	211	2017-04-10 14:54:30.588	I	\N
1790	1	116	212	2017-04-10 14:54:30.59	I	\N
1856	1	566	14	2017-04-10 14:54:46.16	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3433363c2f6c617374757064617465643e0a
1857	1	599	14	2017-04-10 14:54:46.163	I	\N
1858	1	565	14	2017-04-10 14:54:46.171	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3431343c2f6c617374757064617465643e0a
1859	1	564	14	2017-04-10 14:54:46.173	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3431333c2f6c617374757064617465643e0a
1860	1	563	14	2017-04-10 14:54:46.174	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3430363c2f6c617374757064617465643e0a
1861	1	562	14	2017-04-10 14:54:46.176	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3430353c2f6c617374757064617465643e0a
1862	1	600	14	2017-04-10 14:54:46.181	I	\N
1863	1	601	14	2017-04-10 14:54:46.184	I	\N
1864	1	602	14	2017-04-10 14:54:46.187	I	\N
1865	1	603	14	2017-04-10 14:54:46.19	I	\N
1866	1	543	14	2017-04-10 14:54:46.198	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3234323c2f6c617374757064617465643e0a
1867	1	542	14	2017-04-10 14:54:46.199	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3233333c2f6c617374757064617465643e0a
1868	1	541	14	2017-04-10 14:54:46.2	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e32333c2f6c617374757064617465643e0a
1869	1	540	14	2017-04-10 14:54:46.202	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3232393c2f6c617374757064617465643e0a
1870	1	539	14	2017-04-10 14:54:46.203	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3232383c2f6c617374757064617465643e0a
1871	1	538	14	2017-04-10 14:54:46.204	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3232373c2f6c617374757064617465643e0a
1872	1	537	14	2017-04-10 14:54:46.206	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e32323c2f6c617374757064617465643e0a
1873	1	604	14	2017-04-10 14:54:46.213	I	\N
1874	1	605	14	2017-04-10 14:54:46.216	I	\N
1875	1	606	14	2017-04-10 14:54:46.219	I	\N
1876	1	607	14	2017-04-10 14:54:46.223	I	\N
1877	1	608	14	2017-04-10 14:54:46.226	I	\N
1878	1	609	14	2017-04-10 14:54:46.229	I	\N
1879	1	610	14	2017-04-10 14:54:46.232	I	\N
1880	1	548	14	2017-04-10 14:54:46.24	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3237323c2f6c617374757064617465643e0a
1881	1	547	14	2017-04-10 14:54:46.241	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3236393c2f6c617374757064617465643e0a
1882	1	546	14	2017-04-10 14:54:46.243	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3236373c2f6c617374757064617465643e0a
1883	1	545	14	2017-04-10 14:54:46.244	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3236353c2f6c617374757064617465643e0a
1884	1	544	14	2017-04-10 14:54:46.246	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3236323c2f6c617374757064617465643e0a
1885	1	611	14	2017-04-10 14:54:46.252	I	\N
1886	1	612	14	2017-04-10 14:54:46.255	I	\N
1887	1	613	14	2017-04-10 14:54:46.258	I	\N
1888	1	614	14	2017-04-10 14:54:46.261	I	\N
1889	1	615	14	2017-04-10 14:54:46.264	I	\N
1890	1	560	14	2017-04-10 14:54:46.273	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3333333c2f6c617374757064617465643e0a
1891	1	559	14	2017-04-10 14:54:46.274	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35333a31352e3333323c2f6c617374757064617465643e0a
1892	1	616	14	2017-04-10 14:54:46.278	I	\N
1893	1	617	14	2017-04-10 14:54:46.281	I	\N
1901	1	176	29	2017-04-10 14:55:30.196	I	\N
1902	1	177	29	2017-04-10 14:55:30.366	I	\N
1921	1	196	29	2017-04-10 14:55:30.415	I	\N
1922	1	197	29	2017-04-10 14:55:30.464	I	\N
1923	1	198	29	2017-04-10 14:55:30.537	I	\N
1924	1	199	29	2017-04-10 14:55:30.594	I	\N
1941	1	1220	211	2017-04-10 14:59:15.172	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
1942	1	1221	211	2017-04-10 14:59:15.173	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
1943	1	1222	211	2017-04-10 14:59:15.174	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
1944	1	1223	211	2017-04-10 14:59:15.176	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
1945	1	1224	211	2017-04-10 14:59:15.177	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
1946	1	1225	211	2017-04-10 14:59:15.178	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
1947	1	1226	211	2017-04-10 14:59:15.179	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
1948	1	1227	211	2017-04-10 14:59:15.179	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
1949	1	1228	211	2017-04-10 14:59:15.18	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
1950	1	1229	211	2017-04-10 14:59:15.181	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
1951	1	1230	211	2017-04-10 14:59:15.181	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
1952	1	1231	211	2017-04-10 14:59:15.182	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
1953	1	1232	211	2017-04-10 14:59:15.183	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
1954	1	1233	211	2017-04-10 14:59:15.184	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
1955	1	1234	211	2017-04-10 14:59:15.185	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
1956	1	1235	211	2017-04-10 14:59:15.186	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
1957	1	1236	211	2017-04-10 14:59:15.187	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
1958	1	1237	211	2017-04-10 14:59:15.187	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
1959	1	1238	211	2017-04-10 14:59:15.188	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
1960	1	1239	211	2017-04-10 14:59:15.189	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
1961	1	1240	211	2017-04-10 14:59:15.189	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
1962	1	1241	211	2017-04-10 14:59:15.19	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
1963	1	1305	211	2017-04-10 14:59:15.194	I	\N
1964	1	1306	211	2017-04-10 14:59:15.197	I	\N
1965	1	1307	211	2017-04-10 14:59:15.199	I	\N
1966	1	1308	211	2017-04-10 14:59:15.202	I	\N
1967	1	1309	211	2017-04-10 14:59:15.204	I	\N
1968	1	1310	211	2017-04-10 14:59:15.207	I	\N
1969	1	1311	211	2017-04-10 14:59:15.209	I	\N
1970	1	1312	211	2017-04-10 14:59:15.211	I	\N
1971	1	1313	211	2017-04-10 14:59:15.213	I	\N
1972	1	1314	211	2017-04-10 14:59:15.215	I	\N
1973	1	1315	211	2017-04-10 14:59:15.217	I	\N
1974	1	1316	211	2017-04-10 14:59:15.219	I	\N
1975	1	1317	211	2017-04-10 14:59:15.221	I	\N
1976	1	1318	211	2017-04-10 14:59:15.223	I	\N
1977	1	1319	211	2017-04-10 14:59:15.225	I	\N
1978	1	1320	211	2017-04-10 14:59:15.227	I	\N
1979	1	1321	211	2017-04-10 14:59:15.229	I	\N
1980	1	1322	211	2017-04-10 14:59:15.231	I	\N
1981	1	1323	211	2017-04-10 14:59:15.232	I	\N
1982	1	1324	211	2017-04-10 14:59:15.234	I	\N
1983	1	1325	211	2017-04-10 14:59:15.236	I	\N
1984	1	1326	211	2017-04-10 14:59:15.244	I	\N
1985	1	107	212	2017-04-10 14:59:15.246	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
1986	1	117	212	2017-04-10 14:59:15.249	I	\N
1987	1	1242	211	2017-04-10 14:59:15.253	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3738353c2f7465737449643e0a
1988	1	1243	211	2017-04-10 14:59:15.254	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3739343c2f7465737449643e0a
1989	1	1244	211	2017-04-10 14:59:15.255	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831303c2f7465737449643e0a
1990	1	1245	211	2017-04-10 14:59:15.256	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831323c2f7465737449643e0a
1991	1	1246	211	2017-04-10 14:59:15.257	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831333c2f7465737449643e0a
1992	1	1247	211	2017-04-10 14:59:15.258	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831343c2f7465737449643e0a
1993	1	1248	211	2017-04-10 14:59:15.259	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831353c2f7465737449643e0a
1994	1	1249	211	2017-04-10 14:59:15.259	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831363c2f7465737449643e0a
1995	1	1250	211	2017-04-10 14:59:15.26	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831373c2f7465737449643e0a
1996	1	1251	211	2017-04-10 14:59:15.262	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831383c2f7465737449643e0a
1997	1	1252	211	2017-04-10 14:59:15.263	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831393c2f7465737449643e0a
1998	1	1327	211	2017-04-10 14:59:15.266	I	\N
1999	1	1328	211	2017-04-10 14:59:15.27	I	\N
2000	1	1329	211	2017-04-10 14:59:15.272	I	\N
2001	1	1330	211	2017-04-10 14:59:15.274	I	\N
2002	1	1331	211	2017-04-10 14:59:15.277	I	\N
2003	1	1332	211	2017-04-10 14:59:15.28	I	\N
2004	1	1333	211	2017-04-10 14:59:15.283	I	\N
2005	1	1334	211	2017-04-10 14:59:15.285	I	\N
2006	1	1335	211	2017-04-10 14:59:15.288	I	\N
2007	1	1336	211	2017-04-10 14:59:15.29	I	\N
2008	1	1337	211	2017-04-10 14:59:15.293	I	\N
2009	1	108	212	2017-04-10 14:59:15.294	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38363c2f70616e656c49643e0a
2010	1	118	212	2017-04-10 14:59:15.297	I	\N
2011	1	1253	211	2017-04-10 14:59:15.301	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3738363c2f7465737449643e0a
2012	1	1254	211	2017-04-10 14:59:15.302	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3739353c2f7465737449643e0a
2013	1	1255	211	2017-04-10 14:59:15.303	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832303c2f7465737449643e0a
2014	1	1256	211	2017-04-10 14:59:15.304	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832313c2f7465737449643e0a
2015	1	1257	211	2017-04-10 14:59:15.305	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832323c2f7465737449643e0a
2016	1	1258	211	2017-04-10 14:59:15.306	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832333c2f7465737449643e0a
2017	1	1338	211	2017-04-10 14:59:15.31	I	\N
2018	1	1339	211	2017-04-10 14:59:15.312	I	\N
2019	1	1340	211	2017-04-10 14:59:15.315	I	\N
2020	1	1341	211	2017-04-10 14:59:15.317	I	\N
2021	1	1342	211	2017-04-10 14:59:15.322	I	\N
2022	1	1343	211	2017-04-10 14:59:15.325	I	\N
2023	1	109	212	2017-04-10 14:59:15.326	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38373c2f70616e656c49643e0a
2024	1	119	212	2017-04-10 14:59:15.33	I	\N
2025	1	1259	211	2017-04-10 14:59:15.334	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832343c2f7465737449643e0a
2026	1	1260	211	2017-04-10 14:59:15.335	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832353c2f7465737449643e0a
2027	1	1261	211	2017-04-10 14:59:15.336	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832363c2f7465737449643e0a
2028	1	1262	211	2017-04-10 14:59:15.338	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832373c2f7465737449643e0a
2029	1	1263	211	2017-04-10 14:59:15.339	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832383c2f7465737449643e0a
2030	1	1264	211	2017-04-10 14:59:15.34	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832393c2f7465737449643e0a
2031	1	1265	211	2017-04-10 14:59:15.341	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833303c2f7465737449643e0a
2032	1	1266	211	2017-04-10 14:59:15.342	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833313c2f7465737449643e0a
2033	1	1267	211	2017-04-10 14:59:15.343	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833323c2f7465737449643e0a
2034	1	1268	211	2017-04-10 14:59:15.344	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833333c2f7465737449643e0a
2035	1	1269	211	2017-04-10 14:59:15.345	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833343c2f7465737449643e0a
2036	1	1270	211	2017-04-10 14:59:15.346	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833353c2f7465737449643e0a
2037	1	1271	211	2017-04-10 14:59:15.347	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833363c2f7465737449643e0a
2038	1	1272	211	2017-04-10 14:59:15.349	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833373c2f7465737449643e0a
2039	1	1273	211	2017-04-10 14:59:15.35	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833383c2f7465737449643e0a
2040	1	1274	211	2017-04-10 14:59:15.351	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833393c2f7465737449643e0a
2041	1	1275	211	2017-04-10 14:59:15.352	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834303c2f7465737449643e0a
2042	1	1276	211	2017-04-10 14:59:15.353	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834313c2f7465737449643e0a
2043	1	1277	211	2017-04-10 14:59:15.354	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834323c2f7465737449643e0a
2044	1	1278	211	2017-04-10 14:59:15.355	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834333c2f7465737449643e0a
2045	1	1279	211	2017-04-10 14:59:15.357	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834343c2f7465737449643e0a
2046	1	1280	211	2017-04-10 14:59:15.358	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3831313c2f7465737449643e0a
2047	1	1281	211	2017-04-10 14:59:15.359	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834353c2f7465737449643e0a
2048	1	1282	211	2017-04-10 14:59:15.367	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834363c2f7465737449643e0a
2049	1	1283	211	2017-04-10 14:59:15.368	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834373c2f7465737449643e0a
2050	1	1284	211	2017-04-10 14:59:15.369	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834383c2f7465737449643e0a
2051	1	1285	211	2017-04-10 14:59:15.37	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834393c2f7465737449643e0a
2052	1	1286	211	2017-04-10 14:59:15.371	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835303c2f7465737449643e0a
2053	1	1287	211	2017-04-10 14:59:15.372	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835313c2f7465737449643e0a
2054	1	1288	211	2017-04-10 14:59:15.373	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835323c2f7465737449643e0a
2055	1	1289	211	2017-04-10 14:59:15.374	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835333c2f7465737449643e0a
2056	1	1290	211	2017-04-10 14:59:15.376	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835343c2f7465737449643e0a
2057	1	1291	211	2017-04-10 14:59:15.377	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835353c2f7465737449643e0a
2058	1	1292	211	2017-04-10 14:59:15.378	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835363c2f7465737449643e0a
2059	1	1293	211	2017-04-10 14:59:15.379	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835373c2f7465737449643e0a
2060	1	1294	211	2017-04-10 14:59:15.38	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835383c2f7465737449643e0a
2061	1	1295	211	2017-04-10 14:59:15.381	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835393c2f7465737449643e0a
2062	1	1296	211	2017-04-10 14:59:15.382	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836303c2f7465737449643e0a
2063	1	1297	211	2017-04-10 14:59:15.383	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836313c2f7465737449643e0a
2064	1	1298	211	2017-04-10 14:59:15.385	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836323c2f7465737449643e0a
2065	1	1344	211	2017-04-10 14:59:15.388	I	\N
2066	1	1345	211	2017-04-10 14:59:15.391	I	\N
2067	1	1346	211	2017-04-10 14:59:15.406	I	\N
2068	1	1347	211	2017-04-10 14:59:15.409	I	\N
2069	1	1348	211	2017-04-10 14:59:15.412	I	\N
2070	1	1349	211	2017-04-10 14:59:15.415	I	\N
2071	1	1350	211	2017-04-10 14:59:15.418	I	\N
2072	1	1351	211	2017-04-10 14:59:15.421	I	\N
2073	1	1352	211	2017-04-10 14:59:15.425	I	\N
2074	1	1353	211	2017-04-10 14:59:15.428	I	\N
2075	1	1354	211	2017-04-10 14:59:15.431	I	\N
2076	1	1355	211	2017-04-10 14:59:15.434	I	\N
2077	1	1356	211	2017-04-10 14:59:15.437	I	\N
2078	1	1357	211	2017-04-10 14:59:15.44	I	\N
2079	1	1358	211	2017-04-10 14:59:15.443	I	\N
2080	1	1359	211	2017-04-10 14:59:15.447	I	\N
2081	1	1360	211	2017-04-10 14:59:15.45	I	\N
2082	1	1361	211	2017-04-10 14:59:15.453	I	\N
2083	1	1362	211	2017-04-10 14:59:15.457	I	\N
2084	1	1363	211	2017-04-10 14:59:15.46	I	\N
2085	1	1364	211	2017-04-10 14:59:15.463	I	\N
2086	1	1365	211	2017-04-10 14:59:15.467	I	\N
2087	1	1366	211	2017-04-10 14:59:15.47	I	\N
2088	1	1367	211	2017-04-10 14:59:15.473	I	\N
2089	1	1368	211	2017-04-10 14:59:15.477	I	\N
2090	1	1369	211	2017-04-10 14:59:15.48	I	\N
2091	1	1370	211	2017-04-10 14:59:15.484	I	\N
2092	1	1371	211	2017-04-10 14:59:15.487	I	\N
2093	1	1372	211	2017-04-10 14:59:15.491	I	\N
2094	1	1373	211	2017-04-10 14:59:15.494	I	\N
2095	1	1374	211	2017-04-10 14:59:15.498	I	\N
2096	1	1375	211	2017-04-10 14:59:15.501	I	\N
2097	1	1376	211	2017-04-10 14:59:15.505	I	\N
2098	1	1377	211	2017-04-10 14:59:15.509	I	\N
2099	1	1378	211	2017-04-10 14:59:15.513	I	\N
2100	1	1379	211	2017-04-10 14:59:15.517	I	\N
2101	1	1380	211	2017-04-10 14:59:15.521	I	\N
2102	1	1381	211	2017-04-10 14:59:15.524	I	\N
2103	1	1382	211	2017-04-10 14:59:15.528	I	\N
2104	1	1383	211	2017-04-10 14:59:15.532	I	\N
2105	1	110	212	2017-04-10 14:59:15.534	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38383c2f70616e656c49643e0a
2106	1	111	212	2017-04-10 14:59:15.536	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38393c2f70616e656c49643e0a
2107	1	112	212	2017-04-10 14:59:15.537	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39303c2f70616e656c49643e0a
2108	1	113	212	2017-04-10 14:59:15.539	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39313c2f70616e656c49643e0a
2109	1	114	212	2017-04-10 14:59:15.541	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39323c2f70616e656c49643e0a
2110	1	120	212	2017-04-10 14:59:15.544	I	\N
2111	1	121	212	2017-04-10 14:59:15.549	I	\N
2112	1	122	212	2017-04-10 14:59:15.552	I	\N
2113	1	123	212	2017-04-10 14:59:15.556	I	\N
2114	1	124	212	2017-04-10 14:59:15.56	I	\N
2115	1	1299	211	2017-04-10 14:59:15.566	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c7465737449643e3836333c2f7465737449643e0a
2116	1	1300	211	2017-04-10 14:59:15.568	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c7465737449643e3836383c2f7465737449643e0a
2117	1	1384	211	2017-04-10 14:59:15.572	I	\N
2118	1	1385	211	2017-04-10 14:59:15.576	I	\N
2119	1	115	212	2017-04-10 14:59:15.578	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39343c2f70616e656c49643e0a
2120	1	125	212	2017-04-10 14:59:15.582	I	\N
2121	1	1301	211	2017-04-10 14:59:15.589	D	\\x3c747970654f6653616d706c6549643e38373c2f747970654f6653616d706c6549643e0a3c7465737449643e3836343c2f7465737449643e0a
2122	1	1386	211	2017-04-10 14:59:15.593	I	\N
2123	1	1302	211	2017-04-10 14:59:15.6	D	\\x3c747970654f6653616d706c6549643e38383c2f747970654f6653616d706c6549643e0a3c7465737449643e3836353c2f7465737449643e0a
2124	1	1387	211	2017-04-10 14:59:15.613	I	\N
2125	1	1303	211	2017-04-10 14:59:15.62	D	\\x3c747970654f6653616d706c6549643e38393c2f747970654f6653616d706c6549643e0a3c7465737449643e3836363c2f7465737449643e0a
2126	1	1388	211	2017-04-10 14:59:15.624	I	\N
2127	1	1304	211	2017-04-10 14:59:15.631	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c7465737449643e3836373c2f7465737449643e0a
2128	1	1389	211	2017-04-10 14:59:15.636	I	\N
2129	1	116	212	2017-04-10 14:59:15.638	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39333c2f70616e656c49643e0a
2130	1	126	212	2017-04-10 14:59:15.642	I	\N
2141	1	625	154	2017-04-10 15:21:54.932	I	\N
2161	1	625	154	2017-04-10 15:22:13.412	U	\\x3c6d696e4167653e31352e303c2f6d696e4167653e0a
2142	1	625	154	2017-04-10 15:22:49.829	U	\\x3c6d696e4167653e31342e393632373c2f6d696e4167653e0a
2181	1	626	154	2017-04-10 15:24:18.654	I	\N
2201	1	627	154	2017-04-10 16:34:14.598	I	\N
2202	1	628	154	2017-04-10 16:35:00.719	I	\N
2221	1	629	154	2017-04-10 16:35:47.146	I	\N
2222	1	630	154	2017-04-10 16:36:09.047	I	\N
2241	1	631	154	2017-04-10 16:36:49.948	I	\N
2261	1	632	154	2017-04-10 16:37:27.535	I	\N
2281	1	633	154	2017-04-10 16:38:23.665	I	\N
2301	1	634	154	2017-04-10 16:52:56.18	I	\N
2321	1	635	154	2017-04-10 16:53:37.339	I	\N
2322	1	636	154	2017-04-10 16:53:54.506	I	\N
2341	1	637	154	2017-04-10 16:57:28.671	I	\N
2342	1	638	154	2017-04-10 16:57:51.091	I	\N
2343	1	639	154	2017-04-10 16:58:13.679	I	\N
2361	1	640	154	2017-04-10 16:58:29.707	I	\N
2381	1	641	154	2017-04-10 16:58:52.533	I	\N
2344	1	642	154	2017-04-10 16:59:15.552	I	\N
2302	1	643	154	2017-04-10 17:02:56.019	I	\N
2401	1	644	154	2017-04-10 17:03:10.348	I	\N
2303	1	645	154	2017-04-10 17:03:32.005	I	\N
2304	1	646	154	2017-04-10 17:03:48.915	I	\N
2421	1	646	154	2017-04-10 17:04:16.834	U	\\x3c6d696e4167653e302e303c2f6d696e4167653e0a
2441	1	647	154	2017-04-10 17:04:51.644	I	\N
2442	1	648	154	2017-04-10 17:05:10.116	I	\N
2461	1	649	154	2017-04-10 17:05:47.703	I	\N
2481	1	650	154	2017-04-10 17:06:19.963	I	\N
2501	1	651	154	2017-04-10 17:10:32.943	I	\N
2502	1	652	154	2017-04-10 17:11:03.063	I	\N
2521	1	653	154	2017-04-10 17:11:21.995	I	\N
2522	1	654	154	2017-04-10 17:11:36.494	I	\N
2482	1	655	154	2017-04-10 17:12:18.487	I	\N
2483	1	656	154	2017-04-10 17:13:04.093	I	\N
2541	1	657	154	2017-04-10 17:13:19.825	I	\N
2542	1	658	154	2017-04-10 17:13:34.957	I	\N
2561	1	659	154	2017-04-10 17:13:52.775	I	\N
2581	1	660	154	2017-04-10 17:14:10.264	I	\N
2484	1	661	154	2017-04-10 17:16:07.813	I	\N
2601	1	662	154	2017-04-10 17:16:24.469	I	\N
2621	1	663	154	2017-04-10 17:19:08.192	I	\N
2641	1	664	154	2017-04-10 17:19:27.802	I	\N
2661	1	665	154	2017-04-10 17:20:01.635	I	\N
2642	1	666	154	2017-04-10 17:20:18.807	I	\N
2662	1	667	154	2017-04-10 17:20:43.214	I	\N
2681	1	668	154	2017-04-10 17:21:24.298	I	\N
2643	1	669	154	2017-04-10 17:21:53.992	I	\N
2644	1	670	154	2017-04-10 17:22:24.896	I	\N
2701	1	671	154	2017-04-10 17:22:45.375	I	\N
2721	1	672	154	2017-04-10 17:24:16.734	I	\N
2741	1	673	154	2017-04-10 17:24:31.933	I	\N
2742	1	674	154	2017-04-10 17:24:52.397	I	\N
2722	1	675	154	2017-04-10 17:25:20.049	I	\N
2723	1	676	154	2017-04-10 17:25:45.368	I	\N
2761	1	677	154	2017-04-10 17:26:05.635	I	\N
2781	1	678	154	2017-04-10 17:26:19.716	I	\N
2782	1	679	154	2017-04-10 17:26:43.233	I	\N
2801	1	680	154	2017-04-10 17:27:03.24	I	\N
2783	1	681	154	2017-04-10 17:27:19.165	I	\N
2762	1	682	154	2017-04-10 17:27:41.922	I	\N
2802	1	683	154	2017-04-10 17:27:56.389	I	\N
2803	1	684	154	2017-04-10 17:28:11.147	I	\N
2821	1	685	154	2017-04-10 17:28:38.91	I	\N
2822	1	686	154	2017-04-10 17:28:50.305	I	\N
2841	1	687	154	2017-04-10 17:29:05.138	I	\N
2861	1	688	154	2017-04-10 17:29:19.848	I	\N
2881	1	98	36	2017-04-10 17:34:45.138	I	\N
2901	1	99	36	2017-04-10 17:36:15.045	I	\N
2921	1	11	16	2017-04-10 17:55:00.215	I	\N
2922	1	11	198	2017-04-10 17:55:00.222	I	\N
2923	1	11	198	2017-04-10 17:55:00.224	I	\N
2924	1	11	198	2017-04-10 17:55:00.235	I	\N
2925	1	11	198	2017-04-10 17:55:00.236	I	\N
2926	1	11	198	2017-04-10 17:55:00.242	I	\N
2927	1	11	198	2017-04-10 17:55:00.254	I	\N
2928	1	9	15	2017-04-10 17:55:00.255	I	\N
2929	1	13	112	2017-04-10 17:55:00.275	I	\N
2941	1	27	1	2017-04-10 17:55:30.237	I	\N
2942	1	44	23	2017-04-10 17:55:30.244	I	\N
2943	1	469	4	2017-04-10 17:55:30.256	I	\N
2944	1	27	45	2017-04-10 17:55:30.261	I	\N
2945	1	12	16	2017-04-10 17:55:38.985	I	\N
2946	1	6	19	2017-04-10 17:55:38.991	I	\N
2947	1	10	15	2017-04-10 17:55:38.996	I	\N
2930	1	70	21	2017-04-10 17:55:56.332	I	\N
2931	1	64	155	2017-04-10 17:55:56.336	I	\N
2932	1	27	1	2017-04-10 17:55:56.374	U	\\x3c73746174757349643e313c2f73746174757349643e0a
2961	1	469	4	2017-04-10 17:56:41.267	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
2962	1	27	1	2017-04-10 17:56:41.288	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
2981	1	13	16	2017-04-10 17:58:15.113	I	\N
2982	1	13	198	2017-04-10 17:58:15.116	I	\N
2983	1	13	198	2017-04-10 17:58:15.117	I	\N
2984	1	13	198	2017-04-10 17:58:15.118	I	\N
2985	1	13	198	2017-04-10 17:58:15.119	I	\N
2986	1	13	198	2017-04-10 17:58:15.126	I	\N
2987	1	13	198	2017-04-10 17:58:15.127	I	\N
2988	1	11	15	2017-04-10 17:58:15.128	I	\N
2989	1	14	112	2017-04-10 17:58:15.13	I	\N
3001	1	28	1	2017-04-10 17:58:30.179	I	\N
3002	1	45	23	2017-04-10 17:58:30.193	I	\N
3003	1	470	4	2017-04-10 17:58:30.196	I	\N
3004	1	28	45	2017-04-10 17:58:30.202	I	\N
3021	1	71	21	2017-04-10 17:59:04.548	I	\N
3022	1	65	155	2017-04-10 17:59:04.553	I	\N
3023	1	28	1	2017-04-10 17:59:04.565	U	\\x3c73746174757349643e313c2f73746174757349643e0a
2990	1	470	4	2017-04-10 17:59:11.529	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
2991	1	28	1	2017-04-10 17:59:11.538	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
3024	1	29	1	2017-04-10 18:02:30.261	I	\N
3025	1	46	23	2017-04-10 18:02:30.264	I	\N
3026	1	471	4	2017-04-10 18:02:30.267	I	\N
3027	1	29	45	2017-04-10 18:02:30.271	I	\N
3041	1	72	21	2017-04-10 18:02:50.129	I	\N
3042	1	66	155	2017-04-10 18:02:50.132	I	\N
3043	1	29	1	2017-04-10 18:02:50.144	U	\\x3c73746174757349643e313c2f73746174757349643e0a
3044	1	471	4	2017-04-10 18:03:12.683	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
3045	1	29	1	2017-04-10 18:03:12.689	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
3061	1	30	1	2017-04-10 18:04:00.305	I	\N
3062	1	47	23	2017-04-10 18:04:00.313	I	\N
3063	1	472	4	2017-04-10 18:04:00.318	I	\N
3064	1	30	45	2017-04-10 18:04:00.321	I	\N
3081	1	73	21	2017-04-10 18:04:22.238	I	\N
3082	1	67	155	2017-04-10 18:04:22.242	I	\N
3083	1	30	1	2017-04-10 18:04:22.249	U	\\x3c73746174757349643e313c2f73746174757349643e0a
3101	1	73	21	2017-04-10 18:04:32.723	U	\\x3c74657374526573756c743e75732e6d6e2e73746174652e6865616c74682e6c696d732e74657374726573756c742e76616c7565686f6c6465722e54657374526573756c744034626231353432323c2f74657374526573756c743e0a3c76616c75653e313230393c2f76616c75653e0a
3102	1	141	39	2017-04-10 18:04:32.726	I	\N
3065	1	472	4	2017-04-10 18:04:38.934	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
3066	1	30	1	2017-04-10 18:04:38.941	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
3067	1	141	39	2017-04-10 18:04:38.944	U	\\x3c73797374656d5573657249643e3c2f73797374656d5573657249643e0a
3121	1	31	1	2017-04-10 18:06:00.249	I	\N
3122	1	48	23	2017-04-10 18:06:00.257	I	\N
3123	1	473	4	2017-04-10 18:06:00.261	I	\N
3124	1	31	45	2017-04-10 18:06:00.263	I	\N
3141	1	74	21	2017-04-10 18:06:30.485	I	\N
3142	1	68	155	2017-04-10 18:06:30.488	I	\N
3143	1	31	1	2017-04-10 18:06:30.494	U	\\x3c73746174757349643e313c2f73746174757349643e0a
3144	1	473	4	2017-04-10 18:06:39.613	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
3145	1	31	1	2017-04-10 18:06:39.619	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
3161	1	13	198	2017-04-10 18:16:35.833	I	\N
3162	1	13	198	2017-04-10 18:16:35.837	I	\N
3163	1	13	198	2017-04-10 18:16:35.841	I	\N
3164	1	13	198	2017-04-10 18:16:35.843	I	\N
3165	1	13	198	2017-04-10 18:16:35.844	I	\N
3166	1	13	198	2017-04-10 18:16:35.846	I	\N
3167	1	32	1	2017-04-10 18:16:35.847	I	\N
3168	1	49	23	2017-04-10 18:16:35.849	I	\N
3169	1	474	4	2017-04-10 18:16:35.855	I	\N
3170	1	32	45	2017-04-10 18:16:35.858	I	\N
3181	1	75	21	2017-04-10 18:16:51.648	I	\N
3182	1	69	155	2017-04-10 18:16:51.651	I	\N
3183	1	32	1	2017-04-10 18:16:51.659	U	\\x3c73746174757349643e313c2f73746174757349643e0a
3184	1	474	4	2017-04-10 18:16:57.195	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
3185	1	32	1	2017-04-10 18:16:57.201	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c636f6c6c656374696f6e446174653e3c2f636f6c6c656374696f6e446174653e0a3c636f6c6c656374696f6e44617465466f72446973706c61793e3c2f636f6c6c656374696f6e44617465466f72446973706c61793e0a3c636f6c6c656374696f6e54696d65466f72446973706c61793e3c2f636f6c6c656374696f6e54696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
3201	1	14	16	2017-04-11 12:16:00.199	I	\N
3202	1	14	198	2017-04-11 12:16:00.202	I	\N
3203	1	14	198	2017-04-11 12:16:00.204	I	\N
3204	1	14	198	2017-04-11 12:16:00.205	I	\N
3205	1	14	198	2017-04-11 12:16:00.206	I	\N
3206	1	14	198	2017-04-11 12:16:00.206	I	\N
3207	1	14	198	2017-04-11 12:16:00.207	I	\N
3208	1	12	15	2017-04-11 12:16:00.208	I	\N
3209	1	15	112	2017-04-11 12:16:00.211	I	\N
3221	1	869	5	2017-04-11 13:18:45.123	I	\N
3241	1	580	14	2017-04-11 13:19:30.179	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3039373c2f6c617374757064617465643e0a
3242	1	581	14	2017-04-11 13:19:30.181	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e313c2f6c617374757064617465643e0a
3243	1	582	14	2017-04-11 13:19:30.182	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3130333c2f6c617374757064617465643e0a
3244	1	583	14	2017-04-11 13:19:30.189	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3130363c2f6c617374757064617465643e0a
3245	1	584	14	2017-04-11 13:19:30.19	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3130393c2f6c617374757064617465643e0a
3246	1	585	14	2017-04-11 13:19:30.194	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3131323c2f6c617374757064617465643e0a
3247	1	586	14	2017-04-11 13:19:30.194	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3131353c2f6c617374757064617465643e0a
3248	1	587	14	2017-04-11 13:19:30.195	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3131383c2f6c617374757064617465643e0a
3249	1	588	14	2017-04-11 13:19:30.196	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3132313c2f6c617374757064617465643e0a
3250	1	589	14	2017-04-11 13:19:30.2	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3132343c2f6c617374757064617465643e0a
3251	1	590	14	2017-04-11 13:19:30.201	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3132373c2f6c617374757064617465643e0a
3252	1	591	14	2017-04-11 13:19:30.202	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e31333c2f6c617374757064617465643e0a
3253	1	592	14	2017-04-11 13:19:30.202	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3133333c2f6c617374757064617465643e0a
3254	1	593	14	2017-04-11 13:19:30.203	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3133363c2f6c617374757064617465643e0a
3255	1	594	14	2017-04-11 13:19:30.205	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3133393c2f6c617374757064617465643e0a
3256	1	595	14	2017-04-11 13:19:30.206	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3134333c2f6c617374757064617465643e0a
3257	1	596	14	2017-04-11 13:19:30.207	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3134363c2f6c617374757064617465643e0a
3258	1	597	14	2017-04-11 13:19:30.208	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3134393c2f6c617374757064617465643e0a
3417	1	685	14	2017-04-11 13:20:31.832	I	\N
3259	1	598	14	2017-04-11 13:19:30.209	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3135323c2f6c617374757064617465643e0a
3260	1	618	14	2017-04-11 13:19:30.22	I	\N
3261	1	619	14	2017-04-11 13:19:30.223	I	\N
3262	1	620	14	2017-04-11 13:19:30.225	I	\N
3263	1	621	14	2017-04-11 13:19:30.227	I	\N
3264	1	622	14	2017-04-11 13:19:30.233	I	\N
3265	1	623	14	2017-04-11 13:19:30.235	I	\N
3266	1	624	14	2017-04-11 13:19:30.238	I	\N
3267	1	625	14	2017-04-11 13:19:30.24	I	\N
3268	1	626	14	2017-04-11 13:19:30.242	I	\N
3269	1	627	14	2017-04-11 13:19:30.244	I	\N
3270	1	628	14	2017-04-11 13:19:30.246	I	\N
3271	1	629	14	2017-04-11 13:19:30.248	I	\N
3272	1	630	14	2017-04-11 13:19:30.254	I	\N
3273	1	631	14	2017-04-11 13:19:30.255	I	\N
3274	1	632	14	2017-04-11 13:19:30.257	I	\N
3275	1	633	14	2017-04-11 13:19:30.259	I	\N
3276	1	634	14	2017-04-11 13:19:30.261	I	\N
3277	1	635	14	2017-04-11 13:19:30.263	I	\N
3278	1	636	14	2017-04-11 13:19:30.264	I	\N
3279	1	637	14	2017-04-11 13:19:30.266	I	\N
4787	1	1541	211	2017-04-12 11:13:45.368	I	\N
3222	1	1305	211	2017-04-11 13:19:45.078	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
3223	1	1306	211	2017-04-11 13:19:45.079	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
3224	1	1307	211	2017-04-11 13:19:45.08	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
3225	1	1308	211	2017-04-11 13:19:45.081	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
3226	1	1309	211	2017-04-11 13:19:45.082	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
3227	1	1310	211	2017-04-11 13:19:45.083	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
3228	1	1311	211	2017-04-11 13:19:45.083	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
3229	1	1312	211	2017-04-11 13:19:45.084	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
3230	1	1313	211	2017-04-11 13:19:45.085	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
3231	1	1314	211	2017-04-11 13:19:45.086	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
3232	1	1315	211	2017-04-11 13:19:45.086	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
3233	1	1316	211	2017-04-11 13:19:45.087	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
3234	1	1317	211	2017-04-11 13:19:45.088	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
3235	1	1318	211	2017-04-11 13:19:45.088	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
3236	1	1319	211	2017-04-11 13:19:45.089	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
3237	1	1320	211	2017-04-11 13:19:45.09	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
3238	1	1321	211	2017-04-11 13:19:45.094	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
3239	1	1322	211	2017-04-11 13:19:45.095	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
3240	1	1323	211	2017-04-11 13:19:45.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
3281	1	1324	211	2017-04-11 13:19:45.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
3282	1	1325	211	2017-04-11 13:19:45.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
3283	1	1326	211	2017-04-11 13:19:45.098	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
3284	1	1390	211	2017-04-11 13:19:45.101	I	\N
3285	1	1391	211	2017-04-11 13:19:45.104	I	\N
3286	1	1392	211	2017-04-11 13:19:45.111	I	\N
3287	1	1393	211	2017-04-11 13:19:45.113	I	\N
3288	1	1394	211	2017-04-11 13:19:45.116	I	\N
3289	1	1395	211	2017-04-11 13:19:45.118	I	\N
3290	1	1396	211	2017-04-11 13:19:45.12	I	\N
3291	1	1397	211	2017-04-11 13:19:45.122	I	\N
3292	1	1398	211	2017-04-11 13:19:45.124	I	\N
3293	1	1399	211	2017-04-11 13:19:45.126	I	\N
3294	1	1400	211	2017-04-11 13:19:45.128	I	\N
3295	1	1401	211	2017-04-11 13:19:45.131	I	\N
3296	1	1402	211	2017-04-11 13:19:45.133	I	\N
3297	1	1403	211	2017-04-11 13:19:45.134	I	\N
3298	1	1404	211	2017-04-11 13:19:45.143	I	\N
3299	1	1405	211	2017-04-11 13:19:45.145	I	\N
3300	1	1406	211	2017-04-11 13:19:45.147	I	\N
3301	1	1407	211	2017-04-11 13:19:45.149	I	\N
3302	1	1408	211	2017-04-11 13:19:45.152	I	\N
3303	1	1409	211	2017-04-11 13:19:45.155	I	\N
3304	1	1410	211	2017-04-11 13:19:45.157	I	\N
3305	1	1411	211	2017-04-11 13:19:45.16	I	\N
3306	1	1412	211	2017-04-11 13:19:45.162	I	\N
3307	1	117	212	2017-04-11 13:19:45.164	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
3308	1	127	212	2017-04-11 13:19:45.17	I	\N
3321	1	611	14	2017-04-11 13:20:31.394	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3235323c2f6c617374757064617465643e0a
3322	1	612	14	2017-04-11 13:20:31.396	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3235353c2f6c617374757064617465643e0a
3323	1	613	14	2017-04-11 13:20:31.398	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3235383c2f6c617374757064617465643e0a
3324	1	614	14	2017-04-11 13:20:31.399	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3236313c2f6c617374757064617465643e0a
3325	1	615	14	2017-04-11 13:20:31.401	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3236343c2f6c617374757064617465643e0a
3326	1	638	14	2017-04-11 13:20:31.416	I	\N
3327	1	639	14	2017-04-11 13:20:31.419	I	\N
3328	1	640	14	2017-04-11 13:20:31.425	I	\N
3329	1	641	14	2017-04-11 13:20:31.436	I	\N
3330	1	642	14	2017-04-11 13:20:31.439	I	\N
3331	1	600	14	2017-04-11 13:20:31.453	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3138313c2f6c617374757064617465643e0a
3332	1	601	14	2017-04-11 13:20:31.454	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3138343c2f6c617374757064617465643e0a
3333	1	602	14	2017-04-11 13:20:31.462	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3138373c2f6c617374757064617465643e0a
3334	1	603	14	2017-04-11 13:20:31.463	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e31393c2f6c617374757064617465643e0a
3335	1	643	14	2017-04-11 13:20:31.469	I	\N
3336	1	644	14	2017-04-11 13:20:31.475	I	\N
3337	1	645	14	2017-04-11 13:20:31.483	I	\N
3338	1	646	14	2017-04-11 13:20:31.486	I	\N
3339	1	618	14	2017-04-11 13:20:31.501	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e32323c2f6c617374757064617465643e0a
3340	1	619	14	2017-04-11 13:20:31.502	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3232333c2f6c617374757064617465643e0a
3341	1	620	14	2017-04-11 13:20:31.504	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3232353c2f6c617374757064617465643e0a
3342	1	621	14	2017-04-11 13:20:31.507	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3232373c2f6c617374757064617465643e0a
3343	1	622	14	2017-04-11 13:20:31.509	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3233333c2f6c617374757064617465643e0a
3344	1	623	14	2017-04-11 13:20:31.511	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3233353c2f6c617374757064617465643e0a
3345	1	624	14	2017-04-11 13:20:31.517	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3233383c2f6c617374757064617465643e0a
3346	1	625	14	2017-04-11 13:20:31.523	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e32343c2f6c617374757064617465643e0a
3418	1	686	14	2017-04-11 13:20:31.836	I	\N
4783	1	1537	211	2017-04-12 11:13:45.357	I	\N
3347	1	626	14	2017-04-11 13:20:31.526	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3234323c2f6c617374757064617465643e0a
3348	1	627	14	2017-04-11 13:20:31.531	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3234343c2f6c617374757064617465643e0a
3349	1	628	14	2017-04-11 13:20:31.534	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3234363c2f6c617374757064617465643e0a
3350	1	629	14	2017-04-11 13:20:31.535	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3234383c2f6c617374757064617465643e0a
3351	1	630	14	2017-04-11 13:20:31.539	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3235343c2f6c617374757064617465643e0a
3352	1	631	14	2017-04-11 13:20:31.54	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3235353c2f6c617374757064617465643e0a
3353	1	632	14	2017-04-11 13:20:31.542	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3235373c2f6c617374757064617465643e0a
3354	1	633	14	2017-04-11 13:20:31.543	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3235393c2f6c617374757064617465643e0a
3355	1	634	14	2017-04-11 13:20:31.544	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3236313c2f6c617374757064617465643e0a
3356	1	635	14	2017-04-11 13:20:31.546	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3236333c2f6c617374757064617465643e0a
3357	1	636	14	2017-04-11 13:20:31.547	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3236343c2f6c617374757064617465643e0a
3358	1	637	14	2017-04-11 13:20:31.548	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a31393a33302e3236363c2f6c617374757064617465643e0a
3359	1	647	14	2017-04-11 13:20:31.566	I	\N
3360	1	648	14	2017-04-11 13:20:31.569	I	\N
3361	1	649	14	2017-04-11 13:20:31.572	I	\N
3362	1	650	14	2017-04-11 13:20:31.575	I	\N
3363	1	651	14	2017-04-11 13:20:31.578	I	\N
3364	1	652	14	2017-04-11 13:20:31.581	I	\N
3365	1	653	14	2017-04-11 13:20:31.584	I	\N
3366	1	654	14	2017-04-11 13:20:31.587	I	\N
3367	1	655	14	2017-04-11 13:20:31.59	I	\N
3368	1	656	14	2017-04-11 13:20:31.599	I	\N
3369	1	657	14	2017-04-11 13:20:31.602	I	\N
3370	1	658	14	2017-04-11 13:20:31.613	I	\N
3371	1	659	14	2017-04-11 13:20:31.618	I	\N
3372	1	660	14	2017-04-11 13:20:31.621	I	\N
3373	1	661	14	2017-04-11 13:20:31.624	I	\N
3374	1	662	14	2017-04-11 13:20:31.627	I	\N
3375	1	663	14	2017-04-11 13:20:31.63	I	\N
3376	1	664	14	2017-04-11 13:20:31.635	I	\N
3377	1	665	14	2017-04-11 13:20:31.648	I	\N
3378	1	666	14	2017-04-11 13:20:31.659	I	\N
3379	1	575	14	2017-04-11 13:20:31.673	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e30333c2f6c617374757064617465643e0a
3380	1	576	14	2017-04-11 13:20:31.674	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3033343c2f6c617374757064617465643e0a
3381	1	577	14	2017-04-11 13:20:31.681	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3033373c2f6c617374757064617465643e0a
3382	1	578	14	2017-04-11 13:20:31.682	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e30343c2f6c617374757064617465643e0a
3383	1	579	14	2017-04-11 13:20:31.683	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3034333c2f6c617374757064617465643e0a
3384	1	667	14	2017-04-11 13:20:31.699	I	\N
3385	1	668	14	2017-04-11 13:20:31.704	I	\N
3386	1	669	14	2017-04-11 13:20:31.71	I	\N
3387	1	670	14	2017-04-11 13:20:31.713	I	\N
3388	1	671	14	2017-04-11 13:20:31.721	I	\N
3389	1	616	14	2017-04-11 13:20:31.735	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3237383c2f6c617374757064617465643e0a
3390	1	617	14	2017-04-11 13:20:31.736	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3238313c2f6c617374757064617465643e0a
3391	1	672	14	2017-04-11 13:20:31.74	I	\N
3392	1	673	14	2017-04-11 13:20:31.746	I	\N
3393	1	599	14	2017-04-11 13:20:31.754	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3136333c2f6c617374757064617465643e0a
3394	1	674	14	2017-04-11 13:20:31.756	I	\N
3395	1	570	14	2017-04-11 13:20:31.764	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34352e3939333c2f6c617374757064617465643e0a
3396	1	571	14	2017-04-11 13:20:31.765	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34352e3939363c2f6c617374757064617465643e0a
3397	1	572	14	2017-04-11 13:20:31.769	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e303c2f6c617374757064617465643e0a
3398	1	573	14	2017-04-11 13:20:31.77	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3030343c2f6c617374757064617465643e0a
3399	1	574	14	2017-04-11 13:20:31.772	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3030393c2f6c617374757064617465643e0a
3400	1	675	14	2017-04-11 13:20:31.778	I	\N
3401	1	676	14	2017-04-11 13:20:31.781	I	\N
3402	1	677	14	2017-04-11 13:20:31.784	I	\N
3403	1	678	14	2017-04-11 13:20:31.788	I	\N
3404	1	679	14	2017-04-11 13:20:31.791	I	\N
3405	1	604	14	2017-04-11 13:20:31.799	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3231333c2f6c617374757064617465643e0a
3406	1	605	14	2017-04-11 13:20:31.8	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3231363c2f6c617374757064617465643e0a
3407	1	606	14	2017-04-11 13:20:31.802	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3231393c2f6c617374757064617465643e0a
3408	1	607	14	2017-04-11 13:20:31.803	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3232333c2f6c617374757064617465643e0a
3409	1	608	14	2017-04-11 13:20:31.804	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3232363c2f6c617374757064617465643e0a
3410	1	609	14	2017-04-11 13:20:31.806	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3232393c2f6c617374757064617465643e0a
3411	1	610	14	2017-04-11 13:20:31.807	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34362e3233323c2f6c617374757064617465643e0a
3412	1	680	14	2017-04-11 13:20:31.815	I	\N
3413	1	681	14	2017-04-11 13:20:31.818	I	\N
3414	1	682	14	2017-04-11 13:20:31.822	I	\N
3415	1	683	14	2017-04-11 13:20:31.825	I	\N
3416	1	684	14	2017-04-11 13:20:31.828	I	\N
3419	1	568	14	2017-04-11 13:20:31.845	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34352e3935383c2f6c617374757064617465643e0a
3420	1	687	14	2017-04-11 13:20:31.848	I	\N
3421	1	569	14	2017-04-11 13:20:31.856	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642203f3f20333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31302031343a35343a34352e3937313c2f6c617374757064617465643e0a
3422	1	688	14	2017-04-11 13:20:31.859	I	\N
3441	1	870	5	2017-04-11 13:23:45.068	I	\N
3442	1	647	14	2017-04-11 13:24:15.088	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3536363c2f6c617374757064617465643e0a
3443	1	648	14	2017-04-11 13:24:15.089	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3536393c2f6c617374757064617465643e0a
3444	1	649	14	2017-04-11 13:24:15.09	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3537323c2f6c617374757064617465643e0a
3445	1	650	14	2017-04-11 13:24:15.091	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3537353c2f6c617374757064617465643e0a
3446	1	651	14	2017-04-11 13:24:15.092	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3537383c2f6c617374757064617465643e0a
3447	1	652	14	2017-04-11 13:24:15.093	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3538313c2f6c617374757064617465643e0a
3448	1	653	14	2017-04-11 13:24:15.094	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3538343c2f6c617374757064617465643e0a
3449	1	654	14	2017-04-11 13:24:15.095	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3538373c2f6c617374757064617465643e0a
3450	1	655	14	2017-04-11 13:24:15.095	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e35393c2f6c617374757064617465643e0a
3451	1	656	14	2017-04-11 13:24:15.096	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3539393c2f6c617374757064617465643e0a
3452	1	657	14	2017-04-11 13:24:15.097	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3630323c2f6c617374757064617465643e0a
3453	1	658	14	2017-04-11 13:24:15.098	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3631333c2f6c617374757064617465643e0a
3454	1	659	14	2017-04-11 13:24:15.098	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3631383c2f6c617374757064617465643e0a
3455	1	660	14	2017-04-11 13:24:15.1	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3632313c2f6c617374757064617465643e0a
3456	1	661	14	2017-04-11 13:24:15.101	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3632343c2f6c617374757064617465643e0a
3457	1	662	14	2017-04-11 13:24:15.102	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3632373c2f6c617374757064617465643e0a
3458	1	663	14	2017-04-11 13:24:15.103	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e36333c2f6c617374757064617465643e0a
3459	1	664	14	2017-04-11 13:24:15.104	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3633353c2f6c617374757064617465643e0a
3460	1	665	14	2017-04-11 13:24:15.105	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3634383c2f6c617374757064617465643e0a
3461	1	666	14	2017-04-11 13:24:15.105	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3635393c2f6c617374757064617465643e0a
3462	1	689	14	2017-04-11 13:24:15.113	I	\N
3463	1	690	14	2017-04-11 13:24:15.115	I	\N
3464	1	691	14	2017-04-11 13:24:15.117	I	\N
3465	1	692	14	2017-04-11 13:24:15.119	I	\N
3466	1	693	14	2017-04-11 13:24:15.121	I	\N
3467	1	694	14	2017-04-11 13:24:15.124	I	\N
3468	1	695	14	2017-04-11 13:24:15.126	I	\N
3469	1	696	14	2017-04-11 13:24:15.127	I	\N
3470	1	697	14	2017-04-11 13:24:15.129	I	\N
3471	1	698	14	2017-04-11 13:24:15.131	I	\N
3472	1	699	14	2017-04-11 13:24:15.132	I	\N
3473	1	700	14	2017-04-11 13:24:15.134	I	\N
3474	1	701	14	2017-04-11 13:24:15.137	I	\N
3475	1	702	14	2017-04-11 13:24:15.138	I	\N
3476	1	703	14	2017-04-11 13:24:15.14	I	\N
3477	1	704	14	2017-04-11 13:24:15.141	I	\N
3478	1	705	14	2017-04-11 13:24:15.143	I	\N
3479	1	706	14	2017-04-11 13:24:15.149	I	\N
3480	1	707	14	2017-04-11 13:24:15.156	I	\N
3481	1	708	14	2017-04-11 13:24:15.157	I	\N
3482	1	709	14	2017-04-11 13:24:15.159	I	\N
3501	1	1390	211	2017-04-11 13:24:30.092	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
3502	1	1391	211	2017-04-11 13:24:30.094	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
3503	1	1392	211	2017-04-11 13:24:30.095	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
3504	1	1393	211	2017-04-11 13:24:30.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
3505	1	1394	211	2017-04-11 13:24:30.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
3506	1	1395	211	2017-04-11 13:24:30.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
3507	1	1396	211	2017-04-11 13:24:30.099	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
3508	1	1397	211	2017-04-11 13:24:30.1	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
3509	1	1398	211	2017-04-11 13:24:30.101	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
3510	1	1399	211	2017-04-11 13:24:30.103	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
3511	1	1400	211	2017-04-11 13:24:30.106	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
3512	1	1401	211	2017-04-11 13:24:30.106	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
3513	1	1402	211	2017-04-11 13:24:30.107	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
3514	1	1403	211	2017-04-11 13:24:30.111	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
3515	1	1404	211	2017-04-11 13:24:30.117	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
3516	1	1405	211	2017-04-11 13:24:30.121	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
3517	1	1406	211	2017-04-11 13:24:30.122	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
3518	1	1407	211	2017-04-11 13:24:30.125	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
3519	1	1408	211	2017-04-11 13:24:30.125	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
3520	1	1409	211	2017-04-11 13:24:30.126	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
3521	1	1410	211	2017-04-11 13:24:30.126	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
3522	1	1411	211	2017-04-11 13:24:30.128	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
3523	1	1412	211	2017-04-11 13:24:30.129	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3836393c2f7465737449643e0a
3524	1	1413	211	2017-04-11 13:24:30.134	I	\N
3525	1	1414	211	2017-04-11 13:24:30.137	I	\N
3526	1	1415	211	2017-04-11 13:24:30.14	I	\N
3527	1	1416	211	2017-04-11 13:24:30.143	I	\N
3528	1	1417	211	2017-04-11 13:24:30.145	I	\N
3529	1	1418	211	2017-04-11 13:24:30.147	I	\N
3530	1	1419	211	2017-04-11 13:24:30.149	I	\N
3531	1	1420	211	2017-04-11 13:24:30.151	I	\N
3532	1	1421	211	2017-04-11 13:24:30.153	I	\N
3533	1	1422	211	2017-04-11 13:24:30.155	I	\N
3534	1	1423	211	2017-04-11 13:24:30.159	I	\N
3535	1	1424	211	2017-04-11 13:24:30.16	I	\N
3536	1	1425	211	2017-04-11 13:24:30.162	I	\N
3537	1	1426	211	2017-04-11 13:24:30.164	I	\N
3538	1	1427	211	2017-04-11 13:24:30.166	I	\N
3539	1	1428	211	2017-04-11 13:24:30.168	I	\N
3540	1	1429	211	2017-04-11 13:24:30.17	I	\N
3541	1	1430	211	2017-04-11 13:24:30.172	I	\N
3542	1	1431	211	2017-04-11 13:24:30.174	I	\N
3543	1	1432	211	2017-04-11 13:24:30.176	I	\N
3544	1	1433	211	2017-04-11 13:24:30.187	I	\N
3545	1	1434	211	2017-04-11 13:24:30.189	I	\N
3546	1	1435	211	2017-04-11 13:24:30.191	I	\N
3547	1	1436	211	2017-04-11 13:24:30.193	I	\N
3548	1	127	212	2017-04-11 13:24:30.195	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
3549	1	128	212	2017-04-11 13:24:30.198	I	\N
3561	1	643	14	2017-04-11 13:25:00.948	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3436393c2f6c617374757064617465643e0a
3562	1	644	14	2017-04-11 13:25:00.95	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3437353c2f6c617374757064617465643e0a
3563	1	645	14	2017-04-11 13:25:00.951	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3438333c2f6c617374757064617465643e0a
3564	1	646	14	2017-04-11 13:25:00.952	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3438363c2f6c617374757064617465643e0a
3565	1	710	14	2017-04-11 13:25:00.958	I	\N
3566	1	711	14	2017-04-11 13:25:00.961	I	\N
3567	1	712	14	2017-04-11 13:25:00.964	I	\N
3568	1	713	14	2017-04-11 13:25:00.967	I	\N
3569	1	687	14	2017-04-11 13:25:00.975	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3834383c2f6c617374757064617465643e0a
3570	1	714	14	2017-04-11 13:25:00.978	I	\N
3571	1	638	14	2017-04-11 13:25:00.986	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3431363c2f6c617374757064617465643e0a
3572	1	639	14	2017-04-11 13:25:00.987	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3431393c2f6c617374757064617465643e0a
3573	1	640	14	2017-04-11 13:25:00.988	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3432353c2f6c617374757064617465643e0a
3574	1	641	14	2017-04-11 13:25:00.989	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3433363c2f6c617374757064617465643e0a
3575	1	642	14	2017-04-11 13:25:00.991	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3433393c2f6c617374757064617465643e0a
3576	1	715	14	2017-04-11 13:25:00.996	I	\N
3577	1	716	14	2017-04-11 13:25:00.999	I	\N
3578	1	717	14	2017-04-11 13:25:01.003	I	\N
3579	1	718	14	2017-04-11 13:25:01.005	I	\N
3580	1	719	14	2017-04-11 13:25:01.009	I	\N
3581	1	672	14	2017-04-11 13:25:01.017	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e37343c2f6c617374757064617465643e0a
3582	1	673	14	2017-04-11 13:25:01.019	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3734363c2f6c617374757064617465643e0a
3583	1	720	14	2017-04-11 13:25:01.022	I	\N
3584	1	721	14	2017-04-11 13:25:01.025	I	\N
3585	1	674	14	2017-04-11 13:25:01.033	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3735363c2f6c617374757064617465643e0a
3586	1	722	14	2017-04-11 13:25:01.035	I	\N
3587	1	675	14	2017-04-11 13:25:01.042	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3737383c2f6c617374757064617465643e0a
3588	1	676	14	2017-04-11 13:25:01.044	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3738313c2f6c617374757064617465643e0a
3589	1	677	14	2017-04-11 13:25:01.045	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3738343c2f6c617374757064617465643e0a
3590	1	678	14	2017-04-11 13:25:01.046	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3738383c2f6c617374757064617465643e0a
3591	1	679	14	2017-04-11 13:25:01.048	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3739313c2f6c617374757064617465643e0a
3592	1	723	14	2017-04-11 13:25:01.053	I	\N
3593	1	724	14	2017-04-11 13:25:01.056	I	\N
3594	1	725	14	2017-04-11 13:25:01.059	I	\N
3595	1	726	14	2017-04-11 13:25:01.062	I	\N
3596	1	727	14	2017-04-11 13:25:01.065	I	\N
3597	1	680	14	2017-04-11 13:25:01.073	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3831353c2f6c617374757064617465643e0a
3598	1	681	14	2017-04-11 13:25:01.074	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3831383c2f6c617374757064617465643e0a
3599	1	682	14	2017-04-11 13:25:01.075	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3832323c2f6c617374757064617465643e0a
3600	1	683	14	2017-04-11 13:25:01.077	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3832353c2f6c617374757064617465643e0a
3601	1	684	14	2017-04-11 13:25:01.078	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3832383c2f6c617374757064617465643e0a
3602	1	685	14	2017-04-11 13:25:01.079	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3833323c2f6c617374757064617465643e0a
3603	1	686	14	2017-04-11 13:25:01.08	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3833363c2f6c617374757064617465643e0a
3604	1	728	14	2017-04-11 13:25:01.088	I	\N
3605	1	729	14	2017-04-11 13:25:01.091	I	\N
3606	1	730	14	2017-04-11 13:25:01.093	I	\N
3607	1	731	14	2017-04-11 13:25:01.096	I	\N
3608	1	732	14	2017-04-11 13:25:01.099	I	\N
3609	1	733	14	2017-04-11 13:25:01.102	I	\N
3610	1	734	14	2017-04-11 13:25:01.106	I	\N
3611	1	667	14	2017-04-11 13:25:01.113	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3639393c2f6c617374757064617465643e0a
3612	1	668	14	2017-04-11 13:25:01.114	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3730343c2f6c617374757064617465643e0a
3613	1	669	14	2017-04-11 13:25:01.116	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e37313c2f6c617374757064617465643e0a
3614	1	670	14	2017-04-11 13:25:01.117	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3731333c2f6c617374757064617465643e0a
3615	1	671	14	2017-04-11 13:25:01.118	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3732313c2f6c617374757064617465643e0a
3616	1	735	14	2017-04-11 13:25:01.124	I	\N
3617	1	736	14	2017-04-11 13:25:01.127	I	\N
3618	1	737	14	2017-04-11 13:25:01.137	I	\N
3619	1	738	14	2017-04-11 13:25:01.148	I	\N
3620	1	739	14	2017-04-11 13:25:01.151	I	\N
3621	1	688	14	2017-04-11 13:25:01.159	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32303a33312e3835393c2f6c617374757064617465643e0a
3622	1	740	14	2017-04-11 13:25:01.162	I	\N
3623	1	689	14	2017-04-11 13:25:01.171	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3131333c2f6c617374757064617465643e0a
3624	1	690	14	2017-04-11 13:25:01.172	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3131353c2f6c617374757064617465643e0a
3625	1	691	14	2017-04-11 13:25:01.174	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3131373c2f6c617374757064617465643e0a
3626	1	692	14	2017-04-11 13:25:01.175	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3131393c2f6c617374757064617465643e0a
3627	1	693	14	2017-04-11 13:25:01.176	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3132313c2f6c617374757064617465643e0a
3628	1	694	14	2017-04-11 13:25:01.178	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3132343c2f6c617374757064617465643e0a
3629	1	695	14	2017-04-11 13:25:01.179	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3132363c2f6c617374757064617465643e0a
3630	1	696	14	2017-04-11 13:25:01.18	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3132373c2f6c617374757064617465643e0a
3631	1	697	14	2017-04-11 13:25:01.183	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3132393c2f6c617374757064617465643e0a
3632	1	698	14	2017-04-11 13:25:01.184	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3133313c2f6c617374757064617465643e0a
3633	1	699	14	2017-04-11 13:25:01.186	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3133323c2f6c617374757064617465643e0a
3634	1	700	14	2017-04-11 13:25:01.187	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3133343c2f6c617374757064617465643e0a
3635	1	701	14	2017-04-11 13:25:01.188	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3133373c2f6c617374757064617465643e0a
3636	1	702	14	2017-04-11 13:25:01.191	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3133383c2f6c617374757064617465643e0a
3637	1	703	14	2017-04-11 13:25:01.192	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e31343c2f6c617374757064617465643e0a
3638	1	704	14	2017-04-11 13:25:01.194	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3134313c2f6c617374757064617465643e0a
3639	1	705	14	2017-04-11 13:25:01.195	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3134333c2f6c617374757064617465643e0a
3640	1	706	14	2017-04-11 13:25:01.196	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3134393c2f6c617374757064617465643e0a
3641	1	707	14	2017-04-11 13:25:01.198	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3135363c2f6c617374757064617465643e0a
3642	1	708	14	2017-04-11 13:25:01.199	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3135373c2f6c617374757064617465643e0a
3643	1	709	14	2017-04-11 13:25:01.2	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32343a31352e3135393c2f6c617374757064617465643e0a
3644	1	741	14	2017-04-11 13:25:01.219	I	\N
3645	1	742	14	2017-04-11 13:25:01.222	I	\N
3646	1	743	14	2017-04-11 13:25:01.225	I	\N
3647	1	744	14	2017-04-11 13:25:01.228	I	\N
3648	1	745	14	2017-04-11 13:25:01.232	I	\N
3649	1	746	14	2017-04-11 13:25:01.235	I	\N
3650	1	747	14	2017-04-11 13:25:01.238	I	\N
3651	1	748	14	2017-04-11 13:25:01.243	I	\N
3652	1	749	14	2017-04-11 13:25:01.246	I	\N
3653	1	750	14	2017-04-11 13:25:01.251	I	\N
3654	1	751	14	2017-04-11 13:25:01.255	I	\N
3655	1	752	14	2017-04-11 13:25:01.258	I	\N
3656	1	753	14	2017-04-11 13:25:01.261	I	\N
3657	1	754	14	2017-04-11 13:25:01.264	I	\N
3658	1	755	14	2017-04-11 13:25:01.268	I	\N
3659	1	756	14	2017-04-11 13:25:01.271	I	\N
3660	1	757	14	2017-04-11 13:25:01.274	I	\N
3661	1	758	14	2017-04-11 13:25:01.277	I	\N
3662	1	759	14	2017-04-11 13:25:01.28	I	\N
3663	1	760	14	2017-04-11 13:25:01.283	I	\N
3664	1	761	14	2017-04-11 13:25:01.287	I	\N
3681	1	871	5	2017-04-11 13:26:15.087	I	\N
3701	1	741	14	2017-04-11 13:26:30.137	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3231393c2f6c617374757064617465643e0a
3702	1	742	14	2017-04-11 13:26:30.138	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3232323c2f6c617374757064617465643e0a
3703	1	743	14	2017-04-11 13:26:30.139	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3232353c2f6c617374757064617465643e0a
3704	1	744	14	2017-04-11 13:26:30.14	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3232383c2f6c617374757064617465643e0a
3705	1	745	14	2017-04-11 13:26:30.141	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3233323c2f6c617374757064617465643e0a
3706	1	746	14	2017-04-11 13:26:30.142	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3233353c2f6c617374757064617465643e0a
3707	1	747	14	2017-04-11 13:26:30.143	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3233383c2f6c617374757064617465643e0a
3708	1	748	14	2017-04-11 13:26:30.144	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3234333c2f6c617374757064617465643e0a
3709	1	749	14	2017-04-11 13:26:30.145	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3234363c2f6c617374757064617465643e0a
3710	1	750	14	2017-04-11 13:26:30.146	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3235313c2f6c617374757064617465643e0a
3711	1	751	14	2017-04-11 13:26:30.146	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3235353c2f6c617374757064617465643e0a
3712	1	752	14	2017-04-11 13:26:30.147	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3235383c2f6c617374757064617465643e0a
3713	1	753	14	2017-04-11 13:26:30.148	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3236313c2f6c617374757064617465643e0a
3714	1	754	14	2017-04-11 13:26:30.149	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3236343c2f6c617374757064617465643e0a
3715	1	755	14	2017-04-11 13:26:30.149	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3236383c2f6c617374757064617465643e0a
3716	1	756	14	2017-04-11 13:26:30.15	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3237313c2f6c617374757064617465643e0a
3717	1	757	14	2017-04-11 13:26:30.151	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3237343c2f6c617374757064617465643e0a
3718	1	758	14	2017-04-11 13:26:30.152	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3237373c2f6c617374757064617465643e0a
3719	1	759	14	2017-04-11 13:26:30.152	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e32383c2f6c617374757064617465643e0a
3720	1	760	14	2017-04-11 13:26:30.153	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3238333c2f6c617374757064617465643e0a
3721	1	761	14	2017-04-11 13:26:30.154	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3238373c2f6c617374757064617465643e0a
3722	1	762	14	2017-04-11 13:26:30.162	I	\N
3723	1	763	14	2017-04-11 13:26:30.165	I	\N
3724	1	764	14	2017-04-11 13:26:30.167	I	\N
3725	1	765	14	2017-04-11 13:26:30.169	I	\N
3726	1	766	14	2017-04-11 13:26:30.171	I	\N
3727	1	767	14	2017-04-11 13:26:30.172	I	\N
3728	1	768	14	2017-04-11 13:26:30.174	I	\N
3729	1	769	14	2017-04-11 13:26:30.176	I	\N
3730	1	770	14	2017-04-11 13:26:30.177	I	\N
3731	1	771	14	2017-04-11 13:26:30.179	I	\N
3732	1	772	14	2017-04-11 13:26:30.181	I	\N
3733	1	773	14	2017-04-11 13:26:30.182	I	\N
3734	1	774	14	2017-04-11 13:26:30.183	I	\N
3735	1	775	14	2017-04-11 13:26:30.185	I	\N
3736	1	776	14	2017-04-11 13:26:30.186	I	\N
3737	1	777	14	2017-04-11 13:26:30.188	I	\N
3738	1	778	14	2017-04-11 13:26:30.189	I	\N
3739	1	779	14	2017-04-11 13:26:30.191	I	\N
3740	1	780	14	2017-04-11 13:26:30.192	I	\N
3741	1	781	14	2017-04-11 13:26:30.194	I	\N
3742	1	782	14	2017-04-11 13:26:30.195	I	\N
3743	1	783	14	2017-04-11 13:26:30.197	I	\N
3550	1	1413	211	2017-04-11 13:27:00.092	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
3551	1	1414	211	2017-04-11 13:27:00.093	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
3552	1	1415	211	2017-04-11 13:27:00.094	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
3553	1	1416	211	2017-04-11 13:27:00.095	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
3554	1	1417	211	2017-04-11 13:27:00.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
3555	1	1418	211	2017-04-11 13:27:00.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
3556	1	1419	211	2017-04-11 13:27:00.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
3557	1	1420	211	2017-04-11 13:27:00.098	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
3558	1	1421	211	2017-04-11 13:27:00.099	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
3559	1	1422	211	2017-04-11 13:27:00.1	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
3560	1	1423	211	2017-04-11 13:27:00.1	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
3761	1	1424	211	2017-04-11 13:27:00.101	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
3762	1	1425	211	2017-04-11 13:27:00.102	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
3763	1	1426	211	2017-04-11 13:27:00.103	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
3764	1	1427	211	2017-04-11 13:27:00.104	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
3765	1	1428	211	2017-04-11 13:27:00.104	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
3766	1	1429	211	2017-04-11 13:27:00.108	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
3767	1	1430	211	2017-04-11 13:27:00.109	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
3768	1	1431	211	2017-04-11 13:27:00.109	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
3769	1	1432	211	2017-04-11 13:27:00.11	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
3770	1	1433	211	2017-04-11 13:27:00.111	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
3771	1	1434	211	2017-04-11 13:27:00.112	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
3772	1	1435	211	2017-04-11 13:27:00.112	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3836393c2f7465737449643e0a
3773	1	1436	211	2017-04-11 13:27:00.113	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837303c2f7465737449643e0a
3774	1	1437	211	2017-04-11 13:27:00.116	I	\N
3775	1	1438	211	2017-04-11 13:27:00.119	I	\N
3776	1	1439	211	2017-04-11 13:27:00.121	I	\N
3777	1	1440	211	2017-04-11 13:27:00.123	I	\N
3778	1	1441	211	2017-04-11 13:27:00.126	I	\N
3779	1	1442	211	2017-04-11 13:27:00.128	I	\N
3780	1	1443	211	2017-04-11 13:27:00.13	I	\N
3781	1	1444	211	2017-04-11 13:27:00.132	I	\N
3782	1	1445	211	2017-04-11 13:27:00.134	I	\N
3783	1	1446	211	2017-04-11 13:27:00.136	I	\N
3784	1	1447	211	2017-04-11 13:27:00.138	I	\N
3785	1	1448	211	2017-04-11 13:27:00.14	I	\N
3786	1	1449	211	2017-04-11 13:27:00.142	I	\N
3787	1	1450	211	2017-04-11 13:27:00.143	I	\N
3788	1	1451	211	2017-04-11 13:27:00.145	I	\N
3789	1	1452	211	2017-04-11 13:27:00.147	I	\N
3790	1	1453	211	2017-04-11 13:27:00.149	I	\N
3791	1	1454	211	2017-04-11 13:27:00.151	I	\N
3792	1	1455	211	2017-04-11 13:27:00.153	I	\N
3793	1	1456	211	2017-04-11 13:27:00.155	I	\N
3794	1	1457	211	2017-04-11 13:27:00.157	I	\N
3795	1	1458	211	2017-04-11 13:27:00.159	I	\N
3796	1	1459	211	2017-04-11 13:27:00.161	I	\N
3797	1	1460	211	2017-04-11 13:27:00.163	I	\N
3798	1	1461	211	2017-04-11 13:27:00.165	I	\N
3799	1	128	212	2017-04-11 13:27:00.167	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
3800	1	129	212	2017-04-11 13:27:00.17	I	\N
3801	1	740	14	2017-04-11 13:28:01.267	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3136323c2f6c617374757064617465643e0a
3802	1	784	14	2017-04-11 13:28:01.274	I	\N
3803	1	714	14	2017-04-11 13:28:01.282	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3937383c2f6c617374757064617465643e0a
3804	1	785	14	2017-04-11 13:28:01.285	I	\N
3805	1	735	14	2017-04-11 13:28:01.293	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3132343c2f6c617374757064617465643e0a
3806	1	736	14	2017-04-11 13:28:01.295	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3132373c2f6c617374757064617465643e0a
3807	1	737	14	2017-04-11 13:28:01.296	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3133373c2f6c617374757064617465643e0a
3808	1	738	14	2017-04-11 13:28:01.308	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3134383c2f6c617374757064617465643e0a
3809	1	739	14	2017-04-11 13:28:01.31	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3135313c2f6c617374757064617465643e0a
3810	1	786	14	2017-04-11 13:28:01.316	I	\N
3811	1	787	14	2017-04-11 13:28:01.333	I	\N
3812	1	788	14	2017-04-11 13:28:01.35	I	\N
3813	1	789	14	2017-04-11 13:28:01.373	I	\N
3814	1	790	14	2017-04-11 13:28:01.385	I	\N
3815	1	720	14	2017-04-11 13:28:01.422	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3032323c2f6c617374757064617465643e0a
3816	1	721	14	2017-04-11 13:28:01.424	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3032353c2f6c617374757064617465643e0a
3817	1	791	14	2017-04-11 13:28:01.427	I	\N
3818	1	792	14	2017-04-11 13:28:01.43	I	\N
3819	1	762	14	2017-04-11 13:28:01.439	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3136323c2f6c617374757064617465643e0a
3820	1	763	14	2017-04-11 13:28:01.446	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3136353c2f6c617374757064617465643e0a
3821	1	764	14	2017-04-11 13:28:01.447	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3136373c2f6c617374757064617465643e0a
3822	1	765	14	2017-04-11 13:28:01.449	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3136393c2f6c617374757064617465643e0a
3823	1	766	14	2017-04-11 13:28:01.45	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137313c2f6c617374757064617465643e0a
3824	1	767	14	2017-04-11 13:28:01.451	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137323c2f6c617374757064617465643e0a
3825	1	768	14	2017-04-11 13:28:01.452	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137343c2f6c617374757064617465643e0a
3826	1	769	14	2017-04-11 13:28:01.458	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137363c2f6c617374757064617465643e0a
3827	1	770	14	2017-04-11 13:28:01.459	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137373c2f6c617374757064617465643e0a
3828	1	771	14	2017-04-11 13:28:01.46	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3137393c2f6c617374757064617465643e0a
3829	1	772	14	2017-04-11 13:28:01.461	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138313c2f6c617374757064617465643e0a
3830	1	773	14	2017-04-11 13:28:01.462	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138323c2f6c617374757064617465643e0a
3831	1	774	14	2017-04-11 13:28:01.464	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138333c2f6c617374757064617465643e0a
3832	1	775	14	2017-04-11 13:28:01.465	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138353c2f6c617374757064617465643e0a
3833	1	776	14	2017-04-11 13:28:01.466	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138363c2f6c617374757064617465643e0a
3834	1	777	14	2017-04-11 13:28:01.467	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138383c2f6c617374757064617465643e0a
3835	1	778	14	2017-04-11 13:28:01.47	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3138393c2f6c617374757064617465643e0a
3836	1	779	14	2017-04-11 13:28:01.471	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3139313c2f6c617374757064617465643e0a
3837	1	780	14	2017-04-11 13:28:01.472	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3139323c2f6c617374757064617465643e0a
3838	1	781	14	2017-04-11 13:28:01.474	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3139343c2f6c617374757064617465643e0a
3839	1	782	14	2017-04-11 13:28:01.475	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3139353c2f6c617374757064617465643e0a
3840	1	783	14	2017-04-11 13:28:01.477	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32363a33302e3139373c2f6c617374757064617465643e0a
3841	1	793	14	2017-04-11 13:28:01.512	I	\N
3842	1	794	14	2017-04-11 13:28:01.515	I	\N
3843	1	795	14	2017-04-11 13:28:01.519	I	\N
3844	1	796	14	2017-04-11 13:28:01.523	I	\N
3845	1	797	14	2017-04-11 13:28:01.54	I	\N
3846	1	798	14	2017-04-11 13:28:01.552	I	\N
3847	1	799	14	2017-04-11 13:28:01.561	I	\N
3848	1	800	14	2017-04-11 13:28:01.57	I	\N
3849	1	801	14	2017-04-11 13:28:01.58	I	\N
3850	1	802	14	2017-04-11 13:28:01.587	I	\N
3851	1	803	14	2017-04-11 13:28:01.59	I	\N
3852	1	804	14	2017-04-11 13:28:01.593	I	\N
3853	1	805	14	2017-04-11 13:28:01.596	I	\N
3854	1	806	14	2017-04-11 13:28:01.599	I	\N
3855	1	807	14	2017-04-11 13:28:01.603	I	\N
3856	1	808	14	2017-04-11 13:28:01.606	I	\N
3857	1	809	14	2017-04-11 13:28:01.609	I	\N
3858	1	810	14	2017-04-11 13:28:01.612	I	\N
3859	1	811	14	2017-04-11 13:28:01.616	I	\N
3860	1	812	14	2017-04-11 13:28:01.619	I	\N
3861	1	813	14	2017-04-11 13:28:01.622	I	\N
3862	1	814	14	2017-04-11 13:28:01.625	I	\N
3863	1	710	14	2017-04-11 13:28:01.633	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3935383c2f6c617374757064617465643e0a
3864	1	711	14	2017-04-11 13:28:01.635	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3936313c2f6c617374757064617465643e0a
4784	1	1538	211	2017-04-12 11:13:45.359	I	\N
3865	1	712	14	2017-04-11 13:28:01.636	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3936343c2f6c617374757064617465643e0a
3866	1	713	14	2017-04-11 13:28:01.637	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3936373c2f6c617374757064617465643e0a
3867	1	815	14	2017-04-11 13:28:01.643	I	\N
3868	1	816	14	2017-04-11 13:28:01.646	I	\N
3869	1	817	14	2017-04-11 13:28:01.65	I	\N
3870	1	818	14	2017-04-11 13:28:01.653	I	\N
3871	1	715	14	2017-04-11 13:28:01.661	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3939363c2f6c617374757064617465643e0a
3872	1	716	14	2017-04-11 13:28:01.663	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30302e3939393c2f6c617374757064617465643e0a
3873	1	717	14	2017-04-11 13:28:01.664	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3030333c2f6c617374757064617465643e0a
3874	1	718	14	2017-04-11 13:28:01.665	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3030353c2f6c617374757064617465643e0a
3875	1	719	14	2017-04-11 13:28:01.667	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3030393c2f6c617374757064617465643e0a
3876	1	819	14	2017-04-11 13:28:01.673	I	\N
3877	1	820	14	2017-04-11 13:28:01.676	I	\N
3878	1	821	14	2017-04-11 13:28:01.68	I	\N
3879	1	822	14	2017-04-11 13:28:01.683	I	\N
3880	1	823	14	2017-04-11 13:28:01.695	I	\N
3881	1	722	14	2017-04-11 13:28:01.703	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3033353c2f6c617374757064617465643e0a
3882	1	824	14	2017-04-11 13:28:01.706	I	\N
3883	1	728	14	2017-04-11 13:28:01.715	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3038383c2f6c617374757064617465643e0a
3884	1	729	14	2017-04-11 13:28:01.716	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3039313c2f6c617374757064617465643e0a
3885	1	730	14	2017-04-11 13:28:01.717	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3039333c2f6c617374757064617465643e0a
3886	1	731	14	2017-04-11 13:28:01.719	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3039363c2f6c617374757064617465643e0a
3887	1	732	14	2017-04-11 13:28:01.72	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3039393c2f6c617374757064617465643e0a
3888	1	733	14	2017-04-11 13:28:01.721	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3130323c2f6c617374757064617465643e0a
3889	1	734	14	2017-04-11 13:28:01.723	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3130363c2f6c617374757064617465643e0a
3890	1	825	14	2017-04-11 13:28:01.737	I	\N
3891	1	826	14	2017-04-11 13:28:01.74	I	\N
3892	1	827	14	2017-04-11 13:28:01.743	I	\N
3893	1	828	14	2017-04-11 13:28:01.746	I	\N
3894	1	829	14	2017-04-11 13:28:01.75	I	\N
3895	1	830	14	2017-04-11 13:28:01.753	I	\N
3896	1	831	14	2017-04-11 13:28:01.756	I	\N
3897	1	723	14	2017-04-11 13:28:01.765	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3035333c2f6c617374757064617465643e0a
3898	1	724	14	2017-04-11 13:28:01.766	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3035363c2f6c617374757064617465643e0a
3899	1	725	14	2017-04-11 13:28:01.767	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3035393c2f6c617374757064617465643e0a
3900	1	726	14	2017-04-11 13:28:01.769	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3036323c2f6c617374757064617465643e0a
3901	1	727	14	2017-04-11 13:28:01.77	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32353a30312e3036353c2f6c617374757064617465643e0a
3902	1	832	14	2017-04-11 13:28:01.777	I	\N
3903	1	833	14	2017-04-11 13:28:01.78	I	\N
3904	1	834	14	2017-04-11 13:28:01.783	I	\N
3905	1	835	14	2017-04-11 13:28:01.786	I	\N
3906	1	836	14	2017-04-11 13:28:01.79	I	\N
3744	1	872	5	2017-04-11 13:29:00.113	I	\N
3745	1	793	14	2017-04-11 13:29:30.151	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3531323c2f6c617374757064617465643e0a
3746	1	794	14	2017-04-11 13:29:30.152	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3531353c2f6c617374757064617465643e0a
3747	1	795	14	2017-04-11 13:29:30.153	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3531393c2f6c617374757064617465643e0a
3748	1	796	14	2017-04-11 13:29:30.154	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3532333c2f6c617374757064617465643e0a
3749	1	797	14	2017-04-11 13:29:30.155	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e35343c2f6c617374757064617465643e0a
3750	1	798	14	2017-04-11 13:29:30.155	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3535323c2f6c617374757064617465643e0a
3751	1	799	14	2017-04-11 13:29:30.156	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3536313c2f6c617374757064617465643e0a
3752	1	800	14	2017-04-11 13:29:30.157	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e35373c2f6c617374757064617465643e0a
3753	1	801	14	2017-04-11 13:29:30.158	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e35383c2f6c617374757064617465643e0a
3754	1	802	14	2017-04-11 13:29:30.159	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3538373c2f6c617374757064617465643e0a
3755	1	803	14	2017-04-11 13:29:30.159	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e35393c2f6c617374757064617465643e0a
3756	1	804	14	2017-04-11 13:29:30.16	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3539333c2f6c617374757064617465643e0a
3757	1	805	14	2017-04-11 13:29:30.161	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3539363c2f6c617374757064617465643e0a
3758	1	806	14	2017-04-11 13:29:30.161	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3539393c2f6c617374757064617465643e0a
3759	1	807	14	2017-04-11 13:29:30.162	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3630333c2f6c617374757064617465643e0a
3760	1	808	14	2017-04-11 13:29:30.163	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3630363c2f6c617374757064617465643e0a
3921	1	809	14	2017-04-11 13:29:30.164	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3630393c2f6c617374757064617465643e0a
3922	1	810	14	2017-04-11 13:29:30.164	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3631323c2f6c617374757064617465643e0a
3923	1	811	14	2017-04-11 13:29:30.165	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3631363c2f6c617374757064617465643e0a
3924	1	812	14	2017-04-11 13:29:30.166	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3631393c2f6c617374757064617465643e0a
3925	1	813	14	2017-04-11 13:29:30.167	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3632323c2f6c617374757064617465643e0a
3926	1	814	14	2017-04-11 13:29:30.167	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3632353c2f6c617374757064617465643e0a
3927	1	837	14	2017-04-11 13:29:30.175	I	\N
3928	1	838	14	2017-04-11 13:29:30.177	I	\N
3929	1	839	14	2017-04-11 13:29:30.179	I	\N
3930	1	840	14	2017-04-11 13:29:30.181	I	\N
3931	1	841	14	2017-04-11 13:29:30.183	I	\N
3932	1	842	14	2017-04-11 13:29:30.185	I	\N
3933	1	843	14	2017-04-11 13:29:30.187	I	\N
3934	1	844	14	2017-04-11 13:29:30.188	I	\N
3935	1	845	14	2017-04-11 13:29:30.19	I	\N
3936	1	846	14	2017-04-11 13:29:30.192	I	\N
3937	1	847	14	2017-04-11 13:29:30.193	I	\N
3938	1	848	14	2017-04-11 13:29:30.194	I	\N
3939	1	849	14	2017-04-11 13:29:30.196	I	\N
3940	1	850	14	2017-04-11 13:29:30.197	I	\N
3941	1	851	14	2017-04-11 13:29:30.198	I	\N
3942	1	852	14	2017-04-11 13:29:30.2	I	\N
3943	1	853	14	2017-04-11 13:29:30.201	I	\N
3944	1	854	14	2017-04-11 13:29:30.203	I	\N
3945	1	855	14	2017-04-11 13:29:30.204	I	\N
3946	1	856	14	2017-04-11 13:29:30.206	I	\N
3947	1	857	14	2017-04-11 13:29:30.207	I	\N
3948	1	858	14	2017-04-11 13:29:30.209	I	\N
3949	1	859	14	2017-04-11 13:29:30.21	I	\N
3309	1	1437	211	2017-04-11 13:29:45.054	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
3310	1	1438	211	2017-04-11 13:29:45.055	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
3311	1	1439	211	2017-04-11 13:29:45.056	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
3312	1	1440	211	2017-04-11 13:29:45.057	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
3313	1	1441	211	2017-04-11 13:29:45.058	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
3314	1	1442	211	2017-04-11 13:29:45.058	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
3315	1	1443	211	2017-04-11 13:29:45.059	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
3316	1	1444	211	2017-04-11 13:29:45.06	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
3317	1	1445	211	2017-04-11 13:29:45.06	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
3318	1	1446	211	2017-04-11 13:29:45.061	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
3319	1	1447	211	2017-04-11 13:29:45.062	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
3320	1	1448	211	2017-04-11 13:29:45.062	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
3961	1	1449	211	2017-04-11 13:29:45.063	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
3962	1	1450	211	2017-04-11 13:29:45.063	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
3963	1	1451	211	2017-04-11 13:29:45.064	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
3964	1	1452	211	2017-04-11 13:29:45.065	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
3965	1	1453	211	2017-04-11 13:29:45.065	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
3966	1	1454	211	2017-04-11 13:29:45.066	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
3967	1	1455	211	2017-04-11 13:29:45.066	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
3968	1	1456	211	2017-04-11 13:29:45.067	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
3969	1	1457	211	2017-04-11 13:29:45.068	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
3970	1	1458	211	2017-04-11 13:29:45.068	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
3971	1	1459	211	2017-04-11 13:29:45.069	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3836393c2f7465737449643e0a
3972	1	1460	211	2017-04-11 13:29:45.069	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837303c2f7465737449643e0a
3973	1	1461	211	2017-04-11 13:29:45.07	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837313c2f7465737449643e0a
3974	1	1462	211	2017-04-11 13:29:45.073	I	\N
3975	1	1463	211	2017-04-11 13:29:45.076	I	\N
3976	1	1464	211	2017-04-11 13:29:45.078	I	\N
3977	1	1465	211	2017-04-11 13:29:45.08	I	\N
3978	1	1466	211	2017-04-11 13:29:45.083	I	\N
3979	1	1467	211	2017-04-11 13:29:45.085	I	\N
3980	1	1468	211	2017-04-11 13:29:45.087	I	\N
3981	1	1469	211	2017-04-11 13:29:45.089	I	\N
3982	1	1470	211	2017-04-11 13:29:45.091	I	\N
3983	1	1471	211	2017-04-11 13:29:45.093	I	\N
3984	1	1472	211	2017-04-11 13:29:45.095	I	\N
3985	1	1473	211	2017-04-11 13:29:45.096	I	\N
3986	1	1474	211	2017-04-11 13:29:45.098	I	\N
3987	1	1475	211	2017-04-11 13:29:45.1	I	\N
3988	1	1476	211	2017-04-11 13:29:45.102	I	\N
3989	1	1477	211	2017-04-11 13:29:45.104	I	\N
3990	1	1478	211	2017-04-11 13:29:45.106	I	\N
3991	1	1479	211	2017-04-11 13:29:45.108	I	\N
3992	1	1480	211	2017-04-11 13:29:45.11	I	\N
3993	1	1481	211	2017-04-11 13:29:45.112	I	\N
3994	1	1482	211	2017-04-11 13:29:45.114	I	\N
3995	1	1483	211	2017-04-11 13:29:45.116	I	\N
3996	1	1484	211	2017-04-11 13:29:45.118	I	\N
3997	1	1485	211	2017-04-11 13:29:45.121	I	\N
3998	1	1486	211	2017-04-11 13:29:45.123	I	\N
3999	1	1487	211	2017-04-11 13:29:45.125	I	\N
4000	1	129	212	2017-04-11 13:29:45.127	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
4001	1	130	212	2017-04-11 13:29:45.13	I	\N
4021	1	832	14	2017-04-11 13:30:31.008	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3737373c2f6c617374757064617465643e0a
4022	1	833	14	2017-04-11 13:30:31.01	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e37383c2f6c617374757064617465643e0a
4023	1	834	14	2017-04-11 13:30:31.011	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3738333c2f6c617374757064617465643e0a
4024	1	835	14	2017-04-11 13:30:31.013	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3738363c2f6c617374757064617465643e0a
4785	1	1539	211	2017-04-12 11:13:45.362	I	\N
4025	1	836	14	2017-04-11 13:30:31.014	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e37393c2f6c617374757064617465643e0a
4026	1	860	14	2017-04-11 13:30:31.02	I	\N
4027	1	861	14	2017-04-11 13:30:31.024	I	\N
4028	1	862	14	2017-04-11 13:30:31.027	I	\N
4029	1	863	14	2017-04-11 13:30:31.03	I	\N
4030	1	864	14	2017-04-11 13:30:31.033	I	\N
4031	1	785	14	2017-04-11 13:30:31.04	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3238353c2f6c617374757064617465643e0a
4032	1	865	14	2017-04-11 13:30:31.043	I	\N
4033	1	837	14	2017-04-11 13:30:31.05	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3137353c2f6c617374757064617465643e0a
4034	1	838	14	2017-04-11 13:30:31.052	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3137373c2f6c617374757064617465643e0a
4035	1	839	14	2017-04-11 13:30:31.053	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3137393c2f6c617374757064617465643e0a
4036	1	840	14	2017-04-11 13:30:31.054	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3138313c2f6c617374757064617465643e0a
4037	1	841	14	2017-04-11 13:30:31.055	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3138333c2f6c617374757064617465643e0a
4038	1	842	14	2017-04-11 13:30:31.056	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3138353c2f6c617374757064617465643e0a
4039	1	843	14	2017-04-11 13:30:31.057	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3138373c2f6c617374757064617465643e0a
4040	1	844	14	2017-04-11 13:30:31.058	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3138383c2f6c617374757064617465643e0a
4041	1	845	14	2017-04-11 13:30:31.06	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e31393c2f6c617374757064617465643e0a
4042	1	846	14	2017-04-11 13:30:31.061	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139323c2f6c617374757064617465643e0a
4043	1	847	14	2017-04-11 13:30:31.062	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139333c2f6c617374757064617465643e0a
4044	1	848	14	2017-04-11 13:30:31.063	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139343c2f6c617374757064617465643e0a
4045	1	849	14	2017-04-11 13:30:31.065	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139363c2f6c617374757064617465643e0a
4046	1	850	14	2017-04-11 13:30:31.066	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139373c2f6c617374757064617465643e0a
4047	1	851	14	2017-04-11 13:30:31.067	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3139383c2f6c617374757064617465643e0a
4048	1	852	14	2017-04-11 13:30:31.068	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e323c2f6c617374757064617465643e0a
4049	1	853	14	2017-04-11 13:30:31.07	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230313c2f6c617374757064617465643e0a
4050	1	854	14	2017-04-11 13:30:31.071	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230333c2f6c617374757064617465643e0a
4051	1	855	14	2017-04-11 13:30:31.072	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230343c2f6c617374757064617465643e0a
4052	1	856	14	2017-04-11 13:30:31.073	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230363c2f6c617374757064617465643e0a
4053	1	857	14	2017-04-11 13:30:31.074	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230373c2f6c617374757064617465643e0a
4054	1	858	14	2017-04-11 13:30:31.077	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e3230393c2f6c617374757064617465643e0a
4055	1	859	14	2017-04-11 13:30:31.078	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32393a33302e32313c2f6c617374757064617465643e0a
4056	1	866	14	2017-04-11 13:30:31.096	I	\N
4057	1	867	14	2017-04-11 13:30:31.099	I	\N
4058	1	868	14	2017-04-11 13:30:31.101	I	\N
4059	1	869	14	2017-04-11 13:30:31.105	I	\N
4060	1	870	14	2017-04-11 13:30:31.108	I	\N
4061	1	871	14	2017-04-11 13:30:31.11	I	\N
4062	1	872	14	2017-04-11 13:30:31.113	I	\N
4063	1	873	14	2017-04-11 13:30:31.117	I	\N
4064	1	874	14	2017-04-11 13:30:31.12	I	\N
4065	1	875	14	2017-04-11 13:30:31.123	I	\N
4066	1	876	14	2017-04-11 13:30:31.126	I	\N
4067	1	877	14	2017-04-11 13:30:31.129	I	\N
4068	1	878	14	2017-04-11 13:30:31.132	I	\N
4069	1	879	14	2017-04-11 13:30:31.135	I	\N
4070	1	880	14	2017-04-11 13:30:31.138	I	\N
4071	1	881	14	2017-04-11 13:30:31.14	I	\N
4072	1	882	14	2017-04-11 13:30:31.143	I	\N
4073	1	883	14	2017-04-11 13:30:31.146	I	\N
4074	1	884	14	2017-04-11 13:30:31.149	I	\N
4075	1	885	14	2017-04-11 13:30:31.152	I	\N
4076	1	886	14	2017-04-11 13:30:31.155	I	\N
4077	1	887	14	2017-04-11 13:30:31.158	I	\N
4078	1	888	14	2017-04-11 13:30:31.161	I	\N
4079	1	825	14	2017-04-11 13:30:31.169	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3733373c2f6c617374757064617465643e0a
4080	1	826	14	2017-04-11 13:30:31.17	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e37343c2f6c617374757064617465643e0a
4081	1	827	14	2017-04-11 13:30:31.171	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3734333c2f6c617374757064617465643e0a
4082	1	828	14	2017-04-11 13:30:31.173	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3734363c2f6c617374757064617465643e0a
4083	1	829	14	2017-04-11 13:30:31.174	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e37353c2f6c617374757064617465643e0a
4084	1	830	14	2017-04-11 13:30:31.175	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3735333c2f6c617374757064617465643e0a
4085	1	831	14	2017-04-11 13:30:31.177	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3735363c2f6c617374757064617465643e0a
4086	1	889	14	2017-04-11 13:30:31.184	I	\N
4087	1	890	14	2017-04-11 13:30:31.187	I	\N
4088	1	891	14	2017-04-11 13:30:31.19	I	\N
4089	1	892	14	2017-04-11 13:30:31.193	I	\N
4090	1	893	14	2017-04-11 13:30:31.196	I	\N
4091	1	894	14	2017-04-11 13:30:31.199	I	\N
4092	1	895	14	2017-04-11 13:30:31.202	I	\N
4786	1	1540	211	2017-04-12 11:13:45.365	I	\N
4093	1	791	14	2017-04-11 13:30:31.21	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3432373c2f6c617374757064617465643e0a
4094	1	792	14	2017-04-11 13:30:31.211	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e34333c2f6c617374757064617465643e0a
4095	1	896	14	2017-04-11 13:30:31.215	I	\N
4096	1	897	14	2017-04-11 13:30:31.218	I	\N
4097	1	815	14	2017-04-11 13:30:31.226	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3634333c2f6c617374757064617465643e0a
4098	1	816	14	2017-04-11 13:30:31.227	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3634363c2f6c617374757064617465643e0a
4099	1	817	14	2017-04-11 13:30:31.229	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e36353c2f6c617374757064617465643e0a
4100	1	818	14	2017-04-11 13:30:31.231	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3635333c2f6c617374757064617465643e0a
4101	1	898	14	2017-04-11 13:30:31.236	I	\N
4102	1	899	14	2017-04-11 13:30:31.239	I	\N
4103	1	900	14	2017-04-11 13:30:31.242	I	\N
4104	1	901	14	2017-04-11 13:30:31.246	I	\N
4105	1	824	14	2017-04-11 13:30:31.253	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3730363c2f6c617374757064617465643e0a
4106	1	902	14	2017-04-11 13:30:31.257	I	\N
4107	1	786	14	2017-04-11 13:30:31.265	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3331363c2f6c617374757064617465643e0a
4108	1	787	14	2017-04-11 13:30:31.266	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3333333c2f6c617374757064617465643e0a
4109	1	788	14	2017-04-11 13:30:31.267	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e33353c2f6c617374757064617465643e0a
4110	1	789	14	2017-04-11 13:30:31.269	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3337333c2f6c617374757064617465643e0a
4111	1	790	14	2017-04-11 13:30:31.27	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3338353c2f6c617374757064617465643e0a
4112	1	903	14	2017-04-11 13:30:31.276	I	\N
4113	1	904	14	2017-04-11 13:30:31.279	I	\N
4114	1	905	14	2017-04-11 13:30:31.283	I	\N
4115	1	906	14	2017-04-11 13:30:31.286	I	\N
4116	1	907	14	2017-04-11 13:30:31.289	I	\N
4117	1	819	14	2017-04-11 13:30:31.297	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3637333c2f6c617374757064617465643e0a
4118	1	820	14	2017-04-11 13:30:31.298	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3637363c2f6c617374757064617465643e0a
4119	1	821	14	2017-04-11 13:30:31.299	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e36383c2f6c617374757064617465643e0a
4120	1	822	14	2017-04-11 13:30:31.301	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3638333c2f6c617374757064617465643e0a
4121	1	823	14	2017-04-11 13:30:31.302	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3639353c2f6c617374757064617465643e0a
4122	1	908	14	2017-04-11 13:30:31.308	I	\N
4123	1	909	14	2017-04-11 13:30:31.312	I	\N
4124	1	910	14	2017-04-11 13:30:31.315	I	\N
4125	1	911	14	2017-04-11 13:30:31.318	I	\N
4126	1	912	14	2017-04-11 13:30:31.321	I	\N
4127	1	784	14	2017-04-11 13:30:31.33	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a32383a30312e3237343c2f6c617374757064617465643e0a
4128	1	913	14	2017-04-11 13:30:31.333	I	\N
4141	1	95	13	2017-04-11 13:42:00.104	I	\N
4142	1	873	5	2017-04-11 13:43:45.053	I	\N
4143	1	2644	32	2017-04-11 13:43:45.059	I	\N
4144	1	2645	32	2017-04-11 13:46:00.124	I	\N
4145	1	2646	32	2017-04-11 13:46:00.127	I	\N
4146	1	2647	32	2017-04-11 13:46:00.131	I	\N
4161	1	874	5	2017-04-11 14:07:30.443	I	\N
4162	1	2648	32	2017-04-11 14:07:30.456	I	\N
4163	1	2649	32	2017-04-11 14:07:30.459	I	\N
4181	1	914	14	2017-04-11 14:08:00.279	I	\N
4182	1	915	14	2017-04-11 14:08:00.286	I	\N
4164	1	903	14	2017-04-11 14:08:31.184	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3237363c2f6c617374757064617465643e0a
4165	1	904	14	2017-04-11 14:08:31.186	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3237393c2f6c617374757064617465643e0a
4166	1	905	14	2017-04-11 14:08:31.187	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3238333c2f6c617374757064617465643e0a
4167	1	906	14	2017-04-11 14:08:31.188	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3238363c2f6c617374757064617465643e0a
4168	1	907	14	2017-04-11 14:08:31.189	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3238393c2f6c617374757064617465643e0a
4169	1	916	14	2017-04-11 14:08:31.196	I	\N
4170	1	917	14	2017-04-11 14:08:31.199	I	\N
4171	1	918	14	2017-04-11 14:08:31.202	I	\N
4172	1	919	14	2017-04-11 14:08:31.205	I	\N
4173	1	920	14	2017-04-11 14:08:31.208	I	\N
4174	1	902	14	2017-04-11 14:08:31.216	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3235373c2f6c617374757064617465643e0a
4175	1	921	14	2017-04-11 14:08:31.219	I	\N
4176	1	914	14	2017-04-11 14:08:31.226	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a30302e3237393c2f6c617374757064617465643e0a
4177	1	915	14	2017-04-11 14:08:31.227	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a30302e3238363c2f6c617374757064617465643e0a
4178	1	922	14	2017-04-11 14:08:31.231	I	\N
4179	1	923	14	2017-04-11 14:08:31.234	I	\N
4180	1	866	14	2017-04-11 14:08:31.241	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3039363c2f6c617374757064617465643e0a
4201	1	867	14	2017-04-11 14:08:31.242	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3039393c2f6c617374757064617465643e0a
4202	1	868	14	2017-04-11 14:08:31.244	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3130313c2f6c617374757064617465643e0a
4203	1	869	14	2017-04-11 14:08:31.245	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3130353c2f6c617374757064617465643e0a
4204	1	870	14	2017-04-11 14:08:31.246	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3130383c2f6c617374757064617465643e0a
4205	1	871	14	2017-04-11 14:08:31.247	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e31313c2f6c617374757064617465643e0a
4422	1	1463	211	2017-04-11 14:10:15.091	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
4206	1	872	14	2017-04-11 14:08:31.248	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3131333c2f6c617374757064617465643e0a
4207	1	873	14	2017-04-11 14:08:31.25	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3131373c2f6c617374757064617465643e0a
4208	1	874	14	2017-04-11 14:08:31.251	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e31323c2f6c617374757064617465643e0a
4209	1	875	14	2017-04-11 14:08:31.252	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3132333c2f6c617374757064617465643e0a
4210	1	876	14	2017-04-11 14:08:31.253	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3132363c2f6c617374757064617465643e0a
4211	1	877	14	2017-04-11 14:08:31.254	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3132393c2f6c617374757064617465643e0a
4212	1	878	14	2017-04-11 14:08:31.255	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3133323c2f6c617374757064617465643e0a
4213	1	879	14	2017-04-11 14:08:31.257	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3133353c2f6c617374757064617465643e0a
4214	1	880	14	2017-04-11 14:08:31.258	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3133383c2f6c617374757064617465643e0a
4215	1	881	14	2017-04-11 14:08:31.259	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e31343c2f6c617374757064617465643e0a
4216	1	882	14	2017-04-11 14:08:31.26	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3134333c2f6c617374757064617465643e0a
4217	1	883	14	2017-04-11 14:08:31.262	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3134363c2f6c617374757064617465643e0a
4218	1	884	14	2017-04-11 14:08:31.263	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3134393c2f6c617374757064617465643e0a
4219	1	885	14	2017-04-11 14:08:31.264	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3135323c2f6c617374757064617465643e0a
4220	1	886	14	2017-04-11 14:08:31.265	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3135353c2f6c617374757064617465643e0a
4221	1	887	14	2017-04-11 14:08:31.266	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3135383c2f6c617374757064617465643e0a
4222	1	888	14	2017-04-11 14:08:31.268	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3136313c2f6c617374757064617465643e0a
4223	1	924	14	2017-04-11 14:08:31.285	I	\N
4224	1	925	14	2017-04-11 14:08:31.288	I	\N
4225	1	926	14	2017-04-11 14:08:31.291	I	\N
4226	1	927	14	2017-04-11 14:08:31.294	I	\N
4227	1	928	14	2017-04-11 14:08:31.297	I	\N
4228	1	929	14	2017-04-11 14:08:31.3	I	\N
4229	1	930	14	2017-04-11 14:08:31.303	I	\N
4230	1	931	14	2017-04-11 14:08:31.306	I	\N
4231	1	932	14	2017-04-11 14:08:31.308	I	\N
4232	1	933	14	2017-04-11 14:08:31.311	I	\N
4233	1	934	14	2017-04-11 14:08:31.314	I	\N
4234	1	935	14	2017-04-11 14:08:31.317	I	\N
4235	1	936	14	2017-04-11 14:08:31.32	I	\N
4236	1	937	14	2017-04-11 14:08:31.323	I	\N
4237	1	938	14	2017-04-11 14:08:31.326	I	\N
4238	1	939	14	2017-04-11 14:08:31.329	I	\N
4239	1	940	14	2017-04-11 14:08:31.332	I	\N
4240	1	941	14	2017-04-11 14:08:31.335	I	\N
4241	1	942	14	2017-04-11 14:08:31.338	I	\N
4242	1	943	14	2017-04-11 14:08:31.341	I	\N
4243	1	944	14	2017-04-11 14:08:31.344	I	\N
4244	1	945	14	2017-04-11 14:08:31.347	I	\N
4245	1	946	14	2017-04-11 14:08:31.35	I	\N
4246	1	896	14	2017-04-11 14:08:31.358	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3231353c2f6c617374757064617465643e0a
4247	1	897	14	2017-04-11 14:08:31.359	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3231383c2f6c617374757064617465643e0a
4248	1	947	14	2017-04-11 14:08:31.363	I	\N
4249	1	948	14	2017-04-11 14:08:31.366	I	\N
4250	1	865	14	2017-04-11 14:08:31.373	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3034333c2f6c617374757064617465643e0a
4251	1	949	14	2017-04-11 14:08:31.376	I	\N
4252	1	898	14	2017-04-11 14:08:31.384	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3233363c2f6c617374757064617465643e0a
4253	1	899	14	2017-04-11 14:08:31.385	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3233393c2f6c617374757064617465643e0a
4254	1	900	14	2017-04-11 14:08:31.386	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3234323c2f6c617374757064617465643e0a
4255	1	901	14	2017-04-11 14:08:31.388	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3234363c2f6c617374757064617465643e0a
4256	1	950	14	2017-04-11 14:08:31.393	I	\N
4257	1	951	14	2017-04-11 14:08:31.396	I	\N
4258	1	952	14	2017-04-11 14:08:31.399	I	\N
4259	1	953	14	2017-04-11 14:08:31.402	I	\N
4260	1	889	14	2017-04-11 14:08:31.41	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3138343c2f6c617374757064617465643e0a
4261	1	890	14	2017-04-11 14:08:31.411	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3138373c2f6c617374757064617465643e0a
4262	1	891	14	2017-04-11 14:08:31.413	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e31393c2f6c617374757064617465643e0a
4263	1	892	14	2017-04-11 14:08:31.415	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3139333c2f6c617374757064617465643e0a
4264	1	893	14	2017-04-11 14:08:31.416	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3139363c2f6c617374757064617465643e0a
4265	1	894	14	2017-04-11 14:08:31.417	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3139393c2f6c617374757064617465643e0a
4266	1	895	14	2017-04-11 14:08:31.419	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3230323c2f6c617374757064617465643e0a
4267	1	954	14	2017-04-11 14:08:31.426	I	\N
4268	1	955	14	2017-04-11 14:08:31.429	I	\N
4269	1	956	14	2017-04-11 14:08:31.432	I	\N
4270	1	957	14	2017-04-11 14:08:31.436	I	\N
4271	1	958	14	2017-04-11 14:08:31.439	I	\N
4272	1	959	14	2017-04-11 14:08:31.442	I	\N
4273	1	960	14	2017-04-11 14:08:31.445	I	\N
4274	1	908	14	2017-04-11 14:08:31.453	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3330383c2f6c617374757064617465643e0a
4275	1	909	14	2017-04-11 14:08:31.455	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3331323c2f6c617374757064617465643e0a
4276	1	910	14	2017-04-11 14:08:31.456	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3331353c2f6c617374757064617465643e0a
4277	1	911	14	2017-04-11 14:08:31.457	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3331383c2f6c617374757064617465643e0a
4278	1	912	14	2017-04-11 14:08:31.459	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3332313c2f6c617374757064617465643e0a
4279	1	961	14	2017-04-11 14:08:31.465	I	\N
4280	1	962	14	2017-04-11 14:08:31.468	I	\N
4281	1	963	14	2017-04-11 14:08:31.471	I	\N
4282	1	964	14	2017-04-11 14:08:31.475	I	\N
4283	1	965	14	2017-04-11 14:08:31.478	I	\N
4284	1	913	14	2017-04-11 14:08:31.486	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3333333c2f6c617374757064617465643e0a
4285	1	966	14	2017-04-11 14:08:31.489	I	\N
4286	1	860	14	2017-04-11 14:08:31.497	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e30323c2f6c617374757064617465643e0a
4287	1	861	14	2017-04-11 14:08:31.499	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3032343c2f6c617374757064617465643e0a
4288	1	862	14	2017-04-11 14:08:31.5	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3032373c2f6c617374757064617465643e0a
4289	1	863	14	2017-04-11 14:08:31.501	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e30333c2f6c617374757064617465643e0a
4290	1	864	14	2017-04-11 14:08:31.503	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031333a33303a33312e3033333c2f6c617374757064617465643e0a
4291	1	967	14	2017-04-11 14:08:31.509	I	\N
4292	1	968	14	2017-04-11 14:08:31.512	I	\N
4293	1	969	14	2017-04-11 14:08:31.516	I	\N
4294	1	970	14	2017-04-11 14:08:31.519	I	\N
4295	1	971	14	2017-04-11 14:08:31.523	I	\N
4301	1	967	14	2017-04-11 14:08:46.042	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3530393c2f6c617374757064617465643e0a
4302	1	968	14	2017-04-11 14:08:46.044	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3531323c2f6c617374757064617465643e0a
4303	1	969	14	2017-04-11 14:08:46.045	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3531363c2f6c617374757064617465643e0a
4304	1	970	14	2017-04-11 14:08:46.046	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3531393c2f6c617374757064617465643e0a
4305	1	971	14	2017-04-11 14:08:46.047	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3532333c2f6c617374757064617465643e0a
4306	1	972	14	2017-04-11 14:08:46.054	I	\N
4307	1	973	14	2017-04-11 14:08:46.057	I	\N
4308	1	974	14	2017-04-11 14:08:46.06	I	\N
4309	1	975	14	2017-04-11 14:08:46.063	I	\N
4310	1	976	14	2017-04-11 14:08:46.067	I	\N
4311	1	961	14	2017-04-11 14:08:46.074	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3436353c2f6c617374757064617465643e0a
4312	1	962	14	2017-04-11 14:08:46.075	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3436383c2f6c617374757064617465643e0a
4313	1	963	14	2017-04-11 14:08:46.077	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3437313c2f6c617374757064617465643e0a
4314	1	964	14	2017-04-11 14:08:46.078	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3437353c2f6c617374757064617465643e0a
4315	1	965	14	2017-04-11 14:08:46.079	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3437383c2f6c617374757064617465643e0a
4316	1	977	14	2017-04-11 14:08:46.085	I	\N
4317	1	978	14	2017-04-11 14:08:46.088	I	\N
4318	1	979	14	2017-04-11 14:08:46.09	I	\N
4319	1	980	14	2017-04-11 14:08:46.093	I	\N
4320	1	981	14	2017-04-11 14:08:46.096	I	\N
4321	1	916	14	2017-04-11 14:08:46.104	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3139363c2f6c617374757064617465643e0a
4322	1	917	14	2017-04-11 14:08:46.105	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3139393c2f6c617374757064617465643e0a
4323	1	918	14	2017-04-11 14:08:46.106	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3230323c2f6c617374757064617465643e0a
4324	1	919	14	2017-04-11 14:08:46.108	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3230353c2f6c617374757064617465643e0a
4325	1	920	14	2017-04-11 14:08:46.109	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3230383c2f6c617374757064617465643e0a
4326	1	982	14	2017-04-11 14:08:46.114	I	\N
4327	1	983	14	2017-04-11 14:08:46.117	I	\N
4328	1	984	14	2017-04-11 14:08:46.12	I	\N
4329	1	985	14	2017-04-11 14:08:46.123	I	\N
4330	1	986	14	2017-04-11 14:08:46.125	I	\N
4331	1	947	14	2017-04-11 14:08:46.133	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3336333c2f6c617374757064617465643e0a
4332	1	948	14	2017-04-11 14:08:46.134	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3336363c2f6c617374757064617465643e0a
4333	1	987	14	2017-04-11 14:08:46.138	I	\N
4334	1	988	14	2017-04-11 14:08:46.141	I	\N
4335	1	922	14	2017-04-11 14:08:46.148	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3233313c2f6c617374757064617465643e0a
4336	1	923	14	2017-04-11 14:08:46.153	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3233343c2f6c617374757064617465643e0a
4337	1	989	14	2017-04-11 14:08:46.156	I	\N
4338	1	990	14	2017-04-11 14:08:46.159	I	\N
4339	1	924	14	2017-04-11 14:08:46.166	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3238353c2f6c617374757064617465643e0a
4340	1	925	14	2017-04-11 14:08:46.168	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3238383c2f6c617374757064617465643e0a
4341	1	926	14	2017-04-11 14:08:46.169	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3239313c2f6c617374757064617465643e0a
4342	1	927	14	2017-04-11 14:08:46.17	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3239343c2f6c617374757064617465643e0a
4343	1	928	14	2017-04-11 14:08:46.171	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3239373c2f6c617374757064617465643e0a
4344	1	929	14	2017-04-11 14:08:46.172	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e333c2f6c617374757064617465643e0a
4526	1	73	155	2017-04-11 14:36:51.083	I	\N
4345	1	930	14	2017-04-11 14:08:46.174	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3330333c2f6c617374757064617465643e0a
4346	1	931	14	2017-04-11 14:08:46.175	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3330363c2f6c617374757064617465643e0a
4347	1	932	14	2017-04-11 14:08:46.176	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3330383c2f6c617374757064617465643e0a
4348	1	933	14	2017-04-11 14:08:46.178	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3331313c2f6c617374757064617465643e0a
4349	1	934	14	2017-04-11 14:08:46.179	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3331343c2f6c617374757064617465643e0a
4350	1	935	14	2017-04-11 14:08:46.18	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3331373c2f6c617374757064617465643e0a
4351	1	936	14	2017-04-11 14:08:46.181	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e33323c2f6c617374757064617465643e0a
4352	1	937	14	2017-04-11 14:08:46.182	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3332333c2f6c617374757064617465643e0a
4353	1	938	14	2017-04-11 14:08:46.184	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3332363c2f6c617374757064617465643e0a
4354	1	939	14	2017-04-11 14:08:46.185	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3332393c2f6c617374757064617465643e0a
4355	1	940	14	2017-04-11 14:08:46.186	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3333323c2f6c617374757064617465643e0a
4356	1	941	14	2017-04-11 14:08:46.187	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3333353c2f6c617374757064617465643e0a
4357	1	942	14	2017-04-11 14:08:46.189	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3333383c2f6c617374757064617465643e0a
4358	1	943	14	2017-04-11 14:08:46.19	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3334313c2f6c617374757064617465643e0a
4359	1	944	14	2017-04-11 14:08:46.191	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3334343c2f6c617374757064617465643e0a
4360	1	945	14	2017-04-11 14:08:46.192	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3334373c2f6c617374757064617465643e0a
4361	1	946	14	2017-04-11 14:08:46.194	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e33353c2f6c617374757064617465643e0a
4362	1	991	14	2017-04-11 14:08:46.212	I	\N
4363	1	992	14	2017-04-11 14:08:46.215	I	\N
4364	1	993	14	2017-04-11 14:08:46.218	I	\N
4365	1	994	14	2017-04-11 14:08:46.221	I	\N
4366	1	995	14	2017-04-11 14:08:46.224	I	\N
4367	1	996	14	2017-04-11 14:08:46.227	I	\N
4368	1	997	14	2017-04-11 14:08:46.23	I	\N
4369	1	998	14	2017-04-11 14:08:46.233	I	\N
4370	1	999	14	2017-04-11 14:08:46.236	I	\N
4371	1	1000	14	2017-04-11 14:08:46.239	I	\N
4372	1	1001	14	2017-04-11 14:08:46.242	I	\N
4373	1	1002	14	2017-04-11 14:08:46.245	I	\N
4374	1	1003	14	2017-04-11 14:08:46.249	I	\N
4375	1	1004	14	2017-04-11 14:08:46.252	I	\N
4376	1	1005	14	2017-04-11 14:08:46.255	I	\N
4377	1	1006	14	2017-04-11 14:08:46.258	I	\N
4378	1	1007	14	2017-04-11 14:08:46.261	I	\N
4379	1	1008	14	2017-04-11 14:08:46.264	I	\N
4380	1	1009	14	2017-04-11 14:08:46.268	I	\N
4381	1	1010	14	2017-04-11 14:08:46.271	I	\N
4382	1	1011	14	2017-04-11 14:08:46.274	I	\N
4383	1	1012	14	2017-04-11 14:08:46.277	I	\N
4384	1	1013	14	2017-04-11 14:08:46.28	I	\N
4385	1	950	14	2017-04-11 14:08:46.288	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3339333c2f6c617374757064617465643e0a
4386	1	951	14	2017-04-11 14:08:46.289	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3339363c2f6c617374757064617465643e0a
4387	1	952	14	2017-04-11 14:08:46.291	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3339393c2f6c617374757064617465643e0a
4388	1	953	14	2017-04-11 14:08:46.292	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3430323c2f6c617374757064617465643e0a
4389	1	1014	14	2017-04-11 14:08:46.297	I	\N
4390	1	1015	14	2017-04-11 14:08:46.301	I	\N
4391	1	1016	14	2017-04-11 14:08:46.304	I	\N
4392	1	1017	14	2017-04-11 14:08:46.307	I	\N
4393	1	966	14	2017-04-11 14:08:46.315	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3438393c2f6c617374757064617465643e0a
4394	1	1018	14	2017-04-11 14:08:46.318	I	\N
4395	1	954	14	2017-04-11 14:08:46.326	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3432363c2f6c617374757064617465643e0a
4396	1	955	14	2017-04-11 14:08:46.328	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3432393c2f6c617374757064617465643e0a
4397	1	956	14	2017-04-11 14:08:46.329	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3433323c2f6c617374757064617465643e0a
4398	1	957	14	2017-04-11 14:08:46.331	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3433363c2f6c617374757064617465643e0a
4399	1	958	14	2017-04-11 14:08:46.332	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3433393c2f6c617374757064617465643e0a
4400	1	959	14	2017-04-11 14:08:46.333	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3434323c2f6c617374757064617465643e0a
4401	1	960	14	2017-04-11 14:08:46.335	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3434353c2f6c617374757064617465643e0a
4402	1	1019	14	2017-04-11 14:08:46.343	I	\N
4403	1	1020	14	2017-04-11 14:08:46.346	I	\N
4404	1	1021	14	2017-04-11 14:08:46.349	I	\N
4405	1	1022	14	2017-04-11 14:08:46.353	I	\N
4406	1	1023	14	2017-04-11 14:08:46.356	I	\N
4407	1	1024	14	2017-04-11 14:08:46.359	I	\N
4408	1	1025	14	2017-04-11 14:08:46.362	I	\N
4409	1	921	14	2017-04-11 14:08:46.371	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3231393c2f6c617374757064617465643e0a
4410	1	1026	14	2017-04-11 14:08:46.374	I	\N
4411	1	949	14	2017-04-11 14:08:46.382	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a33312e3337363c2f6c617374757064617465643e0a
4412	1	1027	14	2017-04-11 14:08:46.385	I	\N
4421	1	1462	211	2017-04-11 14:10:15.09	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
4527	1	35	1	2017-04-11 14:36:51.09	U	\\x3c73746174757349643e313c2f73746174757349643e0a
4423	1	1464	211	2017-04-11 14:10:15.092	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
4424	1	1465	211	2017-04-11 14:10:15.093	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
4425	1	1466	211	2017-04-11 14:10:15.094	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
4426	1	1467	211	2017-04-11 14:10:15.095	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
4427	1	1468	211	2017-04-11 14:10:15.095	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
4428	1	1469	211	2017-04-11 14:10:15.096	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
4429	1	1470	211	2017-04-11 14:10:15.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
4430	1	1471	211	2017-04-11 14:10:15.097	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
4431	1	1472	211	2017-04-11 14:10:15.098	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
4432	1	1473	211	2017-04-11 14:10:15.099	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
4433	1	1474	211	2017-04-11 14:10:15.099	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
4434	1	1475	211	2017-04-11 14:10:15.1	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
4435	1	1476	211	2017-04-11 14:10:15.1	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
4436	1	1477	211	2017-04-11 14:10:15.101	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
4437	1	1478	211	2017-04-11 14:10:15.101	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
4438	1	1479	211	2017-04-11 14:10:15.102	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
4439	1	1480	211	2017-04-11 14:10:15.103	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
4440	1	1481	211	2017-04-11 14:10:15.103	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830373c2f7465737449643e0a
4441	1	1482	211	2017-04-11 14:10:15.104	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
4442	1	1483	211	2017-04-11 14:10:15.104	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
4443	1	1484	211	2017-04-11 14:10:15.105	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3836393c2f7465737449643e0a
4444	1	1485	211	2017-04-11 14:10:15.106	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837303c2f7465737449643e0a
4445	1	1486	211	2017-04-11 14:10:15.106	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837313c2f7465737449643e0a
4446	1	1487	211	2017-04-11 14:10:15.107	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837323c2f7465737449643e0a
4447	1	1488	211	2017-04-11 14:10:15.11	I	\N
4448	1	1489	211	2017-04-11 14:10:15.113	I	\N
4449	1	1490	211	2017-04-11 14:10:15.115	I	\N
4450	1	1491	211	2017-04-11 14:10:15.118	I	\N
4451	1	1492	211	2017-04-11 14:10:15.121	I	\N
4452	1	1493	211	2017-04-11 14:10:15.124	I	\N
4453	1	1494	211	2017-04-11 14:10:15.126	I	\N
4454	1	1495	211	2017-04-11 14:10:15.128	I	\N
4455	1	1496	211	2017-04-11 14:10:15.13	I	\N
4456	1	1497	211	2017-04-11 14:10:15.132	I	\N
4457	1	1498	211	2017-04-11 14:10:15.134	I	\N
4458	1	1499	211	2017-04-11 14:10:15.135	I	\N
4459	1	1500	211	2017-04-11 14:10:15.137	I	\N
4460	1	1501	211	2017-04-11 14:10:15.139	I	\N
4461	1	1502	211	2017-04-11 14:10:15.143	I	\N
4462	1	1503	211	2017-04-11 14:10:15.145	I	\N
4463	1	1504	211	2017-04-11 14:10:15.147	I	\N
4464	1	1505	211	2017-04-11 14:10:15.149	I	\N
4465	1	1506	211	2017-04-11 14:10:15.151	I	\N
4466	1	1507	211	2017-04-11 14:10:15.153	I	\N
4467	1	1508	211	2017-04-11 14:10:15.155	I	\N
4468	1	1509	211	2017-04-11 14:10:15.157	I	\N
4469	1	1510	211	2017-04-11 14:10:15.16	I	\N
4470	1	1511	211	2017-04-11 14:10:15.162	I	\N
4471	1	1512	211	2017-04-11 14:10:15.164	I	\N
4472	1	1513	211	2017-04-11 14:10:15.167	I	\N
4473	1	1514	211	2017-04-11 14:10:15.169	I	\N
4474	1	130	212	2017-04-11 14:10:15.171	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
4475	1	131	212	2017-04-11 14:10:15.174	I	\N
4476	1	132	212	2017-04-11 14:10:15.177	I	\N
4481	1	33	1	2017-04-11 14:10:30.27	I	\N
4482	1	50	23	2017-04-11 14:10:30.277	I	\N
4483	1	475	4	2017-04-11 14:10:30.283	I	\N
4484	1	476	4	2017-04-11 14:10:30.286	I	\N
4485	1	33	45	2017-04-11 14:10:30.288	I	\N
4486	1	76	21	2017-04-11 14:10:48.448	I	\N
4487	1	70	155	2017-04-11 14:10:48.451	I	\N
4488	1	77	21	2017-04-11 14:10:48.452	I	\N
4489	1	71	155	2017-04-11 14:10:48.453	I	\N
4490	1	33	1	2017-04-11 14:10:48.461	U	\\x3c73746174757349643e313c2f73746174757349643e0a
4491	1	476	4	2017-04-11 14:10:55.793	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
4492	1	475	4	2017-04-11 14:10:55.795	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
4493	1	33	1	2017-04-11 14:10:55.8	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
4501	1	100	36	2017-04-11 14:26:15.079	I	\N
4521	1	34	1	2017-04-11 14:35:45.11	I	\N
4522	1	51	23	2017-04-11 14:35:45.112	I	\N
4523	1	477	4	2017-04-11 14:35:45.115	I	\N
4524	1	34	45	2017-04-11 14:35:45.117	I	\N
4541	1	78	21	2017-04-11 14:36:21.949	I	\N
4542	1	72	155	2017-04-11 14:36:21.952	I	\N
4543	1	34	1	2017-04-11 14:36:21.959	U	\\x3c73746174757349643e313c2f73746174757349643e0a
4544	1	35	1	2017-04-11 14:36:30.117	I	\N
4545	1	52	23	2017-04-11 14:36:30.119	I	\N
4546	1	478	4	2017-04-11 14:36:30.123	I	\N
4547	1	35	45	2017-04-11 14:36:30.125	I	\N
4548	1	477	4	2017-04-11 14:36:44.656	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
4549	1	34	1	2017-04-11 14:36:44.673	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
4525	1	79	21	2017-04-11 14:36:51.081	I	\N
4561	1	478	4	2017-04-11 14:36:56.856	U	\\x3c72656c6561736564446174653e3c2f72656c6561736564446174653e0a3c72656c656173656444617465466f72446973706c61793e3c2f72656c656173656444617465466f72446973706c61793e0a3c73746174757349643e31363c2f73746174757349643e0a
4562	1	35	1	2017-04-11 14:36:56.862	U	\\x3c616363657373696f6e4e756d6265723e3c2f616363657373696f6e4e756d6265723e0a3c646f6d61696e3e3c2f646f6d61696e3e0a3c656e7465726564446174653e3c2f656e7465726564446174653e0a3c656e746572656444617465466f72446973706c61793e3c2f656e746572656444617465466f72446973706c61793e0a3c726563656976656454696d657374616d703e3c2f726563656976656454696d657374616d703e0a3c726563656976656444617465466f72446973706c61793e3c2f726563656976656444617465466f72446973706c61793e0a3c726563656976656454696d65466f72446973706c61793e3c2f726563656976656454696d65466f72446973706c61793e0a3c70617469656e743e3c2f70617469656e743e0a3c757569643e3c2f757569643e0a3c73746174757349643e3c2f73746174757349643e0a3c73616d706c65536f757263653e3c2f73616d706c65536f757263653e0a3c6c617374757064617465643e3c2f6c617374757064617465643e0a
4581	1	58	208	2017-04-11 15:37:14.714	I	\N
4601	1	23	184	2017-04-11 15:47:45.065	U	\\x3c76616c75653e4a616e20537761737468796120536168796f673c2f76616c75653e0a
4602	1	12	184	2017-04-11 15:47:55.437	U	\\x3c76616c75653e596f6c65747465204672616e636f69733c2f76616c75653e0a
4621	1	59	208	2017-04-11 15:48:05.358	I	\N
4641	1	60	208	2017-04-11 15:48:51.947	I	\N
4661	1	61	208	2017-04-11 15:59:42.745	I	\N
4681	1	36	1	2017-04-11 18:26:37.197	I	\N
4682	1	53	23	2017-04-11 18:26:37.208	I	\N
4683	1	479	4	2017-04-11 18:26:37.22	I	\N
4684	1	36	45	2017-04-11 18:26:37.225	I	\N
4701	1	80	21	2017-04-11 18:27:20.169	I	\N
4702	1	74	155	2017-04-11 18:27:20.174	I	\N
4703	1	36	1	2017-04-11 18:27:20.192	U	\\x3c73746174757349643e313c2f73746174757349643e0a
4704	1	62	208	2017-04-11 18:27:38.486	I	\N
4721	1	1344	211	2017-04-12 11:13:45.157	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832343c2f7465737449643e0a
4722	1	1345	211	2017-04-12 11:13:45.173	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832353c2f7465737449643e0a
4723	1	1346	211	2017-04-12 11:13:45.176	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832363c2f7465737449643e0a
4724	1	1347	211	2017-04-12 11:13:45.181	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832373c2f7465737449643e0a
4725	1	1348	211	2017-04-12 11:13:45.182	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832383c2f7465737449643e0a
4726	1	1349	211	2017-04-12 11:13:45.183	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832393c2f7465737449643e0a
4727	1	1350	211	2017-04-12 11:13:45.184	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833303c2f7465737449643e0a
4728	1	1351	211	2017-04-12 11:13:45.19	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833313c2f7465737449643e0a
4729	1	1352	211	2017-04-12 11:13:45.191	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833323c2f7465737449643e0a
4730	1	1353	211	2017-04-12 11:13:45.192	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833333c2f7465737449643e0a
4731	1	1354	211	2017-04-12 11:13:45.193	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833343c2f7465737449643e0a
4732	1	1355	211	2017-04-12 11:13:45.196	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833353c2f7465737449643e0a
4733	1	1356	211	2017-04-12 11:13:45.199	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833363c2f7465737449643e0a
4734	1	1357	211	2017-04-12 11:13:45.2	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833373c2f7465737449643e0a
4735	1	1358	211	2017-04-12 11:13:45.201	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833383c2f7465737449643e0a
4736	1	1359	211	2017-04-12 11:13:45.202	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833393c2f7465737449643e0a
4737	1	1360	211	2017-04-12 11:13:45.203	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834303c2f7465737449643e0a
4738	1	1361	211	2017-04-12 11:13:45.204	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834313c2f7465737449643e0a
4739	1	1362	211	2017-04-12 11:13:45.206	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834323c2f7465737449643e0a
4740	1	1363	211	2017-04-12 11:13:45.208	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834333c2f7465737449643e0a
4741	1	1364	211	2017-04-12 11:13:45.209	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834343c2f7465737449643e0a
4742	1	1365	211	2017-04-12 11:13:45.21	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3831313c2f7465737449643e0a
4743	1	1366	211	2017-04-12 11:13:45.21	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834353c2f7465737449643e0a
4744	1	1367	211	2017-04-12 11:13:45.212	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834363c2f7465737449643e0a
4745	1	1368	211	2017-04-12 11:13:45.213	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834373c2f7465737449643e0a
4746	1	1369	211	2017-04-12 11:13:45.224	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834383c2f7465737449643e0a
4747	1	1370	211	2017-04-12 11:13:45.225	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834393c2f7465737449643e0a
4748	1	1371	211	2017-04-12 11:13:45.23	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835303c2f7465737449643e0a
4749	1	1372	211	2017-04-12 11:13:45.231	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835313c2f7465737449643e0a
4750	1	1373	211	2017-04-12 11:13:45.232	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835323c2f7465737449643e0a
4751	1	1374	211	2017-04-12 11:13:45.232	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835333c2f7465737449643e0a
4752	1	1375	211	2017-04-12 11:13:45.234	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835343c2f7465737449643e0a
4753	1	1376	211	2017-04-12 11:13:45.234	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835353c2f7465737449643e0a
4754	1	1377	211	2017-04-12 11:13:45.235	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835363c2f7465737449643e0a
4755	1	1378	211	2017-04-12 11:13:45.236	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835373c2f7465737449643e0a
4756	1	1379	211	2017-04-12 11:13:45.237	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835383c2f7465737449643e0a
4757	1	1380	211	2017-04-12 11:13:45.243	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835393c2f7465737449643e0a
4758	1	1381	211	2017-04-12 11:13:45.244	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836303c2f7465737449643e0a
4759	1	1382	211	2017-04-12 11:13:45.245	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836313c2f7465737449643e0a
4760	1	1383	211	2017-04-12 11:13:45.245	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836323c2f7465737449643e0a
4761	1	1515	211	2017-04-12 11:13:45.251	I	\N
4762	1	1516	211	2017-04-12 11:13:45.26	I	\N
4763	1	1517	211	2017-04-12 11:13:45.263	I	\N
4764	1	1518	211	2017-04-12 11:13:45.268	I	\N
4765	1	1519	211	2017-04-12 11:13:45.271	I	\N
4766	1	1520	211	2017-04-12 11:13:45.28	I	\N
4767	1	1521	211	2017-04-12 11:13:45.283	I	\N
4768	1	1522	211	2017-04-12 11:13:45.286	I	\N
4769	1	1523	211	2017-04-12 11:13:45.288	I	\N
4770	1	1524	211	2017-04-12 11:13:45.297	I	\N
4771	1	1525	211	2017-04-12 11:13:45.3	I	\N
4772	1	1526	211	2017-04-12 11:13:45.304	I	\N
4773	1	1527	211	2017-04-12 11:13:45.312	I	\N
4774	1	1528	211	2017-04-12 11:13:45.315	I	\N
4775	1	1529	211	2017-04-12 11:13:45.317	I	\N
4776	1	1530	211	2017-04-12 11:13:45.32	I	\N
4777	1	1531	211	2017-04-12 11:13:45.324	I	\N
4778	1	1532	211	2017-04-12 11:13:45.331	I	\N
4779	1	1533	211	2017-04-12 11:13:45.334	I	\N
4780	1	1534	211	2017-04-12 11:13:45.342	I	\N
4781	1	1535	211	2017-04-12 11:13:45.345	I	\N
4782	1	1536	211	2017-04-12 11:13:45.347	I	\N
4788	1	1542	211	2017-04-12 11:13:45.371	I	\N
4789	1	1543	211	2017-04-12 11:13:45.376	I	\N
4790	1	1544	211	2017-04-12 11:13:45.379	I	\N
4791	1	1545	211	2017-04-12 11:13:45.382	I	\N
4792	1	1546	211	2017-04-12 11:13:45.385	I	\N
4793	1	1547	211	2017-04-12 11:13:45.387	I	\N
4794	1	1548	211	2017-04-12 11:13:45.39	I	\N
4795	1	1549	211	2017-04-12 11:13:45.393	I	\N
4796	1	1550	211	2017-04-12 11:13:45.396	I	\N
4797	1	1551	211	2017-04-12 11:13:45.401	I	\N
4798	1	1552	211	2017-04-12 11:13:45.404	I	\N
4799	1	1553	211	2017-04-12 11:13:45.41	I	\N
4800	1	120	212	2017-04-12 11:13:45.413	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38383c2f70616e656c49643e0a
4801	1	121	212	2017-04-12 11:13:45.415	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38393c2f70616e656c49643e0a
4802	1	122	212	2017-04-12 11:13:45.416	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39303c2f70616e656c49643e0a
4803	1	123	212	2017-04-12 11:13:45.418	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39313c2f70616e656c49643e0a
4804	1	124	212	2017-04-12 11:13:45.419	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39323c2f70616e656c49643e0a
4805	1	133	212	2017-04-12 11:13:45.426	I	\N
4806	1	134	212	2017-04-12 11:13:45.429	I	\N
4807	1	135	212	2017-04-12 11:13:45.433	I	\N
4808	1	136	212	2017-04-12 11:13:45.436	I	\N
4809	1	137	212	2017-04-12 11:13:45.44	I	\N
4821	1	977	14	2017-04-12 11:14:16.108	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3038353c2f6c617374757064617465643e0a
4822	1	978	14	2017-04-12 11:14:16.11	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3038383c2f6c617374757064617465643e0a
4823	1	979	14	2017-04-12 11:14:16.111	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e30393c2f6c617374757064617465643e0a
4824	1	980	14	2017-04-12 11:14:16.112	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3039333c2f6c617374757064617465643e0a
4825	1	981	14	2017-04-12 11:14:16.113	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3039363c2f6c617374757064617465643e0a
4826	1	1028	14	2017-04-12 11:14:16.123	I	\N
4827	1	1029	14	2017-04-12 11:14:16.126	I	\N
4828	1	1030	14	2017-04-12 11:14:16.129	I	\N
4829	1	1031	14	2017-04-12 11:14:16.132	I	\N
4830	1	1032	14	2017-04-12 11:14:16.135	I	\N
4831	1	1026	14	2017-04-12 11:14:16.143	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3337343c2f6c617374757064617465643e0a
4832	1	1033	14	2017-04-12 11:14:16.145	I	\N
4833	1	982	14	2017-04-12 11:14:16.152	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3131343c2f6c617374757064617465643e0a
4834	1	983	14	2017-04-12 11:14:16.153	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3131373c2f6c617374757064617465643e0a
4835	1	984	14	2017-04-12 11:14:16.154	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e31323c2f6c617374757064617465643e0a
4836	1	985	14	2017-04-12 11:14:16.156	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3132333c2f6c617374757064617465643e0a
4837	1	986	14	2017-04-12 11:14:16.157	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3132353c2f6c617374757064617465643e0a
4838	1	1034	14	2017-04-12 11:14:16.162	I	\N
4839	1	1035	14	2017-04-12 11:14:16.165	I	\N
4840	1	1036	14	2017-04-12 11:14:16.168	I	\N
4841	1	1037	14	2017-04-12 11:14:16.171	I	\N
4842	1	1038	14	2017-04-12 11:14:16.173	I	\N
4843	1	991	14	2017-04-12 11:14:16.181	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3231323c2f6c617374757064617465643e0a
4844	1	992	14	2017-04-12 11:14:16.182	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3231353c2f6c617374757064617465643e0a
4845	1	993	14	2017-04-12 11:14:16.183	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3231383c2f6c617374757064617465643e0a
4846	1	994	14	2017-04-12 11:14:16.184	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3232313c2f6c617374757064617465643e0a
4847	1	995	14	2017-04-12 11:14:16.185	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3232343c2f6c617374757064617465643e0a
4848	1	996	14	2017-04-12 11:14:16.187	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3232373c2f6c617374757064617465643e0a
4849	1	997	14	2017-04-12 11:14:16.188	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e32333c2f6c617374757064617465643e0a
4850	1	998	14	2017-04-12 11:14:16.189	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3233333c2f6c617374757064617465643e0a
4851	1	999	14	2017-04-12 11:14:16.19	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3233363c2f6c617374757064617465643e0a
4852	1	1000	14	2017-04-12 11:14:16.191	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3233393c2f6c617374757064617465643e0a
4853	1	1001	14	2017-04-12 11:14:16.192	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3234323c2f6c617374757064617465643e0a
4854	1	1002	14	2017-04-12 11:14:16.194	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3234353c2f6c617374757064617465643e0a
4855	1	1003	14	2017-04-12 11:14:16.195	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3234393c2f6c617374757064617465643e0a
4856	1	1004	14	2017-04-12 11:14:16.196	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3235323c2f6c617374757064617465643e0a
4857	1	1005	14	2017-04-12 11:14:16.197	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3235353c2f6c617374757064617465643e0a
4858	1	1006	14	2017-04-12 11:14:16.198	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3235383c2f6c617374757064617465643e0a
4859	1	1007	14	2017-04-12 11:14:16.2	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3236313c2f6c617374757064617465643e0a
4860	1	1008	14	2017-04-12 11:14:16.201	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3236343c2f6c617374757064617465643e0a
4861	1	1009	14	2017-04-12 11:14:16.202	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3236383c2f6c617374757064617465643e0a
4862	1	1010	14	2017-04-12 11:14:16.203	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3237313c2f6c617374757064617465643e0a
4863	1	1011	14	2017-04-12 11:14:16.204	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3237343c2f6c617374757064617465643e0a
4982	1	75	155	2017-04-12 11:26:47.143	I	\N
4864	1	1012	14	2017-04-12 11:14:16.205	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3237373c2f6c617374757064617465643e0a
4865	1	1013	14	2017-04-12 11:14:16.207	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e32383c2f6c617374757064617465643e0a
4866	1	1039	14	2017-04-12 11:14:16.223	I	\N
4867	1	1040	14	2017-04-12 11:14:16.226	I	\N
4868	1	1041	14	2017-04-12 11:14:16.229	I	\N
4869	1	1042	14	2017-04-12 11:14:16.232	I	\N
4870	1	1043	14	2017-04-12 11:14:16.234	I	\N
4871	1	1044	14	2017-04-12 11:14:16.237	I	\N
4872	1	1045	14	2017-04-12 11:14:16.24	I	\N
4873	1	1046	14	2017-04-12 11:14:16.242	I	\N
4874	1	1047	14	2017-04-12 11:14:16.245	I	\N
4875	1	1048	14	2017-04-12 11:14:16.248	I	\N
4876	1	1049	14	2017-04-12 11:14:16.25	I	\N
4877	1	1050	14	2017-04-12 11:14:16.253	I	\N
4878	1	1051	14	2017-04-12 11:14:16.256	I	\N
4879	1	1052	14	2017-04-12 11:14:16.259	I	\N
4880	1	1053	14	2017-04-12 11:14:16.262	I	\N
4881	1	1054	14	2017-04-12 11:14:16.265	I	\N
4882	1	1055	14	2017-04-12 11:14:16.268	I	\N
4883	1	1056	14	2017-04-12 11:14:16.271	I	\N
4884	1	1057	14	2017-04-12 11:14:16.273	I	\N
4885	1	1058	14	2017-04-12 11:14:16.276	I	\N
4886	1	1059	14	2017-04-12 11:14:16.279	I	\N
4887	1	1060	14	2017-04-12 11:14:16.282	I	\N
4888	1	1061	14	2017-04-12 11:14:16.285	I	\N
4889	1	1018	14	2017-04-12 11:14:16.292	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3331383c2f6c617374757064617465643e0a
4890	1	1062	14	2017-04-12 11:14:16.295	I	\N
4891	1	1019	14	2017-04-12 11:14:16.303	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3334333c2f6c617374757064617465643e0a
4892	1	1020	14	2017-04-12 11:14:16.304	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3334363c2f6c617374757064617465643e0a
4893	1	1021	14	2017-04-12 11:14:16.305	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3334393c2f6c617374757064617465643e0a
4894	1	1022	14	2017-04-12 11:14:16.306	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3335333c2f6c617374757064617465643e0a
4895	1	1023	14	2017-04-12 11:14:16.308	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3335363c2f6c617374757064617465643e0a
4896	1	1024	14	2017-04-12 11:14:16.309	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3335393c2f6c617374757064617465643e0a
4897	1	1025	14	2017-04-12 11:14:16.31	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3336323c2f6c617374757064617465643e0a
4898	1	1063	14	2017-04-12 11:14:16.317	I	\N
4899	1	1064	14	2017-04-12 11:14:16.32	I	\N
4900	1	1065	14	2017-04-12 11:14:16.323	I	\N
4901	1	1066	14	2017-04-12 11:14:16.326	I	\N
4902	1	1067	14	2017-04-12 11:14:16.329	I	\N
4903	1	1068	14	2017-04-12 11:14:16.332	I	\N
4904	1	1069	14	2017-04-12 11:14:16.334	I	\N
4905	1	972	14	2017-04-12 11:14:16.342	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3035343c2f6c617374757064617465643e0a
4906	1	973	14	2017-04-12 11:14:16.343	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3035373c2f6c617374757064617465643e0a
4907	1	974	14	2017-04-12 11:14:16.344	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e30363c2f6c617374757064617465643e0a
4908	1	975	14	2017-04-12 11:14:16.346	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3036333c2f6c617374757064617465643e0a
4909	1	976	14	2017-04-12 11:14:16.347	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3036373c2f6c617374757064617465643e0a
4910	1	1070	14	2017-04-12 11:14:16.352	I	\N
4911	1	1071	14	2017-04-12 11:14:16.355	I	\N
4912	1	1072	14	2017-04-12 11:14:16.358	I	\N
4913	1	1073	14	2017-04-12 11:14:16.361	I	\N
4914	1	1074	14	2017-04-12 11:14:16.364	I	\N
4915	1	1027	14	2017-04-12 11:14:16.371	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3338353c2f6c617374757064617465643e0a
4916	1	1075	14	2017-04-12 11:14:16.374	I	\N
4917	1	989	14	2017-04-12 11:14:16.382	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3135363c2f6c617374757064617465643e0a
4918	1	990	14	2017-04-12 11:14:16.383	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3135393c2f6c617374757064617465643e0a
4919	1	1076	14	2017-04-12 11:14:16.387	I	\N
4920	1	1077	14	2017-04-12 11:14:16.389	I	\N
4921	1	987	14	2017-04-12 11:14:16.397	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3133383c2f6c617374757064617465643e0a
4922	1	988	14	2017-04-12 11:14:16.398	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3134313c2f6c617374757064617465643e0a
4923	1	1078	14	2017-04-12 11:14:16.402	I	\N
4924	1	1079	14	2017-04-12 11:14:16.405	I	\N
4925	1	1014	14	2017-04-12 11:14:16.412	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3239373c2f6c617374757064617465643e0a
4926	1	1015	14	2017-04-12 11:14:16.413	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3330313c2f6c617374757064617465643e0a
4927	1	1016	14	2017-04-12 11:14:16.415	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3330343c2f6c617374757064617465643e0a
4928	1	1017	14	2017-04-12 11:14:16.416	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31312031343a30383a34362e3330373c2f6c617374757064617465643e0a
4929	1	1080	14	2017-04-12 11:14:16.43	I	\N
4930	1	1081	14	2017-04-12 11:14:16.433	I	\N
4931	1	1082	14	2017-04-12 11:14:16.436	I	\N
4932	1	1083	14	2017-04-12 11:14:16.439	I	\N
4941	1	1220	9	2017-04-12 11:25:00.109	I	\N
4942	1	2650	32	2017-04-12 11:25:00.117	I	\N
4943	1	1221	9	2017-04-12 11:25:00.118	I	\N
4944	1	2651	32	2017-04-12 11:25:00.126	I	\N
4945	1	1222	9	2017-04-12 11:25:00.127	I	\N
4946	1	2652	32	2017-04-12 11:25:00.129	I	\N
4947	1	1223	9	2017-04-12 11:25:00.131	I	\N
4948	1	2653	32	2017-04-12 11:25:00.132	I	\N
4961	1	37	1	2017-04-12 11:25:45.104	I	\N
4962	1	54	23	2017-04-12 11:25:45.109	I	\N
4963	1	480	4	2017-04-12 11:25:45.113	I	\N
4964	1	37	45	2017-04-12 11:25:45.117	I	\N
4981	1	81	21	2017-04-12 11:26:47.139	I	\N
4983	1	37	1	2017-04-12 11:26:47.151	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5001	1	2654	32	2017-04-12 11:28:45.069	I	\N
5002	1	2655	32	2017-04-12 11:28:45.073	I	\N
5003	1	2656	32	2017-04-12 11:28:45.076	I	\N
5004	1	2657	32	2017-04-12 11:28:45.079	I	\N
5005	1	2658	32	2017-04-12 11:29:15.076	I	\N
5006	1	2659	32	2017-04-12 11:29:15.078	I	\N
5007	1	2660	32	2017-04-12 11:29:15.08	I	\N
5008	1	2661	32	2017-04-12 11:29:15.082	I	\N
5009	1	2662	32	2017-04-12 11:30:00.136	I	\N
5010	1	2663	32	2017-04-12 11:30:00.14	I	\N
5011	1	2664	32	2017-04-12 11:30:00.142	I	\N
5012	1	2665	32	2017-04-12 11:30:00.15	I	\N
5013	1	38	1	2017-04-12 11:30:15.089	I	\N
5014	1	55	23	2017-04-12 11:30:15.092	I	\N
5015	1	481	4	2017-04-12 11:30:15.098	I	\N
5016	1	38	45	2017-04-12 11:30:15.1	I	\N
5021	1	82	21	2017-04-12 11:30:32.157	I	\N
5022	1	76	155	2017-04-12 11:30:32.162	I	\N
5023	1	38	1	2017-04-12 11:30:32.177	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5041	1	2666	32	2017-04-12 12:06:15.192	I	\N
5061	1	2667	32	2017-04-12 12:06:30.131	I	\N
5081	1	2668	32	2017-04-12 12:06:45.103	I	\N
5042	1	39	1	2017-04-12 12:07:15.192	I	\N
5043	1	56	23	2017-04-12 12:07:15.194	I	\N
5044	1	482	4	2017-04-12 12:07:15.197	I	\N
5045	1	483	4	2017-04-12 12:07:15.201	I	\N
5046	1	484	4	2017-04-12 12:07:15.203	I	\N
5047	1	39	45	2017-04-12 12:07:15.206	I	\N
5048	1	83	21	2017-04-12 12:08:48.067	I	\N
5049	1	77	155	2017-04-12 12:08:48.072	I	\N
5050	1	84	21	2017-04-12 12:08:48.074	I	\N
5051	1	78	155	2017-04-12 12:08:48.076	I	\N
5052	1	85	21	2017-04-12 12:08:48.078	I	\N
5053	1	79	155	2017-04-12 12:08:48.08	I	\N
5054	1	39	1	2017-04-12 12:08:48.092	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5101	1	40	1	2017-04-12 12:12:37.162	I	\N
5102	1	57	23	2017-04-12 12:12:37.181	I	\N
5103	1	485	4	2017-04-12 12:12:37.189	I	\N
5104	1	486	4	2017-04-12 12:12:37.195	I	\N
5105	1	487	4	2017-04-12 12:12:37.206	I	\N
5106	1	40	45	2017-04-12 12:12:37.21	I	\N
5121	1	1285	38	2017-04-12 12:44:16.32	I	\N
5122	1	41	1	2017-04-12 12:45:00.166	I	\N
5123	1	58	23	2017-04-12 12:45:00.171	I	\N
5124	1	488	4	2017-04-12 12:45:00.188	I	\N
5125	1	41	45	2017-04-12 12:45:00.197	I	\N
5126	1	86	21	2017-04-12 12:45:28.13	I	\N
5127	1	80	155	2017-04-12 12:45:28.132	I	\N
5128	1	1	191	2017-04-12 12:45:28.141	I	\N
5129	1	1	192	2017-04-12 12:45:28.146	I	\N
5130	1	41	1	2017-04-12 12:45:28.164	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5141	1	42	1	2017-04-12 12:46:45.091	I	\N
5142	1	59	23	2017-04-12 12:46:45.096	I	\N
5143	1	489	4	2017-04-12 12:46:45.101	I	\N
5144	1	42	45	2017-04-12 12:46:45.103	I	\N
5131	1	87	21	2017-04-12 12:47:10.216	I	\N
5132	1	81	155	2017-04-12 12:47:10.218	I	\N
5133	1	2	191	2017-04-12 12:47:10.22	I	\N
5134	1	2	192	2017-04-12 12:47:10.222	I	\N
5135	1	42	1	2017-04-12 12:47:10.228	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5161	1	43	1	2017-04-12 12:49:45.1	I	\N
5162	1	60	23	2017-04-12 12:49:45.103	I	\N
5163	1	490	4	2017-04-12 12:49:45.106	I	\N
5164	1	43	45	2017-04-12 12:49:45.109	I	\N
5181	1	88	21	2017-04-12 12:50:02.396	I	\N
5182	1	82	155	2017-04-12 12:50:02.4	I	\N
5183	1	3	191	2017-04-12 12:50:02.404	I	\N
5184	1	3	192	2017-04-12 12:50:02.406	I	\N
5185	1	43	1	2017-04-12 12:50:02.413	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5201	1	89	21	2017-04-12 13:27:48.415	I	\N
5202	1	83	155	2017-04-12 13:27:48.418	I	\N
5203	1	90	21	2017-04-12 13:27:48.42	I	\N
5204	1	84	155	2017-04-12 13:27:48.421	I	\N
5205	1	91	21	2017-04-12 13:27:48.423	I	\N
5206	1	85	155	2017-04-12 13:27:48.424	I	\N
5207	1	40	1	2017-04-12 13:27:48.433	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5221	1	44	1	2017-04-12 17:02:00.307	I	\N
5222	1	61	23	2017-04-12 17:02:00.557	I	\N
5223	1	491	4	2017-04-12 17:02:00.586	I	\N
5224	1	44	45	2017-04-12 17:02:00.635	I	\N
5241	1	92	21	2017-04-12 17:02:28.46	I	\N
5242	1	86	155	2017-04-12 17:02:28.492	I	\N
5243	1	4	191	2017-04-12 17:02:28.51	I	\N
5244	1	4	192	2017-04-12 17:02:28.571	I	\N
5245	1	44	1	2017-04-12 17:02:28.587	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5261	1	45	1	2017-04-12 17:22:45.075	I	\N
5262	1	62	23	2017-04-12 17:22:45.078	I	\N
5263	1	492	4	2017-04-12 17:22:45.081	I	\N
5264	1	45	45	2017-04-12 17:22:45.083	I	\N
5281	1	93	21	2017-04-12 17:23:40.324	I	\N
5282	1	87	155	2017-04-12 17:23:40.327	I	\N
5283	1	5	191	2017-04-12 17:23:40.329	I	\N
5284	1	5	192	2017-04-12 17:23:40.331	I	\N
5285	1	45	1	2017-04-12 17:23:40.337	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5301	1	46	1	2017-04-12 17:26:30.135	I	\N
5302	1	63	23	2017-04-12 17:26:30.138	I	\N
5303	1	493	4	2017-04-12 17:26:30.141	I	\N
5304	1	46	45	2017-04-12 17:26:30.145	I	\N
5321	1	94	21	2017-04-12 17:26:53.51	I	\N
5322	1	88	155	2017-04-12 17:26:53.512	I	\N
5323	1	6	191	2017-04-12 17:26:53.515	I	\N
5324	1	6	192	2017-04-12 17:26:53.517	I	\N
5325	1	46	1	2017-04-12 17:26:53.524	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5341	1	15	16	2017-04-12 17:50:30.221	I	\N
5342	1	15	198	2017-04-12 17:50:30.224	I	\N
5343	1	15	198	2017-04-12 17:50:30.226	I	\N
5344	1	15	198	2017-04-12 17:50:30.227	I	\N
5345	1	15	198	2017-04-12 17:50:30.228	I	\N
5346	1	15	198	2017-04-12 17:50:30.229	I	\N
5347	1	15	198	2017-04-12 17:50:30.231	I	\N
5348	1	13	15	2017-04-12 17:50:30.246	I	\N
5349	1	16	112	2017-04-12 17:50:30.263	I	\N
5361	1	17	112	2017-04-12 17:52:45.106	I	\N
5362	1	18	112	2017-04-12 17:52:45.108	I	\N
5381	1	16	16	2017-04-12 18:03:30.186	I	\N
5382	1	16	198	2017-04-12 18:03:30.198	I	\N
5383	1	16	198	2017-04-12 18:03:30.201	I	\N
5384	1	16	198	2017-04-12 18:03:30.202	I	\N
5385	1	16	198	2017-04-12 18:03:30.203	I	\N
5386	1	16	198	2017-04-12 18:03:30.204	I	\N
5387	1	16	198	2017-04-12 18:03:30.205	I	\N
5388	1	14	15	2017-04-12 18:03:30.206	I	\N
5389	1	19	112	2017-04-12 18:03:30.209	I	\N
5390	1	20	112	2017-04-12 18:03:30.252	I	\N
5391	1	21	112	2017-04-12 18:03:30.254	I	\N
5401	1	17	16	2017-04-13 10:42:00.208	I	\N
5402	1	17	198	2017-04-13 10:42:00.211	I	\N
5403	1	17	198	2017-04-13 10:42:00.212	I	\N
5404	1	17	198	2017-04-13 10:42:00.213	I	\N
5405	1	17	198	2017-04-13 10:42:00.215	I	\N
5406	1	17	198	2017-04-13 10:42:00.217	I	\N
5407	1	17	198	2017-04-13 10:42:00.219	I	\N
5408	1	15	15	2017-04-13 10:42:00.22	I	\N
5409	1	22	112	2017-04-13 10:42:00.224	I	\N
5421	1	18	16	2017-04-16 13:28:30.178	I	\N
5422	1	18	198	2017-04-16 13:28:30.181	I	\N
5423	1	18	198	2017-04-16 13:28:30.183	I	\N
5424	1	18	198	2017-04-16 13:28:30.184	I	\N
5425	1	18	198	2017-04-16 13:28:30.185	I	\N
5426	1	18	198	2017-04-16 13:28:30.186	I	\N
5427	1	18	198	2017-04-16 13:28:30.187	I	\N
5428	1	16	15	2017-04-16 13:28:30.195	I	\N
5429	1	23	112	2017-04-16 13:28:30.2	I	\N
5441	1	19	16	2017-04-16 13:32:30.236	I	\N
5442	1	19	198	2017-04-16 13:32:30.239	I	\N
5443	1	19	198	2017-04-16 13:32:30.241	I	\N
5444	1	19	198	2017-04-16 13:32:30.242	I	\N
5445	1	19	198	2017-04-16 13:32:30.243	I	\N
5446	1	19	198	2017-04-16 13:32:30.244	I	\N
5447	1	19	198	2017-04-16 13:32:30.245	I	\N
5448	1	17	15	2017-04-16 13:32:30.247	I	\N
5449	1	24	112	2017-04-16 13:32:30.252	I	\N
5461	1	25	112	2017-04-17 15:57:00.142	I	\N
5462	1	26	112	2017-04-17 15:57:00.146	I	\N
5481	1	27	112	2017-04-17 16:10:45.112	I	\N
5482	1	28	112	2017-04-17 16:10:45.114	I	\N
5501	1	29	112	2017-04-18 12:35:15.091	I	\N
5502	1	30	112	2017-04-18 12:35:15.093	I	\N
5521	1	47	1	2017-04-19 10:30:15.145	I	\N
5522	1	64	23	2017-04-19 10:30:15.147	I	\N
5523	1	494	4	2017-04-19 10:30:15.15	I	\N
5524	1	495	4	2017-04-19 10:30:15.153	I	\N
5525	1	47	45	2017-04-19 10:30:15.158	I	\N
5541	1	20	16	2017-04-19 10:32:45.119	I	\N
5542	1	20	198	2017-04-19 10:32:45.122	I	\N
5543	1	20	198	2017-04-19 10:32:45.124	I	\N
5544	1	20	198	2017-04-19 10:32:45.125	I	\N
5545	1	20	198	2017-04-19 10:32:45.126	I	\N
5546	1	20	198	2017-04-19 10:32:45.127	I	\N
5547	1	20	198	2017-04-19 10:32:45.128	I	\N
5548	1	18	15	2017-04-19 10:32:45.129	I	\N
5549	1	31	112	2017-04-19 10:32:45.131	I	\N
5561	1	32	112	2017-04-19 10:33:00.128	I	\N
5562	1	33	112	2017-04-19 10:33:00.13	I	\N
5581	1	21	16	2017-04-20 11:04:15.13	I	\N
5582	1	21	198	2017-04-20 11:04:15.132	I	\N
5583	1	21	198	2017-04-20 11:04:15.134	I	\N
5584	1	21	198	2017-04-20 11:04:15.135	I	\N
5585	1	21	198	2017-04-20 11:04:15.136	I	\N
5586	1	21	198	2017-04-20 11:04:15.137	I	\N
5587	1	21	198	2017-04-20 11:04:15.137	I	\N
5588	1	19	15	2017-04-20 11:04:15.138	I	\N
5589	1	34	112	2017-04-20 11:04:15.14	I	\N
5601	1	48	1	2017-04-20 11:06:15.121	I	\N
5602	1	65	23	2017-04-20 11:06:15.124	I	\N
5603	1	496	4	2017-04-20 11:06:15.127	I	\N
5604	1	48	45	2017-04-20 11:06:15.13	I	\N
5621	1	497	4	2017-04-20 11:08:45.12	I	\N
5641	1	95	21	2017-04-20 13:48:44.708	I	\N
5642	1	89	155	2017-04-20 13:48:44.711	I	\N
5643	1	96	21	2017-04-20 13:48:44.713	I	\N
5644	1	90	155	2017-04-20 13:48:44.714	I	\N
5645	1	48	1	2017-04-20 13:48:44.72	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5661	1	49	1	2017-04-20 13:49:45.079	I	\N
5662	1	66	23	2017-04-20 13:49:45.087	I	\N
5663	1	498	4	2017-04-20 13:49:45.089	I	\N
5664	1	499	4	2017-04-20 13:49:45.092	I	\N
5665	1	500	4	2017-04-20 13:49:45.094	I	\N
5666	1	49	45	2017-04-20 13:49:45.096	I	\N
5681	1	97	21	2017-04-20 13:51:05.707	I	\N
5682	1	91	155	2017-04-20 13:51:05.71	I	\N
5683	1	98	21	2017-04-20 13:51:05.712	I	\N
5684	1	92	155	2017-04-20 13:51:05.713	I	\N
5685	1	99	21	2017-04-20 13:51:05.715	I	\N
5686	1	93	155	2017-04-20 13:51:05.716	I	\N
5687	1	49	1	2017-04-20 13:51:05.74	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5701	1	22	16	2017-04-20 17:19:15.088	I	\N
5702	1	22	198	2017-04-20 17:19:15.093	I	\N
5703	1	22	198	2017-04-20 17:19:15.095	I	\N
5704	1	22	198	2017-04-20 17:19:15.096	I	\N
5705	1	22	198	2017-04-20 17:19:15.097	I	\N
5706	1	22	198	2017-04-20 17:19:15.098	I	\N
5707	1	22	198	2017-04-20 17:19:15.098	I	\N
5708	1	20	15	2017-04-20 17:19:15.099	I	\N
5709	1	35	112	2017-04-20 17:19:15.102	I	\N
5721	1	50	1	2017-04-20 17:22:45.146	I	\N
5722	1	67	23	2017-04-20 17:22:45.149	I	\N
5723	1	501	4	2017-04-20 17:22:45.151	I	\N
5724	1	502	4	2017-04-20 17:22:45.154	I	\N
5725	1	503	4	2017-04-20 17:22:45.156	I	\N
5726	1	504	4	2017-04-20 17:22:45.159	I	\N
5727	1	505	4	2017-04-20 17:22:45.16	I	\N
5728	1	506	4	2017-04-20 17:22:45.162	I	\N
5729	1	507	4	2017-04-20 17:22:45.164	I	\N
5730	1	508	4	2017-04-20 17:22:45.166	I	\N
5731	1	509	4	2017-04-20 17:22:45.168	I	\N
5732	1	510	4	2017-04-20 17:22:45.171	I	\N
5733	1	50	45	2017-04-20 17:22:45.173	I	\N
5741	1	68	23	2017-04-20 17:24:15.118	I	\N
5742	1	511	4	2017-04-20 17:24:15.121	I	\N
5743	1	512	4	2017-04-20 17:24:15.127	I	\N
5744	1	513	4	2017-04-20 17:24:15.129	I	\N
5745	1	514	4	2017-04-20 17:24:15.131	I	\N
5746	1	515	4	2017-04-20 17:24:15.134	I	\N
5747	1	516	4	2017-04-20 17:24:15.139	I	\N
5761	1	69	23	2017-04-20 17:24:45.126	I	\N
5762	1	517	4	2017-04-20 17:24:45.129	I	\N
5763	1	518	4	2017-04-20 17:24:45.133	I	\N
5764	1	519	4	2017-04-20 17:24:45.138	I	\N
5765	1	520	4	2017-04-20 17:24:45.14	I	\N
5766	1	521	4	2017-04-20 17:24:45.143	I	\N
5767	1	522	4	2017-04-20 17:24:45.145	I	\N
5781	1	70	23	2017-04-20 17:38:15.169	I	\N
5782	1	523	4	2017-04-20 17:38:15.172	I	\N
5783	1	524	4	2017-04-20 17:38:15.175	I	\N
5784	1	525	4	2017-04-20 17:38:15.178	I	\N
5785	1	526	4	2017-04-20 17:38:15.18	I	\N
5786	1	527	4	2017-04-20 17:38:15.183	I	\N
5801	1	100	21	2017-04-20 17:52:54.368	I	\N
5802	1	94	155	2017-04-20 17:52:54.371	I	\N
5803	1	101	21	2017-04-20 17:52:54.373	I	\N
5804	1	95	155	2017-04-20 17:52:54.375	I	\N
5805	1	102	21	2017-04-20 17:52:54.376	I	\N
5806	1	96	155	2017-04-20 17:52:54.378	I	\N
5807	1	103	21	2017-04-20 17:52:54.379	I	\N
5808	1	97	155	2017-04-20 17:52:54.386	I	\N
5809	1	104	21	2017-04-20 17:52:54.388	I	\N
5810	1	98	155	2017-04-20 17:52:54.39	I	\N
5811	1	105	21	2017-04-20 17:52:54.391	I	\N
5812	1	99	155	2017-04-20 17:52:54.392	I	\N
5813	1	106	21	2017-04-20 17:52:54.394	I	\N
5814	1	100	155	2017-04-20 17:52:54.396	I	\N
5815	1	107	21	2017-04-20 17:52:54.398	I	\N
5816	1	101	155	2017-04-20 17:52:54.399	I	\N
5817	1	108	21	2017-04-20 17:52:54.401	I	\N
5818	1	102	155	2017-04-20 17:52:54.403	I	\N
5819	1	109	21	2017-04-20 17:52:54.405	I	\N
5820	1	103	155	2017-04-20 17:52:54.407	I	\N
5821	1	110	21	2017-04-20 17:52:54.409	I	\N
5822	1	104	155	2017-04-20 17:52:54.412	I	\N
5823	1	111	21	2017-04-20 17:52:54.415	I	\N
5824	1	105	155	2017-04-20 17:52:54.416	I	\N
5825	1	112	21	2017-04-20 17:52:54.417	I	\N
5826	1	106	155	2017-04-20 17:52:54.419	I	\N
5827	1	113	21	2017-04-20 17:52:54.42	I	\N
5828	1	107	155	2017-04-20 17:52:54.422	I	\N
5829	1	114	21	2017-04-20 17:52:54.423	I	\N
5830	1	108	155	2017-04-20 17:52:54.425	I	\N
5831	1	115	21	2017-04-20 17:52:54.426	I	\N
5832	1	109	155	2017-04-20 17:52:54.427	I	\N
5833	1	116	21	2017-04-20 17:52:54.429	I	\N
5834	1	110	155	2017-04-20 17:52:54.43	I	\N
5835	1	117	21	2017-04-20 17:52:54.431	I	\N
5836	1	111	155	2017-04-20 17:52:54.433	I	\N
5837	1	118	21	2017-04-20 17:52:54.434	I	\N
5838	1	112	155	2017-04-20 17:52:54.436	I	\N
5839	1	119	21	2017-04-20 17:52:54.437	I	\N
5840	1	113	155	2017-04-20 17:52:54.44	I	\N
5841	1	120	21	2017-04-20 17:52:54.441	I	\N
5842	1	114	155	2017-04-20 17:52:54.443	I	\N
5843	1	121	21	2017-04-20 17:52:54.444	I	\N
5844	1	115	155	2017-04-20 17:52:54.446	I	\N
5845	1	122	21	2017-04-20 17:52:54.447	I	\N
5846	1	116	155	2017-04-20 17:52:54.448	I	\N
5847	1	123	21	2017-04-20 17:52:54.45	I	\N
5848	1	117	155	2017-04-20 17:52:54.452	I	\N
5849	1	50	1	2017-04-20 17:52:54.5	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5861	1	63	208	2017-04-20 17:59:21.053	I	\N
5881	1	51	1	2017-04-20 18:20:15.147	I	\N
5882	1	71	23	2017-04-20 18:20:15.15	I	\N
5883	1	528	4	2017-04-20 18:20:15.152	I	\N
5884	1	72	23	2017-04-20 18:20:15.155	I	\N
5885	1	529	4	2017-04-20 18:20:15.156	I	\N
5886	1	51	45	2017-04-20 18:20:15.158	I	\N
5901	1	124	21	2017-04-20 18:21:10.689	I	\N
5902	1	118	155	2017-04-20 18:21:10.692	I	\N
5903	1	125	21	2017-04-20 18:21:10.693	I	\N
5904	1	119	155	2017-04-20 18:21:10.694	I	\N
5905	1	51	1	2017-04-20 18:21:10.701	U	\\x3c73746174757349643e313c2f73746174757349643e0a
5921	1	52	1	2017-04-21 10:44:30.241	I	\N
5922	1	73	23	2017-04-21 10:44:30.245	I	\N
5923	1	530	4	2017-04-21 10:44:30.25	I	\N
5924	1	531	4	2017-04-21 10:44:30.254	I	\N
5925	1	52	45	2017-04-21 10:44:30.256	I	\N
5941	1	53	1	2017-04-21 10:59:30.17	I	\N
5942	1	74	23	2017-04-21 10:59:30.175	I	\N
5943	1	532	4	2017-04-21 10:59:30.177	I	\N
5944	1	53	45	2017-04-21 10:59:30.179	I	\N
5961	1	54	1	2017-04-21 11:00:30.201	I	\N
5962	1	75	23	2017-04-21 11:00:30.203	I	\N
5963	1	533	4	2017-04-21 11:00:30.205	I	\N
5964	1	54	45	2017-04-21 11:00:30.208	I	\N
5981	1	55	1	2017-04-21 11:08:45.125	I	\N
5982	1	76	23	2017-04-21 11:08:45.128	I	\N
5983	1	534	4	2017-04-21 11:08:45.131	I	\N
5984	1	55	45	2017-04-21 11:08:45.133	I	\N
6001	1	126	21	2017-04-21 11:10:59.835	I	\N
6002	1	120	155	2017-04-21 11:10:59.838	I	\N
6003	1	55	1	2017-04-21 11:10:59.844	U	\\x3c73746174757349643e313c2f73746174757349643e0a
6021	1	64	208	2017-04-21 11:11:41.144	I	\N
6022	1	65	208	2017-04-21 11:16:26.424	I	\N
6041	1	23	16	2017-04-21 16:18:45.125	I	\N
6042	1	23	198	2017-04-21 16:18:45.128	I	\N
6043	1	23	198	2017-04-21 16:18:45.129	I	\N
6044	1	23	198	2017-04-21 16:18:45.13	I	\N
6045	1	23	198	2017-04-21 16:18:45.131	I	\N
6046	1	23	198	2017-04-21 16:18:45.132	I	\N
6047	1	23	198	2017-04-21 16:18:45.134	I	\N
6048	1	21	15	2017-04-21 16:18:45.135	I	\N
6049	1	36	112	2017-04-21 16:18:45.137	I	\N
6050	1	56	1	2017-04-21 16:20:00.28	I	\N
6051	1	77	23	2017-04-21 16:20:00.286	I	\N
6052	1	535	4	2017-04-21 16:20:00.288	I	\N
6053	1	56	45	2017-04-21 16:20:00.291	I	\N
6061	1	24	16	2017-04-21 16:51:00.175	I	\N
6062	1	24	198	2017-04-21 16:51:00.177	I	\N
6063	1	24	198	2017-04-21 16:51:00.18	I	\N
6064	1	24	198	2017-04-21 16:51:00.18	I	\N
6065	1	24	198	2017-04-21 16:51:00.186	I	\N
6066	1	24	198	2017-04-21 16:51:00.187	I	\N
6067	1	24	198	2017-04-21 16:51:00.187	I	\N
6068	1	22	15	2017-04-21 16:51:00.188	I	\N
6069	1	37	112	2017-04-21 16:51:00.192	I	\N
6081	1	25	16	2017-04-23 13:09:15.09	I	\N
6082	1	25	198	2017-04-23 13:09:15.092	I	\N
6083	1	25	198	2017-04-23 13:09:15.093	I	\N
6084	1	25	198	2017-04-23 13:09:15.094	I	\N
6085	1	25	198	2017-04-23 13:09:15.095	I	\N
6086	1	25	198	2017-04-23 13:09:15.096	I	\N
6087	1	25	198	2017-04-23 13:09:15.097	I	\N
6088	1	23	15	2017-04-23 13:09:15.097	I	\N
6089	1	38	112	2017-04-23 13:09:15.099	I	\N
6101	1	39	112	2017-04-23 13:09:45.081	I	\N
6102	1	40	112	2017-04-23 13:09:45.083	I	\N
6121	1	57	1	2017-04-24 12:05:30.301	I	\N
6122	1	78	23	2017-04-24 12:05:30.307	I	\N
6123	1	536	4	2017-04-24 12:05:30.309	I	\N
6124	1	537	4	2017-04-24 12:05:30.319	I	\N
6125	1	538	4	2017-04-24 12:05:30.32	I	\N
6126	1	57	45	2017-04-24 12:05:30.34	I	\N
6141	1	127	21	2017-04-24 12:06:08.266	I	\N
6142	1	121	155	2017-04-24 12:06:08.268	I	\N
6143	1	128	21	2017-04-24 12:06:08.27	I	\N
6144	1	122	155	2017-04-24 12:06:08.271	I	\N
6145	1	129	21	2017-04-24 12:06:08.272	I	\N
6146	1	123	155	2017-04-24 12:06:08.273	I	\N
6147	1	57	1	2017-04-24 12:06:08.281	U	\\x3c73746174757349643e313c2f73746174757349643e0a
6161	1	91	34	2017-04-24 12:10:00.133	I	\N
6181	1	1488	211	2017-04-24 12:10:45.141	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738343c2f7465737449643e0a
6182	1	1489	211	2017-04-24 12:10:45.145	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738373c2f7465737449643e0a
6183	1	1490	211	2017-04-24 12:10:45.146	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738383c2f7465737449643e0a
6184	1	1491	211	2017-04-24 12:10:45.147	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3738393c2f7465737449643e0a
6185	1	1492	211	2017-04-24 12:10:45.148	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739303c2f7465737449643e0a
6186	1	1493	211	2017-04-24 12:10:45.149	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739313c2f7465737449643e0a
6187	1	1494	211	2017-04-24 12:10:45.15	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739323c2f7465737449643e0a
6188	1	1495	211	2017-04-24 12:10:45.151	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739333c2f7465737449643e0a
6189	1	1496	211	2017-04-24 12:10:45.152	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739363c2f7465737449643e0a
6190	1	1497	211	2017-04-24 12:10:45.152	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739373c2f7465737449643e0a
6191	1	1498	211	2017-04-24 12:10:45.153	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739383c2f7465737449643e0a
6192	1	1499	211	2017-04-24 12:10:45.154	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3739393c2f7465737449643e0a
6193	1	1500	211	2017-04-24 12:10:45.155	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830303c2f7465737449643e0a
6194	1	1501	211	2017-04-24 12:10:45.155	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830313c2f7465737449643e0a
6195	1	1502	211	2017-04-24 12:10:45.156	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830323c2f7465737449643e0a
6196	1	1503	211	2017-04-24 12:10:45.157	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830333c2f7465737449643e0a
6197	1	1504	211	2017-04-24 12:10:45.158	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830343c2f7465737449643e0a
6198	1	1505	211	2017-04-24 12:10:45.159	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830353c2f7465737449643e0a
6199	1	1506	211	2017-04-24 12:10:45.159	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830363c2f7465737449643e0a
6200	1	1507	211	2017-04-24 12:10:45.16	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830383c2f7465737449643e0a
6201	1	1508	211	2017-04-24 12:10:45.161	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3830393c2f7465737449643e0a
6202	1	1509	211	2017-04-24 12:10:45.161	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3836393c2f7465737449643e0a
6203	1	1510	211	2017-04-24 12:10:45.162	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837303c2f7465737449643e0a
6204	1	1511	211	2017-04-24 12:10:45.163	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837313c2f7465737449643e0a
6205	1	1512	211	2017-04-24 12:10:45.164	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837323c2f7465737449643e0a
6206	1	1513	211	2017-04-24 12:10:45.164	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837333c2f7465737449643e0a
6207	1	1514	211	2017-04-24 12:10:45.165	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c7465737449643e3837343c2f7465737449643e0a
6208	1	1554	211	2017-04-24 12:10:45.182	I	\N
6209	1	1555	211	2017-04-24 12:10:45.211	I	\N
6210	1	1556	211	2017-04-24 12:10:45.214	I	\N
6211	1	1557	211	2017-04-24 12:10:45.217	I	\N
6212	1	1558	211	2017-04-24 12:10:45.225	I	\N
6213	1	1559	211	2017-04-24 12:10:45.227	I	\N
6214	1	1560	211	2017-04-24 12:10:45.229	I	\N
6215	1	1561	211	2017-04-24 12:10:45.232	I	\N
6216	1	1562	211	2017-04-24 12:10:45.24	I	\N
6217	1	1563	211	2017-04-24 12:10:45.242	I	\N
6218	1	1564	211	2017-04-24 12:10:45.245	I	\N
6219	1	1565	211	2017-04-24 12:10:45.247	I	\N
6220	1	1566	211	2017-04-24 12:10:45.251	I	\N
6221	1	1567	211	2017-04-24 12:10:45.257	I	\N
6222	1	1568	211	2017-04-24 12:10:45.259	I	\N
6223	1	1569	211	2017-04-24 12:10:45.262	I	\N
6224	1	1570	211	2017-04-24 12:10:45.265	I	\N
6225	1	1571	211	2017-04-24 12:10:45.27	I	\N
6226	1	1572	211	2017-04-24 12:10:45.274	I	\N
6227	1	1573	211	2017-04-24 12:10:45.282	I	\N
6228	1	1574	211	2017-04-24 12:10:45.284	I	\N
6229	1	1575	211	2017-04-24 12:10:45.29	I	\N
6230	1	1576	211	2017-04-24 12:10:45.293	I	\N
6231	1	1577	211	2017-04-24 12:10:45.296	I	\N
6232	1	1578	211	2017-04-24 12:10:45.302	I	\N
6233	1	1579	211	2017-04-24 12:10:45.305	I	\N
6234	1	1580	211	2017-04-24 12:10:45.308	I	\N
6235	1	131	212	2017-04-24 12:10:45.31	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38353c2f70616e656c49643e0a
6236	1	132	212	2017-04-24 12:10:45.311	D	\\x3c747970654f6653616d706c6549643e38323c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39353c2f70616e656c49643e0a
6237	1	138	212	2017-04-24 12:10:45.333	I	\N
6238	1	139	212	2017-04-24 12:10:45.344	I	\N
6239	1	1327	211	2017-04-24 12:10:45.349	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3738353c2f7465737449643e0a
6240	1	1328	211	2017-04-24 12:10:45.35	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3739343c2f7465737449643e0a
6241	1	1329	211	2017-04-24 12:10:45.351	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831303c2f7465737449643e0a
6242	1	1330	211	2017-04-24 12:10:45.353	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831323c2f7465737449643e0a
6243	1	1331	211	2017-04-24 12:10:45.354	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831333c2f7465737449643e0a
6244	1	1332	211	2017-04-24 12:10:45.355	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831343c2f7465737449643e0a
6245	1	1333	211	2017-04-24 12:10:45.356	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831353c2f7465737449643e0a
6246	1	1334	211	2017-04-24 12:10:45.357	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831363c2f7465737449643e0a
6247	1	1335	211	2017-04-24 12:10:45.358	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831373c2f7465737449643e0a
6248	1	1336	211	2017-04-24 12:10:45.359	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831383c2f7465737449643e0a
6249	1	1337	211	2017-04-24 12:10:45.361	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c7465737449643e3831393c2f7465737449643e0a
6250	1	1581	211	2017-04-24 12:10:45.364	I	\N
6251	1	1582	211	2017-04-24 12:10:45.367	I	\N
6252	1	1583	211	2017-04-24 12:10:45.37	I	\N
6253	1	1584	211	2017-04-24 12:10:45.373	I	\N
6254	1	1585	211	2017-04-24 12:10:45.376	I	\N
6255	1	1586	211	2017-04-24 12:10:45.379	I	\N
6256	1	1587	211	2017-04-24 12:10:45.382	I	\N
6257	1	1588	211	2017-04-24 12:10:45.385	I	\N
6258	1	1589	211	2017-04-24 12:10:45.388	I	\N
6259	1	1590	211	2017-04-24 12:10:45.392	I	\N
6260	1	1591	211	2017-04-24 12:10:45.395	I	\N
6261	1	118	212	2017-04-24 12:10:45.397	D	\\x3c747970654f6653616d706c6549643e38333c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38363c2f70616e656c49643e0a
6262	1	140	212	2017-04-24 12:10:45.401	I	\N
6263	1	1338	211	2017-04-24 12:10:45.406	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3738363c2f7465737449643e0a
6264	1	1339	211	2017-04-24 12:10:45.408	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3739353c2f7465737449643e0a
6265	1	1340	211	2017-04-24 12:10:45.409	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832303c2f7465737449643e0a
6266	1	1341	211	2017-04-24 12:10:45.41	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832313c2f7465737449643e0a
6267	1	1342	211	2017-04-24 12:10:45.412	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832323c2f7465737449643e0a
6268	1	1343	211	2017-04-24 12:10:45.413	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c7465737449643e3832333c2f7465737449643e0a
6269	1	1592	211	2017-04-24 12:10:45.416	I	\N
6270	1	1593	211	2017-04-24 12:10:45.42	I	\N
6271	1	1594	211	2017-04-24 12:10:45.423	I	\N
6272	1	1595	211	2017-04-24 12:10:45.427	I	\N
6273	1	1596	211	2017-04-24 12:10:45.431	I	\N
6274	1	1597	211	2017-04-24 12:10:45.434	I	\N
6275	1	119	212	2017-04-24 12:10:45.436	D	\\x3c747970654f6653616d706c6549643e38343c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38373c2f70616e656c49643e0a
6276	1	141	212	2017-04-24 12:10:45.44	I	\N
6277	1	1515	211	2017-04-24 12:10:45.446	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832343c2f7465737449643e0a
6278	1	1516	211	2017-04-24 12:10:45.448	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832353c2f7465737449643e0a
6279	1	1517	211	2017-04-24 12:10:45.449	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832363c2f7465737449643e0a
6280	1	1518	211	2017-04-24 12:10:45.451	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832373c2f7465737449643e0a
6281	1	1519	211	2017-04-24 12:10:45.452	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832383c2f7465737449643e0a
6282	1	1520	211	2017-04-24 12:10:45.454	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832393c2f7465737449643e0a
6283	1	1521	211	2017-04-24 12:10:45.456	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833303c2f7465737449643e0a
6284	1	1522	211	2017-04-24 12:10:45.457	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833313c2f7465737449643e0a
6285	1	1523	211	2017-04-24 12:10:45.459	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833323c2f7465737449643e0a
6286	1	1524	211	2017-04-24 12:10:45.46	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833333c2f7465737449643e0a
6287	1	1525	211	2017-04-24 12:10:45.462	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833343c2f7465737449643e0a
6288	1	1526	211	2017-04-24 12:10:45.463	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833353c2f7465737449643e0a
6289	1	1527	211	2017-04-24 12:10:45.465	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833363c2f7465737449643e0a
6290	1	1528	211	2017-04-24 12:10:45.466	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833373c2f7465737449643e0a
6291	1	1529	211	2017-04-24 12:10:45.468	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833383c2f7465737449643e0a
6292	1	1530	211	2017-04-24 12:10:45.469	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833393c2f7465737449643e0a
6293	1	1531	211	2017-04-24 12:10:45.471	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834303c2f7465737449643e0a
6294	1	1532	211	2017-04-24 12:10:45.473	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834313c2f7465737449643e0a
6295	1	1533	211	2017-04-24 12:10:45.474	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834323c2f7465737449643e0a
6296	1	1534	211	2017-04-24 12:10:45.476	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834333c2f7465737449643e0a
6297	1	1535	211	2017-04-24 12:10:45.477	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834343c2f7465737449643e0a
6298	1	1536	211	2017-04-24 12:10:45.479	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3831313c2f7465737449643e0a
6299	1	1537	211	2017-04-24 12:10:45.48	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834353c2f7465737449643e0a
6300	1	1538	211	2017-04-24 12:10:45.482	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834363c2f7465737449643e0a
6301	1	1539	211	2017-04-24 12:10:45.483	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834383c2f7465737449643e0a
6302	1	1540	211	2017-04-24 12:10:45.485	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834393c2f7465737449643e0a
6303	1	1541	211	2017-04-24 12:10:45.487	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835303c2f7465737449643e0a
6304	1	1542	211	2017-04-24 12:10:45.488	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835313c2f7465737449643e0a
6305	1	1543	211	2017-04-24 12:10:45.49	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835323c2f7465737449643e0a
6306	1	1544	211	2017-04-24 12:10:45.491	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835333c2f7465737449643e0a
6307	1	1545	211	2017-04-24 12:10:45.493	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835343c2f7465737449643e0a
6308	1	1546	211	2017-04-24 12:10:45.494	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835353c2f7465737449643e0a
6309	1	1547	211	2017-04-24 12:10:45.496	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835363c2f7465737449643e0a
6310	1	1548	211	2017-04-24 12:10:45.497	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835373c2f7465737449643e0a
6311	1	1549	211	2017-04-24 12:10:45.499	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835383c2f7465737449643e0a
6312	1	1550	211	2017-04-24 12:10:45.5	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835393c2f7465737449643e0a
6313	1	1551	211	2017-04-24 12:10:45.502	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836303c2f7465737449643e0a
6314	1	1552	211	2017-04-24 12:10:45.503	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836313c2f7465737449643e0a
6315	1	1553	211	2017-04-24 12:10:45.505	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836323c2f7465737449643e0a
6316	1	1598	211	2017-04-24 12:10:45.509	I	\N
6317	1	1599	211	2017-04-24 12:10:45.513	I	\N
6318	1	1600	211	2017-04-24 12:10:45.517	I	\N
6319	1	1601	211	2017-04-24 12:10:45.522	I	\N
6320	1	1602	211	2017-04-24 12:10:45.526	I	\N
6321	1	1603	211	2017-04-24 12:10:45.53	I	\N
6322	1	1604	211	2017-04-24 12:10:45.534	I	\N
6323	1	1605	211	2017-04-24 12:10:45.539	I	\N
6324	1	1606	211	2017-04-24 12:10:45.543	I	\N
6325	1	1607	211	2017-04-24 12:10:45.547	I	\N
6326	1	1608	211	2017-04-24 12:10:45.552	I	\N
6327	1	1609	211	2017-04-24 12:10:45.556	I	\N
6328	1	1610	211	2017-04-24 12:10:45.56	I	\N
6329	1	1611	211	2017-04-24 12:10:45.565	I	\N
6330	1	1612	211	2017-04-24 12:10:45.569	I	\N
6331	1	1613	211	2017-04-24 12:10:45.574	I	\N
6332	1	1614	211	2017-04-24 12:10:45.579	I	\N
6333	1	1615	211	2017-04-24 12:10:45.583	I	\N
6334	1	1616	211	2017-04-24 12:10:45.588	I	\N
6335	1	1617	211	2017-04-24 12:10:45.593	I	\N
6336	1	1618	211	2017-04-24 12:10:45.597	I	\N
6337	1	1619	211	2017-04-24 12:10:45.602	I	\N
6338	1	1620	211	2017-04-24 12:10:45.607	I	\N
6339	1	1621	211	2017-04-24 12:10:45.612	I	\N
6340	1	1622	211	2017-04-24 12:10:45.617	I	\N
6341	1	1623	211	2017-04-24 12:10:45.621	I	\N
6342	1	1624	211	2017-04-24 12:10:45.626	I	\N
6343	1	1625	211	2017-04-24 12:10:45.631	I	\N
6344	1	1626	211	2017-04-24 12:10:45.635	I	\N
6345	1	1627	211	2017-04-24 12:10:45.638	I	\N
6346	1	1628	211	2017-04-24 12:10:45.642	I	\N
6347	1	1629	211	2017-04-24 12:10:45.646	I	\N
6348	1	1630	211	2017-04-24 12:10:45.65	I	\N
6349	1	1631	211	2017-04-24 12:10:45.653	I	\N
6350	1	1632	211	2017-04-24 12:10:45.657	I	\N
6351	1	1633	211	2017-04-24 12:10:45.661	I	\N
6352	1	1634	211	2017-04-24 12:10:45.665	I	\N
6353	1	1635	211	2017-04-24 12:10:45.669	I	\N
6354	1	1636	211	2017-04-24 12:10:45.673	I	\N
6355	1	133	212	2017-04-24 12:10:45.676	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38383c2f70616e656c49643e0a
6356	1	134	212	2017-04-24 12:10:45.678	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38393c2f70616e656c49643e0a
6357	1	135	212	2017-04-24 12:10:45.679	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39303c2f70616e656c49643e0a
6358	1	136	212	2017-04-24 12:10:45.681	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39313c2f70616e656c49643e0a
6359	1	137	212	2017-04-24 12:10:45.682	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39323c2f70616e656c49643e0a
6360	1	142	212	2017-04-24 12:10:45.687	I	\N
6361	1	143	212	2017-04-24 12:10:45.692	I	\N
6362	1	144	212	2017-04-24 12:10:45.696	I	\N
6363	1	145	212	2017-04-24 12:10:45.701	I	\N
6364	1	146	212	2017-04-24 12:10:45.706	I	\N
6365	1	1384	211	2017-04-24 12:10:45.712	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c7465737449643e3836333c2f7465737449643e0a
6366	1	1385	211	2017-04-24 12:10:45.714	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c7465737449643e3836383c2f7465737449643e0a
6367	1	1637	211	2017-04-24 12:10:45.718	I	\N
6368	1	1638	211	2017-04-24 12:10:45.722	I	\N
6369	1	125	212	2017-04-24 12:10:45.725	D	\\x3c747970654f6653616d706c6549643e38363c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39343c2f70616e656c49643e0a
6370	1	147	212	2017-04-24 12:10:45.729	I	\N
6371	1	1386	211	2017-04-24 12:10:45.735	D	\\x3c747970654f6653616d706c6549643e38373c2f747970654f6653616d706c6549643e0a3c7465737449643e3836343c2f7465737449643e0a
6372	1	1639	211	2017-04-24 12:10:45.739	I	\N
6373	1	1387	211	2017-04-24 12:10:45.747	D	\\x3c747970654f6653616d706c6549643e38383c2f747970654f6653616d706c6549643e0a3c7465737449643e3836353c2f7465737449643e0a
6374	1	1640	211	2017-04-24 12:10:45.751	I	\N
6375	1	1388	211	2017-04-24 12:10:45.758	D	\\x3c747970654f6653616d706c6549643e38393c2f747970654f6653616d706c6549643e0a3c7465737449643e3836363c2f7465737449643e0a
6376	1	1641	211	2017-04-24 12:10:45.762	I	\N
6377	1	1389	211	2017-04-24 12:10:45.776	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c7465737449643e3836373c2f7465737449643e0a
6378	1	1642	211	2017-04-24 12:10:45.78	I	\N
6379	1	126	212	2017-04-24 12:10:45.783	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39333c2f70616e656c49643e0a
6380	1	148	212	2017-04-24 12:10:45.787	I	\N
6381	1	875	5	2017-04-24 12:13:00.143	I	\N
6382	1	2669	32	2017-04-24 12:13:00.252	I	\N
6383	1	2670	32	2017-04-24 12:13:00.267	I	\N
6401	1	1643	211	2017-04-24 12:14:00.174	I	\N
6421	1	1039	14	2017-04-24 12:14:31.028	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3232333c2f6c617374757064617465643e0a
6422	1	1040	14	2017-04-24 12:14:31.029	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3232363c2f6c617374757064617465643e0a
6423	1	1041	14	2017-04-24 12:14:31.031	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3232393c2f6c617374757064617465643e0a
6424	1	1042	14	2017-04-24 12:14:31.032	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3233323c2f6c617374757064617465643e0a
6425	1	1043	14	2017-04-24 12:14:31.033	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3233343c2f6c617374757064617465643e0a
6426	1	1044	14	2017-04-24 12:14:31.035	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3233373c2f6c617374757064617465643e0a
6427	1	1045	14	2017-04-24 12:14:31.036	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e32343c2f6c617374757064617465643e0a
6428	1	1046	14	2017-04-24 12:14:31.037	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3234323c2f6c617374757064617465643e0a
6429	1	1047	14	2017-04-24 12:14:31.039	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3234353c2f6c617374757064617465643e0a
6430	1	1048	14	2017-04-24 12:14:31.04	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3234383c2f6c617374757064617465643e0a
6431	1	1049	14	2017-04-24 12:14:31.041	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e32353c2f6c617374757064617465643e0a
6432	1	1050	14	2017-04-24 12:14:31.042	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3235333c2f6c617374757064617465643e0a
6433	1	1051	14	2017-04-24 12:14:31.043	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3235363c2f6c617374757064617465643e0a
6434	1	1052	14	2017-04-24 12:14:31.045	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3235393c2f6c617374757064617465643e0a
6435	1	1053	14	2017-04-24 12:14:31.046	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3236323c2f6c617374757064617465643e0a
6436	1	1054	14	2017-04-24 12:14:31.047	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3236353c2f6c617374757064617465643e0a
6437	1	1055	14	2017-04-24 12:14:31.049	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3236383c2f6c617374757064617465643e0a
6438	1	1056	14	2017-04-24 12:14:31.05	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3237313c2f6c617374757064617465643e0a
6567	1	1162	14	2017-04-24 12:16:31.149	I	\N
6661	1	60	1	2017-04-24 12:22:43.068	I	\N
6662	1	81	23	2017-04-24 12:22:43.079	I	\N
6439	1	1057	14	2017-04-24 12:14:31.051	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3237333c2f6c617374757064617465643e0a
6440	1	1058	14	2017-04-24 12:14:31.052	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3237363c2f6c617374757064617465643e0a
6441	1	1059	14	2017-04-24 12:14:31.054	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3237393c2f6c617374757064617465643e0a
6442	1	1060	14	2017-04-24 12:14:31.055	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3238323c2f6c617374757064617465643e0a
6443	1	1061	14	2017-04-24 12:14:31.057	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3238353c2f6c617374757064617465643e0a
6444	1	1084	14	2017-04-24 12:14:31.118	I	\N
6445	1	1085	14	2017-04-24 12:14:31.141	I	\N
6446	1	1086	14	2017-04-24 12:14:31.144	I	\N
6447	1	1087	14	2017-04-24 12:14:31.147	I	\N
6448	1	1088	14	2017-04-24 12:14:31.15	I	\N
6449	1	1089	14	2017-04-24 12:14:31.154	I	\N
6450	1	1090	14	2017-04-24 12:14:31.157	I	\N
6451	1	1091	14	2017-04-24 12:14:31.16	I	\N
6452	1	1092	14	2017-04-24 12:14:31.163	I	\N
6453	1	1093	14	2017-04-24 12:14:31.166	I	\N
6454	1	1094	14	2017-04-24 12:14:31.169	I	\N
6455	1	1095	14	2017-04-24 12:14:31.172	I	\N
6456	1	1096	14	2017-04-24 12:14:31.175	I	\N
6457	1	1097	14	2017-04-24 12:14:31.178	I	\N
6458	1	1098	14	2017-04-24 12:14:31.18	I	\N
6459	1	1099	14	2017-04-24 12:14:31.183	I	\N
6460	1	1100	14	2017-04-24 12:14:31.186	I	\N
6461	1	1101	14	2017-04-24 12:14:31.189	I	\N
6462	1	1102	14	2017-04-24 12:14:31.192	I	\N
6463	1	1103	14	2017-04-24 12:14:31.195	I	\N
6464	1	1104	14	2017-04-24 12:14:31.199	I	\N
6465	1	1105	14	2017-04-24 12:14:31.202	I	\N
6466	1	1106	14	2017-04-24 12:14:31.205	I	\N
6467	1	1033	14	2017-04-24 12:14:31.213	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3134353c2f6c617374757064617465643e0a
6468	1	1107	14	2017-04-24 12:14:31.216	I	\N
6469	1	1078	14	2017-04-24 12:14:31.223	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3430323c2f6c617374757064617465643e0a
6470	1	1079	14	2017-04-24 12:14:31.225	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3430353c2f6c617374757064617465643e0a
6471	1	1108	14	2017-04-24 12:14:31.228	I	\N
6472	1	1109	14	2017-04-24 12:14:31.231	I	\N
6473	1	1070	14	2017-04-24 12:14:31.239	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3335323c2f6c617374757064617465643e0a
6474	1	1071	14	2017-04-24 12:14:31.241	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3335353c2f6c617374757064617465643e0a
6475	1	1072	14	2017-04-24 12:14:31.242	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3335383c2f6c617374757064617465643e0a
6476	1	1073	14	2017-04-24 12:14:31.243	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3336313c2f6c617374757064617465643e0a
6477	1	1074	14	2017-04-24 12:14:31.244	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3336343c2f6c617374757064617465643e0a
6478	1	1110	14	2017-04-24 12:14:31.252	I	\N
6479	1	1111	14	2017-04-24 12:14:31.256	I	\N
6480	1	1112	14	2017-04-24 12:14:31.259	I	\N
6481	1	1113	14	2017-04-24 12:14:31.262	I	\N
6482	1	1114	14	2017-04-24 12:14:31.265	I	\N
6483	1	1062	14	2017-04-24 12:14:31.276	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3239353c2f6c617374757064617465643e0a
6484	1	1115	14	2017-04-24 12:14:31.279	I	\N
6485	1	1063	14	2017-04-24 12:14:31.286	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3331373c2f6c617374757064617465643e0a
6486	1	1064	14	2017-04-24 12:14:31.288	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e33323c2f6c617374757064617465643e0a
6487	1	1065	14	2017-04-24 12:14:31.289	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3332333c2f6c617374757064617465643e0a
6488	1	1066	14	2017-04-24 12:14:31.29	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3332363c2f6c617374757064617465643e0a
6489	1	1067	14	2017-04-24 12:14:31.292	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3332393c2f6c617374757064617465643e0a
6490	1	1068	14	2017-04-24 12:14:31.293	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3333323c2f6c617374757064617465643e0a
6491	1	1069	14	2017-04-24 12:14:31.294	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3333343c2f6c617374757064617465643e0a
6492	1	1116	14	2017-04-24 12:14:31.302	I	\N
6493	1	1117	14	2017-04-24 12:14:31.305	I	\N
6494	1	1118	14	2017-04-24 12:14:31.309	I	\N
6495	1	1119	14	2017-04-24 12:14:31.312	I	\N
6496	1	1120	14	2017-04-24 12:14:31.316	I	\N
6497	1	1121	14	2017-04-24 12:14:31.319	I	\N
6498	1	1122	14	2017-04-24 12:14:31.322	I	\N
6499	1	1028	14	2017-04-24 12:14:31.33	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3132333c2f6c617374757064617465643e0a
6500	1	1029	14	2017-04-24 12:14:31.331	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3132363c2f6c617374757064617465643e0a
6501	1	1030	14	2017-04-24 12:14:31.333	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3132393c2f6c617374757064617465643e0a
6502	1	1031	14	2017-04-24 12:14:31.334	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3133323c2f6c617374757064617465643e0a
6503	1	1032	14	2017-04-24 12:14:31.335	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3133353c2f6c617374757064617465643e0a
6504	1	1123	14	2017-04-24 12:14:31.342	I	\N
6505	1	1124	14	2017-04-24 12:14:31.345	I	\N
6506	1	1125	14	2017-04-24 12:14:31.348	I	\N
6507	1	1126	14	2017-04-24 12:14:31.351	I	\N
6508	1	1127	14	2017-04-24 12:14:31.354	I	\N
6509	1	1034	14	2017-04-24 12:14:31.363	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3136323c2f6c617374757064617465643e0a
6510	1	1035	14	2017-04-24 12:14:31.364	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3136353c2f6c617374757064617465643e0a
6511	1	1036	14	2017-04-24 12:14:31.365	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3136383c2f6c617374757064617465643e0a
6644	1	59	45	2017-04-24 12:17:00.152	I	\N
6512	1	1037	14	2017-04-24 12:14:31.367	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3137313c2f6c617374757064617465643e0a
6513	1	1038	14	2017-04-24 12:14:31.368	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3137333c2f6c617374757064617465643e0a
6514	1	1128	14	2017-04-24 12:14:31.375	I	\N
6515	1	1129	14	2017-04-24 12:14:31.378	I	\N
6516	1	1130	14	2017-04-24 12:14:31.381	I	\N
6517	1	1131	14	2017-04-24 12:14:31.384	I	\N
6518	1	1132	14	2017-04-24 12:14:31.388	I	\N
6519	1	1075	14	2017-04-24 12:14:31.396	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3337343c2f6c617374757064617465643e0a
6520	1	1133	14	2017-04-24 12:14:31.399	I	\N
6521	1	1080	14	2017-04-24 12:14:31.411	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e34333c2f6c617374757064617465643e0a
6522	1	1081	14	2017-04-24 12:14:31.413	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3433333c2f6c617374757064617465643e0a
6523	1	1082	14	2017-04-24 12:14:31.414	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3433363c2f6c617374757064617465643e0a
6524	1	1083	14	2017-04-24 12:14:31.416	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3433393c2f6c617374757064617465643e0a
6525	1	1134	14	2017-04-24 12:14:31.422	I	\N
6526	1	1135	14	2017-04-24 12:14:31.427	I	\N
6527	1	1136	14	2017-04-24 12:14:31.43	I	\N
6528	1	1137	14	2017-04-24 12:14:31.434	I	\N
6529	1	1076	14	2017-04-24 12:14:31.442	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3338373c2f6c617374757064617465643e0a
6530	1	1077	14	2017-04-24 12:14:31.443	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d31322031313a31343a31362e3338393c2f6c617374757064617465643e0a
6531	1	1138	14	2017-04-24 12:14:31.448	I	\N
6532	1	1139	14	2017-04-24 12:14:31.451	I	\N
6533	1	58	1	2017-04-24 12:15:15.16	I	\N
6534	1	79	23	2017-04-24 12:15:15.162	I	\N
6535	1	539	4	2017-04-24 12:15:15.165	I	\N
6536	1	58	45	2017-04-24 12:15:15.168	I	\N
6402	1	1084	14	2017-04-24 12:16:31.029	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3131383c2f6c617374757064617465643e0a
6403	1	1085	14	2017-04-24 12:16:31.03	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3134313c2f6c617374757064617465643e0a
6404	1	1086	14	2017-04-24 12:16:31.032	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3134343c2f6c617374757064617465643e0a
6405	1	1087	14	2017-04-24 12:16:31.034	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3134373c2f6c617374757064617465643e0a
6406	1	1088	14	2017-04-24 12:16:31.035	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e31353c2f6c617374757064617465643e0a
6407	1	1089	14	2017-04-24 12:16:31.037	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3135343c2f6c617374757064617465643e0a
6408	1	1090	14	2017-04-24 12:16:31.038	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3135373c2f6c617374757064617465643e0a
6409	1	1091	14	2017-04-24 12:16:31.039	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e31363c2f6c617374757064617465643e0a
6410	1	1092	14	2017-04-24 12:16:31.04	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3136333c2f6c617374757064617465643e0a
6411	1	1093	14	2017-04-24 12:16:31.043	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3136363c2f6c617374757064617465643e0a
6412	1	1094	14	2017-04-24 12:16:31.044	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3136393c2f6c617374757064617465643e0a
6413	1	1095	14	2017-04-24 12:16:31.045	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3137323c2f6c617374757064617465643e0a
6414	1	1096	14	2017-04-24 12:16:31.046	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3137353c2f6c617374757064617465643e0a
6415	1	1097	14	2017-04-24 12:16:31.047	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3137383c2f6c617374757064617465643e0a
6416	1	1098	14	2017-04-24 12:16:31.049	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e31383c2f6c617374757064617465643e0a
6417	1	1099	14	2017-04-24 12:16:31.05	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3138333c2f6c617374757064617465643e0a
6418	1	1100	14	2017-04-24 12:16:31.051	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3138363c2f6c617374757064617465643e0a
6419	1	1101	14	2017-04-24 12:16:31.052	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3138393c2f6c617374757064617465643e0a
6420	1	1102	14	2017-04-24 12:16:31.054	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3139323c2f6c617374757064617465643e0a
6541	1	1103	14	2017-04-24 12:16:31.055	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3139353c2f6c617374757064617465643e0a
6542	1	1104	14	2017-04-24 12:16:31.056	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3139393c2f6c617374757064617465643e0a
6543	1	1105	14	2017-04-24 12:16:31.058	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3230323c2f6c617374757064617465643e0a
6544	1	1106	14	2017-04-24 12:16:31.059	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3230353c2f6c617374757064617465643e0a
6545	1	1140	14	2017-04-24 12:16:31.079	I	\N
6546	1	1141	14	2017-04-24 12:16:31.083	I	\N
6547	1	1142	14	2017-04-24 12:16:31.086	I	\N
6548	1	1143	14	2017-04-24 12:16:31.09	I	\N
6549	1	1144	14	2017-04-24 12:16:31.093	I	\N
6550	1	1145	14	2017-04-24 12:16:31.096	I	\N
6551	1	1146	14	2017-04-24 12:16:31.1	I	\N
6552	1	1147	14	2017-04-24 12:16:31.103	I	\N
6553	1	1148	14	2017-04-24 12:16:31.106	I	\N
6554	1	1149	14	2017-04-24 12:16:31.109	I	\N
6555	1	1150	14	2017-04-24 12:16:31.112	I	\N
6556	1	1151	14	2017-04-24 12:16:31.115	I	\N
6557	1	1152	14	2017-04-24 12:16:31.118	I	\N
6558	1	1153	14	2017-04-24 12:16:31.121	I	\N
6559	1	1154	14	2017-04-24 12:16:31.124	I	\N
6560	1	1155	14	2017-04-24 12:16:31.127	I	\N
6561	1	1156	14	2017-04-24 12:16:31.13	I	\N
6562	1	1157	14	2017-04-24 12:16:31.133	I	\N
6563	1	1158	14	2017-04-24 12:16:31.136	I	\N
6564	1	1159	14	2017-04-24 12:16:31.139	I	\N
6565	1	1160	14	2017-04-24 12:16:31.142	I	\N
6566	1	1161	14	2017-04-24 12:16:31.145	I	\N
6568	1	1116	14	2017-04-24 12:16:31.157	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3330323c2f6c617374757064617465643e0a
6569	1	1117	14	2017-04-24 12:16:31.158	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3330353c2f6c617374757064617465643e0a
6570	1	1118	14	2017-04-24 12:16:31.16	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3330393c2f6c617374757064617465643e0a
6571	1	1119	14	2017-04-24 12:16:31.161	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3331323c2f6c617374757064617465643e0a
6572	1	1120	14	2017-04-24 12:16:31.162	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3331363c2f6c617374757064617465643e0a
6573	1	1121	14	2017-04-24 12:16:31.17	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3331393c2f6c617374757064617465643e0a
6574	1	1122	14	2017-04-24 12:16:31.171	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3332323c2f6c617374757064617465643e0a
6575	1	1163	14	2017-04-24 12:16:31.178	I	\N
6576	1	1164	14	2017-04-24 12:16:31.181	I	\N
6577	1	1165	14	2017-04-24 12:16:31.184	I	\N
6578	1	1166	14	2017-04-24 12:16:31.187	I	\N
6579	1	1167	14	2017-04-24 12:16:31.19	I	\N
6580	1	1168	14	2017-04-24 12:16:31.193	I	\N
6581	1	1169	14	2017-04-24 12:16:31.196	I	\N
6582	1	1110	14	2017-04-24 12:16:31.205	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3235323c2f6c617374757064617465643e0a
6583	1	1111	14	2017-04-24 12:16:31.206	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3235363c2f6c617374757064617465643e0a
6584	1	1112	14	2017-04-24 12:16:31.207	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3235393c2f6c617374757064617465643e0a
6585	1	1113	14	2017-04-24 12:16:31.208	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3236323c2f6c617374757064617465643e0a
6586	1	1114	14	2017-04-24 12:16:31.21	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3236353c2f6c617374757064617465643e0a
6587	1	1170	14	2017-04-24 12:16:31.216	I	\N
6588	1	1171	14	2017-04-24 12:16:31.219	I	\N
6589	1	1172	14	2017-04-24 12:16:31.222	I	\N
6590	1	1173	14	2017-04-24 12:16:31.225	I	\N
6591	1	1174	14	2017-04-24 12:16:31.228	I	\N
6592	1	1108	14	2017-04-24 12:16:31.236	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3232383c2f6c617374757064617465643e0a
6593	1	1109	14	2017-04-24 12:16:31.238	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3233313c2f6c617374757064617465643e0a
6594	1	1175	14	2017-04-24 12:16:31.242	I	\N
6595	1	1176	14	2017-04-24 12:16:31.245	I	\N
6596	1	1138	14	2017-04-24 12:16:31.253	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3434383c2f6c617374757064617465643e0a
6597	1	1139	14	2017-04-24 12:16:31.254	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3435313c2f6c617374757064617465643e0a
6598	1	1177	14	2017-04-24 12:16:31.258	I	\N
6599	1	1178	14	2017-04-24 12:16:31.261	I	\N
6600	1	1133	14	2017-04-24 12:16:31.27	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3339393c2f6c617374757064617465643e0a
6601	1	1179	14	2017-04-24 12:16:31.274	I	\N
6602	1	1107	14	2017-04-24 12:16:31.284	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3231363c2f6c617374757064617465643e0a
6603	1	1180	14	2017-04-24 12:16:31.287	I	\N
6604	1	1128	14	2017-04-24 12:16:31.295	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3337353c2f6c617374757064617465643e0a
6605	1	1129	14	2017-04-24 12:16:31.297	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3337383c2f6c617374757064617465643e0a
6606	1	1130	14	2017-04-24 12:16:31.298	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3338313c2f6c617374757064617465643e0a
6607	1	1131	14	2017-04-24 12:16:31.299	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3338343c2f6c617374757064617465643e0a
6608	1	1132	14	2017-04-24 12:16:31.301	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3338383c2f6c617374757064617465643e0a
6609	1	1181	14	2017-04-24 12:16:31.307	I	\N
6610	1	1182	14	2017-04-24 12:16:31.311	I	\N
6611	1	1183	14	2017-04-24 12:16:31.314	I	\N
6612	1	1184	14	2017-04-24 12:16:31.317	I	\N
6613	1	1185	14	2017-04-24 12:16:31.32	I	\N
6614	1	1115	14	2017-04-24 12:16:31.329	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3237393c2f6c617374757064617465643e0a
6615	1	1186	14	2017-04-24 12:16:31.332	I	\N
6616	1	1123	14	2017-04-24 12:16:31.34	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3334323c2f6c617374757064617465643e0a
6617	1	1124	14	2017-04-24 12:16:31.341	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3334353c2f6c617374757064617465643e0a
6618	1	1125	14	2017-04-24 12:16:31.343	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3334383c2f6c617374757064617465643e0a
6619	1	1126	14	2017-04-24 12:16:31.344	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3335313c2f6c617374757064617465643e0a
6620	1	1127	14	2017-04-24 12:16:31.346	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3335343c2f6c617374757064617465643e0a
6621	1	1187	14	2017-04-24 12:16:31.352	I	\N
6622	1	1188	14	2017-04-24 12:16:31.356	I	\N
6623	1	1189	14	2017-04-24 12:16:31.359	I	\N
6624	1	1190	14	2017-04-24 12:16:31.362	I	\N
6625	1	1191	14	2017-04-24 12:16:31.366	I	\N
6626	1	1134	14	2017-04-24 12:16:31.374	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3432323c2f6c617374757064617465643e0a
6627	1	1135	14	2017-04-24 12:16:31.375	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3432373c2f6c617374757064617465643e0a
6628	1	1136	14	2017-04-24 12:16:31.377	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e34333c2f6c617374757064617465643e0a
6629	1	1137	14	2017-04-24 12:16:31.378	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31343a33312e3433343c2f6c617374757064617465643e0a
6630	1	1192	14	2017-04-24 12:16:31.384	I	\N
6631	1	1193	14	2017-04-24 12:16:31.387	I	\N
6632	1	1194	14	2017-04-24 12:16:31.391	I	\N
6633	1	1195	14	2017-04-24 12:16:31.394	I	\N
6641	1	59	1	2017-04-24 12:17:00.138	I	\N
6642	1	80	23	2017-04-24 12:17:00.141	I	\N
6643	1	540	4	2017-04-24 12:17:00.15	I	\N
6663	1	541	4	2017-04-24 12:22:43.085	I	\N
6664	1	60	45	2017-04-24 12:22:43.09	I	\N
6681	1	130	21	2017-04-24 12:22:46.437	I	\N
6682	1	124	155	2017-04-24 12:22:46.443	I	\N
6683	1	59	1	2017-04-24 12:22:46.462	U	\\x3c73746174757349643e313c2f73746174757349643e0a
6701	1	131	21	2017-04-24 12:23:01.935	I	\N
6702	1	125	155	2017-04-24 12:23:01.939	I	\N
6703	1	60	1	2017-04-24 12:23:01.953	U	\\x3c73746174757349643e313c2f73746174757349643e0a
6721	1	1643	211	2017-04-24 12:31:45.157	D	\\x3c747970654f6653616d706c6549643e39313c2f747970654f6653616d706c6549643e0a3c7465737449643e3837353c2f7465737449643e0a
6722	1	1644	211	2017-04-24 12:31:45.168	I	\N
6741	1	1642	211	2017-04-24 14:37:15.121	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c7465737449643e3836373c2f7465737449643e0a
6742	1	1645	211	2017-04-24 14:37:15.132	I	\N
6743	1	148	212	2017-04-24 14:37:15.135	D	\\x3c747970654f6653616d706c6549643e39303c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39333c2f70616e656c49643e0a
6761	1	1186	14	2017-04-24 14:38:01.192	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3333323c2f6c617374757064617465643e0a
6762	1	1196	14	2017-04-24 14:38:01.201	I	\N
6763	1	1187	14	2017-04-24 14:38:01.211	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3335323c2f6c617374757064617465643e0a
6764	1	1188	14	2017-04-24 14:38:01.213	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3335363c2f6c617374757064617465643e0a
6765	1	1189	14	2017-04-24 14:38:01.214	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3335393c2f6c617374757064617465643e0a
6766	1	1190	14	2017-04-24 14:38:01.218	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3336323c2f6c617374757064617465643e0a
6767	1	1191	14	2017-04-24 14:38:01.219	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3336363c2f6c617374757064617465643e0a
6768	1	1197	14	2017-04-24 14:38:01.225	I	\N
6769	1	1198	14	2017-04-24 14:38:01.229	I	\N
6770	1	1199	14	2017-04-24 14:38:01.232	I	\N
6771	1	1200	14	2017-04-24 14:38:01.235	I	\N
6772	1	1201	14	2017-04-24 14:38:01.239	I	\N
6773	1	1170	14	2017-04-24 14:38:01.248	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3231363c2f6c617374757064617465643e0a
6774	1	1171	14	2017-04-24 14:38:01.25	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3231393c2f6c617374757064617465643e0a
6775	1	1172	14	2017-04-24 14:38:01.252	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3232323c2f6c617374757064617465643e0a
6776	1	1173	14	2017-04-24 14:38:01.253	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3232353c2f6c617374757064617465643e0a
6777	1	1174	14	2017-04-24 14:38:01.254	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3232383c2f6c617374757064617465643e0a
6778	1	1202	14	2017-04-24 14:38:01.26	I	\N
6779	1	1203	14	2017-04-24 14:38:01.263	I	\N
6780	1	1204	14	2017-04-24 14:38:01.266	I	\N
6781	1	1205	14	2017-04-24 14:38:01.269	I	\N
6782	1	1206	14	2017-04-24 14:38:01.272	I	\N
6783	1	1179	14	2017-04-24 14:38:01.28	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3237343c2f6c617374757064617465643e0a
6784	1	1207	14	2017-04-24 14:38:01.282	I	\N
6785	1	1140	14	2017-04-24 14:38:01.29	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3037393c2f6c617374757064617465643e0a
6786	1	1141	14	2017-04-24 14:38:01.292	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3038333c2f6c617374757064617465643e0a
6787	1	1142	14	2017-04-24 14:38:01.294	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3038363c2f6c617374757064617465643e0a
6788	1	1143	14	2017-04-24 14:38:01.295	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e30393c2f6c617374757064617465643e0a
6789	1	1144	14	2017-04-24 14:38:01.296	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3039333c2f6c617374757064617465643e0a
6790	1	1145	14	2017-04-24 14:38:01.298	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3039363c2f6c617374757064617465643e0a
6791	1	1146	14	2017-04-24 14:38:01.299	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e313c2f6c617374757064617465643e0a
6792	1	1147	14	2017-04-24 14:38:01.3	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3130333c2f6c617374757064617465643e0a
6793	1	1148	14	2017-04-24 14:38:01.301	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3130363c2f6c617374757064617465643e0a
6794	1	1149	14	2017-04-24 14:38:01.303	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3130393c2f6c617374757064617465643e0a
6795	1	1150	14	2017-04-24 14:38:01.313	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3131323c2f6c617374757064617465643e0a
6796	1	1151	14	2017-04-24 14:38:01.314	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3131353c2f6c617374757064617465643e0a
6797	1	1152	14	2017-04-24 14:38:01.315	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3131383c2f6c617374757064617465643e0a
6798	1	1153	14	2017-04-24 14:38:01.317	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3132313c2f6c617374757064617465643e0a
6799	1	1154	14	2017-04-24 14:38:01.318	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3132343c2f6c617374757064617465643e0a
6800	1	1155	14	2017-04-24 14:38:01.319	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3132373c2f6c617374757064617465643e0a
6801	1	1156	14	2017-04-24 14:38:01.32	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e31333c2f6c617374757064617465643e0a
6802	1	1157	14	2017-04-24 14:38:01.322	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3133333c2f6c617374757064617465643e0a
6803	1	1158	14	2017-04-24 14:38:01.323	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3133363c2f6c617374757064617465643e0a
6804	1	1159	14	2017-04-24 14:38:01.324	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3133393c2f6c617374757064617465643e0a
6805	1	1160	14	2017-04-24 14:38:01.326	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3134323c2f6c617374757064617465643e0a
6806	1	1161	14	2017-04-24 14:38:01.327	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3134353c2f6c617374757064617465643e0a
6807	1	1162	14	2017-04-24 14:38:01.328	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3134393c2f6c617374757064617465643e0a
6808	1	1208	14	2017-04-24 14:38:01.346	I	\N
6809	1	1209	14	2017-04-24 14:38:01.349	I	\N
6810	1	1210	14	2017-04-24 14:38:01.352	I	\N
6811	1	1211	14	2017-04-24 14:38:01.355	I	\N
6812	1	1212	14	2017-04-24 14:38:01.358	I	\N
6813	1	1213	14	2017-04-24 14:38:01.361	I	\N
6814	1	1214	14	2017-04-24 14:38:01.364	I	\N
6815	1	1215	14	2017-04-24 14:38:01.367	I	\N
6816	1	1216	14	2017-04-24 14:38:01.37	I	\N
6817	1	1217	14	2017-04-24 14:38:01.372	I	\N
6818	1	1218	14	2017-04-24 14:38:01.375	I	\N
6819	1	1219	14	2017-04-24 14:38:01.378	I	\N
6820	1	1220	14	2017-04-24 14:38:01.381	I	\N
6821	1	1221	14	2017-04-24 14:38:01.384	I	\N
6822	1	1222	14	2017-04-24 14:38:01.387	I	\N
6823	1	1223	14	2017-04-24 14:38:01.39	I	\N
6824	1	1224	14	2017-04-24 14:38:01.393	I	\N
6825	1	1225	14	2017-04-24 14:38:01.396	I	\N
6826	1	1226	14	2017-04-24 14:38:01.399	I	\N
6827	1	1227	14	2017-04-24 14:38:01.402	I	\N
6828	1	1228	14	2017-04-24 14:38:01.405	I	\N
6829	1	1229	14	2017-04-24 14:38:01.408	I	\N
6830	1	1230	14	2017-04-24 14:38:01.412	I	\N
6831	1	1181	14	2017-04-24 14:38:01.42	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3330373c2f6c617374757064617465643e0a
6832	1	1182	14	2017-04-24 14:38:01.422	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3331313c2f6c617374757064617465643e0a
6833	1	1183	14	2017-04-24 14:38:01.423	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3331343c2f6c617374757064617465643e0a
6834	1	1184	14	2017-04-24 14:38:01.424	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3331373c2f6c617374757064617465643e0a
6835	1	1185	14	2017-04-24 14:38:01.426	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e33323c2f6c617374757064617465643e0a
6836	1	1231	14	2017-04-24 14:38:01.432	I	\N
6837	1	1232	14	2017-04-24 14:38:01.435	I	\N
6838	1	1233	14	2017-04-24 14:38:01.438	I	\N
6839	1	1234	14	2017-04-24 14:38:01.442	I	\N
6840	1	1235	14	2017-04-24 14:38:01.445	I	\N
6841	1	1175	14	2017-04-24 14:38:01.454	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3234323c2f6c617374757064617465643e0a
6842	1	1176	14	2017-04-24 14:38:01.455	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3234353c2f6c617374757064617465643e0a
6843	1	1236	14	2017-04-24 14:38:01.459	I	\N
6844	1	1237	14	2017-04-24 14:38:01.462	I	\N
6845	1	1163	14	2017-04-24 14:38:01.469	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3137383c2f6c617374757064617465643e0a
6846	1	1164	14	2017-04-24 14:38:01.471	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3138313c2f6c617374757064617465643e0a
6847	1	1165	14	2017-04-24 14:38:01.472	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3138343c2f6c617374757064617465643e0a
6848	1	1166	14	2017-04-24 14:38:01.473	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3138373c2f6c617374757064617465643e0a
6849	1	1167	14	2017-04-24 14:38:01.475	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e31393c2f6c617374757064617465643e0a
6850	1	1168	14	2017-04-24 14:38:01.476	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3139333c2f6c617374757064617465643e0a
6851	1	1169	14	2017-04-24 14:38:01.477	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3139363c2f6c617374757064617465643e0a
6852	1	1238	14	2017-04-24 14:38:01.485	I	\N
6853	1	1239	14	2017-04-24 14:38:01.488	I	\N
6854	1	1240	14	2017-04-24 14:38:01.491	I	\N
6855	1	1241	14	2017-04-24 14:38:01.494	I	\N
6856	1	1242	14	2017-04-24 14:38:01.497	I	\N
6857	1	1243	14	2017-04-24 14:38:01.5	I	\N
6858	1	1244	14	2017-04-24 14:38:01.503	I	\N
6859	1	1177	14	2017-04-24 14:38:01.511	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3235383c2f6c617374757064617465643e0a
6860	1	1178	14	2017-04-24 14:38:01.513	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3236313c2f6c617374757064617465643e0a
6861	1	1245	14	2017-04-24 14:38:01.517	I	\N
6862	1	1246	14	2017-04-24 14:38:01.52	I	\N
6863	1	1192	14	2017-04-24 14:38:01.529	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3338343c2f6c617374757064617465643e0a
6864	1	1193	14	2017-04-24 14:38:01.53	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3338373c2f6c617374757064617465643e0a
6865	1	1194	14	2017-04-24 14:38:01.532	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3339313c2f6c617374757064617465643e0a
6866	1	1195	14	2017-04-24 14:38:01.533	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3339343c2f6c617374757064617465643e0a
6867	1	1247	14	2017-04-24 14:38:01.539	I	\N
6868	1	1248	14	2017-04-24 14:38:01.542	I	\N
6869	1	1249	14	2017-04-24 14:38:01.545	I	\N
6870	1	1250	14	2017-04-24 14:38:01.549	I	\N
6881	1	61	1	2017-04-24 14:39:45.114	I	\N
6882	1	82	23	2017-04-24 14:39:45.117	I	\N
6883	1	542	4	2017-04-24 14:39:45.122	I	\N
6884	1	61	45	2017-04-24 14:39:45.125	I	\N
6901	1	132	21	2017-04-24 14:41:10.526	I	\N
6902	1	126	155	2017-04-24 14:41:10.529	I	\N
6903	1	61	1	2017-04-24 14:41:10.54	U	\\x3c73746174757349643e313c2f73746174757349643e0a
6921	1	62	1	2017-04-24 14:45:15.128	I	\N
6922	1	83	23	2017-04-24 14:45:15.132	I	\N
6923	1	543	4	2017-04-24 14:45:15.136	I	\N
6924	1	62	45	2017-04-24 14:45:15.139	I	\N
6941	1	2671	32	2017-04-24 14:52:15.066	I	\N
6942	1	2672	32	2017-04-24 14:52:15.07	I	\N
6961	1	1207	14	2017-04-24 15:03:00.115	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3238323c2f6c617374757064617465643e0a
6962	1	1251	14	2017-04-24 15:03:00.118	I	\N
6963	1	1252	14	2017-04-24 15:03:00.12	I	\N
6981	1	1251	14	2017-04-24 15:08:30.092	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e673c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031353a30333a30302e3131383c2f6c617374757064617465643e0a
6982	1	1252	14	2017-04-24 15:08:30.097	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e506f7374207072616e6469616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031353a30333a30302e31323c2f6c617374757064617465643e0a
6983	1	1253	14	2017-04-24 15:08:30.102	I	\N
6984	1	1254	14	2017-04-24 15:08:30.104	I	\N
6985	1	1255	14	2017-04-24 15:08:30.108	I	\N
7120	1	1617	211	2017-04-24 15:09:45.058	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834333c2f7465737449643e0a
6986	1	1231	14	2017-04-24 15:08:45.992	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e557265613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3433323c2f6c617374757064617465643e0a
6987	1	1232	14	2017-04-24 15:08:45.994	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4372656174696e696e653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3433353c2f6c617374757064617465643e0a
6988	1	1233	14	2017-04-24 15:08:45.997	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e536f6469756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3433383c2f6c617374757064617465643e0a
6989	1	1234	14	2017-04-24 15:08:46	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e506f7461737369756d3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3434323c2f6c617374757064617465643e0a
6990	1	1235	14	2017-04-24 15:08:46.001	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e43686c6f726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3434353c2f6c617374757064617465643e0a
6991	1	1256	14	2017-04-24 15:08:46.01	I	\N
6992	1	1257	14	2017-04-24 15:08:46.013	I	\N
6993	1	1258	14	2017-04-24 15:08:46.016	I	\N
6994	1	1259	14	2017-04-24 15:08:46.019	I	\N
6995	1	1260	14	2017-04-24 15:08:46.022	I	\N
6996	1	1197	14	2017-04-24 15:08:46.029	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e574243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3232353c2f6c617374757064617465643e0a
6997	1	1198	14	2017-04-24 15:08:46.03	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e524243202853746f6f6c293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3232393c2f6c617374757064617465643e0a
6998	1	1199	14	2017-04-24 15:08:46.031	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4f76613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3233323c2f6c617374757064617465643e0a
6999	1	1200	14	2017-04-24 15:08:46.032	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e416d6f6562613c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3233353c2f6c617374757064617465643e0a
7000	1	1201	14	2017-04-24 15:08:46.034	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e437973743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3233393c2f6c617374757064617465643e0a
7001	1	1261	14	2017-04-24 15:08:46.039	I	\N
7002	1	1262	14	2017-04-24 15:08:46.042	I	\N
7003	1	1263	14	2017-04-24 15:08:46.045	I	\N
7004	1	1264	14	2017-04-24 15:08:46.048	I	\N
7005	1	1265	14	2017-04-24 15:08:46.051	I	\N
7006	1	1245	14	2017-04-24 15:08:46.059	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e41424f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3531373c2f6c617374757064617465643e0a
7007	1	1246	14	2017-04-24 15:08:46.06	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52683c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e35323c2f6c617374757064617465643e0a
7008	1	1266	14	2017-04-24 15:08:46.064	I	\N
7009	1	1267	14	2017-04-24 15:08:46.067	I	\N
7010	1	1247	14	2017-04-24 15:08:46.074	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e532e20547968686920483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3533393c2f6c617374757064617465643e0a
7011	1	1248	14	2017-04-24 15:08:46.075	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e532e205479686869204f3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3534323c2f6c617374757064617465643e0a
7012	1	1249	14	2017-04-24 15:08:46.077	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692041483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3534353c2f6c617374757064617465643e0a
7013	1	1250	14	2017-04-24 15:08:46.078	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e532e20506172612054796868692042483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3534393c2f6c617374757064617465643e0a
7014	1	1268	14	2017-04-24 15:08:46.082	I	\N
7015	1	1269	14	2017-04-24 15:08:46.085	I	\N
7016	1	1270	14	2017-04-24 15:08:46.088	I	\N
7017	1	1271	14	2017-04-24 15:08:46.091	I	\N
7018	1	1202	14	2017-04-24 15:08:46.098	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53474f543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e32363c2f6c617374757064617465643e0a
7019	1	1203	14	2017-04-24 15:08:46.099	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e534750543c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3236333c2f6c617374757064617465643e0a
7020	1	1204	14	2017-04-24 15:08:46.101	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e414c503c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3236363c2f6c617374757064617465643e0a
7021	1	1205	14	2017-04-24 15:08:46.102	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3236393c2f6c617374757064617465643e0a
7022	1	1206	14	2017-04-24 15:08:46.103	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4469726563742042696c69727562696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3237323c2f6c617374757064617465643e0a
7023	1	1272	14	2017-04-24 15:08:46.109	I	\N
7024	1	1273	14	2017-04-24 15:08:46.111	I	\N
7025	1	1274	14	2017-04-24 15:08:46.12	I	\N
7026	1	1275	14	2017-04-24 15:08:46.123	I	\N
7027	1	1276	14	2017-04-24 15:08:46.126	I	\N
7028	1	1236	14	2017-04-24 15:08:46.133	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c2043686f6c65737465726f6c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3435393c2f6c617374757064617465643e0a
7029	1	1237	14	2017-04-24 15:08:46.134	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e547269676c796365726964653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3436323c2f6c617374757064617465643e0a
7030	1	1277	14	2017-04-24 15:08:46.138	I	\N
7031	1	1278	14	2017-04-24 15:08:46.141	I	\N
7032	1	1253	14	2017-04-24 15:08:46.148	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e46617374696e6720426c6f6f6420476c75636f73653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031353a30383a33302e3130323c2f6c617374757064617465643e0a
7033	1	1254	14	2017-04-24 15:08:46.149	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e506f7374207072616e6469616c20426c6f6f6420476c75636f73653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031353a30383a33302e3130343c2f6c617374757064617465643e0a
7034	1	1255	14	2017-04-24 15:08:46.151	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e52616e646f6d20426c6f6f6420476c75636f73653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031353a30383a33302e3130383c2f6c617374757064617465643e0a
7035	1	1279	14	2017-04-24 15:08:46.155	I	\N
7036	1	1280	14	2017-04-24 15:08:46.158	I	\N
7037	1	1281	14	2017-04-24 15:08:46.161	I	\N
7038	1	1196	14	2017-04-24 15:08:46.168	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e53707574756d20414642207820333c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3230313c2f6c617374757064617465643e0a
7039	1	1282	14	2017-04-24 15:08:46.171	I	\N
7040	1	1208	14	2017-04-24 15:08:46.178	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e5742432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3334363c2f6c617374757064617465643e0a
7041	1	1209	14	2017-04-24 15:08:46.18	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e4c796d70686f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3334393c2f6c617374757064617465643e0a
7042	1	1210	14	2017-04-24 15:08:46.181	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f637974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3335323c2f6c617374757064617465643e0a
7043	1	1211	14	2017-04-24 15:08:46.182	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e4e6575742f4772616e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3335353c2f6c617374757064617465643e0a
7044	1	1212	14	2017-04-24 15:08:46.184	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e456f73696e6f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3335383c2f6c617374757064617465643e0a
7045	1	1213	14	2017-04-24 15:08:46.185	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e4261736f7068696c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3336313c2f6c617374757064617465643e0a
7046	1	1214	14	2017-04-24 15:08:46.186	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4d6f6e6f767974653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3336343c2f6c617374757064617465643e0a
7047	1	1215	14	2017-04-24 15:08:46.187	D	\\x3c736f72744f726465723e383c2f736f72744f726465723e0a3c746573744e616d653e5242432028426c6f6f64293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3336373c2f6c617374757064617465643e0a
7048	1	1216	14	2017-04-24 15:08:46.189	D	\\x3c736f72744f726465723e393c2f736f72744f726465723e0a3c746573744e616d653e4d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e33373c2f6c617374757064617465643e0a
7265	1	65	1	2017-04-24 18:34:15.112	I	\N
7049	1	1217	14	2017-04-24 15:08:46.191	D	\\x3c736f72744f726465723e31303c2f736f72744f726465723e0a3c746573744e616d653e48656d61746f637269743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3337323c2f6c617374757064617465643e0a
7050	1	1218	14	2017-04-24 15:08:46.192	D	\\x3c736f72744f726465723e31313c2f736f72744f726465723e0a3c746573744e616d653e4d43483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3337353c2f6c617374757064617465643e0a
7051	1	1219	14	2017-04-24 15:08:46.193	D	\\x3c736f72744f726465723e31323c2f736f72744f726465723e0a3c746573744e616d653e4d4348433c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3337383c2f6c617374757064617465643e0a
7052	1	1220	14	2017-04-24 15:08:46.195	D	\\x3c736f72744f726465723e31333c2f736f72744f726465723e0a3c746573744e616d653e48656d61676c6f62696e3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3338313c2f6c617374757064617465643e0a
7053	1	1221	14	2017-04-24 15:08:46.196	D	\\x3c736f72744f726465723e31343c2f736f72744f726465723e0a3c746573744e616d653e5244572d53443c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3338343c2f6c617374757064617465643e0a
7054	1	1222	14	2017-04-24 15:08:46.197	D	\\x3c736f72744f726465723e31353c2f736f72744f726465723e0a3c746573744e616d653e5244572d43563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3338373c2f6c617374757064617465643e0a
7055	1	1223	14	2017-04-24 15:08:46.198	D	\\x3c736f72744f726465723e31363c2f736f72744f726465723e0a3c746573744e616d653e506c6174656c65743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e33393c2f6c617374757064617465643e0a
7056	1	1224	14	2017-04-24 15:08:46.2	D	\\x3c736f72744f726465723e31373c2f736f72744f726465723e0a3c746573744e616d653e4d50563c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3339333c2f6c617374757064617465643e0a
7057	1	1225	14	2017-04-24 15:08:46.201	D	\\x3c736f72744f726465723e31383c2f736f72744f726465723e0a3c746573744e616d653e426c656564696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3339363c2f6c617374757064617465643e0a
7058	1	1226	14	2017-04-24 15:08:46.202	D	\\x3c736f72744f726465723e31393c2f736f72744f726465723e0a3c746573744e616d653e436c6f7474696e672054696d653c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3339393c2f6c617374757064617465643e0a
7059	1	1227	14	2017-04-24 15:08:46.203	D	\\x3c736f72744f726465723e32303c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204c796d70686f6379746520436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3430323c2f6c617374757064617465643e0a
7060	1	1228	14	2017-04-24 15:08:46.205	D	\\x3c736f72744f726465723e32313c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204e6575742f4772616e20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3430353c2f6c617374757064617465643e0a
7061	1	1229	14	2017-04-24 15:08:46.206	D	\\x3c736f72744f726465723e32323c2f736f72744f726465723e0a3c746573744e616d653e546f74616c20456f73696e6f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3430383c2f6c617374757064617465643e0a
7062	1	1230	14	2017-04-24 15:08:46.207	D	\\x3c736f72744f726465723e32333c2f736f72744f726465723e0a3c746573744e616d653e546f74616c204261736f7068696c20436f756e743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3431323c2f6c617374757064617465643e0a
7063	1	1283	14	2017-04-24 15:08:46.228	I	\N
7064	1	1284	14	2017-04-24 15:08:46.231	I	\N
7065	1	1285	14	2017-04-24 15:08:46.234	I	\N
7066	1	1286	14	2017-04-24 15:08:46.237	I	\N
7067	1	1287	14	2017-04-24 15:08:46.24	I	\N
7068	1	1288	14	2017-04-24 15:08:46.243	I	\N
7069	1	1289	14	2017-04-24 15:08:46.247	I	\N
7070	1	1290	14	2017-04-24 15:08:46.25	I	\N
7071	1	1291	14	2017-04-24 15:08:46.253	I	\N
7072	1	1292	14	2017-04-24 15:08:46.256	I	\N
7073	1	1293	14	2017-04-24 15:08:46.259	I	\N
7074	1	1294	14	2017-04-24 15:08:46.262	I	\N
7075	1	1295	14	2017-04-24 15:08:46.265	I	\N
7076	1	1296	14	2017-04-24 15:08:46.268	I	\N
7077	1	1297	14	2017-04-24 15:08:46.271	I	\N
7078	1	1298	14	2017-04-24 15:08:46.275	I	\N
7079	1	1299	14	2017-04-24 15:08:46.278	I	\N
7080	1	1300	14	2017-04-24 15:08:46.281	I	\N
7081	1	1301	14	2017-04-24 15:08:46.285	I	\N
7082	1	1302	14	2017-04-24 15:08:46.288	I	\N
7083	1	1303	14	2017-04-24 15:08:46.291	I	\N
7084	1	1304	14	2017-04-24 15:08:46.294	I	\N
7085	1	1305	14	2017-04-24 15:08:46.297	I	\N
7086	1	1238	14	2017-04-24 15:08:46.305	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e57424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3438353c2f6c617374757064617465643e0a
7087	1	1239	14	2017-04-24 15:08:46.306	D	\\x3c736f72744f726465723e323c2f736f72744f726465723e0a3c746573744e616d653e52424320285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3438383c2f6c617374757064617465643e0a
7088	1	1240	14	2017-04-24 15:08:46.308	D	\\x3c736f72744f726465723e333c2f736f72744f726465723e0a3c746573744e616d653e416c62756d696e20285572696e65293c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3439313c2f6c617374757064617465643e0a
7089	1	1241	14	2017-04-24 15:08:46.31	D	\\x3c736f72744f726465723e343c2f736f72744f726465723e0a3c746573744e616d653e53756761723c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3439343c2f6c617374757064617465643e0a
7090	1	1242	14	2017-04-24 15:08:46.311	D	\\x3c736f72744f726465723e353c2f736f72744f726465723e0a3c746573744e616d653e4570697468656c69616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3439373c2f6c617374757064617465643e0a
7091	1	1243	14	2017-04-24 15:08:46.312	D	\\x3c736f72744f726465723e363c2f736f72744f726465723e0a3c746573744e616d653e436173743c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e353c2f6c617374757064617465643e0a
7092	1	1244	14	2017-04-24 15:08:46.316	D	\\x3c736f72744f726465723e373c2f736f72744f726465723e0a3c746573744e616d653e4372797374616c3c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031343a33383a30312e3530333c2f6c617374757064617465643e0a
7093	1	1306	14	2017-04-24 15:08:46.324	I	\N
7094	1	1307	14	2017-04-24 15:08:46.327	I	\N
7095	1	1308	14	2017-04-24 15:08:46.33	I	\N
7096	1	1309	14	2017-04-24 15:08:46.333	I	\N
7097	1	1310	14	2017-04-24 15:08:46.336	I	\N
7098	1	1311	14	2017-04-24 15:08:46.34	I	\N
7099	1	1312	14	2017-04-24 15:08:46.343	I	\N
7101	1	1598	211	2017-04-24 15:09:45.04	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832343c2f7465737449643e0a
7102	1	1599	211	2017-04-24 15:09:45.044	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832353c2f7465737449643e0a
7103	1	1600	211	2017-04-24 15:09:45.046	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832363c2f7465737449643e0a
7104	1	1601	211	2017-04-24 15:09:45.047	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832373c2f7465737449643e0a
7105	1	1602	211	2017-04-24 15:09:45.047	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832383c2f7465737449643e0a
7106	1	1603	211	2017-04-24 15:09:45.048	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3832393c2f7465737449643e0a
7107	1	1604	211	2017-04-24 15:09:45.049	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833303c2f7465737449643e0a
7108	1	1605	211	2017-04-24 15:09:45.05	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833313c2f7465737449643e0a
7109	1	1606	211	2017-04-24 15:09:45.051	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833323c2f7465737449643e0a
7110	1	1607	211	2017-04-24 15:09:45.051	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833333c2f7465737449643e0a
7111	1	1608	211	2017-04-24 15:09:45.052	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833343c2f7465737449643e0a
7112	1	1609	211	2017-04-24 15:09:45.053	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833353c2f7465737449643e0a
7113	1	1610	211	2017-04-24 15:09:45.054	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833363c2f7465737449643e0a
7114	1	1611	211	2017-04-24 15:09:45.054	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833373c2f7465737449643e0a
7115	1	1612	211	2017-04-24 15:09:45.055	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833383c2f7465737449643e0a
7116	1	1613	211	2017-04-24 15:09:45.056	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3833393c2f7465737449643e0a
7117	1	1614	211	2017-04-24 15:09:45.056	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834303c2f7465737449643e0a
7118	1	1615	211	2017-04-24 15:09:45.057	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834313c2f7465737449643e0a
7119	1	1616	211	2017-04-24 15:09:45.058	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834323c2f7465737449643e0a
7266	1	86	23	2017-04-24 18:34:15.115	I	\N
7121	1	1618	211	2017-04-24 15:09:45.059	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834343c2f7465737449643e0a
7122	1	1619	211	2017-04-24 15:09:45.06	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3831313c2f7465737449643e0a
7123	1	1620	211	2017-04-24 15:09:45.061	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834353c2f7465737449643e0a
7124	1	1621	211	2017-04-24 15:09:45.061	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834363c2f7465737449643e0a
7125	1	1622	211	2017-04-24 15:09:45.062	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834383c2f7465737449643e0a
7126	1	1623	211	2017-04-24 15:09:45.062	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3834393c2f7465737449643e0a
7127	1	1624	211	2017-04-24 15:09:45.063	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835303c2f7465737449643e0a
7128	1	1625	211	2017-04-24 15:09:45.064	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835313c2f7465737449643e0a
7129	1	1626	211	2017-04-24 15:09:45.064	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835323c2f7465737449643e0a
7130	1	1627	211	2017-04-24 15:09:45.065	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835333c2f7465737449643e0a
7131	1	1628	211	2017-04-24 15:09:45.066	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835343c2f7465737449643e0a
7132	1	1629	211	2017-04-24 15:09:45.066	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835353c2f7465737449643e0a
7133	1	1630	211	2017-04-24 15:09:45.067	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835363c2f7465737449643e0a
7134	1	1631	211	2017-04-24 15:09:45.068	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835373c2f7465737449643e0a
7135	1	1632	211	2017-04-24 15:09:45.068	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835383c2f7465737449643e0a
7136	1	1633	211	2017-04-24 15:09:45.069	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3835393c2f7465737449643e0a
7137	1	1634	211	2017-04-24 15:09:45.07	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836303c2f7465737449643e0a
7138	1	1635	211	2017-04-24 15:09:45.07	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836313c2f7465737449643e0a
7139	1	1636	211	2017-04-24 15:09:45.071	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c7465737449643e3836323c2f7465737449643e0a
7140	1	1646	211	2017-04-24 15:09:45.075	I	\N
7141	1	1647	211	2017-04-24 15:09:45.078	I	\N
7142	1	1648	211	2017-04-24 15:09:45.08	I	\N
7143	1	1649	211	2017-04-24 15:09:45.083	I	\N
7144	1	1650	211	2017-04-24 15:09:45.085	I	\N
7145	1	1651	211	2017-04-24 15:09:45.087	I	\N
7146	1	1652	211	2017-04-24 15:09:45.089	I	\N
7147	1	1653	211	2017-04-24 15:09:45.092	I	\N
7148	1	1654	211	2017-04-24 15:09:45.094	I	\N
7149	1	1655	211	2017-04-24 15:09:45.096	I	\N
7150	1	1656	211	2017-04-24 15:09:45.098	I	\N
7151	1	1657	211	2017-04-24 15:09:45.1	I	\N
7152	1	1658	211	2017-04-24 15:09:45.102	I	\N
7153	1	1659	211	2017-04-24 15:09:45.11	I	\N
7154	1	1660	211	2017-04-24 15:09:45.112	I	\N
7155	1	1661	211	2017-04-24 15:09:45.114	I	\N
7156	1	1662	211	2017-04-24 15:09:45.116	I	\N
7157	1	1663	211	2017-04-24 15:09:45.118	I	\N
7158	1	1664	211	2017-04-24 15:09:45.12	I	\N
7159	1	1665	211	2017-04-24 15:09:45.122	I	\N
7160	1	1666	211	2017-04-24 15:09:45.125	I	\N
7161	1	1667	211	2017-04-24 15:09:45.127	I	\N
7162	1	1668	211	2017-04-24 15:09:45.129	I	\N
7163	1	1669	211	2017-04-24 15:09:45.131	I	\N
7164	1	1670	211	2017-04-24 15:09:45.134	I	\N
7165	1	1671	211	2017-04-24 15:09:45.136	I	\N
7166	1	1672	211	2017-04-24 15:09:45.138	I	\N
7167	1	1673	211	2017-04-24 15:09:45.141	I	\N
7168	1	1674	211	2017-04-24 15:09:45.143	I	\N
7169	1	1675	211	2017-04-24 15:09:45.145	I	\N
7170	1	1676	211	2017-04-24 15:09:45.147	I	\N
7171	1	1677	211	2017-04-24 15:09:45.15	I	\N
7172	1	1678	211	2017-04-24 15:09:45.154	I	\N
7173	1	1679	211	2017-04-24 15:09:45.156	I	\N
7174	1	1680	211	2017-04-24 15:09:45.159	I	\N
7175	1	1681	211	2017-04-24 15:09:45.161	I	\N
7176	1	1682	211	2017-04-24 15:09:45.164	I	\N
7177	1	1683	211	2017-04-24 15:09:45.176	I	\N
7178	1	1684	211	2017-04-24 15:09:45.178	I	\N
7179	1	1685	211	2017-04-24 15:09:45.181	I	\N
7180	1	142	212	2017-04-24 15:09:45.183	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38383c2f70616e656c49643e0a
7181	1	143	212	2017-04-24 15:09:45.185	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e38393c2f70616e656c49643e0a
7182	1	144	212	2017-04-24 15:09:45.186	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39303c2f70616e656c49643e0a
7183	1	145	212	2017-04-24 15:09:45.187	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39313c2f70616e656c49643e0a
7184	1	146	212	2017-04-24 15:09:45.188	D	\\x3c747970654f6653616d706c6549643e38353c2f747970654f6653616d706c6549643e0a3c70616e656c49643e39323c2f70616e656c49643e0a
7185	1	149	212	2017-04-24 15:09:45.193	I	\N
7186	1	150	212	2017-04-24 15:09:45.196	I	\N
7187	1	151	212	2017-04-24 15:09:45.199	I	\N
7188	1	152	212	2017-04-24 15:09:45.202	I	\N
7189	1	153	212	2017-04-24 15:09:45.205	I	\N
7201	1	1180	14	2017-04-24 17:41:30.12	D	\\x3c736f72744f726465723e313c2f736f72744f726465723e0a3c746573744e616d653e4b4f483c2f746573744e616d653e0a3c6c617374757064617465643e323031372d30342d32342031323a31363a33312e3238373c2f6c617374757064617465643e0a
7221	1	133	21	2017-04-24 18:18:57.543	I	\N
7222	1	127	155	2017-04-24 18:18:57.555	I	\N
7223	1	58	1	2017-04-24 18:18:57.585	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7241	1	26	16	2017-04-24 18:30:30.218	I	\N
7242	1	26	198	2017-04-24 18:30:30.222	I	\N
7243	1	26	198	2017-04-24 18:30:30.224	I	\N
7244	1	26	198	2017-04-24 18:30:30.225	I	\N
7245	1	26	198	2017-04-24 18:30:30.226	I	\N
7246	1	26	198	2017-04-24 18:30:30.228	I	\N
7247	1	26	198	2017-04-24 18:30:30.229	I	\N
7248	1	24	15	2017-04-24 18:30:30.231	I	\N
7249	1	41	112	2017-04-24 18:30:30.237	I	\N
7261	1	63	1	2017-04-24 18:31:30.188	I	\N
7262	1	84	23	2017-04-24 18:31:30.193	I	\N
7263	1	544	4	2017-04-24 18:31:30.203	I	\N
7264	1	63	45	2017-04-24 18:31:30.207	I	\N
7281	1	134	21	2017-04-24 18:31:51.266	I	\N
7282	1	128	155	2017-04-24 18:31:51.27	I	\N
7283	1	63	1	2017-04-24 18:31:51.286	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7301	1	64	1	2017-04-24 18:33:15.166	I	\N
7302	1	85	23	2017-04-24 18:33:15.17	I	\N
7303	1	545	4	2017-04-24 18:33:15.181	I	\N
7304	1	64	45	2017-04-24 18:33:15.184	I	\N
7321	1	135	21	2017-04-24 18:33:28.771	I	\N
7322	1	129	155	2017-04-24 18:33:28.774	I	\N
7323	1	64	1	2017-04-24 18:33:28.784	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7267	1	546	4	2017-04-24 18:34:15.118	I	\N
7268	1	547	4	2017-04-24 18:34:15.121	I	\N
7269	1	548	4	2017-04-24 18:34:15.124	I	\N
7270	1	65	45	2017-04-24 18:34:15.126	I	\N
7271	1	136	21	2017-04-24 18:34:36.723	I	\N
7272	1	130	155	2017-04-24 18:34:36.726	I	\N
7273	1	137	21	2017-04-24 18:34:36.729	I	\N
7274	1	131	155	2017-04-24 18:34:36.73	I	\N
7275	1	138	21	2017-04-24 18:34:36.733	I	\N
7276	1	132	155	2017-04-24 18:34:36.734	I	\N
7277	1	65	1	2017-04-24 18:34:36.752	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7341	1	66	1	2017-04-24 18:36:00.174	I	\N
7342	1	87	23	2017-04-24 18:36:00.178	I	\N
7343	1	549	4	2017-04-24 18:36:00.182	I	\N
7344	1	550	4	2017-04-24 18:36:00.185	I	\N
7345	1	551	4	2017-04-24 18:36:00.187	I	\N
7346	1	66	45	2017-04-24 18:36:00.189	I	\N
7361	1	27	16	2017-04-24 18:36:15.06	I	\N
7362	1	27	198	2017-04-24 18:36:15.063	I	\N
7363	1	27	198	2017-04-24 18:36:15.064	I	\N
7364	1	27	198	2017-04-24 18:36:15.065	I	\N
7365	1	27	198	2017-04-24 18:36:15.066	I	\N
7366	1	27	198	2017-04-24 18:36:15.067	I	\N
7367	1	27	198	2017-04-24 18:36:15.073	I	\N
7368	1	25	15	2017-04-24 18:36:15.074	I	\N
7369	1	42	112	2017-04-24 18:36:15.076	I	\N
7278	1	139	21	2017-04-24 18:36:17.517	I	\N
7279	1	133	155	2017-04-24 18:36:17.519	I	\N
7280	1	140	21	2017-04-24 18:36:17.521	I	\N
7381	1	134	155	2017-04-24 18:36:17.523	I	\N
7382	1	141	21	2017-04-24 18:36:17.524	I	\N
7383	1	135	155	2017-04-24 18:36:17.525	I	\N
7384	1	66	1	2017-04-24 18:36:17.534	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7401	1	67	1	2017-04-24 18:36:30.114	I	\N
7402	1	88	23	2017-04-24 18:36:30.117	I	\N
7403	1	552	4	2017-04-24 18:36:30.119	I	\N
7404	1	553	4	2017-04-24 18:36:30.123	I	\N
7405	1	67	45	2017-04-24 18:36:30.125	I	\N
7421	1	28	16	2017-04-25 10:31:00.195	I	\N
7422	1	28	198	2017-04-25 10:31:00.197	I	\N
7423	1	28	198	2017-04-25 10:31:00.199	I	\N
7424	1	28	198	2017-04-25 10:31:00.2	I	\N
7425	1	28	198	2017-04-25 10:31:00.204	I	\N
7426	1	28	198	2017-04-25 10:31:00.205	I	\N
7427	1	28	198	2017-04-25 10:31:00.206	I	\N
7428	1	26	15	2017-04-25 10:31:00.207	I	\N
7429	1	43	112	2017-04-25 10:31:00.21	I	\N
7441	1	68	1	2017-04-25 10:34:15.133	I	\N
7442	1	89	23	2017-04-25 10:34:15.136	I	\N
7443	1	554	4	2017-04-25 10:34:15.138	I	\N
7444	1	555	4	2017-04-25 10:34:15.142	I	\N
7445	1	556	4	2017-04-25 10:34:15.144	I	\N
7446	1	90	23	2017-04-25 10:34:15.145	I	\N
7447	1	557	4	2017-04-25 10:34:15.147	I	\N
7448	1	91	23	2017-04-25 10:34:15.149	I	\N
7449	1	558	4	2017-04-25 10:34:15.15	I	\N
7450	1	92	23	2017-04-25 10:34:15.152	I	\N
7451	1	559	4	2017-04-25 10:34:15.154	I	\N
7452	1	560	4	2017-04-25 10:34:15.156	I	\N
7453	1	561	4	2017-04-25 10:34:15.158	I	\N
7454	1	68	45	2017-04-25 10:34:15.159	I	\N
7461	1	142	21	2017-04-25 11:00:24.078	I	\N
7462	1	136	155	2017-04-25 11:00:24.083	I	\N
7463	1	143	21	2017-04-25 11:00:24.092	I	\N
7464	1	137	155	2017-04-25 11:00:24.094	I	\N
7465	1	144	21	2017-04-25 11:00:24.096	I	\N
7466	1	138	155	2017-04-25 11:00:24.097	I	\N
7467	1	145	21	2017-04-25 11:00:24.099	I	\N
7468	1	139	155	2017-04-25 11:00:24.101	I	\N
7469	1	146	21	2017-04-25 11:00:24.106	I	\N
7470	1	140	155	2017-04-25 11:00:24.107	I	\N
7471	1	147	21	2017-04-25 11:00:24.112	I	\N
7472	1	141	155	2017-04-25 11:00:24.113	I	\N
7473	1	148	21	2017-04-25 11:00:24.115	I	\N
7474	1	142	155	2017-04-25 11:00:24.117	I	\N
7475	1	149	21	2017-04-25 11:00:24.119	I	\N
7476	1	143	155	2017-04-25 11:00:24.12	I	\N
7477	1	68	1	2017-04-25 11:00:24.138	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7481	1	66	208	2017-04-25 11:00:58.091	I	\N
7501	1	67	208	2017-04-25 11:21:25.219	I	\N
7521	1	69	1	2017-04-25 13:01:00.133	I	\N
7522	1	93	23	2017-04-25 13:01:00.136	I	\N
7523	1	562	4	2017-04-25 13:01:00.138	I	\N
7524	1	69	45	2017-04-25 13:01:00.141	I	\N
7541	1	150	21	2017-04-25 13:01:22.494	I	\N
7542	1	144	155	2017-04-25 13:01:22.497	I	\N
7543	1	69	1	2017-04-25 13:01:22.504	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7561	1	29	16	2017-04-25 15:02:15.156	I	\N
7562	1	29	198	2017-04-25 15:02:15.158	I	\N
7563	1	29	198	2017-04-25 15:02:15.159	I	\N
7564	1	29	198	2017-04-25 15:02:15.16	I	\N
7565	1	29	198	2017-04-25 15:02:15.162	I	\N
7566	1	29	198	2017-04-25 15:02:15.163	I	\N
7567	1	29	198	2017-04-25 15:02:15.164	I	\N
7568	1	27	15	2017-04-25 15:02:15.164	I	\N
7569	1	44	112	2017-04-25 15:02:15.167	I	\N
7581	1	45	112	2017-04-26 14:21:30.206	I	\N
7582	1	46	112	2017-04-26 14:21:30.208	I	\N
7601	1	30	16	2017-04-26 14:31:15.091	I	\N
7602	1	30	198	2017-04-26 14:31:15.093	I	\N
7603	1	30	198	2017-04-26 14:31:15.096	I	\N
7604	1	30	198	2017-04-26 14:31:15.097	I	\N
7605	1	30	198	2017-04-26 14:31:15.098	I	\N
7606	1	30	198	2017-04-26 14:31:15.112	I	\N
7607	1	30	198	2017-04-26 14:31:15.113	I	\N
7608	1	28	15	2017-04-26 14:31:15.114	I	\N
7609	1	47	112	2017-04-26 14:31:15.122	I	\N
7610	1	48	112	2017-04-26 14:32:45.117	I	\N
7611	1	49	112	2017-04-26 14:32:45.118	I	\N
7621	1	31	16	2017-04-27 09:57:00.159	I	\N
7622	1	31	198	2017-04-27 09:57:00.161	I	\N
7623	1	31	198	2017-04-27 09:57:00.163	I	\N
7624	1	31	198	2017-04-27 09:57:00.163	I	\N
7625	1	31	198	2017-04-27 09:57:00.164	I	\N
7626	1	31	198	2017-04-27 09:57:00.165	I	\N
7627	1	31	198	2017-04-27 09:57:00.166	I	\N
7628	1	29	15	2017-04-27 09:57:00.167	I	\N
7629	1	50	112	2017-04-27 09:57:00.169	I	\N
7641	1	32	16	2017-04-27 11:01:15.126	I	\N
7642	1	32	198	2017-04-27 11:01:15.129	I	\N
7643	1	32	198	2017-04-27 11:01:15.13	I	\N
7644	1	32	198	2017-04-27 11:01:15.131	I	\N
7645	1	32	198	2017-04-27 11:01:15.132	I	\N
7646	1	32	198	2017-04-27 11:01:15.133	I	\N
7647	1	32	198	2017-04-27 11:01:15.134	I	\N
7648	1	30	15	2017-04-27 11:01:15.135	I	\N
7649	1	51	112	2017-04-27 11:01:15.137	I	\N
7650	1	33	16	2017-04-27 11:02:45.064	I	\N
7651	1	33	198	2017-04-27 11:02:45.066	I	\N
7652	1	33	198	2017-04-27 11:02:45.066	I	\N
7653	1	33	198	2017-04-27 11:02:45.067	I	\N
7654	1	33	198	2017-04-27 11:02:45.067	I	\N
7655	1	33	198	2017-04-27 11:02:45.068	I	\N
7656	1	33	198	2017-04-27 11:02:45.069	I	\N
7657	1	31	15	2017-04-27 11:02:45.069	I	\N
7658	1	52	112	2017-04-27 11:02:45.071	I	\N
7661	1	34	16	2017-04-27 11:14:00.104	I	\N
7662	1	34	198	2017-04-27 11:14:00.106	I	\N
7663	1	34	198	2017-04-27 11:14:00.108	I	\N
7664	1	34	198	2017-04-27 11:14:00.109	I	\N
7665	1	34	198	2017-04-27 11:14:00.11	I	\N
7666	1	34	198	2017-04-27 11:14:00.11	I	\N
7667	1	34	198	2017-04-27 11:14:00.111	I	\N
7668	1	32	15	2017-04-27 11:14:00.112	I	\N
7669	1	53	112	2017-04-27 11:14:00.114	I	\N
7681	1	54	112	2017-04-27 11:22:00.127	I	\N
7682	1	55	112	2017-04-27 11:22:00.129	I	\N
7701	1	70	1	2017-04-27 13:32:15.09	I	\N
7702	1	94	23	2017-04-27 13:32:15.092	I	\N
7703	1	563	4	2017-04-27 13:32:15.095	I	\N
7704	1	70	45	2017-04-27 13:32:15.098	I	\N
7721	1	56	112	2017-04-28 09:56:30.173	I	\N
7722	1	57	112	2017-04-28 09:56:30.177	I	\N
7741	1	35	16	2017-04-28 10:30:45.11	I	\N
7742	1	35	198	2017-04-28 10:30:45.115	I	\N
7743	1	35	198	2017-04-28 10:30:45.116	I	\N
7744	1	35	198	2017-04-28 10:30:45.117	I	\N
7745	1	35	198	2017-04-28 10:30:45.118	I	\N
7746	1	35	198	2017-04-28 10:30:45.119	I	\N
7747	1	35	198	2017-04-28 10:30:45.119	I	\N
7748	1	33	15	2017-04-28 10:30:45.12	I	\N
7749	1	58	112	2017-04-28 10:30:45.125	I	\N
7761	1	36	16	2017-04-28 10:38:15.092	I	\N
7762	1	36	198	2017-04-28 10:38:15.094	I	\N
7763	1	36	198	2017-04-28 10:38:15.095	I	\N
7764	1	36	198	2017-04-28 10:38:15.096	I	\N
7765	1	36	198	2017-04-28 10:38:15.097	I	\N
7766	1	36	198	2017-04-28 10:38:15.103	I	\N
7767	1	36	198	2017-04-28 10:38:15.106	I	\N
7768	1	34	15	2017-04-28 10:38:15.107	I	\N
7769	1	59	112	2017-04-28 10:38:15.114	I	\N
7781	1	60	112	2017-04-28 10:38:30.142	I	\N
7782	1	61	112	2017-04-28 10:38:30.144	I	\N
7801	1	37	16	2017-04-28 14:13:45.121	I	\N
7802	1	37	198	2017-04-28 14:13:45.126	I	\N
7803	1	37	198	2017-04-28 14:13:45.128	I	\N
7804	1	37	198	2017-04-28 14:13:45.135	I	\N
7805	1	37	198	2017-04-28 14:13:45.136	I	\N
7806	1	37	198	2017-04-28 14:13:45.137	I	\N
7807	1	37	198	2017-04-28 14:13:45.138	I	\N
7808	1	35	15	2017-04-28 14:13:45.139	I	\N
7809	1	62	112	2017-04-28 14:13:45.141	I	\N
7821	1	71	1	2017-04-28 16:53:30.173	I	\N
7822	1	95	23	2017-04-28 16:53:30.177	I	\N
7823	1	564	4	2017-04-28 16:53:30.18	I	\N
7824	1	71	45	2017-04-28 16:53:30.183	I	\N
7841	1	38	16	2017-04-28 16:58:15.133	I	\N
7842	1	38	198	2017-04-28 16:58:15.135	I	\N
7843	1	38	198	2017-04-28 16:58:15.137	I	\N
7844	1	38	198	2017-04-28 16:58:15.137	I	\N
7845	1	38	198	2017-04-28 16:58:15.138	I	\N
7846	1	38	198	2017-04-28 16:58:15.139	I	\N
7847	1	38	198	2017-04-28 16:58:15.14	I	\N
7848	1	36	15	2017-04-28 16:58:15.141	I	\N
7849	1	63	112	2017-04-28 16:58:15.143	I	\N
7850	1	39	16	2017-04-28 17:07:30.058	I	\N
7851	1	39	198	2017-04-28 17:07:30.059	I	\N
7852	1	39	198	2017-04-28 17:07:30.061	I	\N
7853	1	39	198	2017-04-28 17:07:30.062	I	\N
7854	1	39	198	2017-04-28 17:07:30.062	I	\N
7855	1	39	198	2017-04-28 17:07:30.063	I	\N
7856	1	39	198	2017-04-28 17:07:30.064	I	\N
7857	1	37	15	2017-04-28 17:07:30.064	I	\N
7858	1	64	112	2017-04-28 17:07:30.066	I	\N
7861	1	151	21	2017-04-28 17:07:59.839	I	\N
7862	1	145	155	2017-04-28 17:07:59.842	I	\N
7863	1	71	1	2017-04-28 17:07:59.848	U	\\x3c73746174757349643e313c2f73746174757349643e0a
7881	1	65	112	2017-04-28 17:13:30.133	I	\N
7882	1	66	112	2017-04-28 17:13:30.135	I	\N
7901	1	67	112	2017-04-28 17:46:30.194	I	\N
7902	1	68	112	2017-04-28 17:46:30.2	I	\N
7921	1	40	16	2017-05-01 11:17:15.096	I	\N
7922	1	40	198	2017-05-01 11:17:15.098	I	\N
7923	1	40	198	2017-05-01 11:17:15.1	I	\N
7924	1	40	198	2017-05-01 11:17:15.101	I	\N
7925	1	40	198	2017-05-01 11:17:15.101	I	\N
7926	1	40	198	2017-05-01 11:17:15.102	I	\N
7927	1	40	198	2017-05-01 11:17:15.103	I	\N
7928	1	38	15	2017-05-01 11:17:15.104	I	\N
7929	1	69	112	2017-05-01 11:17:15.106	I	\N
7941	1	41	16	2017-05-01 13:22:45.116	I	\N
7942	1	41	198	2017-05-01 13:22:45.118	I	\N
7943	1	41	198	2017-05-01 13:22:45.119	I	\N
7944	1	41	198	2017-05-01 13:22:45.12	I	\N
7945	1	41	198	2017-05-01 13:22:45.121	I	\N
7946	1	41	198	2017-05-01 13:22:45.122	I	\N
7947	1	41	198	2017-05-01 13:22:45.123	I	\N
7948	1	39	15	2017-05-01 13:22:45.124	I	\N
7949	1	70	112	2017-05-01 13:22:45.128	I	\N
7961	1	71	112	2017-05-01 13:40:30.151	I	\N
7962	1	72	112	2017-05-01 13:40:30.153	I	\N
7981	1	42	16	2017-05-01 13:58:00.165	I	\N
7982	1	42	198	2017-05-01 13:58:00.172	I	\N
7983	1	42	198	2017-05-01 13:58:00.174	I	\N
7984	1	42	198	2017-05-01 13:58:00.175	I	\N
7985	1	42	198	2017-05-01 13:58:00.181	I	\N
7986	1	42	198	2017-05-01 13:58:00.182	I	\N
7987	1	42	198	2017-05-01 13:58:00.183	I	\N
7988	1	40	15	2017-05-01 13:58:00.184	I	\N
7989	1	73	112	2017-05-01 13:58:00.189	I	\N
8001	1	43	16	2017-05-01 14:07:45.183	I	\N
8002	1	43	198	2017-05-01 14:07:45.187	I	\N
8003	1	43	198	2017-05-01 14:07:45.19	I	\N
8004	1	43	198	2017-05-01 14:07:45.192	I	\N
8005	1	43	198	2017-05-01 14:07:45.196	I	\N
8006	1	43	198	2017-05-01 14:07:45.197	I	\N
8007	1	43	198	2017-05-01 14:07:45.198	I	\N
8008	1	41	15	2017-05-01 14:07:45.2	I	\N
8009	1	74	112	2017-05-01 14:07:45.204	I	\N
8021	1	75	112	2017-05-01 14:11:30.182	I	\N
8022	1	76	112	2017-05-01 14:11:30.19	I	\N
8041	1	44	16	2017-05-01 14:25:30.118	I	\N
8042	1	44	198	2017-05-01 14:25:30.12	I	\N
8043	1	44	198	2017-05-01 14:25:30.122	I	\N
8044	1	44	198	2017-05-01 14:25:30.123	I	\N
8045	1	44	198	2017-05-01 14:25:30.124	I	\N
8046	1	44	198	2017-05-01 14:25:30.124	I	\N
8047	1	44	198	2017-05-01 14:25:30.125	I	\N
8048	1	42	15	2017-05-01 14:25:30.126	I	\N
8049	1	77	112	2017-05-01 14:25:30.129	I	\N
8061	1	72	1	2017-05-01 14:31:00.156	I	\N
8062	1	96	23	2017-05-01 14:31:00.161	I	\N
8063	1	565	4	2017-05-01 14:31:00.164	I	\N
8064	1	566	4	2017-05-01 14:31:00.166	I	\N
8065	1	567	4	2017-05-01 14:31:00.168	I	\N
8066	1	568	4	2017-05-01 14:31:00.171	I	\N
8067	1	569	4	2017-05-01 14:31:00.179	I	\N
8068	1	570	4	2017-05-01 14:31:00.181	I	\N
8069	1	571	4	2017-05-01 14:31:00.189	I	\N
8070	1	572	4	2017-05-01 14:31:00.191	I	\N
8071	1	573	4	2017-05-01 14:31:00.193	I	\N
8072	1	574	4	2017-05-01 14:31:00.195	I	\N
8073	1	575	4	2017-05-01 14:31:00.196	I	\N
8074	1	576	4	2017-05-01 14:31:00.203	I	\N
8075	1	577	4	2017-05-01 14:31:00.205	I	\N
8076	1	578	4	2017-05-01 14:31:00.207	I	\N
8077	1	579	4	2017-05-01 14:31:00.209	I	\N
8078	1	580	4	2017-05-01 14:31:00.216	I	\N
8079	1	581	4	2017-05-01 14:31:00.219	I	\N
8080	1	582	4	2017-05-01 14:31:00.221	I	\N
8081	1	583	4	2017-05-01 14:31:00.223	I	\N
8082	1	584	4	2017-05-01 14:31:00.225	I	\N
8083	1	585	4	2017-05-01 14:31:00.229	I	\N
8084	1	586	4	2017-05-01 14:31:00.232	I	\N
8085	1	587	4	2017-05-01 14:31:00.237	I	\N
8086	1	72	45	2017-05-01 14:31:00.239	I	\N
8101	1	152	21	2017-05-01 14:32:01.542	I	\N
8102	1	146	155	2017-05-01 14:32:01.545	I	\N
8103	1	153	21	2017-05-01 14:32:01.547	I	\N
8104	1	147	155	2017-05-01 14:32:01.548	I	\N
8105	1	154	21	2017-05-01 14:32:01.55	I	\N
8106	1	148	155	2017-05-01 14:32:01.551	I	\N
8107	1	155	21	2017-05-01 14:32:01.553	I	\N
8108	1	149	155	2017-05-01 14:32:01.555	I	\N
8109	1	156	21	2017-05-01 14:32:01.557	I	\N
8110	1	150	155	2017-05-01 14:32:01.558	I	\N
8111	1	157	21	2017-05-01 14:32:01.56	I	\N
8112	1	151	155	2017-05-01 14:32:01.561	I	\N
8113	1	158	21	2017-05-01 14:32:01.563	I	\N
8114	1	152	155	2017-05-01 14:32:01.564	I	\N
8115	1	159	21	2017-05-01 14:32:01.565	I	\N
8116	1	153	155	2017-05-01 14:32:01.566	I	\N
8117	1	160	21	2017-05-01 14:32:01.568	I	\N
8118	1	154	155	2017-05-01 14:32:01.569	I	\N
8119	1	161	21	2017-05-01 14:32:01.571	I	\N
8120	1	155	155	2017-05-01 14:32:01.572	I	\N
8121	1	162	21	2017-05-01 14:32:01.573	I	\N
8122	1	156	155	2017-05-01 14:32:01.575	I	\N
8123	1	163	21	2017-05-01 14:32:01.576	I	\N
8124	1	157	155	2017-05-01 14:32:01.577	I	\N
8125	1	164	21	2017-05-01 14:32:01.579	I	\N
8126	1	158	155	2017-05-01 14:32:01.58	I	\N
8127	1	165	21	2017-05-01 14:32:01.582	I	\N
8128	1	159	155	2017-05-01 14:32:01.583	I	\N
8129	1	166	21	2017-05-01 14:32:01.584	I	\N
8130	1	160	155	2017-05-01 14:32:01.586	I	\N
8131	1	167	21	2017-05-01 14:32:01.587	I	\N
8132	1	161	155	2017-05-01 14:32:01.588	I	\N
8133	1	168	21	2017-05-01 14:32:01.59	I	\N
8134	1	162	155	2017-05-01 14:32:01.591	I	\N
8135	1	169	21	2017-05-01 14:32:01.593	I	\N
8136	1	163	155	2017-05-01 14:32:01.594	I	\N
8137	1	170	21	2017-05-01 14:32:01.596	I	\N
8138	1	164	155	2017-05-01 14:32:01.597	I	\N
8139	1	171	21	2017-05-01 14:32:01.603	I	\N
8140	1	165	155	2017-05-01 14:32:01.604	I	\N
8141	1	172	21	2017-05-01 14:32:01.606	I	\N
8142	1	166	155	2017-05-01 14:32:01.607	I	\N
8143	1	173	21	2017-05-01 14:32:01.608	I	\N
8144	1	167	155	2017-05-01 14:32:01.61	I	\N
8145	1	174	21	2017-05-01 14:32:01.611	I	\N
8146	1	168	155	2017-05-01 14:32:01.614	I	\N
8147	1	72	1	2017-05-01 14:32:01.679	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8161	1	73	1	2017-05-01 14:33:30.184	I	\N
8162	1	97	23	2017-05-01 14:33:30.187	I	\N
8163	1	588	4	2017-05-01 14:33:30.19	I	\N
8164	1	73	45	2017-05-01 14:33:30.2	I	\N
8181	1	175	21	2017-05-01 14:36:22.423	I	\N
8182	1	169	155	2017-05-01 14:36:22.424	I	\N
8183	1	7	191	2017-05-01 14:36:22.43	I	\N
8184	1	7	192	2017-05-01 14:36:22.436	I	\N
8185	1	73	1	2017-05-01 14:36:22.447	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8201	1	74	1	2017-05-01 14:38:30.237	I	\N
8202	1	98	23	2017-05-01 14:38:30.24	I	\N
8203	1	589	4	2017-05-01 14:38:30.248	I	\N
8204	1	74	45	2017-05-01 14:38:30.25	I	\N
8221	1	176	21	2017-05-01 14:38:49.796	I	\N
8222	1	170	155	2017-05-01 14:38:49.797	I	\N
8223	1	8	191	2017-05-01 14:38:49.799	I	\N
8224	1	8	192	2017-05-01 14:38:49.801	I	\N
8225	1	74	1	2017-05-01 14:38:49.807	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8241	1	75	1	2017-05-01 14:39:45.121	I	\N
8242	1	99	23	2017-05-01 14:39:45.124	I	\N
8243	1	590	4	2017-05-01 14:39:45.129	I	\N
8244	1	75	45	2017-05-01 14:39:45.132	I	\N
8261	1	177	21	2017-05-01 14:40:43.624	I	\N
8262	1	171	155	2017-05-01 14:40:43.626	I	\N
8263	1	9	191	2017-05-01 14:40:43.629	I	\N
8264	1	9	192	2017-05-01 14:40:43.631	I	\N
8265	1	75	1	2017-05-01 14:40:43.637	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8281	1	76	1	2017-05-01 14:42:00.292	I	\N
8282	1	100	23	2017-05-01 14:42:00.295	I	\N
8283	1	591	4	2017-05-01 14:42:00.299	I	\N
8284	1	76	45	2017-05-01 14:42:00.301	I	\N
8301	1	178	21	2017-05-01 14:42:44.369	I	\N
8302	1	172	155	2017-05-01 14:42:44.374	I	\N
8303	1	76	1	2017-05-01 14:42:44.38	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8321	1	77	1	2017-05-01 14:51:45.176	I	\N
8322	1	101	23	2017-05-01 14:51:45.182	I	\N
8323	1	592	4	2017-05-01 14:51:45.187	I	\N
8324	1	77	45	2017-05-01 14:51:45.19	I	\N
8325	1	179	21	2017-05-01 14:52:55.553	I	\N
8326	1	173	155	2017-05-01 14:52:55.554	I	\N
8327	1	10	191	2017-05-01 14:52:55.557	I	\N
8328	1	10	192	2017-05-01 14:52:55.56	I	\N
8329	1	77	1	2017-05-01 14:52:55.566	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8341	1	78	1	2017-05-01 15:05:15.134	I	\N
8342	1	102	23	2017-05-01 15:05:15.137	I	\N
8343	1	593	4	2017-05-01 15:05:15.14	I	\N
8344	1	594	4	2017-05-01 15:05:15.143	I	\N
8345	1	78	45	2017-05-01 15:05:15.145	I	\N
8361	1	180	21	2017-05-01 15:05:52.551	I	\N
8362	1	174	155	2017-05-01 15:05:52.553	I	\N
8363	1	11	191	2017-05-01 15:05:52.555	I	\N
8364	1	11	192	2017-05-01 15:05:52.557	I	\N
8365	1	78	1	2017-05-01 15:05:52.564	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8381	1	181	21	2017-05-01 15:06:14.863	I	\N
8382	1	175	155	2017-05-01 15:06:14.866	I	\N
8401	1	79	1	2017-05-01 15:13:30.145	I	\N
8402	1	103	23	2017-05-01 15:13:30.147	I	\N
8403	1	595	4	2017-05-01 15:13:30.149	I	\N
8404	1	79	45	2017-05-01 15:13:30.152	I	\N
8421	1	182	21	2017-05-01 15:14:54.398	I	\N
8422	1	176	155	2017-05-01 15:14:54.4	I	\N
8423	1	12	191	2017-05-01 15:14:54.402	I	\N
8424	1	12	192	2017-05-01 15:14:54.404	I	\N
8425	1	79	1	2017-05-01 15:14:54.417	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8441	1	45	16	2017-05-01 16:36:15.087	I	\N
8442	1	45	198	2017-05-01 16:36:15.09	I	\N
8443	1	45	198	2017-05-01 16:36:15.091	I	\N
8444	1	45	198	2017-05-01 16:36:15.092	I	\N
8445	1	45	198	2017-05-01 16:36:15.093	I	\N
8446	1	45	198	2017-05-01 16:36:15.094	I	\N
8447	1	45	198	2017-05-01 16:36:15.095	I	\N
8448	1	43	15	2017-05-01 16:36:15.095	I	\N
8449	1	78	112	2017-05-01 16:36:15.098	I	\N
8461	1	80	1	2017-05-01 16:45:30.272	I	\N
8462	1	104	23	2017-05-01 16:45:30.275	I	\N
8463	1	596	4	2017-05-01 16:45:30.277	I	\N
8464	1	597	4	2017-05-01 16:45:30.28	I	\N
8465	1	598	4	2017-05-01 16:45:30.281	I	\N
8466	1	80	45	2017-05-01 16:45:30.283	I	\N
8481	1	183	21	2017-05-01 16:46:26.444	I	\N
8482	1	177	155	2017-05-01 16:46:26.447	I	\N
8483	1	184	21	2017-05-01 16:46:26.45	I	\N
8484	1	178	155	2017-05-01 16:46:26.451	I	\N
8485	1	185	21	2017-05-01 16:46:26.452	I	\N
8486	1	179	155	2017-05-01 16:46:26.453	I	\N
8487	1	80	1	2017-05-01 16:46:26.462	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8501	1	79	112	2017-05-01 16:49:45.071	I	\N
8502	1	80	112	2017-05-01 16:49:45.073	I	\N
8521	1	46	16	2017-05-02 09:24:30.224	I	\N
8522	1	46	198	2017-05-02 09:24:30.226	I	\N
8523	1	46	198	2017-05-02 09:24:30.227	I	\N
8524	1	46	198	2017-05-02 09:24:30.228	I	\N
8525	1	46	198	2017-05-02 09:24:30.229	I	\N
8526	1	46	198	2017-05-02 09:24:30.229	I	\N
8527	1	46	198	2017-05-02 09:24:30.23	I	\N
8528	1	44	15	2017-05-02 09:24:30.231	I	\N
8529	1	81	112	2017-05-02 09:24:30.234	I	\N
8541	1	82	112	2017-05-02 09:25:30.14	I	\N
8542	1	83	112	2017-05-02 09:25:30.144	I	\N
8561	1	81	1	2017-05-02 11:12:00.165	I	\N
8562	1	105	23	2017-05-02 11:12:00.168	I	\N
8563	1	599	4	2017-05-02 11:12:00.171	I	\N
8564	1	81	45	2017-05-02 11:12:00.178	I	\N
8601	1	186	21	2017-05-02 11:28:22.886	I	\N
8602	1	180	155	2017-05-02 11:28:22.894	I	\N
8603	1	13	191	2017-05-02 11:28:22.9	I	\N
8604	1	13	192	2017-05-02 11:28:22.904	I	\N
8605	1	81	1	2017-05-02 11:28:22.924	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8621	1	47	16	2017-05-02 11:30:15.115	I	\N
8622	1	47	198	2017-05-02 11:30:15.125	I	\N
8623	1	47	198	2017-05-02 11:30:15.127	I	\N
8624	1	47	198	2017-05-02 11:30:15.128	I	\N
8625	1	47	198	2017-05-02 11:30:15.129	I	\N
8626	1	47	198	2017-05-02 11:30:15.13	I	\N
8627	1	47	198	2017-05-02 11:30:15.131	I	\N
8628	1	45	15	2017-05-02 11:30:15.133	I	\N
8629	1	84	112	2017-05-02 11:30:15.136	I	\N
8641	1	82	1	2017-05-02 11:30:30.267	I	\N
8642	1	106	23	2017-05-02 11:30:30.276	I	\N
8643	1	600	4	2017-05-02 11:30:30.282	I	\N
8644	1	82	45	2017-05-02 11:30:30.289	I	\N
8661	1	187	21	2017-05-02 11:41:06.881	I	\N
8662	1	181	155	2017-05-02 11:41:06.884	I	\N
8663	1	14	191	2017-05-02 11:41:06.886	I	\N
8664	1	14	192	2017-05-02 11:41:06.889	I	\N
8665	1	82	1	2017-05-02 11:41:06.902	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8681	1	83	1	2017-05-02 11:45:15.065	I	\N
8682	1	107	23	2017-05-02 11:45:15.068	I	\N
8683	1	601	4	2017-05-02 11:45:15.072	I	\N
8684	1	83	45	2017-05-02 11:45:15.074	I	\N
8701	1	188	21	2017-05-02 11:45:29.494	I	\N
8702	1	182	155	2017-05-02 11:45:29.496	I	\N
8703	1	15	191	2017-05-02 11:45:29.498	I	\N
8704	1	15	192	2017-05-02 11:45:29.5	I	\N
8705	1	83	1	2017-05-02 11:45:29.507	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8721	1	47	198	2017-05-02 11:49:26.03	I	\N
8722	1	47	198	2017-05-02 11:49:26.033	I	\N
8723	1	47	198	2017-05-02 11:49:26.035	I	\N
8724	1	47	198	2017-05-02 11:49:26.036	I	\N
8725	1	47	198	2017-05-02 11:49:26.037	I	\N
8726	1	47	198	2017-05-02 11:49:26.038	I	\N
8727	1	84	1	2017-05-02 11:49:26.039	I	\N
8728	1	108	23	2017-05-02 11:49:26.041	I	\N
8729	1	602	4	2017-05-02 11:49:26.047	I	\N
8730	1	84	45	2017-05-02 11:49:26.05	I	\N
8731	1	189	21	2017-05-02 11:49:50.216	I	\N
8732	1	183	155	2017-05-02 11:49:50.217	I	\N
8733	1	16	191	2017-05-02 11:49:50.219	I	\N
8734	1	16	192	2017-05-02 11:49:50.221	I	\N
8735	1	84	1	2017-05-02 11:49:50.23	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8741	1	1286	38	2017-05-02 11:52:20.084	I	\N
8761	1	85	1	2017-05-02 11:57:00.37	I	\N
8762	1	109	23	2017-05-02 11:57:00.383	I	\N
8763	1	603	4	2017-05-02 11:57:00.392	I	\N
8764	1	85	45	2017-05-02 11:57:00.398	I	\N
8781	1	190	21	2017-05-02 11:57:54.523	I	\N
8782	1	184	155	2017-05-02 11:57:54.526	I	\N
8783	1	17	191	2017-05-02 11:57:54.532	I	\N
8784	1	17	192	2017-05-02 11:57:54.536	I	\N
8785	1	85	1	2017-05-02 11:57:54.559	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8801	1	86	1	2017-05-02 12:23:30.283	I	\N
8802	1	110	23	2017-05-02 12:23:30.291	I	\N
8803	1	604	4	2017-05-02 12:23:30.296	I	\N
8804	1	86	45	2017-05-02 12:23:30.299	I	\N
8821	1	191	21	2017-05-02 13:11:14.57	I	\N
8822	1	185	155	2017-05-02 13:11:14.575	I	\N
8823	1	62	1	2017-05-02 13:11:14.583	U	\\x3c73746174757349643e313c2f73746174757349643e0a
8841	1	48	16	2017-05-02 14:11:15.159	I	\N
8842	1	48	198	2017-05-02 14:11:15.163	I	\N
8843	1	48	198	2017-05-02 14:11:15.165	I	\N
8844	1	48	198	2017-05-02 14:11:15.166	I	\N
8845	1	48	198	2017-05-02 14:11:15.167	I	\N
8846	1	48	198	2017-05-02 14:11:15.168	I	\N
8847	1	48	198	2017-05-02 14:11:15.169	I	\N
8848	1	46	15	2017-05-02 14:11:15.171	I	\N
8849	1	85	112	2017-05-02 14:11:15.181	I	\N
8850	1	86	112	2017-05-02 14:11:15.229	I	\N
8851	1	87	112	2017-05-02 14:11:15.23	I	\N
8861	1	49	16	2017-05-02 14:27:45.095	I	\N
8862	1	49	198	2017-05-02 14:27:45.098	I	\N
8863	1	49	198	2017-05-02 14:27:45.1	I	\N
8864	1	49	198	2017-05-02 14:27:45.101	I	\N
8865	1	49	198	2017-05-02 14:27:45.102	I	\N
8866	1	49	198	2017-05-02 14:27:45.104	I	\N
8867	1	49	198	2017-05-02 14:27:45.105	I	\N
8868	1	47	15	2017-05-02 14:27:45.106	I	\N
8869	1	88	112	2017-05-02 14:27:45.108	I	\N
8881	1	87	1	2017-05-02 14:34:30.542	I	\N
8882	1	111	23	2017-05-02 14:34:30.545	I	\N
8883	1	605	4	2017-05-02 14:34:30.547	I	\N
8884	1	606	4	2017-05-02 14:34:30.551	I	\N
8885	1	607	4	2017-05-02 14:34:30.553	I	\N
8886	1	608	4	2017-05-02 14:34:30.557	I	\N
8887	1	609	4	2017-05-02 14:34:30.559	I	\N
8888	1	610	4	2017-05-02 14:34:30.568	I	\N
8889	1	611	4	2017-05-02 14:34:30.576	I	\N
8890	1	612	4	2017-05-02 14:34:30.578	I	\N
8891	1	613	4	2017-05-02 14:34:30.58	I	\N
8892	1	614	4	2017-05-02 14:34:30.581	I	\N
8893	1	615	4	2017-05-02 14:34:30.589	I	\N
8894	1	616	4	2017-05-02 14:34:30.591	I	\N
8895	1	617	4	2017-05-02 14:34:30.593	I	\N
8896	1	618	4	2017-05-02 14:34:30.595	I	\N
8897	1	619	4	2017-05-02 14:34:30.608	I	\N
8898	1	620	4	2017-05-02 14:34:30.61	I	\N
8899	1	621	4	2017-05-02 14:34:30.615	I	\N
8900	1	622	4	2017-05-02 14:34:30.618	I	\N
8901	1	623	4	2017-05-02 14:34:30.621	I	\N
8902	1	624	4	2017-05-02 14:34:30.622	I	\N
8903	1	625	4	2017-05-02 14:34:30.624	I	\N
8904	1	626	4	2017-05-02 14:34:30.626	I	\N
8905	1	627	4	2017-05-02 14:34:30.628	I	\N
8906	1	112	23	2017-05-02 14:34:30.63	I	\N
8907	1	628	4	2017-05-02 14:34:30.632	I	\N
8908	1	87	45	2017-05-02 14:34:30.634	I	\N
8921	1	88	1	2017-05-02 14:48:15.591	I	\N
8922	1	113	23	2017-05-02 14:48:15.596	I	\N
8923	1	629	4	2017-05-02 14:48:15.6	I	\N
8924	1	630	4	2017-05-02 14:48:15.603	I	\N
8925	1	631	4	2017-05-02 14:48:15.605	I	\N
8926	1	632	4	2017-05-02 14:48:15.607	I	\N
8927	1	633	4	2017-05-02 14:48:15.61	I	\N
8928	1	634	4	2017-05-02 14:48:15.612	I	\N
8929	1	635	4	2017-05-02 14:48:15.614	I	\N
8930	1	636	4	2017-05-02 14:48:15.616	I	\N
8931	1	637	4	2017-05-02 14:48:15.618	I	\N
8932	1	638	4	2017-05-02 14:48:15.619	I	\N
8933	1	639	4	2017-05-02 14:48:15.621	I	\N
8934	1	640	4	2017-05-02 14:48:15.623	I	\N
8935	1	641	4	2017-05-02 14:48:15.625	I	\N
8936	1	642	4	2017-05-02 14:48:15.627	I	\N
8937	1	643	4	2017-05-02 14:48:15.628	I	\N
8938	1	644	4	2017-05-02 14:48:15.63	I	\N
8939	1	645	4	2017-05-02 14:48:15.632	I	\N
8940	1	646	4	2017-05-02 14:48:15.634	I	\N
8941	1	647	4	2017-05-02 14:48:15.638	I	\N
8942	1	648	4	2017-05-02 14:48:15.639	I	\N
8943	1	649	4	2017-05-02 14:48:15.641	I	\N
8944	1	650	4	2017-05-02 14:48:15.643	I	\N
8945	1	651	4	2017-05-02 14:48:15.645	I	\N
8946	1	88	45	2017-05-02 14:48:15.647	I	\N
8961	1	114	23	2017-05-02 15:18:43.888	I	\N
8962	1	652	4	2017-05-02 15:18:43.892	I	\N
8981	1	89	1	2017-05-02 16:54:00.225	I	\N
8982	1	115	23	2017-05-02 16:54:00.228	I	\N
8983	1	653	4	2017-05-02 16:54:00.235	I	\N
8984	1	654	4	2017-05-02 16:54:00.24	I	\N
8985	1	655	4	2017-05-02 16:54:00.242	I	\N
8986	1	656	4	2017-05-02 16:54:00.247	I	\N
8987	1	657	4	2017-05-02 16:54:00.249	I	\N
8988	1	658	4	2017-05-02 16:54:00.251	I	\N
8989	1	659	4	2017-05-02 16:54:00.253	I	\N
8990	1	660	4	2017-05-02 16:54:00.255	I	\N
8991	1	661	4	2017-05-02 16:54:00.257	I	\N
8992	1	662	4	2017-05-02 16:54:00.258	I	\N
8993	1	663	4	2017-05-02 16:54:00.26	I	\N
8994	1	664	4	2017-05-02 16:54:00.262	I	\N
8995	1	665	4	2017-05-02 16:54:00.264	I	\N
8996	1	666	4	2017-05-02 16:54:00.266	I	\N
8997	1	667	4	2017-05-02 16:54:00.268	I	\N
8998	1	668	4	2017-05-02 16:54:00.27	I	\N
8999	1	669	4	2017-05-02 16:54:00.272	I	\N
9000	1	670	4	2017-05-02 16:54:00.283	I	\N
9001	1	671	4	2017-05-02 16:54:00.288	I	\N
9002	1	672	4	2017-05-02 16:54:00.29	I	\N
9003	1	673	4	2017-05-02 16:54:00.295	I	\N
9004	1	674	4	2017-05-02 16:54:00.301	I	\N
9005	1	675	4	2017-05-02 16:54:00.311	I	\N
9006	1	89	45	2017-05-02 16:54:00.318	I	\N
9021	1	90	1	2017-05-02 17:06:00.189	I	\N
9022	1	116	23	2017-05-02 17:06:00.192	I	\N
9023	1	676	4	2017-05-02 17:06:00.195	I	\N
9024	1	90	45	2017-05-02 17:06:00.198	I	\N
9041	1	192	21	2017-05-02 17:06:34.316	I	\N
9042	1	186	155	2017-05-02 17:06:34.32	I	\N
9043	1	90	1	2017-05-02 17:06:34.326	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9061	1	193	21	2017-05-02 17:13:25.006	I	\N
9062	1	187	155	2017-05-02 17:13:25.009	I	\N
9063	1	194	21	2017-05-02 17:13:25.011	I	\N
9064	1	188	155	2017-05-02 17:13:25.012	I	\N
9065	1	195	21	2017-05-02 17:13:25.016	I	\N
9066	1	189	155	2017-05-02 17:13:25.021	I	\N
9067	1	196	21	2017-05-02 17:13:25.023	I	\N
9068	1	190	155	2017-05-02 17:13:25.024	I	\N
9069	1	197	21	2017-05-02 17:13:25.025	I	\N
9070	1	191	155	2017-05-02 17:13:25.026	I	\N
9071	1	198	21	2017-05-02 17:13:25.029	I	\N
9072	1	192	155	2017-05-02 17:13:25.034	I	\N
9073	1	199	21	2017-05-02 17:13:25.035	I	\N
9074	1	193	155	2017-05-02 17:13:25.036	I	\N
9075	1	200	21	2017-05-02 17:13:25.037	I	\N
9076	1	194	155	2017-05-02 17:13:25.039	I	\N
9077	1	89	1	2017-05-02 17:13:25.061	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9081	1	68	208	2017-05-02 17:14:02.585	I	\N
9082	1	69	208	2017-05-02 17:14:20.357	I	\N
9101	1	201	21	2017-05-02 17:14:27.657	I	\N
9102	1	195	155	2017-05-02 17:14:27.659	I	\N
9121	1	202	21	2017-05-02 17:15:45.814	I	\N
9122	1	196	155	2017-05-02 17:15:45.818	I	\N
9141	1	203	21	2017-05-02 17:23:11.993	I	\N
9142	1	197	155	2017-05-02 17:23:11.995	I	\N
9143	1	18	191	2017-05-02 17:23:11.998	I	\N
9144	1	18	192	2017-05-02 17:23:12	I	\N
9145	1	204	21	2017-05-02 17:23:12.005	I	\N
9146	1	198	155	2017-05-02 17:23:12.008	I	\N
9147	1	19	191	2017-05-02 17:23:12.012	I	\N
9148	1	19	192	2017-05-02 17:23:12.013	I	\N
9149	1	205	21	2017-05-02 17:23:12.015	I	\N
9150	1	199	155	2017-05-02 17:23:12.017	I	\N
9151	1	20	191	2017-05-02 17:23:12.02	I	\N
9152	1	20	192	2017-05-02 17:23:12.021	I	\N
9153	1	88	1	2017-05-02 17:23:12.034	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9161	1	201	21	2017-05-02 17:34:15.19	U	\\x3c75706c6f6164656446696c654e616d653e3c2f75706c6f6164656446696c654e616d653e0a
9181	1	180	21	2017-05-02 17:36:45.184	U	\\x3c74657374526573756c743e3c2f74657374526573756c743e0a3c75706c6f6164656446696c654e616d653e3c2f75706c6f6164656446696c654e616d653e0a
9201	1	50	16	2017-05-02 17:42:15.067	I	\N
9202	1	50	198	2017-05-02 17:42:15.072	I	\N
9203	1	50	198	2017-05-02 17:42:15.073	I	\N
9204	1	50	198	2017-05-02 17:42:15.074	I	\N
9205	1	50	198	2017-05-02 17:42:15.075	I	\N
9206	1	50	198	2017-05-02 17:42:15.076	I	\N
9207	1	50	198	2017-05-02 17:42:15.081	I	\N
9208	1	48	15	2017-05-02 17:42:15.082	I	\N
9209	1	89	112	2017-05-02 17:42:15.084	I	\N
9221	1	91	1	2017-05-02 17:42:30.192	I	\N
9222	1	117	23	2017-05-02 17:42:30.197	I	\N
9223	1	677	4	2017-05-02 17:42:30.201	I	\N
9224	1	91	45	2017-05-02 17:42:30.205	I	\N
9241	1	206	21	2017-05-02 17:42:58.991	I	\N
9242	1	200	155	2017-05-02 17:42:58.994	I	\N
9243	1	91	1	2017-05-02 17:42:59	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9261	1	90	112	2017-05-02 19:14:15.112	I	\N
9262	1	91	112	2017-05-02 19:14:15.114	I	\N
9281	1	92	112	2017-05-02 19:14:45.125	I	\N
9282	1	93	112	2017-05-02 19:14:45.127	I	\N
9301	1	51	16	2017-05-03 13:02:45.146	I	\N
9302	1	51	198	2017-05-03 13:02:45.148	I	\N
9303	1	51	198	2017-05-03 13:02:45.149	I	\N
9304	1	51	198	2017-05-03 13:02:45.15	I	\N
9305	1	51	198	2017-05-03 13:02:45.152	I	\N
9306	1	51	198	2017-05-03 13:02:45.153	I	\N
9307	1	51	198	2017-05-03 13:02:45.154	I	\N
9308	1	49	15	2017-05-03 13:02:45.155	I	\N
9309	1	94	112	2017-05-03 13:02:45.157	I	\N
9310	1	92	1	2017-05-03 13:03:00.223	I	\N
9311	1	118	23	2017-05-03 13:03:00.225	I	\N
9312	1	678	4	2017-05-03 13:03:00.23	I	\N
9313	1	92	45	2017-05-03 13:03:00.233	I	\N
9314	1	207	21	2017-05-03 13:04:08.965	I	\N
9315	1	201	155	2017-05-03 13:04:08.971	I	\N
9316	1	92	1	2017-05-03 13:04:08.98	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9321	1	207	21	2017-05-03 13:04:22.829	U	\\x3c75706c6f6164656446696c654e616d653e3c2f75706c6f6164656446696c654e616d653e0a
9341	1	93	1	2017-05-03 13:06:45.112	I	\N
9342	1	119	23	2017-05-03 13:06:45.115	I	\N
9343	1	679	4	2017-05-03 13:06:45.117	I	\N
9344	1	93	45	2017-05-03 13:06:45.12	I	\N
9361	1	208	21	2017-05-03 13:07:36.097	I	\N
9362	1	202	155	2017-05-03 13:07:36.101	I	\N
9363	1	93	1	2017-05-03 13:07:36.107	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9364	1	50	198	2017-05-03 13:08:16.037	I	\N
9365	1	50	198	2017-05-03 13:08:16.038	I	\N
9366	1	50	198	2017-05-03 13:08:16.043	I	\N
9367	1	50	198	2017-05-03 13:08:16.045	I	\N
9368	1	50	198	2017-05-03 13:08:16.045	I	\N
9369	1	50	198	2017-05-03 13:08:16.046	I	\N
9370	1	94	1	2017-05-03 13:08:16.048	I	\N
9371	1	120	23	2017-05-03 13:08:16.049	I	\N
9372	1	680	4	2017-05-03 13:08:16.056	I	\N
9373	1	94	45	2017-05-03 13:08:16.058	I	\N
9374	1	209	21	2017-05-03 13:08:27.936	I	\N
9375	1	203	155	2017-05-03 13:08:27.942	I	\N
9376	1	94	1	2017-05-03 13:08:27.946	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9381	1	52	16	2017-05-03 13:20:45.096	I	\N
9382	1	52	198	2017-05-03 13:20:45.099	I	\N
9383	1	52	198	2017-05-03 13:20:45.101	I	\N
9384	1	52	198	2017-05-03 13:20:45.101	I	\N
9385	1	52	198	2017-05-03 13:20:45.102	I	\N
9386	1	52	198	2017-05-03 13:20:45.103	I	\N
9387	1	52	198	2017-05-03 13:20:45.104	I	\N
9388	1	50	15	2017-05-03 13:20:45.105	I	\N
9389	1	95	112	2017-05-03 13:20:45.107	I	\N
9390	1	96	112	2017-05-03 13:20:45.14	I	\N
9391	1	97	112	2017-05-03 13:20:45.141	I	\N
9401	1	53	16	2017-05-03 13:24:00.111	I	\N
9402	1	53	198	2017-05-03 13:24:00.113	I	\N
9403	1	53	198	2017-05-03 13:24:00.115	I	\N
9404	1	53	198	2017-05-03 13:24:00.116	I	\N
9405	1	53	198	2017-05-03 13:24:00.117	I	\N
9406	1	53	198	2017-05-03 13:24:00.118	I	\N
9407	1	53	198	2017-05-03 13:24:00.119	I	\N
9408	1	51	15	2017-05-03 13:24:00.119	I	\N
9409	1	98	112	2017-05-03 13:24:00.123	I	\N
9421	1	54	16	2017-05-03 13:31:30.101	I	\N
9422	1	54	198	2017-05-03 13:31:30.111	I	\N
9423	1	54	198	2017-05-03 13:31:30.116	I	\N
9424	1	54	198	2017-05-03 13:31:30.119	I	\N
9425	1	54	198	2017-05-03 13:31:30.12	I	\N
9426	1	54	198	2017-05-03 13:31:30.12	I	\N
9427	1	54	198	2017-05-03 13:31:30.121	I	\N
9428	1	52	15	2017-05-03 13:31:30.122	I	\N
9429	1	99	112	2017-05-03 13:31:30.124	I	\N
9441	1	55	16	2017-05-03 15:37:45.08	I	\N
9442	1	55	198	2017-05-03 15:37:45.083	I	\N
9443	1	55	198	2017-05-03 15:37:45.084	I	\N
9444	1	55	198	2017-05-03 15:37:45.085	I	\N
9445	1	55	198	2017-05-03 15:37:45.086	I	\N
9446	1	55	198	2017-05-03 15:37:45.086	I	\N
9447	1	55	198	2017-05-03 15:37:45.087	I	\N
9448	1	53	15	2017-05-03 15:37:45.088	I	\N
9449	1	100	112	2017-05-03 15:37:45.092	I	\N
9450	1	101	112	2017-05-03 15:37:45.132	I	\N
9451	1	102	112	2017-05-03 15:37:45.133	I	\N
9461	1	56	16	2017-05-05 18:33:45.139	I	\N
9462	1	56	198	2017-05-05 18:33:45.141	I	\N
9463	1	56	198	2017-05-05 18:33:45.148	I	\N
9464	1	56	198	2017-05-05 18:33:45.149	I	\N
9465	1	56	198	2017-05-05 18:33:45.15	I	\N
9466	1	56	198	2017-05-05 18:33:45.151	I	\N
9467	1	56	198	2017-05-05 18:33:45.152	I	\N
9468	1	54	15	2017-05-05 18:33:45.152	I	\N
9469	1	103	112	2017-05-05 18:33:45.159	I	\N
9481	1	57	16	2017-05-05 19:47:30.177	I	\N
9482	1	57	198	2017-05-05 19:47:30.179	I	\N
9483	1	57	198	2017-05-05 19:47:30.18	I	\N
9484	1	57	198	2017-05-05 19:47:30.181	I	\N
9485	1	57	198	2017-05-05 19:47:30.182	I	\N
9486	1	57	198	2017-05-05 19:47:30.188	I	\N
9487	1	57	198	2017-05-05 19:47:30.189	I	\N
9488	1	55	15	2017-05-05 19:47:30.19	I	\N
9489	1	104	112	2017-05-05 19:47:30.192	I	\N
9501	1	58	16	2017-05-06 08:50:15.126	I	\N
9502	1	58	198	2017-05-06 08:50:15.13	I	\N
9503	1	58	198	2017-05-06 08:50:15.131	I	\N
9504	1	58	198	2017-05-06 08:50:15.132	I	\N
9505	1	58	198	2017-05-06 08:50:15.132	I	\N
9506	1	58	198	2017-05-06 08:50:15.133	I	\N
9507	1	58	198	2017-05-06 08:50:15.134	I	\N
9508	1	56	15	2017-05-06 08:50:15.135	I	\N
9509	1	105	112	2017-05-06 08:50:15.139	I	\N
9521	1	70	208	2017-05-08 11:07:46.246	I	\N
9541	1	71	208	2017-05-09 17:22:41.866	I	\N
9561	1	72	208	2017-05-09 17:33:20.415	I	\N
9581	1	73	208	2017-05-09 18:32:40.662	I	\N
9601	1	74	208	2017-05-09 18:37:49.475	I	\N
9621	1	75	208	2017-05-11 05:33:47.123	I	\N
9641	1	76	208	2017-05-11 05:44:42.122	I	\N
9642	1	77	208	2017-05-11 05:44:42.125	I	\N
9643	1	78	208	2017-05-11 05:44:42.127	I	\N
9644	1	79	208	2017-05-11 05:44:42.131	I	\N
9645	1	80	208	2017-05-11 05:44:42.133	I	\N
9646	1	81	208	2017-05-11 05:44:42.135	I	\N
9661	1	149	50	2017-05-11 06:07:12.514	I	\N
9662	1	123	28	2017-05-11 06:06:25.982	I	\N
9663	1	12312	175	2017-05-11 06:07:12.577	I	\N
9664	1	1237	175	2017-05-11 06:07:12.657	I	\N
9665	1	1235	175	2017-05-11 06:07:12.658	I	\N
9681	123	210	21	2017-05-11 06:09:46.43	I	\N
9682	123	204	155	2017-05-11 06:09:46.557	I	\N
9701	1	59	16	2017-05-11 08:04:30.171	I	\N
9702	1	59	198	2017-05-11 08:04:30.173	I	\N
9703	1	59	198	2017-05-11 08:04:30.202	I	\N
9704	1	59	198	2017-05-11 08:04:30.203	I	\N
9705	1	59	198	2017-05-11 08:04:30.204	I	\N
9706	1	59	198	2017-05-11 08:04:30.204	I	\N
9707	1	59	198	2017-05-11 08:04:30.205	I	\N
9708	1	57	15	2017-05-11 08:04:30.206	I	\N
9709	1	106	112	2017-05-11 08:04:30.234	I	\N
9721	1	60	16	2017-05-11 08:11:45.065	I	\N
9722	1	60	198	2017-05-11 08:11:45.067	I	\N
9723	1	60	198	2017-05-11 08:11:45.069	I	\N
9724	1	60	198	2017-05-11 08:11:45.07	I	\N
9725	1	60	198	2017-05-11 08:11:45.071	I	\N
9726	1	60	198	2017-05-11 08:11:45.072	I	\N
9727	1	60	198	2017-05-11 08:11:45.072	I	\N
9728	1	58	15	2017-05-11 08:11:45.073	I	\N
9729	1	107	112	2017-05-11 08:11:45.075	I	\N
9741	1	61	16	2017-05-11 08:18:30.165	I	\N
9742	1	61	198	2017-05-11 08:18:30.167	I	\N
9743	1	61	198	2017-05-11 08:18:30.168	I	\N
9744	1	61	198	2017-05-11 08:18:30.169	I	\N
9745	1	61	198	2017-05-11 08:18:30.17	I	\N
9746	1	61	198	2017-05-11 08:18:30.171	I	\N
9747	1	61	198	2017-05-11 08:18:30.172	I	\N
9748	1	59	15	2017-05-11 08:18:30.172	I	\N
9749	1	108	112	2017-05-11 08:18:30.174	I	\N
9761	1	62	16	2017-05-11 08:22:15.05	I	\N
9762	1	62	198	2017-05-11 08:22:15.053	I	\N
9763	1	62	198	2017-05-11 08:22:15.058	I	\N
9764	1	62	198	2017-05-11 08:22:15.059	I	\N
9765	1	62	198	2017-05-11 08:22:15.059	I	\N
9766	1	62	198	2017-05-11 08:22:15.06	I	\N
9767	1	62	198	2017-05-11 08:22:15.061	I	\N
9768	1	60	15	2017-05-11 08:22:15.062	I	\N
9769	1	109	112	2017-05-11 08:22:15.092	I	\N
9781	1	95	1	2017-05-11 08:28:00.193	I	\N
9782	1	121	23	2017-05-11 08:28:00.226	I	\N
9783	1	681	4	2017-05-11 08:28:00.263	I	\N
9784	1	682	4	2017-05-11 08:28:00.284	I	\N
9785	1	683	4	2017-05-11 08:28:00.287	I	\N
9786	1	95	45	2017-05-11 08:28:00.291	I	\N
9801	1	211	21	2017-05-11 08:29:17.976	I	\N
9802	1	205	155	2017-05-11 08:29:17.979	I	\N
9803	1	212	21	2017-05-11 08:29:17.98	I	\N
9804	1	206	155	2017-05-11 08:29:17.982	I	\N
9805	1	213	21	2017-05-11 08:29:17.983	I	\N
9806	1	207	155	2017-05-11 08:29:17.984	I	\N
9807	1	95	1	2017-05-11 08:29:18.007	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9821	1	63	16	2017-05-11 08:37:15.047	I	\N
9822	1	63	198	2017-05-11 08:37:15.049	I	\N
9823	1	63	198	2017-05-11 08:37:15.05	I	\N
9824	1	63	198	2017-05-11 08:37:15.052	I	\N
9825	1	63	198	2017-05-11 08:37:15.053	I	\N
9826	1	63	198	2017-05-11 08:37:15.054	I	\N
9827	1	63	198	2017-05-11 08:37:15.054	I	\N
9828	1	61	15	2017-05-11 08:37:15.055	I	\N
9829	1	110	112	2017-05-11 08:37:15.057	I	\N
9841	1	64	16	2017-05-12 11:15:00.175	I	\N
9842	1	64	198	2017-05-12 11:15:00.177	I	\N
9843	1	64	198	2017-05-12 11:15:00.182	I	\N
9844	1	64	198	2017-05-12 11:15:00.188	I	\N
9845	1	64	198	2017-05-12 11:15:00.189	I	\N
9846	1	64	198	2017-05-12 11:15:00.19	I	\N
9847	1	64	198	2017-05-12 11:15:00.191	I	\N
9848	1	62	15	2017-05-12 11:15:00.192	I	\N
9849	1	111	112	2017-05-12 11:15:00.194	I	\N
9850	1	112	112	2017-05-12 11:15:00.226	I	\N
9851	1	113	112	2017-05-12 11:15:00.227	I	\N
9861	1	65	16	2017-05-15 13:09:30.187	I	\N
9862	1	65	198	2017-05-15 13:09:30.189	I	\N
9863	1	65	198	2017-05-15 13:09:30.19	I	\N
9864	1	65	198	2017-05-15 13:09:30.191	I	\N
9865	1	65	198	2017-05-15 13:09:30.192	I	\N
9866	1	65	198	2017-05-15 13:09:30.193	I	\N
9867	1	65	198	2017-05-15 13:09:30.194	I	\N
9868	1	63	15	2017-05-15 13:09:30.197	I	\N
9869	1	114	112	2017-05-15 13:09:30.199	I	\N
9881	1	66	16	2017-05-17 10:51:30.12	I	\N
9882	1	66	198	2017-05-17 10:51:30.123	I	\N
9883	1	66	198	2017-05-17 10:51:30.124	I	\N
9884	1	66	198	2017-05-17 10:51:30.125	I	\N
9885	1	66	198	2017-05-17 10:51:30.126	I	\N
9886	1	66	198	2017-05-17 10:51:30.126	I	\N
9887	1	66	198	2017-05-17 10:51:30.127	I	\N
9888	1	64	15	2017-05-17 10:51:30.128	I	\N
9889	1	115	112	2017-05-17 10:51:30.13	I	\N
9901	1	96	1	2017-05-17 10:53:30.121	I	\N
9902	1	122	23	2017-05-17 10:53:30.124	I	\N
9903	1	684	4	2017-05-17 10:53:30.126	I	\N
9904	1	96	45	2017-05-17 10:53:30.155	I	\N
9921	1	214	21	2017-05-17 10:54:25.494	I	\N
9922	1	208	155	2017-05-17 10:54:25.526	I	\N
9923	1	96	1	2017-05-17 10:54:25.531	U	\\x3c73746174757349643e313c2f73746174757349643e0a
9941	1	82	208	2017-05-17 10:59:49.484	I	\N
9961	1	97	1	2017-05-17 11:11:30.136	I	\N
9962	1	123	23	2017-05-17 11:11:30.138	I	\N
9963	1	685	4	2017-05-17 11:11:30.141	I	\N
9964	1	97	45	2017-05-17 11:11:30.144	I	\N
9981	1	215	21	2017-05-17 11:11:54.064	I	\N
9982	1	209	155	2017-05-17 11:11:54.067	I	\N
9983	1	97	1	2017-05-17 11:11:54.072	U	\\x3c73746174757349643e313c2f73746174757349643e0a
10001	1	67	16	2017-05-17 11:47:45.062	I	\N
10002	1	67	198	2017-05-17 11:47:45.066	I	\N
10003	1	67	198	2017-05-17 11:47:45.067	I	\N
10004	1	67	198	2017-05-17 11:47:45.068	I	\N
10005	1	67	198	2017-05-17 11:47:45.069	I	\N
10006	1	67	198	2017-05-17 11:47:45.07	I	\N
10007	1	67	198	2017-05-17 11:47:45.081	I	\N
10008	1	65	15	2017-05-17 11:47:45.082	I	\N
10009	1	116	112	2017-05-17 11:47:45.086	I	\N
10021	1	68	16	2017-05-17 13:09:15.061	I	\N
10022	1	68	198	2017-05-17 13:09:15.064	I	\N
10023	1	68	198	2017-05-17 13:09:15.065	I	\N
10024	1	68	198	2017-05-17 13:09:15.066	I	\N
10025	1	68	198	2017-05-17 13:09:15.067	I	\N
10026	1	68	198	2017-05-17 13:09:15.068	I	\N
10027	1	68	198	2017-05-17 13:09:15.069	I	\N
10028	1	66	15	2017-05-17 13:09:15.071	I	\N
10029	1	117	112	2017-05-17 13:09:15.073	I	\N
10041	1	118	112	2017-05-17 14:57:15.058	I	\N
10042	1	119	112	2017-05-17 14:57:15.06	I	\N
10061	1	69	16	2017-05-18 15:30:30.158	I	\N
10062	1	69	198	2017-05-18 15:30:30.16	I	\N
10063	1	69	198	2017-05-18 15:30:30.161	I	\N
10064	1	69	198	2017-05-18 15:30:30.162	I	\N
10065	1	69	198	2017-05-18 15:30:30.163	I	\N
10066	1	69	198	2017-05-18 15:30:30.164	I	\N
10067	1	69	198	2017-05-18 15:30:30.166	I	\N
10068	1	67	15	2017-05-18 15:30:30.167	I	\N
10069	1	120	112	2017-05-18 15:30:30.169	I	\N
10081	1	121	112	2017-05-18 15:31:00.112	I	\N
10082	1	122	112	2017-05-18 15:31:00.116	I	\N
10101	1	70	16	2017-05-18 17:15:15.074	I	\N
10102	1	70	198	2017-05-18 17:15:15.076	I	\N
10103	1	70	198	2017-05-18 17:15:15.078	I	\N
10104	1	70	198	2017-05-18 17:15:15.078	I	\N
10105	1	70	198	2017-05-18 17:15:15.079	I	\N
10106	1	70	198	2017-05-18 17:15:15.08	I	\N
10107	1	70	198	2017-05-18 17:15:15.081	I	\N
10108	1	68	15	2017-05-18 17:15:15.081	I	\N
10109	1	123	112	2017-05-18 17:15:15.083	I	\N
10121	1	124	112	2017-05-18 17:40:15.061	I	\N
10122	1	125	112	2017-05-18 17:40:15.062	I	\N
10141	1	71	16	2017-05-22 10:57:00.214	I	\N
10142	1	71	198	2017-05-22 10:57:00.216	I	\N
10143	1	71	198	2017-05-22 10:57:00.218	I	\N
10144	1	71	198	2017-05-22 10:57:00.223	I	\N
10145	1	71	198	2017-05-22 10:57:00.224	I	\N
10146	1	71	198	2017-05-22 10:57:00.226	I	\N
10147	1	71	198	2017-05-22 10:57:00.227	I	\N
10148	1	69	15	2017-05-22 10:57:00.228	I	\N
10149	1	126	112	2017-05-22 10:57:00.232	I	\N
10161	1	127	112	2017-05-22 11:16:00.134	I	\N
10162	1	128	112	2017-05-22 11:16:00.139	I	\N
10181	1	83	208	2017-05-22 12:11:40.633	I	\N
10201	1	72	16	2017-05-22 12:25:15.091	I	\N
10202	1	72	198	2017-05-22 12:25:15.094	I	\N
10203	1	72	198	2017-05-22 12:25:15.095	I	\N
10204	1	72	198	2017-05-22 12:25:15.096	I	\N
10205	1	72	198	2017-05-22 12:25:15.097	I	\N
10206	1	72	198	2017-05-22 12:25:15.098	I	\N
10207	1	72	198	2017-05-22 12:25:15.099	I	\N
10208	1	70	15	2017-05-22 12:25:15.099	I	\N
10209	1	129	112	2017-05-22 12:25:15.102	I	\N
10221	1	98	1	2017-05-22 16:13:00.176	I	\N
10222	1	124	23	2017-05-22 16:13:00.179	I	\N
10223	1	686	4	2017-05-22 16:13:00.181	I	\N
10224	1	687	4	2017-05-22 16:13:00.184	I	\N
10225	1	688	4	2017-05-22 16:13:00.186	I	\N
10226	1	689	4	2017-05-22 16:13:00.188	I	\N
10227	1	690	4	2017-05-22 16:13:00.191	I	\N
10228	1	691	4	2017-05-22 16:13:00.194	I	\N
10229	1	692	4	2017-05-22 16:13:00.196	I	\N
10230	1	693	4	2017-05-22 16:13:00.197	I	\N
10231	1	694	4	2017-05-22 16:13:00.2	I	\N
10232	1	695	4	2017-05-22 16:13:00.202	I	\N
10233	1	696	4	2017-05-22 16:13:00.203	I	\N
10234	1	697	4	2017-05-22 16:13:00.205	I	\N
10235	1	698	4	2017-05-22 16:13:00.207	I	\N
10236	1	699	4	2017-05-22 16:13:00.209	I	\N
10237	1	700	4	2017-05-22 16:13:00.21	I	\N
10238	1	701	4	2017-05-22 16:13:00.212	I	\N
10239	1	702	4	2017-05-22 16:13:00.214	I	\N
10240	1	703	4	2017-05-22 16:13:00.216	I	\N
10241	1	704	4	2017-05-22 16:13:00.217	I	\N
10242	1	705	4	2017-05-22 16:13:00.219	I	\N
10243	1	706	4	2017-05-22 16:13:00.221	I	\N
10244	1	707	4	2017-05-22 16:13:00.223	I	\N
10245	1	708	4	2017-05-22 16:13:00.225	I	\N
10246	1	98	45	2017-05-22 16:13:00.226	I	\N
10261	1	99	1	2017-05-22 16:16:30.141	I	\N
10262	1	125	23	2017-05-22 16:16:30.147	I	\N
10263	1	709	4	2017-05-22 16:16:30.149	I	\N
10264	1	710	4	2017-05-22 16:16:30.152	I	\N
10265	1	711	4	2017-05-22 16:16:30.155	I	\N
10266	1	712	4	2017-05-22 16:16:30.158	I	\N
10267	1	713	4	2017-05-22 16:16:30.165	I	\N
10268	1	714	4	2017-05-22 16:16:30.172	I	\N
10269	1	715	4	2017-05-22 16:16:30.174	I	\N
10270	1	716	4	2017-05-22 16:16:30.179	I	\N
10271	1	717	4	2017-05-22 16:16:30.18	I	\N
10272	1	718	4	2017-05-22 16:16:30.182	I	\N
10273	1	719	4	2017-05-22 16:16:30.183	I	\N
10274	1	720	4	2017-05-22 16:16:30.185	I	\N
10275	1	721	4	2017-05-22 16:16:30.187	I	\N
10276	1	722	4	2017-05-22 16:16:30.188	I	\N
10277	1	723	4	2017-05-22 16:16:30.19	I	\N
10278	1	724	4	2017-05-22 16:16:30.199	I	\N
10279	1	725	4	2017-05-22 16:16:30.201	I	\N
10280	1	726	4	2017-05-22 16:16:30.203	I	\N
10281	1	727	4	2017-05-22 16:16:30.205	I	\N
10282	1	728	4	2017-05-22 16:16:30.206	I	\N
10283	1	729	4	2017-05-22 16:16:30.208	I	\N
10284	1	730	4	2017-05-22 16:16:30.21	I	\N
10285	1	731	4	2017-05-22 16:16:30.211	I	\N
10286	1	99	45	2017-05-22 16:16:30.213	I	\N
10247	1	216	21	2017-05-22 16:17:24.448	I	\N
10248	1	210	155	2017-05-22 16:17:24.451	I	\N
10249	1	217	21	2017-05-22 16:17:24.453	I	\N
10250	1	211	155	2017-05-22 16:17:24.454	I	\N
10251	1	218	21	2017-05-22 16:17:24.455	I	\N
10252	1	212	155	2017-05-22 16:17:24.457	I	\N
10253	1	219	21	2017-05-22 16:17:24.458	I	\N
10254	1	213	155	2017-05-22 16:17:24.46	I	\N
10255	1	220	21	2017-05-22 16:17:24.461	I	\N
10256	1	214	155	2017-05-22 16:17:24.463	I	\N
10257	1	221	21	2017-05-22 16:17:24.464	I	\N
10258	1	215	155	2017-05-22 16:17:24.465	I	\N
10259	1	222	21	2017-05-22 16:17:24.467	I	\N
10260	1	216	155	2017-05-22 16:17:24.468	I	\N
10301	1	223	21	2017-05-22 16:17:24.469	I	\N
10302	1	217	155	2017-05-22 16:17:24.47	I	\N
10303	1	224	21	2017-05-22 16:17:24.471	I	\N
10304	1	218	155	2017-05-22 16:17:24.472	I	\N
10305	1	225	21	2017-05-22 16:17:24.474	I	\N
10306	1	219	155	2017-05-22 16:17:24.475	I	\N
10307	1	226	21	2017-05-22 16:17:24.476	I	\N
10308	1	220	155	2017-05-22 16:17:24.477	I	\N
10309	1	227	21	2017-05-22 16:17:24.479	I	\N
10310	1	221	155	2017-05-22 16:17:24.48	I	\N
10311	1	228	21	2017-05-22 16:17:24.481	I	\N
10312	1	222	155	2017-05-22 16:17:24.483	I	\N
10313	1	229	21	2017-05-22 16:17:24.484	I	\N
10314	1	223	155	2017-05-22 16:17:24.485	I	\N
10315	1	230	21	2017-05-22 16:17:24.486	I	\N
10316	1	224	155	2017-05-22 16:17:24.487	I	\N
10317	1	231	21	2017-05-22 16:17:24.489	I	\N
10318	1	225	155	2017-05-22 16:17:24.49	I	\N
10319	1	232	21	2017-05-22 16:17:24.491	I	\N
10320	1	226	155	2017-05-22 16:17:24.493	I	\N
10321	1	233	21	2017-05-22 16:17:24.494	I	\N
10322	1	227	155	2017-05-22 16:17:24.495	I	\N
10323	1	234	21	2017-05-22 16:17:24.497	I	\N
10324	1	228	155	2017-05-22 16:17:24.498	I	\N
10325	1	235	21	2017-05-22 16:17:24.499	I	\N
10326	1	229	155	2017-05-22 16:17:24.501	I	\N
10327	1	236	21	2017-05-22 16:17:24.502	I	\N
10328	1	230	155	2017-05-22 16:17:24.503	I	\N
10329	1	237	21	2017-05-22 16:17:24.505	I	\N
10330	1	231	155	2017-05-22 16:17:24.506	I	\N
10331	1	238	21	2017-05-22 16:17:24.508	I	\N
10332	1	232	155	2017-05-22 16:17:24.509	I	\N
10333	1	98	1	2017-05-22 16:17:24.551	U	\\x3c73746174757349643e313c2f73746174757349643e0a
10341	1	239	21	2017-05-22 16:18:27.871	I	\N
10342	1	233	155	2017-05-22 16:18:27.873	I	\N
10343	1	240	21	2017-05-22 16:18:27.875	I	\N
10344	1	234	155	2017-05-22 16:18:27.876	I	\N
10345	1	241	21	2017-05-22 16:18:27.878	I	\N
10346	1	235	155	2017-05-22 16:18:27.879	I	\N
10347	1	242	21	2017-05-22 16:18:27.881	I	\N
10348	1	236	155	2017-05-22 16:18:27.882	I	\N
10349	1	243	21	2017-05-22 16:18:27.883	I	\N
10350	1	237	155	2017-05-22 16:18:27.885	I	\N
10351	1	244	21	2017-05-22 16:18:27.886	I	\N
10352	1	238	155	2017-05-22 16:18:27.887	I	\N
10353	1	245	21	2017-05-22 16:18:27.888	I	\N
10354	1	239	155	2017-05-22 16:18:27.889	I	\N
10355	1	246	21	2017-05-22 16:18:27.891	I	\N
10356	1	240	155	2017-05-22 16:18:27.892	I	\N
10357	1	247	21	2017-05-22 16:18:27.893	I	\N
10358	1	241	155	2017-05-22 16:18:27.895	I	\N
10359	1	248	21	2017-05-22 16:18:27.896	I	\N
10360	1	242	155	2017-05-22 16:18:27.897	I	\N
10361	1	249	21	2017-05-22 16:18:27.899	I	\N
10362	1	243	155	2017-05-22 16:18:27.9	I	\N
10363	1	250	21	2017-05-22 16:18:27.901	I	\N
10364	1	244	155	2017-05-22 16:18:27.902	I	\N
10365	1	251	21	2017-05-22 16:18:27.904	I	\N
10366	1	245	155	2017-05-22 16:18:27.905	I	\N
10367	1	252	21	2017-05-22 16:18:27.906	I	\N
10368	1	246	155	2017-05-22 16:18:27.908	I	\N
10369	1	253	21	2017-05-22 16:18:27.909	I	\N
10370	1	247	155	2017-05-22 16:18:27.91	I	\N
10371	1	254	21	2017-05-22 16:18:27.912	I	\N
10372	1	248	155	2017-05-22 16:18:27.913	I	\N
10373	1	255	21	2017-05-22 16:18:27.914	I	\N
10374	1	249	155	2017-05-22 16:18:27.915	I	\N
10375	1	256	21	2017-05-22 16:18:27.917	I	\N
10376	1	250	155	2017-05-22 16:18:27.918	I	\N
10377	1	257	21	2017-05-22 16:18:27.919	I	\N
10378	1	251	155	2017-05-22 16:18:27.92	I	\N
10379	1	258	21	2017-05-22 16:18:27.922	I	\N
10380	1	252	155	2017-05-22 16:18:27.923	I	\N
10381	1	259	21	2017-05-22 16:18:27.924	I	\N
10382	1	253	155	2017-05-22 16:18:27.926	I	\N
10383	1	260	21	2017-05-22 16:18:27.927	I	\N
10384	1	254	155	2017-05-22 16:18:27.928	I	\N
10385	1	261	21	2017-05-22 16:18:27.93	I	\N
10386	1	255	155	2017-05-22 16:18:27.931	I	\N
10387	1	99	1	2017-05-22 16:18:27.972	U	\\x3c73746174757349643e313c2f73746174757349643e0a
10401	1	130	112	2017-05-23 16:18:30.147	I	\N
10402	1	131	112	2017-05-23 16:18:30.15	I	\N
10421	1	73	16	2017-05-23 20:45:15.061	I	\N
10422	1	73	198	2017-05-23 20:45:15.063	I	\N
10423	1	73	198	2017-05-23 20:45:15.064	I	\N
10424	1	73	198	2017-05-23 20:45:15.065	I	\N
10425	1	73	198	2017-05-23 20:45:15.066	I	\N
10426	1	73	198	2017-05-23 20:45:15.067	I	\N
10427	1	73	198	2017-05-23 20:45:15.068	I	\N
10428	1	71	15	2017-05-23 20:45:15.068	I	\N
10429	1	132	112	2017-05-23 20:45:15.07	I	\N
10441	1	133	112	2017-05-23 20:46:00.12	I	\N
10442	1	134	112	2017-05-23 20:46:00.122	I	\N
10461	1	135	112	2017-05-23 20:50:45.067	I	\N
10462	1	136	112	2017-05-23 20:50:45.069	I	\N
10463	1	74	16	2017-05-23 20:52:00.123	I	\N
10464	1	74	198	2017-05-23 20:52:00.125	I	\N
10465	1	74	198	2017-05-23 20:52:00.126	I	\N
10466	1	74	198	2017-05-23 20:52:00.127	I	\N
10467	1	74	198	2017-05-23 20:52:00.128	I	\N
10468	1	74	198	2017-05-23 20:52:00.129	I	\N
10469	1	74	198	2017-05-23 20:52:00.129	I	\N
10470	1	72	15	2017-05-23 20:52:00.13	I	\N
10471	1	137	112	2017-05-23 20:52:00.133	I	\N
10472	1	138	112	2017-05-23 20:52:00.157	I	\N
10473	1	139	112	2017-05-23 20:52:00.158	I	\N
10481	1	75	16	2017-05-23 20:53:30.09	I	\N
10482	1	75	198	2017-05-23 20:53:30.092	I	\N
10483	1	75	198	2017-05-23 20:53:30.093	I	\N
10484	1	75	198	2017-05-23 20:53:30.094	I	\N
10485	1	75	198	2017-05-23 20:53:30.096	I	\N
10486	1	75	198	2017-05-23 20:53:30.097	I	\N
10487	1	75	198	2017-05-23 20:53:30.098	I	\N
10488	1	73	15	2017-05-23 20:53:30.099	I	\N
10489	1	140	112	2017-05-23 20:53:30.101	I	\N
10501	1	141	112	2017-05-23 20:56:15.078	I	\N
10502	1	142	112	2017-05-23 20:56:15.08	I	\N
10521	1	76	16	2017-05-23 20:59:15.092	I	\N
10522	1	76	198	2017-05-23 20:59:15.097	I	\N
10523	1	76	198	2017-05-23 20:59:15.102	I	\N
10524	1	76	198	2017-05-23 20:59:15.102	I	\N
10525	1	76	198	2017-05-23 20:59:15.103	I	\N
10526	1	76	198	2017-05-23 20:59:15.104	I	\N
10527	1	76	198	2017-05-23 20:59:15.105	I	\N
10528	1	74	15	2017-05-23 20:59:15.105	I	\N
10529	1	143	112	2017-05-23 20:59:15.108	I	\N
10541	1	77	16	2017-05-24 09:23:45.128	I	\N
10542	1	77	198	2017-05-24 09:23:45.13	I	\N
10543	1	77	198	2017-05-24 09:23:45.133	I	\N
10544	1	77	198	2017-05-24 09:23:45.134	I	\N
10545	1	77	198	2017-05-24 09:23:45.135	I	\N
10546	1	77	198	2017-05-24 09:23:45.135	I	\N
10547	1	77	198	2017-05-24 09:23:45.136	I	\N
10548	1	75	15	2017-05-24 09:23:45.137	I	\N
10549	1	144	112	2017-05-24 09:23:45.149	I	\N
10561	1	145	112	2017-05-24 09:23:45.19	I	\N
10562	1	146	112	2017-05-24 09:23:45.192	I	\N
10581	1	100	1	2017-05-24 09:25:00.402	I	\N
10582	1	126	23	2017-05-24 09:25:00.405	I	\N
10583	1	732	4	2017-05-24 09:25:00.408	I	\N
10584	1	100	45	2017-05-24 09:25:00.41	I	\N
10601	1	78	16	2017-05-24 10:45:00.122	I	\N
10602	1	78	198	2017-05-24 10:45:00.125	I	\N
10603	1	78	198	2017-05-24 10:45:00.126	I	\N
10604	1	78	198	2017-05-24 10:45:00.129	I	\N
10605	1	78	198	2017-05-24 10:45:00.13	I	\N
10606	1	78	198	2017-05-24 10:45:00.131	I	\N
10607	1	78	198	2017-05-24 10:45:00.132	I	\N
10608	1	76	15	2017-05-24 10:45:00.132	I	\N
10609	1	147	112	2017-05-24 10:45:00.134	I	\N
10621	1	79	16	2017-05-24 10:45:30.128	I	\N
10622	1	79	198	2017-05-24 10:45:30.13	I	\N
10623	1	79	198	2017-05-24 10:45:30.132	I	\N
10624	1	79	198	2017-05-24 10:45:30.133	I	\N
10625	1	79	198	2017-05-24 10:45:30.134	I	\N
10626	1	79	198	2017-05-24 10:45:30.136	I	\N
10627	1	79	198	2017-05-24 10:45:30.137	I	\N
10628	1	77	15	2017-05-24 10:45:30.138	I	\N
10629	1	148	112	2017-05-24 10:45:30.14	I	\N
10630	1	149	112	2017-05-24 10:45:30.161	I	\N
10631	1	150	112	2017-05-24 10:45:30.162	I	\N
10641	1	101	1	2017-05-25 11:20:45.132	I	\N
10642	1	127	23	2017-05-25 11:20:45.135	I	\N
10643	1	733	4	2017-05-25 11:20:45.137	I	\N
10644	1	734	4	2017-05-25 11:20:45.14	I	\N
10645	1	735	4	2017-05-25 11:20:45.142	I	\N
10646	1	101	45	2017-05-25 11:20:45.143	I	\N
10661	1	80	16	2017-05-25 11:29:45.109	I	\N
10662	1	80	198	2017-05-25 11:29:45.111	I	\N
10663	1	80	198	2017-05-25 11:29:45.113	I	\N
10664	1	80	198	2017-05-25 11:29:45.113	I	\N
10665	1	80	198	2017-05-25 11:29:45.114	I	\N
10666	1	80	198	2017-05-25 11:29:45.115	I	\N
10667	1	80	198	2017-05-25 11:29:45.116	I	\N
10668	1	78	15	2017-05-25 11:29:45.116	I	\N
10669	1	151	112	2017-05-25 11:29:45.118	I	\N
10681	1	81	16	2017-05-25 11:37:45.063	I	\N
10682	1	81	198	2017-05-25 11:37:45.065	I	\N
10683	1	81	198	2017-05-25 11:37:45.067	I	\N
10684	1	81	198	2017-05-25 11:37:45.068	I	\N
10685	1	81	198	2017-05-25 11:37:45.068	I	\N
10686	1	81	198	2017-05-25 11:37:45.069	I	\N
10687	1	81	198	2017-05-25 11:37:45.07	I	\N
10688	1	79	15	2017-05-25 11:37:45.071	I	\N
10689	1	152	112	2017-05-25 11:37:45.073	I	\N
10701	1	82	16	2017-05-25 12:21:15.075	I	\N
10702	1	82	198	2017-05-25 12:21:15.077	I	\N
10703	1	82	198	2017-05-25 12:21:15.079	I	\N
10704	1	82	198	2017-05-25 12:21:15.08	I	\N
10705	1	82	198	2017-05-25 12:21:15.081	I	\N
10706	1	82	198	2017-05-25 12:21:15.081	I	\N
10707	1	82	198	2017-05-25 12:21:15.082	I	\N
10708	1	80	15	2017-05-25 12:21:15.083	I	\N
10709	1	153	112	2017-05-25 12:21:15.085	I	\N
10721	1	102	1	2017-05-25 12:54:15.108	I	\N
10722	1	128	23	2017-05-25 12:54:15.111	I	\N
10723	1	736	4	2017-05-25 12:54:15.113	I	\N
10724	1	737	4	2017-05-25 12:54:15.116	I	\N
10725	1	738	4	2017-05-25 12:54:15.117	I	\N
10726	1	102	45	2017-05-25 12:54:15.119	I	\N
10741	1	83	16	2017-05-25 13:03:30.098	I	\N
10742	1	83	198	2017-05-25 13:03:30.102	I	\N
10743	1	83	198	2017-05-25 13:03:30.103	I	\N
10744	1	83	198	2017-05-25 13:03:30.107	I	\N
10745	1	83	198	2017-05-25 13:03:30.109	I	\N
10746	1	83	198	2017-05-25 13:03:30.113	I	\N
10747	1	83	198	2017-05-25 13:03:30.114	I	\N
10748	1	81	15	2017-05-25 13:03:30.114	I	\N
10749	1	154	112	2017-05-25 13:03:30.118	I	\N
10761	1	84	16	2017-05-25 21:15:30.126	I	\N
10762	1	84	198	2017-05-25 21:15:30.128	I	\N
10763	1	84	198	2017-05-25 21:15:30.129	I	\N
10764	1	84	198	2017-05-25 21:15:30.13	I	\N
10765	1	84	198	2017-05-25 21:15:30.131	I	\N
10766	1	84	198	2017-05-25 21:15:30.132	I	\N
10767	1	84	198	2017-05-25 21:15:30.133	I	\N
10768	1	82	15	2017-05-25 21:15:30.133	I	\N
10769	1	155	112	2017-05-25 21:15:30.136	I	\N
10781	1	85	16	2017-05-26 10:57:00.183	I	\N
10782	1	85	198	2017-05-26 10:57:00.188	I	\N
10783	1	85	198	2017-05-26 10:57:00.19	I	\N
10784	1	85	198	2017-05-26 10:57:00.191	I	\N
10785	1	85	198	2017-05-26 10:57:00.192	I	\N
10786	1	85	198	2017-05-26 10:57:00.193	I	\N
10787	1	85	198	2017-05-26 10:57:00.194	I	\N
10788	1	83	15	2017-05-26 10:57:00.194	I	\N
10789	1	156	112	2017-05-26 10:57:00.196	I	\N
10801	1	86	16	2017-05-26 11:45:00.126	I	\N
10802	1	86	198	2017-05-26 11:45:00.128	I	\N
10803	1	86	198	2017-05-26 11:45:00.129	I	\N
10804	1	86	198	2017-05-26 11:45:00.13	I	\N
10805	1	86	198	2017-05-26 11:45:00.131	I	\N
10806	1	86	198	2017-05-26 11:45:00.132	I	\N
10807	1	86	198	2017-05-26 11:45:00.132	I	\N
10808	1	84	15	2017-05-26 11:45:00.136	I	\N
10809	1	157	112	2017-05-26 11:45:00.139	I	\N
10810	1	158	112	2017-05-26 11:45:00.17	I	\N
10811	1	159	112	2017-05-26 11:45:00.171	I	\N
10821	1	87	16	2017-05-26 11:57:30.102	I	\N
10822	1	87	198	2017-05-26 11:57:30.104	I	\N
10823	1	87	198	2017-05-26 11:57:30.105	I	\N
10824	1	87	198	2017-05-26 11:57:30.106	I	\N
10825	1	87	198	2017-05-26 11:57:30.107	I	\N
10826	1	87	198	2017-05-26 11:57:30.108	I	\N
10827	1	87	198	2017-05-26 11:57:30.109	I	\N
10828	1	85	15	2017-05-26 11:57:30.109	I	\N
10829	1	160	112	2017-05-26 11:57:30.111	I	\N
10830	1	161	112	2017-05-26 11:57:45.072	I	\N
10831	1	162	112	2017-05-26 11:57:45.073	I	\N
10841	1	88	16	2017-05-26 12:00:30.137	I	\N
10842	1	88	198	2017-05-26 12:00:30.139	I	\N
10843	1	88	198	2017-05-26 12:00:30.14	I	\N
10844	1	88	198	2017-05-26 12:00:30.14	I	\N
10845	1	88	198	2017-05-26 12:00:30.141	I	\N
10846	1	88	198	2017-05-26 12:00:30.142	I	\N
10847	1	88	198	2017-05-26 12:00:30.143	I	\N
10848	1	86	15	2017-05-26 12:00:30.144	I	\N
10849	1	163	112	2017-05-26 12:00:30.146	I	\N
10861	1	164	112	2017-05-26 12:01:00.131	I	\N
10862	1	165	112	2017-05-26 12:01:00.134	I	\N
10881	1	89	16	2017-05-26 14:04:30.129	I	\N
10882	1	89	198	2017-05-26 14:04:30.134	I	\N
10883	1	89	198	2017-05-26 14:04:30.136	I	\N
10884	1	89	198	2017-05-26 14:04:30.137	I	\N
10885	1	89	198	2017-05-26 14:04:30.137	I	\N
10886	1	89	198	2017-05-26 14:04:30.139	I	\N
10887	1	89	198	2017-05-26 14:04:30.139	I	\N
10888	1	87	15	2017-05-26 14:04:30.14	I	\N
10889	1	166	112	2017-05-26 14:04:30.142	I	\N
10901	1	167	112	2017-05-26 14:53:15.056	I	\N
10902	1	168	112	2017-05-26 14:53:15.058	I	\N
10921	1	90	16	2017-05-26 17:02:30.108	I	\N
10922	1	90	198	2017-05-26 17:02:30.111	I	\N
10923	1	90	198	2017-05-26 17:02:30.113	I	\N
10924	1	90	198	2017-05-26 17:02:30.114	I	\N
10925	1	90	198	2017-05-26 17:02:30.115	I	\N
10926	1	90	198	2017-05-26 17:02:30.116	I	\N
10927	1	90	198	2017-05-26 17:02:30.116	I	\N
10928	1	88	15	2017-05-26 17:02:30.117	I	\N
10929	1	169	112	2017-05-26 17:02:30.119	I	\N
10941	1	170	112	2017-05-26 17:09:00.133	I	\N
10942	1	171	112	2017-05-26 17:09:00.136	I	\N
10961	1	172	112	2017-05-27 12:09:15.11	I	\N
10962	1	173	112	2017-05-27 12:09:15.112	I	\N
10981	1	91	16	2017-05-27 12:57:15.064	I	\N
10982	1	91	198	2017-05-27 12:57:15.066	I	\N
10983	1	91	198	2017-05-27 12:57:15.068	I	\N
10984	1	91	198	2017-05-27 12:57:15.068	I	\N
10985	1	91	198	2017-05-27 12:57:15.069	I	\N
10986	1	91	198	2017-05-27 12:57:15.07	I	\N
10987	1	91	198	2017-05-27 12:57:15.075	I	\N
10988	1	89	15	2017-05-27 12:57:15.076	I	\N
10989	1	174	112	2017-05-27 12:57:15.079	I	\N
11001	1	92	16	2017-05-27 17:31:00.163	I	\N
11002	1	92	198	2017-05-27 17:31:00.165	I	\N
11003	1	92	198	2017-05-27 17:31:00.166	I	\N
11004	1	92	198	2017-05-27 17:31:00.167	I	\N
11005	1	92	198	2017-05-27 17:31:00.168	I	\N
11006	1	92	198	2017-05-27 17:31:00.169	I	\N
11007	1	92	198	2017-05-27 17:31:00.17	I	\N
11008	1	90	15	2017-05-27 17:31:00.17	I	\N
11009	1	175	112	2017-05-27 17:31:00.172	I	\N
11021	1	176	112	2017-05-27 17:34:15.061	I	\N
11022	1	177	112	2017-05-27 17:34:15.062	I	\N
11041	1	103	1	2017-05-28 20:01:45.134	I	\N
11042	1	129	23	2017-05-28 20:01:45.137	I	\N
11043	1	739	4	2017-05-28 20:01:45.139	I	\N
11044	1	740	4	2017-05-28 20:01:45.142	I	\N
11045	1	741	4	2017-05-28 20:01:45.144	I	\N
11046	1	742	4	2017-05-28 20:01:45.146	I	\N
11047	1	743	4	2017-05-28 20:01:45.148	I	\N
11048	1	744	4	2017-05-28 20:01:45.15	I	\N
11049	1	745	4	2017-05-28 20:01:45.152	I	\N
11050	1	746	4	2017-05-28 20:01:45.153	I	\N
11051	1	747	4	2017-05-28 20:01:45.162	I	\N
11052	1	748	4	2017-05-28 20:01:45.164	I	\N
11053	1	749	4	2017-05-28 20:01:45.165	I	\N
11054	1	750	4	2017-05-28 20:01:45.167	I	\N
11055	1	751	4	2017-05-28 20:01:45.168	I	\N
11056	1	752	4	2017-05-28 20:01:45.172	I	\N
11057	1	753	4	2017-05-28 20:01:45.174	I	\N
11058	1	754	4	2017-05-28 20:01:45.175	I	\N
11059	1	755	4	2017-05-28 20:01:45.177	I	\N
11060	1	756	4	2017-05-28 20:01:45.178	I	\N
11061	1	757	4	2017-05-28 20:01:45.18	I	\N
11062	1	758	4	2017-05-28 20:01:45.182	I	\N
11063	1	759	4	2017-05-28 20:01:45.184	I	\N
11064	1	760	4	2017-05-28 20:01:45.185	I	\N
11065	1	761	4	2017-05-28 20:01:45.187	I	\N
11066	1	103	45	2017-05-28 20:01:45.188	I	\N
11081	1	93	16	2017-05-28 20:35:00.137	I	\N
11082	1	93	198	2017-05-28 20:35:00.139	I	\N
11083	1	93	198	2017-05-28 20:35:00.14	I	\N
11084	1	93	198	2017-05-28 20:35:00.141	I	\N
11085	1	93	198	2017-05-28 20:35:00.142	I	\N
11086	1	93	198	2017-05-28 20:35:00.143	I	\N
11087	1	93	198	2017-05-28 20:35:00.144	I	\N
11088	1	91	15	2017-05-28 20:35:00.144	I	\N
11089	1	178	112	2017-05-28 20:35:00.146	I	\N
11101	1	94	16	2017-05-29 11:02:00.127	I	\N
11102	1	94	198	2017-05-29 11:02:00.129	I	\N
11103	1	94	198	2017-05-29 11:02:00.131	I	\N
11104	1	94	198	2017-05-29 11:02:00.132	I	\N
11105	1	94	198	2017-05-29 11:02:00.133	I	\N
11106	1	94	198	2017-05-29 11:02:00.133	I	\N
11107	1	94	198	2017-05-29 11:02:00.134	I	\N
11108	1	92	15	2017-05-29 11:02:00.135	I	\N
11109	1	179	112	2017-05-29 11:02:00.137	I	\N
11110	1	95	16	2017-05-29 11:05:00.078	I	\N
11111	1	95	198	2017-05-29 11:05:00.079	I	\N
11112	1	95	198	2017-05-29 11:05:00.08	I	\N
11113	1	95	198	2017-05-29 11:05:00.08	I	\N
11114	1	95	198	2017-05-29 11:05:00.081	I	\N
11115	1	95	198	2017-05-29 11:05:00.081	I	\N
11116	1	95	198	2017-05-29 11:05:00.082	I	\N
11117	1	93	15	2017-05-29 11:05:00.083	I	\N
11118	1	180	112	2017-05-29 11:05:00.084	I	\N
11121	1	96	16	2017-05-29 11:05:30.088	I	\N
11122	1	96	198	2017-05-29 11:05:30.09	I	\N
11123	1	96	198	2017-05-29 11:05:30.091	I	\N
11124	1	96	198	2017-05-29 11:05:30.092	I	\N
11125	1	96	198	2017-05-29 11:05:30.116	I	\N
11126	1	96	198	2017-05-29 11:05:30.117	I	\N
11127	1	96	198	2017-05-29 11:05:30.118	I	\N
11128	1	94	15	2017-05-29 11:05:30.118	I	\N
11129	1	181	112	2017-05-29 11:05:30.12	I	\N
11119	1	182	112	2017-05-29 11:05:45.078	I	\N
11120	1	183	112	2017-05-29 11:05:45.079	I	\N
11141	1	184	112	2017-05-29 11:22:15.061	I	\N
11142	1	185	112	2017-05-29 11:22:15.063	I	\N
11161	1	104	1	2017-05-29 12:03:00.195	I	\N
11162	1	130	23	2017-05-29 12:03:00.197	I	\N
11163	1	762	4	2017-05-29 12:03:00.2	I	\N
11164	1	763	4	2017-05-29 12:03:00.203	I	\N
11165	1	764	4	2017-05-29 12:03:00.205	I	\N
11166	1	765	4	2017-05-29 12:03:00.207	I	\N
11167	1	766	4	2017-05-29 12:03:00.209	I	\N
11168	1	767	4	2017-05-29 12:03:00.21	I	\N
11169	1	768	4	2017-05-29 12:03:00.212	I	\N
11170	1	769	4	2017-05-29 12:03:00.214	I	\N
11171	1	770	4	2017-05-29 12:03:00.215	I	\N
11172	1	771	4	2017-05-29 12:03:00.217	I	\N
11173	1	772	4	2017-05-29 12:03:00.221	I	\N
11174	1	773	4	2017-05-29 12:03:00.222	I	\N
11175	1	774	4	2017-05-29 12:03:00.224	I	\N
11176	1	775	4	2017-05-29 12:03:00.231	I	\N
11177	1	776	4	2017-05-29 12:03:00.233	I	\N
11178	1	777	4	2017-05-29 12:03:00.236	I	\N
11179	1	778	4	2017-05-29 12:03:00.239	I	\N
11180	1	779	4	2017-05-29 12:03:00.241	I	\N
11181	1	780	4	2017-05-29 12:03:00.243	I	\N
11182	1	781	4	2017-05-29 12:03:00.244	I	\N
11183	1	782	4	2017-05-29 12:03:00.253	I	\N
11184	1	783	4	2017-05-29 12:03:00.255	I	\N
11185	1	784	4	2017-05-29 12:03:00.257	I	\N
11186	1	104	45	2017-05-29 12:03:00.259	I	\N
11201	1	105	1	2017-05-29 13:34:00.144	I	\N
11202	1	131	23	2017-05-29 13:34:00.147	I	\N
11203	1	785	4	2017-05-29 13:34:00.15	I	\N
11204	1	132	23	2017-05-29 13:34:00.152	I	\N
11205	1	786	4	2017-05-29 13:34:00.154	I	\N
11206	1	133	23	2017-05-29 13:34:00.156	I	\N
11207	1	787	4	2017-05-29 13:34:00.157	I	\N
11208	1	788	4	2017-05-29 13:34:00.159	I	\N
11209	1	789	4	2017-05-29 13:34:00.163	I	\N
11210	1	790	4	2017-05-29 13:34:00.165	I	\N
11211	1	791	4	2017-05-29 13:34:00.169	I	\N
11212	1	792	4	2017-05-29 13:34:00.17	I	\N
11213	1	793	4	2017-05-29 13:34:00.172	I	\N
11214	1	794	4	2017-05-29 13:34:00.174	I	\N
11215	1	795	4	2017-05-29 13:34:00.175	I	\N
11216	1	796	4	2017-05-29 13:34:00.177	I	\N
11217	1	797	4	2017-05-29 13:34:00.179	I	\N
11218	1	798	4	2017-05-29 13:34:00.18	I	\N
11219	1	799	4	2017-05-29 13:34:00.182	I	\N
11220	1	800	4	2017-05-29 13:34:00.183	I	\N
11221	1	801	4	2017-05-29 13:34:00.185	I	\N
11222	1	802	4	2017-05-29 13:34:00.187	I	\N
11223	1	803	4	2017-05-29 13:34:00.189	I	\N
11224	1	804	4	2017-05-29 13:34:00.191	I	\N
11225	1	805	4	2017-05-29 13:34:00.192	I	\N
11226	1	806	4	2017-05-29 13:34:00.194	I	\N
11227	1	807	4	2017-05-29 13:34:00.196	I	\N
11228	1	808	4	2017-05-29 13:34:00.198	I	\N
11229	1	809	4	2017-05-29 13:34:00.199	I	\N
11230	1	810	4	2017-05-29 13:34:00.201	I	\N
11231	1	134	23	2017-05-29 13:34:00.202	I	\N
11232	1	811	4	2017-05-29 13:34:00.204	I	\N
11233	1	105	45	2017-05-29 13:34:00.206	I	\N
11241	1	97	16	2017-05-29 14:07:15.063	I	\N
11242	1	97	198	2017-05-29 14:07:15.066	I	\N
11243	1	97	198	2017-05-29 14:07:15.067	I	\N
11244	1	97	198	2017-05-29 14:07:15.068	I	\N
11245	1	97	198	2017-05-29 14:07:15.069	I	\N
11246	1	97	198	2017-05-29 14:07:15.069	I	\N
11247	1	97	198	2017-05-29 14:07:15.07	I	\N
11248	1	95	15	2017-05-29 14:07:15.071	I	\N
11249	1	186	112	2017-05-29 14:07:15.073	I	\N
11250	1	187	112	2017-05-29 14:07:30.123	I	\N
11251	1	188	112	2017-05-29 14:07:30.124	I	\N
11261	1	106	1	2017-05-29 15:08:00.13	I	\N
11262	1	135	23	2017-05-29 15:08:00.132	I	\N
11263	1	812	4	2017-05-29 15:08:00.135	I	\N
11264	1	813	4	2017-05-29 15:08:00.138	I	\N
11265	1	814	4	2017-05-29 15:08:00.14	I	\N
11266	1	815	4	2017-05-29 15:08:00.142	I	\N
11267	1	816	4	2017-05-29 15:08:00.143	I	\N
11268	1	817	4	2017-05-29 15:08:00.146	I	\N
11269	1	818	4	2017-05-29 15:08:00.148	I	\N
11270	1	819	4	2017-05-29 15:08:00.149	I	\N
11271	1	820	4	2017-05-29 15:08:00.151	I	\N
11272	1	821	4	2017-05-29 15:08:00.155	I	\N
11273	1	822	4	2017-05-29 15:08:00.156	I	\N
11274	1	823	4	2017-05-29 15:08:00.158	I	\N
11275	1	824	4	2017-05-29 15:08:00.159	I	\N
11276	1	825	4	2017-05-29 15:08:00.161	I	\N
11277	1	826	4	2017-05-29 15:08:00.162	I	\N
11278	1	827	4	2017-05-29 15:08:00.164	I	\N
11279	1	828	4	2017-05-29 15:08:00.165	I	\N
11280	1	829	4	2017-05-29 15:08:00.167	I	\N
11281	1	830	4	2017-05-29 15:08:00.168	I	\N
11282	1	831	4	2017-05-29 15:08:00.172	I	\N
11283	1	832	4	2017-05-29 15:08:00.174	I	\N
11284	1	833	4	2017-05-29 15:08:00.176	I	\N
11285	1	834	4	2017-05-29 15:08:00.178	I	\N
11286	1	106	45	2017-05-29 15:08:00.179	I	\N
11301	1	32	198	2017-05-29 15:17:53.916	I	\N
11302	1	32	198	2017-05-29 15:17:53.918	I	\N
11303	1	32	198	2017-05-29 15:17:53.918	I	\N
11304	1	32	198	2017-05-29 15:17:53.919	I	\N
11305	1	32	198	2017-05-29 15:17:53.92	I	\N
11306	1	32	198	2017-05-29 15:17:53.921	I	\N
11307	1	107	1	2017-05-29 15:17:53.922	I	\N
11308	1	136	23	2017-05-29 15:17:53.923	I	\N
11309	1	835	4	2017-05-29 15:17:53.927	I	\N
11310	1	836	4	2017-05-29 15:17:53.93	I	\N
11311	1	837	4	2017-05-29 15:17:53.932	I	\N
11312	1	107	45	2017-05-29 15:17:53.933	I	\N
11321	1	84	208	2017-05-29 15:18:19.485	I	\N
11341	1	262	21	2017-05-29 18:27:08.461	I	\N
11342	1	256	155	2017-05-29 18:27:08.464	I	\N
11343	1	263	21	2017-05-29 18:27:08.465	I	\N
11344	1	257	155	2017-05-29 18:27:08.466	I	\N
11345	1	106	1	2017-05-29 18:27:08.473	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11361	1	108	1	2017-05-30 10:27:15.125	I	\N
11362	1	137	23	2017-05-30 10:27:15.128	I	\N
11363	1	838	4	2017-05-30 10:27:15.13	I	\N
11364	1	839	4	2017-05-30 10:27:15.133	I	\N
11365	1	840	4	2017-05-30 10:27:15.135	I	\N
11366	1	841	4	2017-05-30 10:27:15.136	I	\N
11367	1	842	4	2017-05-30 10:27:15.138	I	\N
11368	1	843	4	2017-05-30 10:27:15.14	I	\N
11369	1	844	4	2017-05-30 10:27:15.141	I	\N
11370	1	845	4	2017-05-30 10:27:15.143	I	\N
11371	1	846	4	2017-05-30 10:27:15.145	I	\N
11372	1	108	45	2017-05-30 10:27:15.146	I	\N
11381	1	264	21	2017-05-30 10:36:59.311	I	\N
11382	1	258	155	2017-05-30 10:36:59.314	I	\N
11383	1	265	21	2017-05-30 10:36:59.316	I	\N
11384	1	259	155	2017-05-30 10:36:59.317	I	\N
11385	1	266	21	2017-05-30 10:36:59.318	I	\N
11386	1	260	155	2017-05-30 10:36:59.319	I	\N
11387	1	267	21	2017-05-30 10:36:59.321	I	\N
11388	1	261	155	2017-05-30 10:36:59.322	I	\N
11389	1	268	21	2017-05-30 10:36:59.323	I	\N
11390	1	262	155	2017-05-30 10:36:59.324	I	\N
11391	1	269	21	2017-05-30 10:36:59.325	I	\N
11392	1	263	155	2017-05-30 10:36:59.326	I	\N
11393	1	270	21	2017-05-30 10:36:59.328	I	\N
11394	1	264	155	2017-05-30 10:36:59.328	I	\N
11395	1	271	21	2017-05-30 10:36:59.33	I	\N
11396	1	265	155	2017-05-30 10:36:59.33	I	\N
11397	1	272	21	2017-05-30 10:36:59.332	I	\N
11398	1	266	155	2017-05-30 10:36:59.333	I	\N
11399	1	108	1	2017-05-30 10:36:59.356	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11400	1	109	1	2017-05-30 10:40:45.082	I	\N
11401	1	138	23	2017-05-30 10:40:45.084	I	\N
11402	1	847	4	2017-05-30 10:40:45.086	I	\N
11403	1	109	45	2017-05-30 10:40:45.087	I	\N
11421	1	273	21	2017-05-30 10:42:56.224	I	\N
11422	1	267	155	2017-05-30 10:42:56.235	I	\N
11423	1	109	1	2017-05-30 10:42:56.248	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11441	1	85	208	2017-05-30 10:43:30.391	I	\N
11461	1	86	208	2017-05-30 10:51:55.662	I	\N
11481	1	274	21	2017-05-30 10:54:21.322	I	\N
11482	1	268	155	2017-05-30 10:54:21.324	I	\N
11483	1	275	21	2017-05-30 10:54:21.326	I	\N
11484	1	269	155	2017-05-30 10:54:21.328	I	\N
11485	1	276	21	2017-05-30 10:54:21.329	I	\N
11486	1	270	155	2017-05-30 10:54:21.331	I	\N
11487	1	277	21	2017-05-30 10:54:21.332	I	\N
11488	1	271	155	2017-05-30 10:54:21.334	I	\N
11489	1	278	21	2017-05-30 10:54:21.335	I	\N
11490	1	272	155	2017-05-30 10:54:21.336	I	\N
11491	1	279	21	2017-05-30 10:54:21.338	I	\N
11492	1	273	155	2017-05-30 10:54:21.339	I	\N
11493	1	280	21	2017-05-30 10:54:21.34	I	\N
11494	1	274	155	2017-05-30 10:54:21.341	I	\N
11495	1	281	21	2017-05-30 10:54:21.342	I	\N
11496	1	275	155	2017-05-30 10:54:21.343	I	\N
11497	1	282	21	2017-05-30 10:54:21.345	I	\N
11498	1	276	155	2017-05-30 10:54:21.346	I	\N
11499	1	283	21	2017-05-30 10:54:21.347	I	\N
11500	1	277	155	2017-05-30 10:54:21.348	I	\N
11501	1	284	21	2017-05-30 10:54:21.349	I	\N
11502	1	278	155	2017-05-30 10:54:21.35	I	\N
11503	1	285	21	2017-05-30 10:54:21.352	I	\N
11504	1	279	155	2017-05-30 10:54:21.353	I	\N
11505	1	286	21	2017-05-30 10:54:21.354	I	\N
11506	1	280	155	2017-05-30 10:54:21.355	I	\N
11507	1	287	21	2017-05-30 10:54:21.356	I	\N
11508	1	281	155	2017-05-30 10:54:21.357	I	\N
11509	1	288	21	2017-05-30 10:54:21.359	I	\N
11510	1	282	155	2017-05-30 10:54:21.36	I	\N
11511	1	289	21	2017-05-30 10:54:21.361	I	\N
11512	1	283	155	2017-05-30 10:54:21.362	I	\N
11513	1	290	21	2017-05-30 10:54:21.364	I	\N
11514	1	284	155	2017-05-30 10:54:21.365	I	\N
11515	1	291	21	2017-05-30 10:54:21.366	I	\N
11516	1	285	155	2017-05-30 10:54:21.367	I	\N
11517	1	292	21	2017-05-30 10:54:21.368	I	\N
11518	1	286	155	2017-05-30 10:54:21.369	I	\N
11519	1	293	21	2017-05-30 10:54:21.371	I	\N
11520	1	287	155	2017-05-30 10:54:21.372	I	\N
11521	1	294	21	2017-05-30 10:54:21.373	I	\N
11522	1	288	155	2017-05-30 10:54:21.374	I	\N
11541	1	87	208	2017-05-30 11:00:04.826	I	\N
11561	1	98	16	2017-05-30 12:15:45.064	I	\N
11562	1	98	198	2017-05-30 12:15:45.066	I	\N
11563	1	98	198	2017-05-30 12:15:45.067	I	\N
11564	1	98	198	2017-05-30 12:15:45.068	I	\N
11565	1	98	198	2017-05-30 12:15:45.069	I	\N
11566	1	98	198	2017-05-30 12:15:45.07	I	\N
11567	1	98	198	2017-05-30 12:15:45.071	I	\N
11568	1	96	15	2017-05-30 12:15:45.071	I	\N
11569	1	189	112	2017-05-30 12:15:45.073	I	\N
11581	1	99	16	2017-05-30 12:21:30.158	I	\N
11582	1	99	198	2017-05-30 12:21:30.16	I	\N
11583	1	99	198	2017-05-30 12:21:30.161	I	\N
11584	1	99	198	2017-05-30 12:21:30.162	I	\N
11585	1	99	198	2017-05-30 12:21:30.163	I	\N
11586	1	99	198	2017-05-30 12:21:30.164	I	\N
11587	1	99	198	2017-05-30 12:21:30.164	I	\N
11588	1	97	15	2017-05-30 12:21:30.166	I	\N
11589	1	190	112	2017-05-30 12:21:30.169	I	\N
11601	1	100	16	2017-05-30 12:50:00.081	I	\N
11602	1	100	198	2017-05-30 12:50:00.083	I	\N
11603	1	100	198	2017-05-30 12:50:00.084	I	\N
11604	1	100	198	2017-05-30 12:50:00.085	I	\N
11605	1	100	198	2017-05-30 12:50:00.086	I	\N
11606	1	100	198	2017-05-30 12:50:00.086	I	\N
11607	1	100	198	2017-05-30 12:50:00.087	I	\N
11608	1	98	15	2017-05-30 12:50:00.088	I	\N
11609	1	191	112	2017-05-30 12:50:00.09	I	\N
11621	1	110	1	2017-05-30 12:56:30.095	I	\N
11622	1	139	23	2017-05-30 12:56:30.097	I	\N
11623	1	848	4	2017-05-30 12:56:30.1	I	\N
11624	1	110	45	2017-05-30 12:56:30.102	I	\N
11641	1	295	21	2017-05-30 12:56:56.684	I	\N
11642	1	289	155	2017-05-30 12:56:56.686	I	\N
11643	1	110	1	2017-05-30 12:56:56.691	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11625	1	111	1	2017-05-30 12:58:00.102	I	\N
11626	1	140	23	2017-05-30 12:58:00.104	I	\N
11627	1	849	4	2017-05-30 12:58:00.106	I	\N
11628	1	111	45	2017-05-30 12:58:00.108	I	\N
11661	1	192	112	2017-05-30 13:02:45.063	I	\N
11662	1	193	112	2017-05-30 13:02:45.067	I	\N
11681	1	101	16	2017-05-30 13:04:45.066	I	\N
11682	1	101	198	2017-05-30 13:04:45.068	I	\N
11683	1	101	198	2017-05-30 13:04:45.069	I	\N
11684	1	101	198	2017-05-30 13:04:45.07	I	\N
11685	1	101	198	2017-05-30 13:04:45.071	I	\N
11686	1	101	198	2017-05-30 13:04:45.071	I	\N
11687	1	101	198	2017-05-30 13:04:45.072	I	\N
11688	1	99	15	2017-05-30 13:04:45.073	I	\N
11689	1	194	112	2017-05-30 13:04:45.075	I	\N
11701	1	195	112	2017-05-30 13:06:45.069	I	\N
11702	1	196	112	2017-05-30 13:06:45.071	I	\N
11721	1	102	16	2017-05-30 15:08:45.075	I	\N
11722	1	102	198	2017-05-30 15:08:45.077	I	\N
11723	1	102	198	2017-05-30 15:08:45.078	I	\N
11724	1	102	198	2017-05-30 15:08:45.079	I	\N
11725	1	102	198	2017-05-30 15:08:45.08	I	\N
11726	1	102	198	2017-05-30 15:08:45.08	I	\N
11727	1	102	198	2017-05-30 15:08:45.081	I	\N
11728	1	100	15	2017-05-30 15:08:45.082	I	\N
11729	1	197	112	2017-05-30 15:08:45.084	I	\N
11741	1	198	112	2017-05-30 15:09:15.067	I	\N
11742	1	199	112	2017-05-30 15:09:15.069	I	\N
11761	1	112	1	2017-05-30 15:26:30.12	I	\N
11762	1	141	23	2017-05-30 15:26:30.122	I	\N
11763	1	850	4	2017-05-30 15:26:30.125	I	\N
11764	1	112	45	2017-05-30 15:26:30.127	I	\N
11781	1	296	21	2017-05-30 16:41:51.659	I	\N
11782	1	290	155	2017-05-30 16:41:51.67	I	\N
11783	1	112	1	2017-05-30 16:41:51.697	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11784	1	103	16	2017-05-30 16:42:15.276	I	\N
11785	1	103	198	2017-05-30 16:42:15.281	I	\N
11786	1	103	198	2017-05-30 16:42:15.287	I	\N
11787	1	103	198	2017-05-30 16:42:15.288	I	\N
11788	1	103	198	2017-05-30 16:42:15.295	I	\N
11789	1	103	198	2017-05-30 16:42:15.3	I	\N
11790	1	103	198	2017-05-30 16:42:15.302	I	\N
11791	1	101	15	2017-05-30 16:42:15.306	I	\N
11792	1	200	112	2017-05-30 16:42:15.31	I	\N
11793	1	113	1	2017-05-30 16:42:30.381	I	\N
11794	1	142	23	2017-05-30 16:42:30.393	I	\N
11795	1	851	4	2017-05-30 16:42:30.411	I	\N
11796	1	113	45	2017-05-30 16:42:30.419	I	\N
11801	1	114	1	2017-05-30 16:42:45.16	I	\N
11802	1	143	23	2017-05-30 16:42:45.166	I	\N
11803	1	852	4	2017-05-30 16:42:45.174	I	\N
11804	1	853	4	2017-05-30 16:42:45.181	I	\N
11805	1	854	4	2017-05-30 16:42:45.186	I	\N
11806	1	855	4	2017-05-30 16:42:45.193	I	\N
11807	1	856	4	2017-05-30 16:42:45.2	I	\N
11808	1	857	4	2017-05-30 16:42:45.206	I	\N
11809	1	858	4	2017-05-30 16:42:45.209	I	\N
11810	1	859	4	2017-05-30 16:42:45.217	I	\N
11811	1	860	4	2017-05-30 16:42:45.222	I	\N
11812	1	861	4	2017-05-30 16:42:45.228	I	\N
11813	1	862	4	2017-05-30 16:42:45.236	I	\N
11814	1	863	4	2017-05-30 16:42:45.241	I	\N
11815	1	864	4	2017-05-30 16:42:45.244	I	\N
11816	1	865	4	2017-05-30 16:42:45.25	I	\N
11817	1	866	4	2017-05-30 16:42:45.256	I	\N
11818	1	867	4	2017-05-30 16:42:45.26	I	\N
11819	1	868	4	2017-05-30 16:42:45.264	I	\N
11820	1	869	4	2017-05-30 16:42:45.267	I	\N
11821	1	870	4	2017-05-30 16:42:45.271	I	\N
11822	1	871	4	2017-05-30 16:42:45.274	I	\N
11823	1	872	4	2017-05-30 16:42:45.277	I	\N
11824	1	873	4	2017-05-30 16:42:45.281	I	\N
11825	1	874	4	2017-05-30 16:42:45.291	I	\N
11826	1	114	45	2017-05-30 16:42:45.295	I	\N
11841	1	297	21	2017-05-30 16:44:45.473	I	\N
11842	1	291	155	2017-05-30 16:44:45.477	I	\N
11843	1	113	1	2017-05-30 16:44:45.486	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11861	1	298	21	2017-05-30 16:45:09.826	I	\N
11862	1	292	155	2017-05-30 16:45:09.829	I	\N
11863	1	299	21	2017-05-30 16:45:09.832	I	\N
11864	1	293	155	2017-05-30 16:45:09.837	I	\N
11865	1	300	21	2017-05-30 16:45:09.84	I	\N
11866	1	294	155	2017-05-30 16:45:09.841	I	\N
11867	1	114	1	2017-05-30 16:45:09.859	U	\\x3c73746174757349643e313c2f73746174757349643e0a
11881	1	301	21	2017-05-30 16:52:33.474	I	\N
11882	1	295	155	2017-05-30 16:52:33.477	I	\N
11901	1	88	208	2017-05-30 17:03:15.018	I	\N
11921	1	89	208	2017-05-30 17:03:15.034	I	\N
11941	1	90	208	2017-05-30 17:04:18.507	I	\N
11961	1	104	16	2017-05-31 11:02:00.132	I	\N
11962	1	104	198	2017-05-31 11:02:00.137	I	\N
11963	1	104	198	2017-05-31 11:02:00.138	I	\N
11964	1	104	198	2017-05-31 11:02:00.139	I	\N
11965	1	104	198	2017-05-31 11:02:00.14	I	\N
11966	1	104	198	2017-05-31 11:02:00.141	I	\N
11967	1	104	198	2017-05-31 11:02:00.143	I	\N
11968	1	102	15	2017-05-31 11:02:00.145	I	\N
11969	1	201	112	2017-05-31 11:02:00.151	I	\N
11981	1	105	16	2017-05-31 11:59:45.066	I	\N
11982	1	105	198	2017-05-31 11:59:45.069	I	\N
11983	1	105	198	2017-05-31 11:59:45.07	I	\N
11984	1	105	198	2017-05-31 11:59:45.071	I	\N
11985	1	105	198	2017-05-31 11:59:45.072	I	\N
11986	1	105	198	2017-05-31 11:59:45.073	I	\N
11987	1	105	198	2017-05-31 11:59:45.074	I	\N
11988	1	103	15	2017-05-31 11:59:45.076	I	\N
11989	1	202	112	2017-05-31 11:59:45.078	I	\N
12001	1	203	112	2017-06-01 10:38:30.167	I	\N
12002	1	204	112	2017-06-01 10:38:30.17	I	\N
12003	1	106	16	2017-06-01 10:39:15.083	I	\N
12004	1	106	198	2017-06-01 10:39:15.084	I	\N
12005	1	106	198	2017-06-01 10:39:15.086	I	\N
12006	1	106	198	2017-06-01 10:39:15.086	I	\N
12007	1	106	198	2017-06-01 10:39:15.087	I	\N
12008	1	106	198	2017-06-01 10:39:15.088	I	\N
12009	1	106	198	2017-06-01 10:39:15.089	I	\N
12010	1	104	15	2017-06-01 10:39:15.09	I	\N
12011	1	205	112	2017-06-01 10:39:15.092	I	\N
12021	1	107	16	2017-06-01 19:40:00.122	I	\N
12022	1	107	198	2017-06-01 19:40:00.126	I	\N
12023	1	107	198	2017-06-01 19:40:00.127	I	\N
12024	1	107	198	2017-06-01 19:40:00.128	I	\N
12025	1	107	198	2017-06-01 19:40:00.129	I	\N
12026	1	107	198	2017-06-01 19:40:00.13	I	\N
12027	1	107	198	2017-06-01 19:40:00.131	I	\N
12028	1	105	15	2017-06-01 19:40:00.132	I	\N
12029	1	206	112	2017-06-01 19:40:00.137	I	\N
12041	1	207	112	2017-06-01 19:40:15.076	I	\N
12042	1	208	112	2017-06-01 19:40:15.078	I	\N
12061	1	209	112	2017-06-02 09:20:15.064	I	\N
12062	1	210	112	2017-06-02 09:20:15.067	I	\N
12081	1	108	16	2017-06-02 09:21:30.117	I	\N
12082	1	108	198	2017-06-02 09:21:30.119	I	\N
12083	1	108	198	2017-06-02 09:21:30.121	I	\N
12084	1	108	198	2017-06-02 09:21:30.122	I	\N
12085	1	108	198	2017-06-02 09:21:30.123	I	\N
12086	1	108	198	2017-06-02 09:21:30.124	I	\N
12087	1	108	198	2017-06-02 09:21:30.125	I	\N
12088	1	106	15	2017-06-02 09:21:30.125	I	\N
12089	1	211	112	2017-06-02 09:21:30.128	I	\N
12101	1	109	16	2017-06-02 09:21:45.052	I	\N
12102	1	109	198	2017-06-02 09:21:45.054	I	\N
12103	1	109	198	2017-06-02 09:21:45.055	I	\N
12104	1	109	198	2017-06-02 09:21:45.056	I	\N
12105	1	109	198	2017-06-02 09:21:45.057	I	\N
12106	1	109	198	2017-06-02 09:21:45.058	I	\N
12107	1	109	198	2017-06-02 09:21:45.059	I	\N
12108	1	107	15	2017-06-02 09:21:45.059	I	\N
12109	1	212	112	2017-06-02 09:21:45.061	I	\N
12121	1	110	16	2017-06-02 09:32:30.091	I	\N
12122	1	110	198	2017-06-02 09:32:30.098	I	\N
12123	1	110	198	2017-06-02 09:32:30.099	I	\N
12124	1	110	198	2017-06-02 09:32:30.1	I	\N
12125	1	110	198	2017-06-02 09:32:30.101	I	\N
12126	1	110	198	2017-06-02 09:32:30.102	I	\N
12127	1	110	198	2017-06-02 09:32:30.103	I	\N
12128	1	108	15	2017-06-02 09:32:30.104	I	\N
12129	1	213	112	2017-06-02 09:32:30.111	I	\N
12141	1	214	112	2017-06-02 09:33:30.105	I	\N
12142	1	215	112	2017-06-02 09:33:30.107	I	\N
12161	1	216	112	2017-06-02 10:07:45.067	I	\N
12162	1	217	112	2017-06-02 10:07:45.069	I	\N
12181	1	115	1	2017-06-02 10:25:30.189	I	\N
12182	1	144	23	2017-06-02 10:25:30.192	I	\N
12183	1	875	4	2017-06-02 10:25:30.195	I	\N
12184	1	876	4	2017-06-02 10:25:30.199	I	\N
12185	1	877	4	2017-06-02 10:25:30.202	I	\N
12186	1	878	4	2017-06-02 10:25:30.205	I	\N
12187	1	879	4	2017-06-02 10:25:30.214	I	\N
12188	1	880	4	2017-06-02 10:25:30.216	I	\N
12189	1	881	4	2017-06-02 10:25:30.22	I	\N
12190	1	882	4	2017-06-02 10:25:30.222	I	\N
12191	1	883	4	2017-06-02 10:25:30.224	I	\N
12192	1	884	4	2017-06-02 10:25:30.231	I	\N
12193	1	885	4	2017-06-02 10:25:30.233	I	\N
12194	1	886	4	2017-06-02 10:25:30.235	I	\N
12195	1	887	4	2017-06-02 10:25:30.236	I	\N
12196	1	888	4	2017-06-02 10:25:30.238	I	\N
12197	1	889	4	2017-06-02 10:25:30.24	I	\N
12198	1	890	4	2017-06-02 10:25:30.242	I	\N
12199	1	891	4	2017-06-02 10:25:30.244	I	\N
12200	1	892	4	2017-06-02 10:25:30.246	I	\N
12201	1	893	4	2017-06-02 10:25:30.247	I	\N
12202	1	894	4	2017-06-02 10:25:30.249	I	\N
12203	1	895	4	2017-06-02 10:25:30.251	I	\N
12204	1	896	4	2017-06-02 10:25:30.253	I	\N
12205	1	897	4	2017-06-02 10:25:30.255	I	\N
12206	1	115	45	2017-06-02 10:25:30.257	I	\N
12221	1	116	1	2017-06-02 11:09:45.094	I	\N
12222	1	145	23	2017-06-02 11:09:45.096	I	\N
12223	1	898	4	2017-06-02 11:09:45.099	I	\N
12224	1	899	4	2017-06-02 11:09:45.101	I	\N
12225	1	900	4	2017-06-02 11:09:45.103	I	\N
12226	1	116	45	2017-06-02 11:09:45.105	I	\N
12241	1	117	1	2017-06-02 14:50:30.124	I	\N
12242	1	146	23	2017-06-02 14:50:30.126	I	\N
12243	1	901	4	2017-06-02 14:50:30.128	I	\N
12244	1	902	4	2017-06-02 14:50:30.131	I	\N
12245	1	903	4	2017-06-02 14:50:30.133	I	\N
12246	1	117	45	2017-06-02 14:50:30.135	I	\N
12261	1	118	1	2017-06-04 18:18:00.141	I	\N
12262	1	147	23	2017-06-04 18:18:00.143	I	\N
12263	1	904	4	2017-06-04 18:18:00.146	I	\N
12264	1	905	4	2017-06-04 18:18:00.149	I	\N
12265	1	906	4	2017-06-04 18:18:00.151	I	\N
12266	1	118	45	2017-06-04 18:18:00.152	I	\N
12281	1	119	1	2017-06-05 21:23:45.091	I	\N
12282	1	148	23	2017-06-05 21:23:45.094	I	\N
12283	1	907	4	2017-06-05 21:23:45.097	I	\N
12284	1	908	4	2017-06-05 21:23:45.101	I	\N
12285	1	909	4	2017-06-05 21:23:45.103	I	\N
12286	1	910	4	2017-06-05 21:23:45.105	I	\N
12287	1	911	4	2017-06-05 21:23:45.107	I	\N
12288	1	912	4	2017-06-05 21:23:45.109	I	\N
12289	1	913	4	2017-06-05 21:23:45.112	I	\N
12290	1	914	4	2017-06-05 21:23:45.113	I	\N
12291	1	915	4	2017-06-05 21:23:45.115	I	\N
12292	1	916	4	2017-06-05 21:23:45.117	I	\N
12293	1	917	4	2017-06-05 21:23:45.119	I	\N
12294	1	918	4	2017-06-05 21:23:45.126	I	\N
12295	1	919	4	2017-06-05 21:23:45.132	I	\N
12296	1	920	4	2017-06-05 21:23:45.133	I	\N
12297	1	921	4	2017-06-05 21:23:45.135	I	\N
12298	1	922	4	2017-06-05 21:23:45.137	I	\N
12299	1	923	4	2017-06-05 21:23:45.138	I	\N
12300	1	924	4	2017-06-05 21:23:45.14	I	\N
12301	1	925	4	2017-06-05 21:23:45.142	I	\N
12302	1	926	4	2017-06-05 21:23:45.144	I	\N
12303	1	927	4	2017-06-05 21:23:45.147	I	\N
12304	1	928	4	2017-06-05 21:23:45.149	I	\N
12305	1	929	4	2017-06-05 21:23:45.151	I	\N
12306	1	119	45	2017-06-05 21:23:45.152	I	\N
12321	1	120	1	2017-06-09 22:04:30.105	I	\N
12322	1	149	23	2017-06-09 22:04:30.108	I	\N
12323	1	930	4	2017-06-09 22:04:30.116	I	\N
12324	1	120	45	2017-06-09 22:04:30.119	I	\N
12341	1	302	21	2017-06-09 22:05:10.25	I	\N
12342	1	296	155	2017-06-09 22:05:10.252	I	\N
12343	1	303	21	2017-06-09 22:05:10.254	I	\N
12344	1	297	155	2017-06-09 22:05:10.256	I	\N
12345	1	21	191	2017-06-09 22:05:10.263	I	\N
12346	1	21	192	2017-06-09 22:05:10.266	I	\N
12347	1	119	1	2017-06-09 22:05:10.274	U	\\x3c73746174757349643e313c2f73746174757349643e0a
12361	1	161	39	2017-06-09 22:06:13.598	I	\N
12381	1	91	208	2017-06-09 22:08:07.352	I	\N
12401	1	111	16	2017-06-10 07:03:15.074	I	\N
12402	1	111	198	2017-06-10 07:03:15.077	I	\N
12403	1	111	198	2017-06-10 07:03:15.078	I	\N
12404	1	111	198	2017-06-10 07:03:15.079	I	\N
12405	1	111	198	2017-06-10 07:03:15.08	I	\N
12406	1	111	198	2017-06-10 07:03:15.08	I	\N
12407	1	111	198	2017-06-10 07:03:15.081	I	\N
12408	1	109	15	2017-06-10 07:03:15.082	I	\N
12409	1	218	112	2017-06-10 07:03:15.086	I	\N
12421	1	92	208	2017-06-13 11:56:57.76	I	\N
12441	1	112	16	2017-06-20 10:42:30.093	I	\N
12442	1	112	198	2017-06-20 10:42:30.096	I	\N
12443	1	112	198	2017-06-20 10:42:30.098	I	\N
12444	1	112	198	2017-06-20 10:42:30.099	I	\N
12445	1	112	198	2017-06-20 10:42:30.1	I	\N
12446	1	112	198	2017-06-20 10:42:30.101	I	\N
12447	1	112	198	2017-06-20 10:42:30.102	I	\N
12448	1	110	15	2017-06-20 10:42:30.103	I	\N
12449	1	219	112	2017-06-20 10:42:30.105	I	\N
12461	1	113	16	2017-07-17 17:59:07.196	I	\N
12462	1	113	198	2017-07-17 17:59:07.368	I	\N
12463	1	113	198	2017-07-17 17:59:07.408	I	\N
12464	1	113	198	2017-07-17 17:59:07.411	I	\N
12465	1	113	198	2017-07-17 17:59:07.414	I	\N
12466	1	113	198	2017-07-17 17:59:07.418	I	\N
12467	1	113	198	2017-07-17 17:59:07.428	I	\N
12468	1	111	15	2017-07-17 17:59:07.451	I	\N
12469	1	220	112	2017-07-17 17:59:07.523	I	\N
12470	1	221	112	2017-07-17 17:59:07.66	I	\N
12471	1	222	112	2017-07-17 17:59:07.687	I	\N
12481	1	114	16	2017-07-17 17:59:08.161	I	\N
12482	1	114	198	2017-07-17 17:59:08.167	I	\N
12483	1	114	198	2017-07-17 17:59:08.179	I	\N
12484	1	114	198	2017-07-17 17:59:08.18	I	\N
12485	1	114	198	2017-07-17 17:59:08.21	I	\N
12486	1	114	198	2017-07-17 17:59:08.212	I	\N
12487	1	114	198	2017-07-17 17:59:08.215	I	\N
12488	1	112	15	2017-07-17 17:59:08.221	I	\N
12489	1	223	112	2017-07-17 17:59:08.235	I	\N
12490	1	224	112	2017-07-17 17:59:08.309	I	\N
12491	1	225	112	2017-07-17 17:59:08.313	I	\N
12492	1	115	16	2017-07-17 17:59:09.021	I	\N
12493	1	115	198	2017-07-17 17:59:09.028	I	\N
12494	1	115	198	2017-07-17 17:59:09.034	I	\N
12495	1	115	198	2017-07-17 17:59:09.036	I	\N
12496	1	115	198	2017-07-17 17:59:09.038	I	\N
12497	1	115	198	2017-07-17 17:59:09.046	I	\N
12498	1	115	198	2017-07-17 17:59:09.056	I	\N
12499	1	113	15	2017-07-17 17:59:09.057	I	\N
12500	1	226	112	2017-07-17 17:59:09.069	I	\N
12501	1	227	112	2017-07-17 17:59:09.444	I	\N
12502	1	228	112	2017-07-17 17:59:09.447	I	\N
12503	1	116	16	2017-07-17 17:59:09.497	I	\N
12504	1	116	198	2017-07-17 17:59:09.499	I	\N
12505	1	116	198	2017-07-17 17:59:09.503	I	\N
12506	1	116	198	2017-07-17 17:59:09.505	I	\N
12507	1	116	198	2017-07-17 17:59:09.507	I	\N
12508	1	116	198	2017-07-17 17:59:09.508	I	\N
12509	1	116	198	2017-07-17 17:59:09.509	I	\N
12510	1	114	15	2017-07-17 17:59:09.512	I	\N
12511	1	229	112	2017-07-17 17:59:09.515	I	\N
12512	1	117	16	2017-07-17 17:59:09.551	I	\N
12513	1	117	198	2017-07-17 17:59:09.554	I	\N
12514	1	117	198	2017-07-17 17:59:09.555	I	\N
12515	1	117	198	2017-07-17 17:59:09.557	I	\N
12516	1	117	198	2017-07-17 17:59:09.56	I	\N
12517	1	117	198	2017-07-17 17:59:09.561	I	\N
12518	1	117	198	2017-07-17 17:59:09.563	I	\N
12519	1	115	15	2017-07-17 17:59:09.564	I	\N
12520	1	230	112	2017-07-17 17:59:09.571	I	\N
12521	1	118	16	2017-07-17 17:59:09.62	I	\N
12522	1	118	198	2017-07-17 17:59:09.623	I	\N
12523	1	118	198	2017-07-17 17:59:09.627	I	\N
12524	1	118	198	2017-07-17 17:59:09.628	I	\N
12525	1	118	198	2017-07-17 17:59:09.63	I	\N
12526	1	118	198	2017-07-17 17:59:09.632	I	\N
12527	1	118	198	2017-07-17 17:59:09.637	I	\N
12528	1	116	15	2017-07-17 17:59:09.64	I	\N
12529	1	231	112	2017-07-17 17:59:09.653	I	\N
12541	1	232	112	2017-07-17 17:59:09.703	I	\N
12542	1	233	112	2017-07-17 17:59:09.707	I	\N
12543	1	119	16	2017-07-17 17:59:09.803	I	\N
12544	1	119	198	2017-07-17 17:59:09.805	I	\N
12545	1	119	198	2017-07-17 17:59:09.807	I	\N
12546	1	119	198	2017-07-17 17:59:09.808	I	\N
12547	1	119	198	2017-07-17 17:59:09.809	I	\N
12548	1	119	198	2017-07-17 17:59:09.81	I	\N
12549	1	119	198	2017-07-17 17:59:09.812	I	\N
12550	1	117	15	2017-07-17 17:59:09.813	I	\N
12551	1	234	112	2017-07-17 17:59:09.821	I	\N
12552	1	122	16	2017-07-17 17:59:09.959	I	\N
12553	1	122	198	2017-07-17 17:59:09.961	I	\N
12554	1	122	198	2017-07-17 17:59:09.962	I	\N
12555	1	122	198	2017-07-17 17:59:09.963	I	\N
12556	1	122	198	2017-07-17 17:59:09.964	I	\N
12557	1	122	198	2017-07-17 17:59:09.966	I	\N
12558	1	122	198	2017-07-17 17:59:09.966	I	\N
12559	1	120	15	2017-07-17 17:59:09.967	I	\N
12560	1	237	112	2017-07-17 17:59:09.97	I	\N
12472	1	120	16	2017-07-17 17:59:09.859	I	\N
12473	1	120	198	2017-07-17 17:59:09.861	I	\N
12474	1	120	198	2017-07-17 17:59:09.862	I	\N
12475	1	120	198	2017-07-17 17:59:09.863	I	\N
12476	1	120	198	2017-07-17 17:59:09.864	I	\N
12477	1	120	198	2017-07-17 17:59:09.87	I	\N
12478	1	120	198	2017-07-17 17:59:09.871	I	\N
12479	1	118	15	2017-07-17 17:59:09.872	I	\N
12480	1	235	112	2017-07-17 17:59:09.875	I	\N
12561	1	121	16	2017-07-17 17:59:09.908	I	\N
12562	1	121	198	2017-07-17 17:59:09.91	I	\N
12563	1	121	198	2017-07-17 17:59:09.911	I	\N
12564	1	121	198	2017-07-17 17:59:09.912	I	\N
12565	1	121	198	2017-07-17 17:59:09.913	I	\N
12566	1	121	198	2017-07-17 17:59:09.914	I	\N
12567	1	121	198	2017-07-17 17:59:09.915	I	\N
12568	1	119	15	2017-07-17 17:59:09.916	I	\N
12569	1	236	112	2017-07-17 17:59:09.923	I	\N
12570	1	238	112	2017-07-17 17:59:10.015	I	\N
12571	1	239	112	2017-07-17 17:59:10.017	I	\N
12572	1	123	16	2017-07-17 17:59:10.188	I	\N
12573	1	123	198	2017-07-17 17:59:10.19	I	\N
12574	1	123	198	2017-07-17 17:59:10.191	I	\N
12575	1	123	198	2017-07-17 17:59:10.191	I	\N
12576	1	123	198	2017-07-17 17:59:10.192	I	\N
12577	1	123	198	2017-07-17 17:59:10.194	I	\N
12578	1	123	198	2017-07-17 17:59:10.195	I	\N
12579	1	121	15	2017-07-17 17:59:10.196	I	\N
12580	1	240	112	2017-07-17 17:59:10.206	I	\N
12581	1	241	112	2017-07-17 17:59:10.248	I	\N
12582	1	242	112	2017-07-17 17:59:10.25	I	\N
12583	1	124	16	2017-07-17 17:59:11.513	I	\N
12584	1	124	198	2017-07-17 17:59:11.515	I	\N
12585	1	124	198	2017-07-17 17:59:11.516	I	\N
12586	1	124	198	2017-07-17 17:59:11.517	I	\N
12587	1	124	198	2017-07-17 17:59:11.517	I	\N
12588	1	124	198	2017-07-17 17:59:11.518	I	\N
12589	1	124	198	2017-07-17 17:59:11.519	I	\N
12590	1	122	15	2017-07-17 17:59:11.52	I	\N
12591	1	243	112	2017-07-17 17:59:11.522	I	\N
12592	1	125	16	2017-07-17 17:59:11.577	I	\N
12593	1	125	198	2017-07-17 17:59:11.579	I	\N
12594	1	125	198	2017-07-17 17:59:11.58	I	\N
12595	1	125	198	2017-07-17 17:59:11.581	I	\N
12596	1	125	198	2017-07-17 17:59:11.582	I	\N
12597	1	125	198	2017-07-17 17:59:11.582	I	\N
12598	1	125	198	2017-07-17 17:59:11.583	I	\N
12599	1	123	15	2017-07-17 17:59:11.588	I	\N
12600	1	244	112	2017-07-17 17:59:11.59	I	\N
12601	1	124	15	2017-08-02 14:20:28.09	I	\N
12621	1	124	198	2017-08-02 14:21:02.717	I	\N
12622	1	124	198	2017-08-02 14:21:02.748	I	\N
12623	1	124	198	2017-08-02 14:21:02.752	I	\N
12624	1	124	198	2017-08-02 14:21:02.754	I	\N
12625	1	124	198	2017-08-02 14:21:02.757	I	\N
12626	1	124	198	2017-08-02 14:21:02.761	I	\N
12627	1	121	1	2017-08-02 14:21:02.766	I	\N
12628	1	150	23	2017-08-02 14:21:02.81	I	\N
12629	1	931	4	2017-08-02 14:21:02.929	I	\N
12630	1	121	45	2017-08-02 14:21:02.974	I	\N
12631	1	93	208	2017-08-02 14:21:13.151	I	\N
\.


--
-- Name: history_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('history_seq', 12640, true);


--
-- Name: hl7_encoding_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('hl7_encoding_type_seq', 4, true);


--
-- Data for Name: htmldb_plan_table; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY htmldb_plan_table (statement_id, plan_id, "timestamp", remarks, operation, options, object_node, object_owner, object_name, object_alias, object_instance, object_type, optimizer, search_columns, id, parent_id, depth, "position", cost, cardinality, bytes, other_tag, partition_start, partition_stop, partition_id, other, distribution, cpu_cost, io_cost, temp_space, access_predicates, filter_predicates, projection, "time", qblock_name) FROM stdin;
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146420525171748	1	2008-05-08 14:33:14	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146420525171748	1	2008-05-08 14:33:14	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
7146722603172428	2	2008-05-08 14:33:20	\N	SELECT STATEMENT	\N	\N	\N	\N	\N	\N	\N	ALL_ROWS	\N	0	\N	0	238	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	\N	3	\N
7146722603172428	2	2008-05-08 14:33:20	<remarks><info type="db_version">10.2.0.1</info><info type="parse_schema"><![CDATA["CLINLIMS"]]></info><info type="plan_hash">288471584</info><outline_data><hint><![CDATA[FULL(@"SEL$1" "CITY_STATE_ZIP"@"SEL$1")]]></hint><hint><![CDATA[OUTLINE_LEAF(@"SEL$1")]]></hint><hint><![CDATA[ALL_ROWS]]></hint><hint><![CDATA[OPTIMIZER_FEATURES_ENABLE('10.2.0.1')]]></hint><hint><![CDATA[IGNORE_OPTIM_EMBEDDED_HINTS]]></hint></outline_data></remarks>	TABLE ACCESS	FULL	\N	CLINLIMS	CITY_STATE_ZIP	CITY_STATE_ZIP@SEL$1	1	TABLE	ANALYZED	\N	1	0	1	1	238	79529	5726088	\N	\N	\N	\N	\N	\N	33895495	232	\N	\N	\N	"CITY_STATE_ZIP"."ID"[NUMBER,22], "CITY_STATE_ZIP"."CITY"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE"[VARCHAR2,2], "CITY_STATE_ZIP"."ZIP_CODE"[VARCHAR2,10], "CITY_STATE_ZIP"."COUNTY_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."COUNTY"[VARCHAR2,25], "CITY_STATE_ZIP"."REGION_ID"[NUMBER,22], "CITY_STATE_ZIP"."REGION"[VARCHAR2,30], "CITY_STATE_ZIP"."STATE_FIPS"[NUMBER,22], "CITY_STATE_ZIP"."STATE_NAME"[VARCHAR2,30], "CITY_STATE_ZIP"."LASTUPDATED"[TIMESTAMP,11]	3	SEL$1
\.


--
-- Data for Name: import_status; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY import_status (id, original_file_name, saved_file_name, error_file_name, type, status, successful_records, failed_records, stage_name, uploaded_by, start_time, end_time, stack_trace) FROM stdin;
\.


--
-- Name: import_status_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('import_status_id_seq', 1, false);


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY instrument (id, scrip_id, name, description, instru_type, is_active, location) FROM stdin;
\.


--
-- Data for Name: instrument_analyte; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY instrument_analyte (id, analyte_id, instru_id, method_id, result_group) FROM stdin;
\.


--
-- Data for Name: instrument_log; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY instrument_log (id, instru_id, instlog_type, event_begin, event_end) FROM stdin;
\.


--
-- Data for Name: inventory_component; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY inventory_component (id, invitem_id, quantity, material_component_id) FROM stdin;
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY inventory_item (id, uom_id, name, description, quantity_min_level, quantity_max_level, quantity_to_reorder, is_reorder_auto, is_lot_maintained, is_active, average_lead_time, average_cost, average_daily_use) FROM stdin;
20	\N	HIV testKit	HIV	\N	\N	\N	\N	\N	N	\N	\N	\N
21	\N	SyphlisTK	SYPHILIS	\N	\N	\N	\N	\N	N	\N	\N	\N
\.


--
-- Name: inventory_item_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('inventory_item_seq', 21, true);


--
-- Data for Name: inventory_location; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY inventory_location (id, storage_id, lot_number, quantity_onhand, expiration_date, inv_item_id) FROM stdin;
19	\N	1	\N	2011-08-12 00:00:00	20
20	\N	1	\N	\N	21
\.


--
-- Name: inventory_location_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('inventory_location_seq', 20, true);


--
-- Data for Name: inventory_receipt; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY inventory_receipt (id, invitem_id, received_date, quantity_received, unit_cost, qc_reference, external_reference, org_id) FROM stdin;
\.


--
-- Name: inventory_receipt_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('inventory_receipt_seq', 20, true);


--
-- Data for Name: lab_order_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY lab_order_item (id, lab_order_type_id, table_ref, record_id, identifier, action, lastupdated) FROM stdin;
\.


--
-- Name: lab_order_item_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('lab_order_item_seq', 1, false);


--
-- Data for Name: lab_order_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY lab_order_type (id, domain, type, context, description, sort_order, lastupdated, display_key) FROM stdin;
\.


--
-- Name: lab_order_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('lab_order_type_seq', 1, false);


--
-- Data for Name: label; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY label (id, name, description, printer_type, scriptlet_id, lastupdated) FROM stdin;
62	MOLECULAR EPI - TEST	TEST LABEL FOR MOLECULAR EPIDEMIOLOGY	P	13	2008-05-01 21:25:56.575
65	labelname1	labeldescr1	P	12	2006-11-20 15:31:47
68	testa	test	t	11	2006-12-13 10:06:03.873
69	testb	test	t	12	2006-12-13 10:05:58.435
70	testc	test	t	12	2006-12-13 10:05:43.107
60	Diane Test	Diane Test	P	11	2008-05-01 21:26:17.387
61	VIROLOGY-TEST	TEST LABELS FOR VIROLOGY	P	12	2006-09-07 08:06:40
71	12	12	1	11	2006-12-13 10:56:53.37
67	test	test	t	12	2006-12-13 10:05:04.56
64	NO LABEL	NO LABEL	P	\N	2006-10-25 08:09:35
66	Label Name 2	Label Desc 2	P	13	2008-05-05 23:13:30.414
1	aaa	aaa	\N	\N	2007-10-11 09:33:32.059
2	a	a	\N	\N	2007-10-10 16:45:24.842
\.


--
-- Name: label_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('label_seq', 3, false);


--
-- Data for Name: login_user; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY login_user (id, login_name, password, password_expired_dt, account_locked, account_disabled, is_admin, user_time_out) FROM stdin;
130	user	FVSAQzka8nEbrZUyGU3iTQ==	2021-02-14	N	N	N	480
1	admin	n2OrWHXVm/BQsgd1YZJoCA==	2020-04-02	N	N	Y	220
148	atomfeed	SyPE4ibAjS4D3vOsEyjisw==	2036-05-02	N	N	N	120
149	random	n2OrWHXVm/BQsgd1YZJoCA==	2027-05-11	N	N	N	480
\.


--
-- Name: login_user_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('login_user_seq', 149, true);


--
-- Data for Name: markers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY markers (id, feed_uri_for_last_read_entry, feed_uri, last_read_entry_id) FROM stdin;
\.


--
-- Name: markers_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('markers_id_seq', 5, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY menu (id, parent_id, presentation_order, element_id, action_url, click_action, display_key, tool_tip_key, new_window) FROM stdin;
107	\N	1	menu_home	/Dashboard.do	\N	banner.menu.home	tooltip.bannner.menu.home	f
109	108	1	menu_sample_add	/SamplePatientEntry.do	\N	banner.menu.sampleAdd	tooltip.bannner.menu.sampleAdd	f
110	108	2	menu_sample_edit	/SampleEdit.do?type=readwrite	\N	banner.menu.sampleEdit	tooltip.banner.menu.sampleEdit	f
112	111	1	menu_patient_add_or_edit	/PatientManagement.do	\N	banner.menu.patient.addOrEdit	tooltip.banner.menu.patient.addOrEdit	f
145	144	1	menu_results_patient	/PatientResults.do	\N	banner.menu.results.patient	tooltip.banner.menu.results.patient	f
146	144	2	menu_results_accession	/AccessionResults.do	\N	banner.menu.results.accession	tooltip.banner.menu.results.accession	f
147	144	3	menu_results_status	/StatusResults.do?blank=true	\N	banner.menu.results.status	tooltip.banner.menu.results.status	f
144	130	1	menu_results_search	\N	\N	banner.menu.results.search	tooltip.banner.menu.results.search	f
163	162	1	menu_reports_status	\N	\N	openreports.statusreports.title	tooltip.openreports.statusreports.title	f
164	163	1	menu_reports_status_patient	/Report.do?type=patient&report=patientHaitiClinical	\N	openreports.patientTestStatus	tooltip.openreports.patientTestStatus	f
168	162	3	menu_reports_nonconformity	\N	\N	reports.nonConformity.menu	tooltip.reports.nonConformity.menu	f
169	168	1	menu_reports_nonconformity_date	/Report.do?type=patient&report=haitiClinicalNonConformityByDate	\N	reports.nonConformity.byDate.report	tooltip.reports.nonConformity.byDate.report	f
170	168	2	menu_reports_nonconformity_section	/Report.do?type=patient&report=haitiClinicalNonConformityBySectionReason	\N	reports.nonConformity.bySectionReason.report	tooltip.reports.nonConformity.bySectionReason.report	f
171	162	5	menu_reports_auditTrail	/AuditTrailReport.do	\N	reports.auditTrail	reports.auditTrail	f
174	148	200	menu_resultvalidation_All	/ResultValidation.do?type=All+Sections&test=	\N	banner.menu.resultvalidation.AllSections	banner.menu.resultvalidation.AllSections	f
108	\N	3	menu_sample	\N	\N	banner.menu.sample	tooltip.bannner.menu.sample	f
111	\N	4	menu_patient	\N	\N	banner.menu.patient	tooltip.bannner.menu.patient	f
113	\N	5	menu_nonconformity	/NonConformity.do	\N	banner.menu.nonconformity	tooltip.banner.menu.nonconformity	f
130	\N	7	menu_results	\N	\N	banner.menu.results	tooltip.bannner.menu.results	f
148	\N	8	menu_resultvalidation	\N	\N	banner.menu.resultvalidation	tooltip.banner.menu.resultvalidation	f
162	\N	10	menu_reports	\N	\N	banner.menu.reports	tooltip.banner.menu.reports	f
172	\N	11	menu_administration	/MasterListsPage.do	\N	banner.menu.administration	tooltip.banner.menu.administration	f
173	\N	12	menu_help	/documentation/HaitiClinical_fr.pdf	\N	banner.menu.help	tooltip.banner.menu.help	t
175	\N	2	menu_labDashboard	/LabDashboard.do	\N	banner.menu.labdashboard	tooltip.banner.menu.labdashboard	f
176	\N	10	blah	/Upload.do	\N	banner.menu.upload	banner.menu.upload	f
178	162	2	menu_reports_aggregate	\N	\N	openreports.aggregate.title	tooltip.openreports.aggregate.title	f
179	178	2	menu_reports_aggregate_all	/Report.do?type=indicator&report=indicatorHaitiClinicalAllTests	\N	openreports.all.tests.aggregate	tooltip.openreports.all.tests.aggregate	f
177	130	3	menu_results_referredOut	/ReferredOutTests.do	\N	banner.menu.referredOut	tooltip.banner.menu.referredOut	f
180	130	2	menu_results_logbook	\N	\N	banner.menu.results.logbook	tooltip.banner.menu.results.logbook	f
\.


--
-- Name: menu_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('menu_seq', 180, true);


--
-- Data for Name: message_org; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY message_org (id, org_id, is_active, active_begin, active_end, description, lastupdated) FROM stdin;
\.


--
-- Name: message_org_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('message_org_seq', 41, false);


--
-- Name: messagecontrolidseq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('messagecontrolidseq', 1, false);


--
-- Data for Name: method; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY method (id, name, description, reporting_description, is_active, active_begin, active_end, lastupdated) FROM stdin;
1	EIA 	Enzyme-linked immunoassay	EIA 	Y	2007-04-24 00:00:00	\N	2007-04-24 13:46:47.063
31	PCR	Polymerase Chain Reaction	\N	Y	2006-09-18 00:00:00	\N	2006-09-29 14:32:51
32	STAIN	Stain	\N	Y	2006-09-29 00:00:00	\N	2006-09-29 14:32:57
33	CULTURE	Culture	\N	Y	2006-09-29 00:00:00	\N	2006-11-01 08:10:49.606
34	PROBE	Probe	\N	Y	2006-09-29 00:00:00	\N	2006-09-29 14:33:05
35	BIOCHEMICAL	Biochemical	\N	Y	2006-09-29 00:00:00	\N	2006-11-08 09:16:24.377
27	Diane Test	Diane Test	\N	Y	2006-09-06 00:00:00	\N	2006-10-23 15:35:39.534
36	HPLC	High Pressure Liquid Chromatography	\N	Y	2006-09-29 00:00:00	\N	2006-09-29 14:31:50
37	DNA SEQUENCING	DNA Sequencing	\N	Y	2006-09-29 00:00:00	\N	2006-10-23 15:35:40.691
3	AUTO	Automated (Haiti)		Y	2009-02-24 00:00:00	\N	2009-02-24 16:26:17.507
4	MANUAL	test done manually (Haiti)		Y	2009-02-24 00:00:00	\N	2009-02-24 16:26:47.604
5	HIV_TEST_KIT	Uses Hiv test kit		Y	2009-03-05 00:00:00	\N	2009-03-05 14:26:19.46
6	SYPHILIS_TEST_KIT	Test kit for syphilis		Y	2009-03-05 00:00:00	\N	2009-03-05 14:28:11.61
\.


--
-- Data for Name: method_analyte; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY method_analyte (id, method_id, analyte_id, result_group, sort_order, ma_type) FROM stdin;
\.


--
-- Data for Name: method_result; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY method_result (id, scrip_id, result_group, flags, methres_type, value, quant_limit, cont_level, method_id) FROM stdin;
\.


--
-- Name: method_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('method_seq', 6, true);


--
-- Data for Name: mls_lab_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY mls_lab_type (id, description, org_mlt_org_mlt_id) FROM stdin;
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY note (id, sys_user_id, reference_id, reference_table, note_type, subject, text, lastupdated) FROM stdin;
\.


--
-- Name: note_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('note_seq', 180, true);


--
-- Data for Name: observation_history; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY observation_history (id, patient_id, sample_id, observation_history_type_id, value_type, value, lastupdated, sample_item_id) FROM stdin;
\.


--
-- Name: observation_history_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('observation_history_seq', 1, false);


--
-- Data for Name: observation_history_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY observation_history_type (id, type_name, description, lastupdated) FROM stdin;
1	initialSampleCondition	The condition of the sample when it was delievered to the lab	2011-02-16 22:48:42.513601+00
2	paymentStatus	The payment status of the patient	2012-04-24 00:30:14.756638+00
\.


--
-- Name: observation_history_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('observation_history_type_seq', 2, true);


--
-- Data for Name: occupation; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY occupation (id, occupation, lastupdated) FROM stdin;
\.


--
-- Name: occupation_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('occupation_seq', 1, false);


--
-- Data for Name: or_properties; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY or_properties (property_id, property_key, property_value) FROM stdin;
1870	base.directory	/usr/share/tomcat5.5/webapps/openreports/reports/
1871	temp.directory	/usr/share/tomcat5.5/webapps/openreports/temp/
1872	report.generation.directory	/usr/share/tomcat5.5/webapps/openreports/generatedreports/
1873	date.format	dd/MM/yyyy
1874	mail.auth.password	barLAC28
1875	mail.auth.user	admin
1876	mail.smtp.auth	false
1877	mail.smtp.host	
1878	xmla.catalog	
1879	xmla.datasource	
1880	xmla.uri	
\.


--
-- Data for Name: or_tags; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY or_tags (tag_id, tagged_object_id, tagged_object_class, tag_value, tag_type) FROM stdin;
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY order_item (id, ord_id, quantity_requested, quantity_received, inv_loc_id) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY orders (id, org_id, sys_user_id, ordered_date, neededby_date, requested_by, cost_center, shipping_type, shipping_carrier, shipping_cost, delivered_date, is_external, external_order_number, is_filled) FROM stdin;
\.


--
-- Data for Name: org_hl7_encoding_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY org_hl7_encoding_type (organization_id, encoding_type_id, lastupdated) FROM stdin;
\.


--
-- Data for Name: org_mls_lab_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY org_mls_lab_type (org_id, mls_lab_id, org_mlt_id) FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY organization (id, name, city, zip_code, mls_sentinel_lab_flag, org_mlt_org_mlt_id, org_id, short_name, multiple_unit, street_address, state, internet_address, clia_num, pws_id, lastupdated, mls_lab_flag, is_active, local_abbrev) FROM stdin;
3	Haiti	Seattle	98103	N	\N	\N			DNA	WA			\N	2008-11-20 13:48:42.141	N	Y	22
1284	Bahmni	\N	\N	N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Y	\N
1285	Jigme Dorji Wangchuck Referral Hospital	\N	\N	N	\N	\N	JDWNRH	\N	Gongphel Lam,Thimphu	MN		\N	\N	2017-04-12 12:44:16.32	N	Y	\N
1286	External Lab	\N	\N	N	\N	\N		\N		MN		\N	\N	2017-05-02 11:52:20.084	N	Y	\N
\.


--
-- Data for Name: organization_address; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY organization_address (organization_id, address_part_id, type, value) FROM stdin;
\.


--
-- Data for Name: organization_contact; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY organization_contact (id, organization_id, person_id, "position") FROM stdin;
\.


--
-- Name: organization_contact_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('organization_contact_seq', 1, false);


--
-- Data for Name: organization_organization_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY organization_organization_type (org_id, org_type_id) FROM stdin;
1285	3
1286	3
\.


--
-- Name: organization_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('organization_seq', 1286, true);


--
-- Data for Name: organization_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY organization_type (id, short_name, description, name_display_key, lastupdated) FROM stdin;
1	TestKitVender	Organization selling HIV test kits	db.organization.type.name.testkit	2009-12-17 12:07:12.477554
3	referralLab	An organization to which samples may be sent	orgainzation.type.referral.lab	2010-11-23 10:30:22.117828
4	referring clinic	Name of org who can order lab tests	organization.type.referral.in.lab	2011-02-16 14:46:31.32568
5	resultRequester	An organization which can request lab results	org_type.resultRequester	2012-04-23 17:30:16.500759
\.


--
-- Name: organization_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('organization_type_seq', 5, true);


--
-- Data for Name: package_1; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY package_1 (id) FROM stdin;
\.


--
-- Data for Name: panel; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY panel (id, name, description, lastupdated, display_key, sort_order, is_active) FROM stdin;
\.


--
-- Data for Name: panel_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY panel_item (id, panel_id, sort_order, test_local_abbrev, method_name, lastupdated, test_name, test_id) FROM stdin;
\.


--
-- Name: panel_item_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('panel_item_seq', 1312, true);


--
-- Name: panel_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('panel_seq', 95, true);


--
-- Data for Name: patient; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient (id, person_id, race, gender, birth_date, epi_first_name, epi_middle_name, epi_last_name, birth_time, death_date, national_id, ethnicity, school_attend, medicare_id, medicaid_id, birth_place, lastupdated, external_id, chart_number, entered_birth_date, uuid) FROM stdin;
\.


--
-- Data for Name: patient_identity; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_identity (id, identity_type_id, patient_id, identity_data, lastupdated) FROM stdin;
\.


--
-- Name: patient_identity_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_identity_seq', 244, true);


--
-- Data for Name: patient_identity_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_identity_type (id, identity_type, description, lastupdated) FROM stdin;
2	ST	ST Number	2008-11-05 10:36:39.615
3	AKA	Also known as name	2008-11-05 10:36:39.615
4	MOTHER	Mothers name	2008-11-05 10:36:39.615
1	NATIONAL	National ID	2008-11-05 10:36:39.615
5	INSURANCE	Primary insurance number	\N
6	OCCUPATION	patients occupation	\N
9	SUBJECT	Subject Number	2010-01-06 12:56:16.166813
8	ORG_SITE	Organization Site	2010-01-06 12:56:39.622399
11	MOTHERS_INITIAL	Initial of mothers first name	2010-03-15 13:15:08.22301
14	GUID	\N	2011-03-10 13:25:23.644
30	EDUCATION	Patients education level	2013-08-08 08:02:34.866733
31	MARITIAL	Patients maritial status	2013-08-08 08:02:34.866733
32	NATIONALITY	Patients nationality	2013-08-08 08:02:34.866733
33	OTHER NATIONALITY	Named nationality if OTHER is selected	2013-08-08 08:02:34.866733
34	HEALTH DISTRICT	Patients health district	2013-08-08 08:02:34.866733
35	HEALTH REGION	Patients health region	2013-08-08 08:02:34.866733
36	PRIMARYRELATIVE	Father's/Husband's name	2017-02-28 15:47:53.471395
\.


--
-- Name: patient_identity_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_identity_type_seq', 36, true);


--
-- Data for Name: patient_occupation; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_occupation (id, patient_id, occupation, lastupdated) FROM stdin;
\.


--
-- Name: patient_occupation_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_occupation_seq', 1, false);


--
-- Data for Name: patient_patient_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_patient_type (id, patient_type_id, patient_id, lastupdated) FROM stdin;
\.


--
-- Name: patient_patient_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_patient_type_seq', 2, true);


--
-- Name: patient_relation_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_relation_seq', 1, false);


--
-- Data for Name: patient_relations; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_relations (id, pat_id_source, pat_id, relation) FROM stdin;
\.


--
-- Name: patient_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_seq', 124, true);


--
-- Data for Name: patient_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY patient_type (id, type, description, lastupdated) FROM stdin;
1	R	Referré	2009-07-09 13:06:10.215545
2	E	Patient Externe	2009-07-09 13:06:10.215545
3	H	Hospitalisé	2009-07-09 13:06:10.215545
4	U	Urgences	2009-07-09 13:06:10.215545
5	P	Patient Privé	2009-07-09 13:06:10.215545
\.


--
-- Name: patient_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('patient_type_seq', 20, true);


--
-- Data for Name: payment_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY payment_type (id, type, description) FROM stdin;
\.


--
-- Name: payment_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('payment_type_seq', 1, false);


--
-- Data for Name: person; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY person (id, last_name, first_name, middle_name, multiple_unit, street_address, city, state, zip_code, country, work_phone, home_phone, cell_phone, fax, email, lastupdated, is_active) FROM stdin;
12	UNKNOWN_	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-04-10 17:55:38.985	\N
\.


--
-- Data for Name: person_address; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY person_address (person_id, address_part_id, type, value) FROM stdin;
\.


--
-- Name: person_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('person_seq', 125, true);


--
-- Data for Name: program; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY program (id, code, name, lastupdated) FROM stdin;
\.


--
-- Name: program_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('program_seq', 1, false);


--
-- Data for Name: project; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY project (id, name, sys_user_id, description, started_date, completed_date, is_active, reference_to, program_code, lastupdated, scriptlet_id, local_abbrev, display_key) FROM stdin;
\.


--
-- Data for Name: project_organization; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY project_organization (project_id, org_id) FROM stdin;
\.


--
-- Data for Name: project_parameter; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY project_parameter (id, projparam_type, operation, value, project_id, param_name) FROM stdin;
\.


--
-- Name: project_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('project_seq', 13, false);


--
-- Data for Name: provider; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY provider (id, npi, person_id, external_id, provider_type, lastupdated) FROM stdin;
6	\N	12	\N	\N	2017-04-10 17:55:38.991
\.


--
-- Name: provider_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('provider_seq', 6, true);


--
-- Data for Name: qa_event; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qa_event (id, name, description, is_billable, reporting_sequence, reporting_text, test_id, is_holdable, lastupdated, type, category, display_key) FROM stdin;
67	Insufficient	Insufficient sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.insufficient
68	Hemolytic	Hemolytic sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.hemolytic
69	Mislabeled	Bad or mislabled sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.mislabled
70	No form	 No form with sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.noForm
71	Incorrect Form	Form not filled out correctly	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.formNotCorrect
72	No Sample	No sample with form	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.noSample
73	Bloodstained Tube	Bloodstained tube	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.bloodstained.tube
74	Bloodstained Form	Bloodstained form	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.bloodstained.form
75	Other	Other	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.other
76	Broken	Broken tube/container	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.broken
77	Contaminated	Contaminated sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.contaminated
78	Frozen	Frozen sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.frozen
79	Inadequate	Inadequate sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.inadequate
80	unrefrigerated	unrefrigerated sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.unrefrigerated
81	Overturned	Overturned specimen	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.overturned
66	Coagulated	Coagulated sample	\N	\N	\N	\N	Y	2012-04-23 17:30:24.343465	\N	\N	qa_event.coagulated
\.


--
-- Name: qa_event_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('qa_event_seq', 85, true);


--
-- Data for Name: qa_observation; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qa_observation (id, observed_id, observed_type, qa_observation_type_id, value_type, value, lastupdated) FROM stdin;
\.


--
-- Name: qa_observation_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('qa_observation_seq', 1, true);


--
-- Data for Name: qa_observation_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qa_observation_type (id, name, description, lastupdated) FROM stdin;
1	authorizer	The name of the person who authorized the event	2013-08-08 08:02:34.982965+00
2	section	The section in which this happened	2013-08-08 08:02:34.982965+00
3	documentNumber	The qa document tracking number	2013-08-08 08:02:34.982965+00
\.


--
-- Name: qa_observation_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('qa_observation_type_seq', 3, true);


--
-- Data for Name: qc; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qc (id, uom_id, sys_user_id, name, source, lot_number, prepared_date, prepared_volume, usable_date, expire_date) FROM stdin;
\.


--
-- Data for Name: qc_analytes; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qc_analytes (id, qcanaly_type, value, analyte_id) FROM stdin;
\.


--
-- Data for Name: qrtz_blob_triggers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_blob_triggers (trigger_name, trigger_group, blob_data) FROM stdin;
\.


--
-- Data for Name: qrtz_calendars; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_calendars (calendar_name, calendar) FROM stdin;
\.


--
-- Data for Name: qrtz_cron_triggers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_cron_triggers (trigger_name, trigger_group, cron_expression, time_zone_id) FROM stdin;
\.


--
-- Data for Name: qrtz_fired_triggers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_fired_triggers (entry_id, trigger_name, trigger_group, is_volatile, instance_name, fired_time, priority, state, job_name, job_group, is_stateful, requests_recovery) FROM stdin;
\.


--
-- Data for Name: qrtz_job_details; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_job_details (job_name, job_group, description, job_class_name, is_durable, is_volatile, is_stateful, requests_recovery, job_data) FROM stdin;
\.


--
-- Data for Name: qrtz_job_listeners; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_job_listeners (job_name, job_group, job_listener) FROM stdin;
\.


--
-- Data for Name: qrtz_locks; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_locks (lock_name) FROM stdin;
TRIGGER_ACCESS
JOB_ACCESS
CALENDAR_ACCESS
STATE_ACCESS
MISFIRE_ACCESS
\.


--
-- Data for Name: qrtz_paused_trigger_grps; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_paused_trigger_grps (trigger_group) FROM stdin;
\.


--
-- Data for Name: qrtz_scheduler_state; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_scheduler_state (instance_name, last_checkin_time, checkin_interval) FROM stdin;
\.


--
-- Data for Name: qrtz_simple_triggers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_simple_triggers (trigger_name, trigger_group, repeat_count, repeat_interval, times_triggered) FROM stdin;
\.


--
-- Data for Name: qrtz_trigger_listeners; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_trigger_listeners (trigger_name, trigger_group, trigger_listener) FROM stdin;
\.


--
-- Data for Name: qrtz_triggers; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY qrtz_triggers (trigger_name, trigger_group, job_name, job_group, is_volatile, description, next_fire_time, prev_fire_time, priority, trigger_state, trigger_type, start_time, end_time, calendar_name, misfire_instr, job_data) FROM stdin;
\.


--
-- Data for Name: quartz_cron_scheduler; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY quartz_cron_scheduler (id, cron_statement, last_run, active, run_if_past, name, job_name, display_key, description_key) FROM stdin;
2	never	\N	f	t	gather site indicators	gatherSiteIndicators	schedule.name.gatherSiteIndicators	schedule.description.gatherSiteIndicators
3	never	2012-05-06 09:40:00.013+00	f	t	send malaria surviellance report	sendMalariaSurviellanceReport	schedule.name.sendMalariaServiellanceReport	schedule.description.sendMalariaServiellanceReport
1	never	2012-05-06 18:11:00.004+00	f	t	send site indicators	sendSiteIndicators	schedule.name.sendSiteIndicators	schedule.description.sendSiteIndicators
12	0 0 0 1/1 * ? *	2017-08-03 18:30:00+00	t	t	atom-feed-events-offset-marker	atom-feed-events-offset-marker	schedule.name.atomFeedEventsOffsetMarker	schedule.name.atomFeedEventsOffsetMarker
4	0/15 * * * * ?	2017-10-30 11:56:30.015+00	t	t	atom-feed-openmrs-patient	atom-feed-openmrs-patient	schedule.name.atomFeedOpenMRSPatient	schedule.name.atomFeedOpenMRSPatient
15	0/2 * * * * ?	2017-10-30 11:56:32.002+00	t	t	atom-feed-events-publisher	atom-feed-events-publisher	schedule.name.eventPublisher	schedule.name.eventPublisher
9	0/15 * * * * ?	2017-10-30 11:56:30.001+00	t	t	atom-feed-openmrs-encounter-failed	atom-feed-openmrs-encounter-failed	schedule.name.atomFeedOpenMRSEncounter.failed	schedule.name.atomFeedOpenMRSEncounter.failed
14	0/15 * * * * ?	2017-10-30 11:56:30.014+00	t	t	atom-feed-openmrs-lab-failed	atom-feed-openmrs-lab-failed	schedule.name.atomFeedOpenMRSLab.failed	schedule.name.atomFeedOpenMRSLab.failed
8	0/15 * * * * ?	2017-10-30 11:56:30.001+00	t	t	atom-feed-openmrs-encounter	atom-feed-openmrs-encounter	schedule.name.atomFeedOpenMRSEncounter	schedule.name.atomFeedOpenMRSEncounter
13	0/15 * * * * ?	2017-10-30 11:56:30.001+00	t	t	atom-feed-openmrs-lab	atom-feed-openmrs-lab	schedule.name.atomFeedOpenMRSLab	schedule.name.atomFeedOpenMRSLab
7	0 0/1 * * * ?	2017-10-30 11:56:00.031+00	t	t	atom-feed-openmrs-patient-failed	atom-feed-openmrs-patient-failed	schedule.name.atomFeedOpenMRSPatient.failed	schedule.name.atomFeedOpenMRSPatient.failed
\.


--
-- Name: quartz_cron_scheduler_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('quartz_cron_scheduler_seq', 15, true);


--
-- Data for Name: race; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY race (id, description, race_type, is_active) FROM stdin;
\.


--
-- Data for Name: receiver_code_element; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY receiver_code_element (id, identifier, text, code_system, lastupdated, message_org_id, code_element_type_id) FROM stdin;
\.


--
-- Name: receiver_code_element_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('receiver_code_element_seq', 21, false);


--
-- Data for Name: reference_tables; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY reference_tables (id, name, keep_history, is_hl7_encoded, lastupdated) FROM stdin;
40	STATUS_OF_SAMPLE	Y	Y	\N
39	NOTE	Y	N	\N
1	SAMPLE	Y	N	\N
2	GENDER	Y	N	\N
3	SAMPLE_ORGANIZATION	Y	N	\N
4	ANALYSIS	Y	N	\N
5	TEST	Y	Y	\N
6	CITY	Y	N	\N
7	ANALYTE	Y	Y	\N
8	COUNTY	Y	N	\N
9	DICTIONARY	Y	N	\N
10	DICTIONARY_CATEGORY	Y	N	\N
11	LABEL	Y	N	\N
12	METHOD	Y	N	\N
13	PANEL	Y	N	\N
14	PANEL_ITEM	Y	N	\N
15	PATIENT	Y	N	\N
16	PERSON	Y	N	\N
17	PROGRAM	Y	N	\N
18	PROJECT	Y	N	\N
19	PROVIDER	Y	N	\N
20	REGION	Y	N	\N
21	RESULT	Y	N	\N
22	SAMPLE_DOMAIN	Y	N	\N
23	SAMPLE_ITEM	Y	N	\N
24	SAMPLE_PROJECTS	Y	N	\N
25	SCRIPTLET	Y	N	\N
26	SOURCE_OF_SAMPLE	Y	N	\N
27	STATE_CODE	Y	N	\N
28	SYSTEM_USER	Y	N	\N
29	TEST_SECTION	Y	N	\N
30	TEST_ANALYTE	Y	N	\N
31	TEST_REFLEX	Y	N	\N
32	TEST_RESULT	Y	N	\N
33	TEST_TRAILER	Y	N	\N
34	TYPE_OF_SAMPLE	Y	N	\N
35	TYPE_OF_TEST_RESULT	Y	N	\N
36	UNIT_OF_MEASURE	Y	Y	\N
37	ZIP_CODE	Y	N	\N
38	ORGANIZATION	Y	N	\N
45	SAMPLE_HUMAN	Y	N	\N
46	QA_EVENT	Y	N	\N
48	ANALYSIS_QAEVENT	Y	N	\N
47	ACTION	Y	N	\N
49	ANALYSIS_QAEVENT_ACTION	Y	N	\N
70	REFERENCE_TABLES	N	N	\N
41	CODE_ELEMENT_TYPE	Y	N	\N
42	CODE_ELEMENT_XREF	Y	N	\N
43	MESSAGE_ORG	Y	N	\N
44	RECEIVER_CODE_ELEMENT	Y	N	\N
50	LOGIN_USER	Y	N	\N
51	SYSTEM_MODULE	Y	N	\N
52	SYSTEM_USER_MODULE	Y	N	\N
53	SYSTEM_USER_SECTION	Y	N	\N
110	SAMPLE_NEWBORN	Y	N	\N
111	PATIENT_RELATIONS	Y	N	\N
112	PATIENT_IDENTITY	Y	N	\N
113	PATIENT_PATIENT_TYPE	Y	N	\N
130	PATIENT_TYPE	N	N	\N
154	RESULT_LIMITS	Y	N	2009-02-10 17:11:57.227
155	RESULT_SIGNATURE	Y	N	2009-02-20 13:05:56.666
167	INVENTORY_LOCATION	N	N	2009-03-19 12:20:50.594
168	INVENTORY_ITEM	N	N	2009-03-19 12:20:50.594
169	INVENTORY_RECEIPT	N	N	2009-03-19 12:20:50.594
171	RESULT_INVENTORY	Y	N	2009-03-25 16:20:17.301
172	SYSTEM_ROLE	Y	N	2009-05-20 09:56:52.877513
173	SYSTEM_ROLE_MODULE	Y	N	2009-06-05 11:49:44.562736
174	SYSTEM_ROLE	Y	N	2009-06-05 11:50:56.86615
175	SYSTEM_USER_ROLE	Y	N	2009-06-05 11:59:25.708258
176	SYSTEM_USER_ROLE	Y	N	2009-06-05 12:03:40.526192
177	SYSTEM_ROLE	Y	N	2009-06-05 12:04:41.627999
178	SYSTEM_USER_ROLE	Y	N	2009-06-05 12:04:48.416696
179	SYSTEM_ROLE_MODULE	Y	N	2009-06-05 12:05:01.033811
182	analyzer	Y	N	2009-11-25 15:35:31.308859
183	analyzer_results	Y	N	2009-11-25 15:35:31.569744
184	site_information	Y	N	2010-03-23 17:04:19.671634
187	observation_history_type	Y	N	2010-04-28 14:13:23.717515
186	observation_history	Y	N	2010-04-21 10:38:59.516839
185	observation_history_type	Y	N	2010-04-21 10:38:50.05707
188	SAMPLE_QAEVENT	Y	N	2010-10-28 06:12:39.992393
189	referral_reason	Y	N	2010-10-28 06:13:55.299708
190	referral_type	Y	N	2010-10-28 06:13:55.299708
191	referral	Y	N	2010-10-28 06:13:55.299708
192	referral_result	Y	N	2010-11-23 10:30:22.045552
193	org_hl7_encoding_type	Y	N	2011-03-04 16:38:48.986228
197	address_part	Y	N	2011-03-29 16:23:10.813326
198	person_address	Y	N	2011-03-29 16:23:10.813326
199	organization_address	Y	N	2011-03-29 16:23:10.813326
200	organization_contact	Y	N	2011-03-29 16:23:10.825084
201	SITE_INFORMATION_DOMAIN	Y	N	2012-04-23 17:30:07.193494
202	MENU	Y	N	2012-04-23 17:30:07.25924
203	QUARTZ_CRON_SCHEDULER	Y	N	2012-04-23 17:30:07.331733
204	REPORT_QUEUE_TYPE	Y	N	2012-04-23 17:30:07.402102
205	REPORT_QUEUE	Y	N	2012-04-23 17:30:07.424341
206	REPORT_EXTERNAL_IMPORT	Y	N	2012-04-23 17:30:07.500089
207	document_type	Y	N	2012-04-23 17:30:13.955455
208	document_track	Y	N	2012-04-23 17:30:13.955455
209	ANALYZER_TEST_MAP	Y	N	2012-04-23 17:30:14.633487
210	PATIENT_IDENTITY_TYPE	Y	N	2012-04-23 17:30:14.633487
211	SAMPLETYPE_TEST	Y	N	2012-04-23 17:30:14.633487
212	SAMPLETYPE_PANEL	Y	N	2012-04-23 17:30:14.633487
213	SAMPLE_REQUESTER	Y	N	2012-04-23 17:30:14.633487
195	TEST_CODE	Y	N	2011-03-04 16:38:48.986228
194	TEST_CODE_TYPE	Y	N	2011-03-04 16:38:48.986228
214	QA_OBSERVATION	Y	N	2013-08-08 08:02:34.962871
\.


--
-- Name: reference_tables_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('reference_tables_seq', 214, true);


--
-- Data for Name: referral; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY referral (id, analysis_id, organization_id, organization_name, send_ready_date, sent_date, result_recieved_date, referral_reason_id, referral_type_id, requester_name, lastupdated, canceled, referral_request_date) FROM stdin;
\.


--
-- Data for Name: referral_reason; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY referral_reason (id, name, description, display_key, lastupdated) FROM stdin;
1	Auto Referred Out	Auto Referred Out	referral.reason.autoReferredOut	2017-02-28 15:47:54.272674+00
2	Test not available in Hospital	Test not available in Hospital	referral.reason.notAvailable	2017-05-02 05:10:34.297463+00
\.


--
-- Name: referral_reason_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('referral_reason_seq', 1, true);


--
-- Data for Name: referral_result; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY referral_result (id, referral_id, test_id, result_id, referral_report_date, lastupdated) FROM stdin;
\.


--
-- Name: referral_result_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('referral_result_seq', 21, true);


--
-- Name: referral_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('referral_seq', 21, true);


--
-- Data for Name: referral_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY referral_type (id, name, description, display_key, lastupdated) FROM stdin;
1	Confirmation	Sent out to confirm result	referral.type.confirmation	2017-02-28 15:47:53.502577+00
\.


--
-- Name: referral_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('referral_type_seq', 1, true);


--
-- Data for Name: region; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY region (id, region, lastupdated) FROM stdin;
\.


--
-- Name: region_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('region_seq', 1, false);


--
-- Data for Name: report_external_export; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY report_external_export (id, event_date, collection_date, sent_date, type, data, lastupdated, send_flag, bookkeeping) FROM stdin;
\.


--
-- Data for Name: report_external_import; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY report_external_import (id, sending_site, event_date, recieved_date, type, updated_flag, data, lastupdated) FROM stdin;
\.


--
-- Name: report_external_import_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('report_external_import_seq', 1, false);


--
-- Name: report_queue_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('report_queue_seq', 124, true);


--
-- Data for Name: report_queue_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY report_queue_type (id, name, description) FROM stdin;
1	labIndicator	Lab indicator reports.  Number of tests run etc
2	Results	Result sharing with iSante
3	malariaCase	malaria case report
\.


--
-- Name: report_queue_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('report_queue_type_seq', 3, true);


--
-- Data for Name: requester_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY requester_type (id, requester_type) FROM stdin;
1	organization
2	provider
\.


--
-- Name: requester_type_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('requester_type_seq', 2, false);


--
-- Data for Name: result; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY result (id, analysis_id, sort_order, is_reportable, result_type, value, analyte_id, test_result_id, lastupdated, min_normal, max_normal, parent_id, abnormal, uploaded_file_name, result_limit_id) FROM stdin;
\.


--
-- Data for Name: result_inventory; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY result_inventory (id, inventory_location_id, result_id, description, lastupdated) FROM stdin;
\.


--
-- Name: result_inventory_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('result_inventory_seq', 1, false);


--
-- Data for Name: result_limits; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY result_limits (id, test_id, test_result_type_id, min_age, max_age, gender, low_normal, high_normal, low_valid, high_valid, lastupdated, normal_dictionary_id, always_validate) FROM stdin;
\.


--
-- Name: result_limits_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('result_limits_seq', 688, true);


--
-- Name: result_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('result_seq', 303, true);


--
-- Data for Name: result_signature; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY result_signature (id, result_id, system_user_id, is_supervisor, lastupdated, non_user_name) FROM stdin;
\.


--
-- Name: result_signature_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('result_signature_seq', 297, true);


--
-- Data for Name: sample; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample (id, accession_number, package_id, domain, next_item_sequence, revision, entered_date, received_date, collection_date, client_reference, status, released_date, sticker_rcvd_flag, sys_user_id, barcode, transmission_date, lastupdated, spec_or_isolate, priority, status_id, sample_source_id, uuid) FROM stdin;
\.


--
-- Data for Name: sample_animal; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_animal (id, sci_name_id, comm_anim_id, sampling_location, collector, samp_id, multiple_unit, street_address, city, state, country, zip_code) FROM stdin;
\.


--
-- Data for Name: sample_domain; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_domain (id, domain_description, domain, lastupdated) FROM stdin;
28	ANIMAL SAMPLES	A	2006-11-08 10:58:03.229
29	ENVIRONMENTAL	E	2006-09-21 10:06:53
27	HUMAN SAMPLES	H	2006-09-21 10:06:01
2	NEWBORN SAMPLES	N	2008-10-31 15:19:03.544
\.


--
-- Name: sample_domain_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_domain_seq', 2, true);


--
-- Data for Name: sample_environmental; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_environmental (id, samp_id, is_hazardous, lot_nbr, description, chem_samp_num, street_address, multiple_unit, city, state, zip_code, country, collector, sampling_location) FROM stdin;
\.


--
-- Data for Name: sample_human; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_human (id, provider_id, samp_id, patient_id, lastupdated) FROM stdin;
\.


--
-- Name: sample_human_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_human_seq', 121, true);


--
-- Data for Name: sample_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_item (id, sort_order, sampitem_id, samp_id, source_id, typeosamp_id, uom_id, source_other, quantity, lastupdated, external_id, collection_date, status_id, collector) FROM stdin;
\.


--
-- Name: sample_item_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_item_seq', 150, true);


--
-- Data for Name: sample_newborn; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_newborn (id, weight, multi_birth, birth_order, gestational_week, date_first_feeding, breast, tpn, formula, milk, soy, jaundice, antibiotics, transfused, date_transfusion, medical_record_numeric, nicu, birth_defect, pregnancy_complication, deceased_sibling, cause_of_death, family_history, other, y_numeric, yellow_card, lastupdated) FROM stdin;
\.


--
-- Name: sample_org_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_org_seq', 112, false);


--
-- Data for Name: sample_organization; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_organization (id, org_id, samp_id, samp_org_type, lastupdated) FROM stdin;
\.


--
-- Data for Name: sample_pdf; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_pdf (id, accession_number, allow_view, barcode) FROM stdin;
\.


--
-- Name: sample_pdf_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_pdf_seq', 1, false);


--
-- Name: sample_proj_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_proj_seq', 1, false);


--
-- Data for Name: sample_projects; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_projects (samp_id, proj_id, is_permanent, id, lastupdated) FROM stdin;
\.


--
-- Data for Name: sample_qaevent; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_qaevent (id, qa_event_id, sample_id, completed_date, lastupdated, sampleitem_id, entered_date) FROM stdin;
\.


--
-- Data for Name: sample_qaevent_action; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_qaevent_action (id, sample_qaevent_id, action_id, created_date, lastupdated, sys_user_id) FROM stdin;
\.


--
-- Name: sample_qaevent_action_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_qaevent_action_seq', 1, false);


--
-- Name: sample_qaevent_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_qaevent_seq', 2, true);


--
-- Data for Name: sample_requester; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_requester (sample_id, requester_id, requester_type_id, lastupdated) FROM stdin;
\.


--
-- Name: sample_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_seq', 121, true);


--
-- Data for Name: sample_source; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sample_source (id, name, description, active, display_order) FROM stdin;
2	OPD	OutPatient Department	t	1
1	IPD	InPatient Department	t	2
3	Emergency	Emergency	t	3
4	Sub Center	Sub Center	t	4
5	Community Program	Community Program	t	5
6	Paro DH	Paro DH	t	6
\.


--
-- Name: sample_source_id_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_source_id_seq', 6, true);


--
-- Name: sample_type_panel_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_type_panel_seq', 153, true);


--
-- Name: sample_type_test_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('sample_type_test_seq', 1685, true);


--
-- Data for Name: sampletype_panel; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sampletype_panel (id, sample_type_id, panel_id) FROM stdin;
\.


--
-- Data for Name: sampletype_test; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sampletype_test (id, sample_type_id, test_id, is_panel) FROM stdin;
\.


--
-- Data for Name: scriptlet; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY scriptlet (id, name, code_type, code_source, lastupdated) FROM stdin;
13	Ais Test	B	C	2006-12-13 11:00:01.748
11	Diane Test	T	Diane test	2006-11-01 13:34:49.667
12	SCRIPTLET	S	test	2006-11-08 10:58:32.964
1	HIV Status Indeterminate	I	HIV Indeterminate	2011-02-02 11:55:53.344606
2	HIV Status Negative	I	HIV N	2011-02-02 11:55:53.344606
3	HIV Status Positive	I	HIV Positive	2011-02-02 11:55:53.344606
\.


--
-- Name: scriptlet_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('scriptlet_seq', 3, true);


--
-- Data for Name: sequence; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY sequence (seq_name, seq_count) FROM stdin;
\.


--
-- Data for Name: site_information; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY site_information (id, name, lastupdated, description, value, encrypted, domain_id, value_type, instruction_key, "group", schedule_id, tag, dictionary_category_id) FROM stdin;
17	modify results role	2012-04-24 00:30:14.552196+00	Should a separate role be required to be able to modify results	true	f	1	boolean	\N	0	\N	\N	\N
19	ResultTechnicianName	2012-04-24 00:30:14.59688+00	If true then the technician name is required for entering results	true	f	1	boolean	instructions.results.technician	0	\N	\N	\N
20	autoFillTechNameBox	2012-04-24 00:30:14.59688+00	If the techs name is required on results then add a box for autofill	true	f	1	boolean	instructions.results.autofilltechbox	0	\N	\N	\N
18	modify results note required	2012-04-24 00:30:14.552196+00	Is a note required when results are modified	true	f	1	boolean	\N	0	\N	\N	\N
25	alertWhenInvalidResult	2012-04-24 00:30:14.768284+00	Should there be an alert when the user enters a result outside of the valid range	true	f	1	boolean	instructions.results.invalidAlert	0	\N	\N	\N
32	reflex_rules	2012-04-24 00:30:25.248429+00	What set of reflex rules are used. From a predefined list	\N	f	6	text	\N	0	\N	\N	\N
11	siteNumber	2011-09-27 16:49:46.515742+00	The site number of the this lab	11404	f	2	text	\N	0	\N	\N	\N
14	patientSearchURL	2011-09-27 16:49:46.51774+00	The service URL from which to import patient demographics	https://192.168.1.50/PatientSearchService/iSante/services/patients	f	2	text	\N	0	\N	\N	\N
15	patientSearchLogOnUser	2011-09-27 16:49:46.518276+00	The user name for using the service	iSanteSvcUser	f	2	text	\N	0	\N	\N	\N
41	statusRules	2012-04-24 00:30:25.342503+00	statusRules determine specific status values for the application, ex: LNSP_haiti	Haiti	f	11	text	\N	0	\N	\N	\N
13	useExternalPatientSource	2011-09-27 16:49:46.517196+00	Use an external source patient demographics true/false	true	f	2	boolean	\N	0	\N	\N	\N
5	appName	2010-10-28 11:13:55.857654+00	The name of the application.	haitiOpenElis	f	8	text	\N	0	\N	\N	\N
39	trackPayment	2012-04-24 00:30:25.331052+00	If true track patient payment for services	false	f	10	boolean	instructions.patient.payment	0	\N	\N	\N
42	reflexAction	2012-04-24 00:30:25.342503+00	reflexActions determine the meaning of the flags in reflexes, ex: RetroCI	Haiti	f	11	text	\N	0	\N	\N	\N
44	passwordRequirements	2012-04-24 00:30:25.342503+00	changes the password requirements depending on site, ex: HAITI	HAITI	f	11	text	\N	0	\N	\N	\N
47	malariaSurURL	2012-04-25 00:25:44.847629+00	The URL for malaria Surveillance reports	https://openelis-dev.cirg.washington.edu/upload/receive-file.pl	f	9	text	instructions.result.malaria.sur.url	2	\N	url	\N
48	malariaSurReport	2012-04-25 00:25:44.847629+00	True to send reports, false otherwise	true	f	9	boolean	instructions.result.malaria.surveillance	2	3	enable	\N
38	resultReportingURL	2012-04-24 00:30:25.292745+00	Where reporting results electronically should be sent	https://openelis-dev.cirg.washington.edu/upload/receive-file.pl	f	9	text	\N	1	\N	url	\N
10	TrainingInstallation	\N	Allows for deletion of all patient and sample data	false	f	2	boolean	\N	0	\N	\N	\N
49	malariaCaseURL	2012-04-25 00:25:44.847629+00	The URL for malaria case reports	https://openelis-dev.cirg.washington.edu/upload/receive-file.pl	f	9	text	instructions.result.malaria.case.url	3	\N	url	\N
21	autoFillTechNameUser	2012-04-24 00:30:14.59688+00	If the techs name is required on results then autofill with logged in user	true	f	1	boolean	instructions.results.autofilltech.user	0	\N	\N	\N
34	testUsageAggregationUserName	2012-04-24 00:30:25.248429+00	The user name for accesses to the service for aggregating test usage	user	f	7	text	\N	0	\N	\N	\N
35	testUsageAggregationPassword	2012-04-24 00:30:25.248429+00	The password for accesser to the service for aggregating test usage	userUSER!	t	7	text	\N	0	\N	\N	\N
33	testUsageAggregationUrl	2012-04-24 00:30:25.248429+00	The url of the site to which test usage will be sent	https://openelis-dev.cirg.washington.edu/LNSP_HaitiOpenElis	f	7	text	\N	0	\N	\N	\N
36	testUsageSendStatus	2012-04-24 00:30:25.266236+00	The status of what happened the last time an attempt was made to send the report	Succès!	f	7	text	\N	0	\N	\N	\N
55	condenseNSF	2013-08-08 08:02:34.823415+00	Should NFS be represented as NFS or as individual tests	false	f	11	boolean	\N	0	\N	\N	\N
56	roleForPatientOnResults	2013-08-08 08:02:34.878224+00	Is patient information restricted to those in correct role	false	f	1	boolean	\N	0	\N	\N	\N
54	configuration name	2013-08-08 08:02:34.806178+00	The name which will appear after the version number in header	Haiti Clinical	f	2	text	\N	0	\N	\N	\N
58	sortQaEvents	2013-08-08 08:02:35.09779+00	sort qa events in lists	true	f	2	boolean	siteInformation.instruction.sortQaEvents	0	\N	\N	\N
57	reportPageNumbers	2013-08-08 08:02:35.049849+00	use page numbers on reports	true	f	12	boolean	siteInformation.instruction.pageNumbers	0	\N	\N	\N
61	lab logo	2013-08-08 08:02:35.287294+00	Provides for uploading lab logo		f	12	logoUpload	siteInformation.instruction.labLogo	0	\N	\N	\N
43	acessionFormat	2012-04-24 00:30:25.342503+00	specifies the format of the acession number,ex: SiteYearNum	DATENUM	f	11	text	\N	0	\N	\N	\N
52	default language locale	2013-08-08 08:02:34.795224+00	The default language local	en-GB	f	2	dictionary	\N	0	\N	\N	177
53	default date locale	2013-08-08 08:02:34.795224+00	The default date local	en-GB	f	2	dictionary	\N	0	\N	\N	177
45	setFieldForm	2012-04-24 00:30:25.342503+00	set form fields for each different implementation, ex: Haiti	bahmni	f	11	text	\N	0	\N	\N	\N
22	showValidationFailureIcon	2012-04-24 00:30:14.608163+00	If the analysis has failed validation show icon on results page	true	f	1	boolean	instructions.results.validationFailIcon	0	\N	\N	\N
60	additional site info	2013-08-08 08:02:35.279543+00	additional information for report header		f	12	text	siteInformation.instruction.headerInfo	0	\N	\N	\N
40	stringContext	2012-04-24 00:30:25.342503+00	The context for the property, ex: Cote d' Iviore		f	11	text	\N	0	\N	\N	\N
12	lab director	2011-09-27 16:49:46.516648+00	Name which may appear on reports as lab head		f	12	text	\N	0	\N	\N	\N
37	resultReporting	2012-04-24 00:30:25.292745+00	Should reporting results electronically be enabled	false	f	9	text	\N	1	\N	enable	\N
24	useLogoInReport	2012-04-24 00:30:14.687813+00	Should the site logo be used in the report	true	f	12	boolean	instructions.site.logo	0	\N	\N	\N
16	allowLanguageChange	2012-04-24 00:30:07.039386+00	Allows the user to change the language at login	true	f	2	boolean	\N	0	\N	\N	\N
8	patientSearchPassword	2010-10-28 11:13:56.491221+00	The password for using the service	***************	t	2	text	\N	0	\N	\N	\N
23	SiteName	2012-04-24 00:30:14.645114+00	The name of the site for reports and header	ePIS - Ministry of Health, Bhutan	f	12	text	instructions.site.name	0	\N	\N	\N
59	validate all results	2013-08-08 08:02:35.118408+00	all results should be validated even if normal	false	f	1	boolean	siteInformation.instruction.validate.all	0	\N	\N	\N
62	SampleEntryFieldsetOrder	2017-02-28 15:47:52.762194+00	Configures the order in which each section appears in the Add Sample Entry form. Eg: value: patient|samples|order	patient|samples|order	f	\N	text	\N	0	\N	\N	\N
63	AdminUser	2017-02-28 15:47:53.295229+00	Holds the name of the admin user responsible for creating Lab/Panels	admin	f	\N	text	\N	0	\N	\N	\N
64	uploadedFilesDirectory	2017-02-28 15:47:53.680255+00	Configures the directory where the uploaded files are saved.	/uploaded-files/elis/	f	\N	text	\N	0	\N	\N	\N
66	durationInDaysForUploadStatuses	2017-02-28 15:47:53.690407+00	Configures the past number of days for which we display the upload data on Upload Dashboard.	30	f	\N	int	\N	0	\N	\N	\N
68	resultsValidationPageSize	2017-02-28 15:47:53.771269+00	Configures the number tests per page for result validation	30	f	\N	int	\N	0	\N	\N	\N
50	malariaCaseReport	2012-04-25 00:25:44.847629+00	True to send reports, false otherwise	false	f	9	boolean	instructions.result.malaria.case	3	\N	enable	\N
51	testUsageReporting	2012-05-02 20:18:13.979353+00	Should reporting testUsage electronically be enabled	false	f	7	boolean	instructions.test.usage	0	\N	enable	\N
69	uploadedResultsDirectory	2017-02-28 15:47:54.03016+00	Contains all files uploaded against results	/uploaded_results/	f	\N	text	\N	0	\N	\N	\N
67	resultsPageSize	2017-02-28 15:47:53.764055+00	Configures the number tests per page for result entry	30	f	\N	int	\N	0	\N	\N	\N
71	defaultSampleSource	\N	Configuration for default sample source value 		f	2	text	\N	0	\N	\N	\N
72	defaultOrganizationName	2017-02-28 15:48:25.560524+00	Default organization name for department to be synced from openmrs	Bahmni	f	\N	text	\N	0	\N	\N	\N
65	parentOfUploadedFilesDirectory	2017-02-28 15:47:53.680255+00	Configures the parent directory of uploaded files directory.	/home/bahmni	f	\N	text	\N	0	\N	\N	\N
\.


--
-- Data for Name: site_information_domain; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY site_information_domain (id, name, description) FROM stdin;
1	resultConfiguration	site information which effects the handling of results
2	siteIdentity	Identityfing items which don't change the behavior
3	patientSharing	Items needed to share patient information
4	siteExtras	Items which turn extra capacity on and off
5	formating	Items which specify the format of artifacts
6	rules	Items which change the busness rules and effect the workflow
7	testUsage	Items which change the busness rules and effect the workflow
8	configIdentity	Identityfing items which identify the configuration
10	sampleEntryConfig	Configuration for those items which can appear on the sample entry form
11	hiddenProperties	Configuration properties invisible to the user
9	resultReporting	Items which effect reports being sent electronically
12	printedReportsConfig	items which effect printed reports
\.


--
-- Name: site_information_domain_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('site_information_domain_seq', 12, true);


--
-- Name: site_information_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('site_information_seq', 72, true);


--
-- Data for Name: source_of_sample; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY source_of_sample (id, description, domain, lastupdated) FROM stdin;
\.


--
-- Name: source_of_sample_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('source_of_sample_seq', 1, false);


--
-- Data for Name: state_code; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY state_code (id, code, description, lastupdated) FROM stdin;
\.


--
-- Name: state_code_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('state_code_seq', 1, false);


--
-- Data for Name: status_of_sample; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY status_of_sample (id, description, code, status_type, lastupdated, name, display_key, is_active) FROM stdin;
4	This test has not yet been done	1	ANALYSIS	2010-04-28 15:39:55.011	Not Tested	status.test.notStarted	Y
9	test has been referred to an outside lab and the results have not been returned	1	ANALYSIS	2010-10-28 06:13:55.174221	referred out	status.test.referred.out	Y
10	test has been done at an outside lab and then referred to this lab	1	ANALYSIS	2011-03-29 16:23:08.29256	referred in	status.test.referred.in	Y
6	The results of the analysis are final	1	ANALYSIS	2010-04-28 15:39:55.011	Finalized	status.test.valid	Y
7	The Biologist did not accept this result as valid	1	ANALYSIS	2012-04-23 17:30:24.415051	Biologist Rejection	status.test.biologist.reject	Y
15	Test was requested but then canceled	1	ANALYSIS	2012-04-23 17:30:24.415051	Test Canceled	status.test.canceled	Y
16	The results of the test were accepted by technician as being valid	1	ANALYSIS	2012-04-23 17:30:24.415051	Technical Acceptance	status.test.tech.accepted	Y
17	The results of the test were not accepted by the technicain	1	ANALYSIS	2012-04-23 17:30:24.415051	Technical Rejected	status.test.tech.rejected	Y
1	No tests have been run for this order	1	ORDER	2010-04-28 15:39:55.011	Test Entered	status.sample.notStarted	Y
2	Some tests have been run on this order	1	ORDER	2010-04-28 15:39:55.011	Testing Started	status.sample.started	Y
3	All tests have been run on this order	1	ORDER	2010-04-28 15:39:55.011	Testing finished	status.sample.finished	Y
18	The sample has been canceled by the user	1	SAMPLE	2013-08-08 08:02:34.640284	SampleCanceled	status.sample.entered	Y
19	The sample has been entered into the system	1	SAMPLE	2013-08-08 08:02:34.640284	SampleEntered	status.sample.entered	Y
11	The order is non-conforming	1	ORDER	2012-04-23 17:30:13.485907	NonConforming	status.sample.nonConforming	N
14	The order is non-conforming	1	ORDER	2012-04-23 17:30:24.383612	NonConforming	status.sample.nonConforming	N
12	The order is non-conforming	1	ANALYSIS	2012-04-23 17:30:13.485907	NonConforming	status.analysis.nonConforming	N
13	The order is non-conforming	1	ANALYSIS	2012-04-23 17:30:24.330299	NonConforming	status.analysis.nonconforming	N
20	The results of the test were accepted by technician as being valid for referred out test	1	ANALYSIS	2017-02-28 15:47:53.558125	Technical Acceptance RO	status.test.referred.out.tech.accepted	Y
21	The results of the analysis are final for referred out test	1	ANALYSIS	2017-02-28 15:47:53.558125	Finalized RO	status.test.referred.out.valid	Y
22	The Biologist did not accept this result as valid for referred out test	1	ANALYSIS	2017-02-28 15:47:53.609227	Biologist Rejection RO	status.test.referred.out.biologist.reject	Y
\.


--
-- Name: status_of_sample_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('status_of_sample_seq', 22, true);


--
-- Data for Name: storage_location; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY storage_location (id, sort_order, name, location, is_available, parent_storageloc_id, storage_unit_id) FROM stdin;
\.


--
-- Data for Name: storage_unit; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY storage_unit (id, category, description, is_singular) FROM stdin;
\.


--
-- Data for Name: system_module; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_module (id, name, description, has_select_flag, has_add_flag, has_update_flag, has_delete_flag) FROM stdin;
1	PanelItem	Master Lists => Panel Item => edit	Y	Y	Y	N
2	DictionaryCategory	Master Lists => Dictionary Category => edit	Y	Y	Y	N
3	Dictionary	Master Lists => Dictonary => edit	Y	Y	Y	N
4	Gender	Master Lists => Gender => edit	Y	Y	Y	N
5	LoginUser	Master Lists => Login User => Edit	Y	Y	Y	N
6	Organization	Master Lists => Organization => edit	Y	Y	Y	N
7	Panel	Master Lists => Panel	Y	Y	Y	Y
8	PatientResults	Results->By Patient	N	N	N	N
9	ResultLimits	Master Lists => ResultLimits => edit	Y	Y	Y	N
10	Result	Master Lists => Result => edit	Y	Y	Y	N
11	Role	Master Lists => Role => edit	Y	Y	Y	N
12	StatusOfSample	Master Lists => StatusOfSample => edit	Y	Y	Y	N
13	SystemModule	Master Lists => System Module	Y	Y	Y	N
14	SystemUser	Master Lists => System User	Y	Y	Y	N
15	Test	Master Lists => Test	Y	Y	Y	N
16	SampleEntry	Sample->Sample Entry	N	N	N	N
17	MasterList	Administration	N	N	N	N
18	Inventory	Inventory	N	N	N	N
26	StatusResults	Results->By Status	N	N	N	N
27	ReportAdmin	Master Lists => OR Admin	Y	Y	Y	N
28	ReportUserDetail	Reports	Y	Y	Y	N
29	ReportUserOption	Reports	Y	Y	Y	N
30	ReportUserRun	Reports	Y	Y	Y	N
31	TypeOfTestResult	Master Lists => Type Of Test Result	Y	Y	Y	N
32	SystemUserModule	Master Lists => System User Module	Y	Y	Y	N
33	ResultsEntry	Result Management => Results Entry	Y	Y	Y	N
34	TestSection	Master Lists => Test Section	Y	Y	Y	N
35	TypeOfSample	Master Lists => Type Of Sample	Y	Y	Y	N
36	UnitOfMeasure	Master Lists => Unit Of Measure	N	N	N	N
40	UserRole	MasterList => UserRole	Y	Y	Y	Y
41	PatientType	MasterList => PatientType	Y	Y	Y	Y
42	TypeOfSamplePanel	MasterList => Associtate type of sample with panel	Y	Y	Y	Y
43	TypeOfSampleTest	MasterList => Associtate type of sample with tests	Y	Y	Y	Y
44	UnifiedSystemUser	MasterList->ManageUsers	Y	Y	Y	Y
45	LogbookResults	Results=>logbook=>save	Y	Y	Y	Y
46	SamplePatientEntry	Sample->SampleEntry	Y	Y	Y	Y
47	SiteInformation	MasterList=>Site Information	Y	Y	Y	Y
48	AnalyzerTestName	MasterList->Analyzer Test Name	Y	Y	Y	Y
49	AnalyzerResults	Results->Analyzers	Y	Y	Y	Y
51	SampleEntryByProject:initial	Sample=>CreateSample=>initial	Y	Y	Y	Y
52	SampleEntryByProject:verify	Sample=>CreateSample=>verify	Y	Y	Y	Y
55	PatientEntryByProject:initial	Patient=>Enter=>initial	Y	Y	Y	Y
56	PatientEntryByProject:verify	Patient=>Enter=>verify	Y	Y	Y	Y
60	LogbookResults:serology	Results=>Enter=>serology	Y	Y	Y	Y
61	LogbookResults:virology	Results=>Enter=>virology	Y	Y	Y	Y
63	AccessionResults	Results=>Search=>Lab No.	Y	Y	Y	Y
65	AnalyzerResults:cobas_integra	Results=>Analyzer=>cobas_integra	Y	Y	Y	Y
66	AnalyzerResults:sysmex	Results=>Analyzer=>sysmex	Y	Y	Y	Y
67	AnalyzerResults:facscalibur	Results=>Analyzer=>facscalibur	Y	Y	Y	Y
68	AnalyzerResults:evolis	Results=>Analyzer=>evolis	Y	Y	Y	Y
69	Workplan:test	Workplan=>test	Y	Y	Y	Y
70	Workplan:serology	Workplan=>serology	Y	Y	Y	Y
71	Workplan:immunology	Workplan=>immunology	Y	Y	Y	Y
72	Workplan:hematology	Workplan=>hematology	Y	Y	Y	Y
73	Workplan:biochemistry	Workplan=>biochemistry	Y	Y	Y	Y
74	Workplan:virology	Workplan=>virology	Y	Y	Y	Y
84	TestResult	Admin=>TestResult	Y	Y	Y	Y
86	TestReflex	Admin=>TestReflex	Y	Y	Y	Y
87	TestAnalyte	Admin=>TestAnalyte	Y	Y	Y	Y
97	Method	Admin=>Method	Y	Y	Y	Y
53	SampleEditByProject:readwrite	Sample=>SampleEditByProject:readwrite	Y	Y	Y	Y
54	SampleEditByProject:readonly	Sample=>SampleEditByProject:readonly	Y	Y	Y	Y
20	LogbookResults:chem	Results->By Logbook->Chem	N	N	N	N
25	LogbookResults:HIV	Results->By Logbook->VCT	N	N	N	N
19	LogbookResults:bacteriology	Results->By Logbook->Bacteria	N	N	N	N
21	LogbookResults:ECBU	Results->By Logbook->ECBU	N	N	N	N
22	LogbookResults:hematology	Results->By Logbook->Hemaology	N	N	N	N
23	LogbookResults:immuno	Results->By Logbook->Immuno	N	N	N	N
24	LogbookResults:parasitology	Results->By Logbook->Parasitology	N	N	N	N
101	Analyte	Admin=>Analyte	Y	Y	Y	Y
106	SampleEdit	Sample=>edit	Y	Y	Y	Y
107	NonConformity	NonConformity	Y	Y	Y	Y
108	Report:patient	Patient reports	Y	Y	Y	Y
109	Report:summary	Lab summary reports	Y	Y	Y	Y
110	Report:indicator	Lab quality indicator reports	Y	Y	Y	Y
111	ResultValidation:serology	Validation=>serology	Y	Y	Y	Y
112	ResultValidation:immunology	Validation=>immunology	Y	Y	Y	Y
113	ResultValidation:hematology	Validation=>hematology	Y	Y	Y	Y
114	ResultValidation:biochemistry	Validation=>biochemistry	Y	Y	Y	Y
115	ResultValidation:virology	Validation=>virology	Y	Y	Y	Y
116	PatientEditByProject:readwrite	Patient=>PatientEdit	Y	Y	Y	Y
117	PatientEditByProject:readonly	Patient=>PatientConsult	Y	Y	Y	Y
118	SampleEdit:readwrite	Sample -> edit	Y	Y	Y	Y
123	SampleEdit:readonly	Sample=>SampleConsult	Y	Y	Y	Y
173	ReportUserDetail:patientARV2	Report=>patient=>ARV follow-up Save	Y	Y	Y	Y
174	ReportUserDetail:patientEID	Report=>patient=>EID	Y	Y	Y	Y
185	ReferredOutTests	Results=>Referrals	Y	Y	Y	Y
253	SampleConfirmationEntry	Sample=>sample confirmation	Y	Y	Y	Y
322	LogbookResults:mycobacteriology	Results=>logbooks=>mycobacteriology	Y	Y	Y	Y
341	AnalyzerResults:facscanto	Results=>Analyzer=>facscanto	Y	Y	Y	Y
349	Workplan:chem	Workplan=>chem	Y	Y	Y	Y
350	Workplan:cytobacteriology	Workplan=>cytobacteriology	Y	Y	Y	Y
351	Workplan:bacteriology	Workplan=>bacteriology	Y	Y	Y	Y
352	Workplan:ECBU	Workplan=>ECBU	Y	Y	Y	Y
353	Workplan:parasitology	Workplan=>parasitology	Y	Y	Y	Y
354	Workplan:immuno	Workplan=>immuno	Y	Y	Y	Y
355	Workplan:HIV	Workplan=>HIV	Y	Y	Y	Y
356	Workplan:molecularBio	Workplan=>molecularBio	Y	Y	Y	Y
357	Workplan:liquidBio	Workplan=>liquidBio	Y	Y	Y	Y
358	Workplan:mycrobacteriology	Workplan=>mycrobacteriology	Y	Y	Y	Y
359	Workplan:endocrin	Workplan=>endocrin	Y	Y	Y	Y
360	Workplan:serologie	Workplan=>serologie	Y	Y	Y	Y
405	LogbookResults:mycrobacteriology	Results=>logbooks=>mycrobacteriology	Y	Y	Y	Y
406	LogbookResults:cytobacteriology	Results=>logbooks=>cytobacteriology	Y	Y	Y	Y
407	LogbookResults:molecularBio	Results=>logbooks=>molecularBio	Y	Y	Y	Y
408	LogbookResults:liquidBio	Results=>logbooks=>liquidBio	Y	Y	Y	Y
409	LogbookResults:endocrin	Results=>logbooks=>endocrin	Y	Y	Y	Y
410	Workplan:panel	Workplan=>panel	Y	Y	Y	Y
411	Workplan:virologie	workplan-unit-virology	Y	Y	Y	Y
412	LogbookResults:virologie	results-section-virology	Y	Y	Y	Y
495	Workplan:mycology	Workplan=>mycology	Y	Y	Y	Y
496	LogbookResults:mycology	LogbookResults=>mycology	Y	Y	Y	Y
508	LogbookResults:serologie	Results=>Enter=>serologie	Y	Y	Y	Y
667	LogbookResults:serolo-immunology	LogbookResults=>serology-immunology	Y	Y	Y	Y
668	LogbookResults:immunology	LogbookResults=>immunology	Y	Y	Y	Y
669	LogbookResults:hemato-immunology	LogbookResults=>hemato-immunology	Y	Y	Y	Y
670	LogbookResults:biochemistry	LogbookResults=>biochemistry	Y	Y	Y	Y
671	Workplan:hemato-immunology	workplan=>units=>hemato-immunology	Y	Y	Y	Y
672	Workplan:serology-immunology	workplan=>units=>serology-immunology	Y	Y	Y	Y
673	ResultValidation:Hemto-Immunology	validation=>units=>Hemato-Immunity	Y	Y	Y	Y
675	ResultValidation:Serology-Immunology	validation=>units=>Serology-Immunity	Y	Y	Y	Y
676	ResultValidation	validation return	Y	Y	Y	Y
677	PatientDataOnResults	Able to view patient data when looking at results	Y	Y	Y	Y
678	AuditTrailView	Report=>view audit log	Y	Y	Y	Y
679	AnalyzerResults:cobasDBS	Result=>analyzers=>CobasTaqmanDBS	Y	Y	Y	Y
680	ResultValidation:molecularBio	ResultValidation=>molecularBio	Y	Y	Y	Y
681	ResultValidation:Cytobacteriologie	ResultValidation=>Cytobacteriologie	Y	Y	Y	Y
682	ResultValidation:ECBU	ResultValidation=>ECBU	Y	Y	Y	Y
683	ResultValidation:Parasitology	ResultValidation=>Parasitology	Y	Y	Y	Y
684	ResultValidation:Liquides biologique	ResultValidation=>Liquides biologique	Y	Y	Y	Y
685	ResultValidation:Mycobacteriology	ResultValidation=>Mycobacteriology	Y	Y	Y	Y
686	ResultValidation:Endocrinologie	ResultValidation=>Endocrinologie	Y	Y	Y	Y
687	ResultValidation:Serologie	ResultValidation=>Serologie	Y	Y	Y	Y
688	ResultValidation:VCT	ResultValidation=>VCT	Y	Y	Y	Y
689	ResultValidation:virologie	ResultValidation=>virologie	Y	Y	Y	Y
690	ResultValidation:Bacteria	ResultValidation=>Bacteria	Y	Y	Y	Y
691	ResultValidation:mycology	ResultValidation=>mycology	Y	Y	Y	Y
692	AnalyzerResults:cobasc311	AnalyzerResults=>cobasc311	Y	Y	Y	Y
694	Upload	Upload	N	N	N	N
693	LabDashboard	Lab Dashboard	N	N	N	N
695	ResultValidation:All Sections	Validation of all sections	N	N	N	N
696	HealthCenter	HealthCenter ajax page	N	N	N	N
\.


--
-- Name: system_module_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('system_module_seq', 696, true);


--
-- Data for Name: system_role; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_role (id, name, description, is_grouping_role, grouping_parent, display_key, active, editable) FROM stdin;
1	Maintenance Admin   	Change tests, panels etc.	f	\N	\N	t	f
2	User Admin          	Add/remove users and assign roles.	f	\N	\N	t	f
4	Intake              	Sample entry and patient management.	f	\N	\N	t	f
5	Results entry       	Enter and review results.	f	\N	\N	t	f
6	Inventory mgr       	Add and de/reactivate kits.	f	\N	\N	t	f
7	Reports             	Generate reports.	f	\N	\N	t	f
10	Quality control     	Able to do QC (e.g. nonconformity)	f	\N	role.quality.control	t	f
9	Results modifier    	Has permission to modify already entered results	f	\N	role.result.modifier	t	t
11	Audit Trail         	Able to view the audit trail	f	\N	role.audittrail	t	f
3	Validation          	Able to validate results	f	\N	\N	t	f
12	LabDashboard        	View Lab Dashboard	f	\N	\N	t	f
13	Upload              	csv upload facility	f	\N	\N	t	f
\.


--
-- Data for Name: system_role_module; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_role_module (id, has_select, has_add, has_update, has_delete, system_role_id, system_module_id) FROM stdin;
259	Y	Y	Y	Y	1	17
260	Y	Y	Y	Y	1	87
261	Y	Y	Y	Y	1	48
262	Y	Y	Y	Y	1	3
263	Y	Y	Y	Y	1	4
264	Y	Y	Y	Y	1	97
265	Y	Y	Y	Y	1	6
266	Y	Y	Y	Y	1	7
267	Y	Y	Y	Y	1	1
268	Y	Y	Y	Y	1	41
269	Y	Y	Y	Y	1	9
270	Y	Y	Y	Y	1	11
271	Y	Y	Y	Y	1	47
272	Y	Y	Y	Y	1	12
273	Y	Y	Y	Y	1	15
274	Y	Y	Y	Y	1	86
275	Y	Y	Y	Y	1	84
276	Y	Y	Y	Y	1	34
277	Y	Y	Y	Y	1	35
278	Y	Y	Y	Y	1	42
279	Y	Y	Y	Y	1	43
280	Y	Y	Y	Y	1	31
281	Y	Y	Y	Y	1	36
282	Y	Y	Y	Y	1	27
283	Y	Y	Y	Y	1	13
284	Y	Y	Y	Y	1	32
285	Y	Y	Y	Y	1	44
286	Y	Y	Y	Y	1	101
287	Y	Y	Y	Y	2	17
288	Y	Y	Y	Y	2	44
289	Y	Y	Y	Y	4	46
290	Y	Y	Y	Y	5	8
291	Y	Y	Y	Y	5	26
292	Y	Y	Y	Y	5	63
293	Y	Y	Y	Y	5	20
294	Y	Y	Y	Y	5	25
295	Y	Y	Y	Y	5	19
296	Y	Y	Y	Y	5	21
297	Y	Y	Y	Y	5	22
298	Y	Y	Y	Y	5	23
299	Y	Y	Y	Y	5	24
300	Y	Y	Y	Y	5	45
301	Y	Y	Y	Y	6	18
302	Y	Y	Y	Y	7	28
303	Y	Y	Y	Y	7	29
304	Y	Y	Y	Y	7	30
305	Y	Y	Y	Y	4	118
306	Y	Y	Y	Y	4	123
307	Y	Y	Y	Y	4	106
308	Y	Y	Y	Y	4	118
309	Y	Y	Y	Y	4	123
310	Y	Y	Y	Y	4	106
311	Y	Y	Y	Y	5	185
312	Y	Y	Y	Y	7	108
258	Y	Y	Y	Y	5	185
313	Y	Y	Y	Y	7	110
314	Y	Y	Y	Y	5	322
315	Y	Y	Y	Y	5	69
316	Y	Y	Y	Y	5	72
317	Y	Y	Y	Y	5	349
318	Y	Y	Y	Y	5	350
319	Y	Y	Y	Y	5	352
320	Y	Y	Y	Y	5	353
321	Y	Y	Y	Y	5	354
322	Y	Y	Y	Y	5	356
323	Y	Y	Y	Y	5	357
324	Y	Y	Y	Y	5	358
325	Y	Y	Y	Y	5	359
326	Y	Y	Y	Y	5	360
327	Y	Y	Y	Y	5	355
328	Y	Y	Y	Y	10	107
329	Y	Y	Y	Y	5	405
330	Y	Y	Y	Y	5	406
331	Y	Y	Y	Y	5	407
332	Y	Y	Y	Y	5	408
333	Y	Y	Y	Y	5	409
334	Y	Y	Y	Y	5	60
335	Y	Y	Y	Y	5	410
336	Y	Y	Y	Y	5	356
337	Y	Y	Y	Y	5	411
338	Y	Y	Y	Y	5	412
339	Y	Y	Y	Y	5	508
340	Y	Y	Y	Y	11	678
341	Y	Y	Y	Y	3	113
342	Y	Y	Y	Y	3	114
343	Y	Y	Y	Y	3	681
344	Y	Y	Y	Y	3	682
345	Y	Y	Y	Y	3	683
346	Y	Y	Y	Y	3	112
347	Y	Y	Y	Y	3	680
348	Y	Y	Y	Y	3	684
349	Y	Y	Y	Y	3	685
350	Y	Y	Y	Y	3	686
351	Y	Y	Y	Y	3	687
352	Y	Y	Y	Y	3	688
353	Y	Y	Y	Y	3	676
354	Y	Y	Y	Y	13	694
355	Y	Y	Y	Y	12	693
356	Y	Y	Y	Y	3	695
357	Y	Y	Y	Y	4	696
\.


--
-- Name: system_role_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('system_role_seq', 13, true);


--
-- Data for Name: system_user; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_user (id, external_id, login_name, last_name, first_name, initials, is_active, is_employee, lastupdated) FROM stdin;
1	1	admin	ELIS	Open	OE	Y	Y	2006-11-08 11:11:14.312
106	1	user	User	User	UU	Y	Y	2011-02-14 16:40:02.925
122	\N	atomfeed	atomfeed	atomfeed	\N	Y	N	2017-02-28 15:48:22.708523
123	6048bbda-c626-4b55-9f22-ee5c4563fdd6	random	r	random	rr	Y	Y	2017-05-11 06:06:25.982
\.


--
-- Data for Name: system_user_module; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_user_module (id, has_select, has_add, has_update, has_delete, system_user_id, system_module_id) FROM stdin;
\.


--
-- Name: system_user_module_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('system_user_module_seq', 357, true);


--
-- Data for Name: system_user_role; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_user_role (system_user_id, role_id) FROM stdin;
106	4
106	6
106	7
106	5
106	3
106	2
106	10
106	9
122	12
123	12
123	7
123	5
\.


--
-- Data for Name: system_user_section; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY system_user_section (id, has_view, has_assign, has_complete, has_release, has_cancel, system_user_id, test_section_id) FROM stdin;
\.


--
-- Name: system_user_section_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('system_user_section_seq', 1, false);


--
-- Name: system_user_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('system_user_seq', 123, true);


--
-- Data for Name: test; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test (id, method_id, uom_id, description, loinc, reporting_description, sticker_req_flag, is_active, active_begin, active_end, is_reportable, time_holding, time_wait, time_ta_average, time_ta_warning, time_ta_max, label_qty, lastupdated, label_id, test_trailer_id, test_section_id, scriptlet_id, test_format_id, local_abbrev, sort_order, name, display_key, orderable, is_referred_out) FROM stdin;
\.


--
-- Data for Name: test_analyte; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_analyte (id, test_id, analyte_id, result_group, sort_order, testalyt_type, lastupdated, is_reportable) FROM stdin;
\.


--
-- Name: test_analyte_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_analyte_seq', 280, true);


--
-- Data for Name: test_code; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_code (test_id, code_type_id, value, lastupdated) FROM stdin;
\.


--
-- Data for Name: test_code_type; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_code_type (id, schema_name, lastupdated) FROM stdin;
1	LOINC	2012-04-24 00:30:07.075933+00
2	SNOMED	2012-04-24 00:30:07.075933+00
3	billingCode	2013-08-08 08:02:34.814891+00
4	analyzeCode	2013-08-08 08:02:34.814891+00
\.


--
-- Data for Name: test_formats; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_formats (id, lastupdated) FROM stdin;
\.


--
-- Data for Name: test_reflex; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_reflex (id, tst_rslt_id, flags, lastupdated, test_analyte_id, test_id, add_test_id, sibling_reflex, scriptlet_id) FROM stdin;
\.


--
-- Name: test_reflex_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_reflex_seq', 6, true);


--
-- Data for Name: test_result; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_result (id, test_id, result_group, flags, tst_rslt_type, value, significant_digits, quant_limit, cont_level, lastupdated, scriptlet_id, sort_order, abnormal, is_active) FROM stdin;
\.


--
-- Name: test_result_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_result_seq', 2672, true);


--
-- Data for Name: test_section; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_section (id, name, description, org_id, is_external, lastupdated, parent_test_section, display_key, sort_order, is_active, uuid) FROM stdin;
136	user	Indicates user will chose test section	3	N	2013-08-08 08:02:35.294475	\N	\N	2147483647	N	c0843711-45a9-4a04-a74f-e95eb4cebd32
156	New	Dummy Section	\N	N	\N	\N	\N	2147483647	N	cc564870-3f7a-43fd-abb5-c18d6d64c5d3
177	Clinical Pathology Department	Clinical Pathology Department	1284	\N	2017-04-10 14:55:30.366	\N	\N	0	Y	f865e6b5-41c0-4d31-8c94-7bea925ae8df
196	Parasitology Department	Parasitology Department	1284	\N	2017-04-10 14:55:30.415	\N	\N	0	Y	a63dc2b6-2aee-49b4-a736-756e763a574a
198	Immunology Department	Immunology Department	1284	\N	2017-04-10 14:55:30.537	\N	\N	0	Y	48f375a0-a7fa-45c6-a26d-eecab0ae81ea
176	Haematology Department	Haematology Department	1284	\N	2017-04-11 14:09:30.144	\N	\N	0	Y	4dc3bfe7-5346-47c3-b6b8-44214deb5318
199	Microbiology Department	Microbiology Department	1284	\N	2017-04-24 12:15:00.184	\N	\N	0	Y	eb319037-2fe7-4348-9563-8135420657a0
197	Biochemistry Department	Biochemistry Department	1284	\N	2017-04-24 17:52:00.109	\N	\N	0	Y	569df49b-3dfb-4452-94ff-b7ceb84f731f
\.


--
-- Name: test_section_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_section_seq', 215, true);


--
-- Name: test_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_seq', 875, true);


--
-- Data for Name: test_trailer; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_trailer (id, name, description, text, lastupdated) FROM stdin;
\.


--
-- Name: test_trailer_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('test_trailer_seq', 2, false);


--
-- Data for Name: test_worksheet_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_worksheet_item (id, tw_id, qc_id, "position", cell_type) FROM stdin;
\.


--
-- Data for Name: test_worksheets; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY test_worksheets (id, test_id, batch_capacity, total_capacity, number_format) FROM stdin;
\.


--
-- Name: tobereomved_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('tobereomved_seq', 1, false);


--
-- Data for Name: type_of_provider; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY type_of_provider (id, description, tp_code) FROM stdin;
\.


--
-- Data for Name: type_of_sample; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY type_of_sample (id, description, domain, lastupdated, local_abbrev, display_key, is_active, sort_order, uuid) FROM stdin;
\.


--
-- Name: type_of_sample_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('type_of_sample_seq', 91, true);


--
-- Data for Name: type_of_test_result; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY type_of_test_result (id, test_result_type, description, lastupdated, hl7_value) FROM stdin;
2	D	Dictionary	2006-11-08 11:40:58.824	TX
3	T	Titer	2006-03-29 11:53:15	TX
4	N	Numeric	2006-03-29 11:53:21	NM
1	R	Remark	2010-10-28 06:12:41.971687	TX
5	A	Alpha,no range check	2010-10-28 06:13:53.177655	TX
6	M	Multiselect	2011-01-06 10:57:15.79331	TX
\.


--
-- Name: type_of_test_result_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('type_of_test_result_seq', 6, true);


--
-- Data for Name: unit_of_measure; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY unit_of_measure (id, name, description, lastupdated, uuid) FROM stdin;
82	10���3/��	\N	2017-04-10 14:52:15.223	\N
83	%	\N	2017-04-10 14:52:15.401	\N
84	10���6/��	\N	2017-04-10 14:52:15.555	\N
85	fL	\N	2017-04-10 14:52:15.626	\N
86	pg	\N	2017-04-10 14:52:15.66	\N
87	g/dl	\N	2017-04-10 14:52:15.686	\N
88	Minutes	\N	2017-04-10 14:52:15.829	\N
89	mm/hr	\N	2017-04-10 14:52:15.916	\N
90	g/dL	\N	2017-04-10 14:52:16.029	\N
91	mg/dL	\N	2017-04-10 14:52:16.416	\N
92	mEq/L	\N	2017-04-10 14:52:16.494	\N
93	IU/L	\N	2017-04-10 14:52:16.544	\N
94	ug/dL	\N	2017-04-10 14:52:16.864	\N
95	Random	\N	2017-04-10 14:52:17.026	\N
96	IU/mL	\N	2017-04-10 14:52:17.055	\N
97	Titre	\N	2017-04-10 14:52:17.134	\N
98	10ᶺ3/µ	\N	2017-04-10 17:34:45.138	\N
99	10ᶺ6/µ	\N	2017-04-10 17:36:15.045	\N
100	/HPF	\N	2017-04-11 14:26:15.079	\N
\.


--
-- Name: unit_of_measure_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('unit_of_measure_seq', 100, true);


--
-- Data for Name: user_alert_map; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY user_alert_map (user_id, alert_id, report_id, alert_limit, alert_operator, map_id) FROM stdin;
\.


--
-- Data for Name: user_group_map; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY user_group_map (user_id, group_id, map_id) FROM stdin;
1	1120	0
241	1121	0
\.


--
-- Data for Name: user_security; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY user_security (user_id, role_name) FROM stdin;
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
1	ROOT_ADMIN_ROLE
1	LOG_VIEWER_ROLE
1	UPLOAD_ROLE
1	GROUP_ADMIN_ROLE
1	DATASOURCE_ADMIN_ROLE
1	CHART_ADMIN_ROLE
1	REPORT_ADMIN_ROLE
1	ADVANCED_SCHEDULER_ROLE
1	PARAMETER_ADMIN_ROLE
1	SCHEDULER_ROLE
\.


--
-- Data for Name: worksheet_analysis; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheet_analysis (id, reference_type, reference_id, worksheet_item_id) FROM stdin;
\.


--
-- Data for Name: worksheet_analyte; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheet_analyte (id, wrkst_anls_id, sort_order, result_id) FROM stdin;
\.


--
-- Data for Name: worksheet_heading; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheet_heading (id, worksheet_name, rownumber, column1, column2, column3, column4, column5, column6, column7, column8, column9, column10, type) FROM stdin;
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
1	TB	1	Micro Result	Culture Result	Report Date	\N	\N	\N	\N	\N	\N	\N	RESULT
2	GC	1	12 HOUR	24 HOUR	48 HOUR	\N	\N	\N	\N	\N	\N	\N	RESULT
9	US FTA	7	\N	\N	\N	\N	PBS	.	.	.	-	.	QC
10	US FTA	8	\N	\N	\N	\N	Sorbent	.	.	.	-	.	QC
8	US FTA	6	PBS	.	.	.	Nonspecific Control / Sorbent	.	.	.	-	.	QC
11	US FTA	1	    USR     Repeat Quant	   FTA      Current Run	    FTA     Previous Runs	   FTA         Final	  TPPA       Result	Comments	\N	\N	\N	\N	RESULT
26	US FTA	1	TEST	TESTing	\N	\N	\N	\N	\N	\N	\N	\N	ANALYTE
7	US FTA	5	.	.	.	.	Nonspecific Control/ PBS	.	.	.	>2+	.	QC
6	US FTA	4	FITCconjugate Working Dilution:	.	.	.	Minimally Reactive Control	.	.	.	1+	.	QC
5	US FTA	3	Sorbent	.	.	.	Reactive Control / Sorbent	.	.	.	3-4+	.	QC
4	US FTA	2	T Palladium antigen	.	.	.	Reactive Control/PBS	.	.	.	4+	.	QC
3	US FTA	1	Reagent	Source	Lot	Expire Date	Reagent	Source	Lot	Expires	Expect	Actual	QC
25	F	23	KNO3	RT incubation	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
24	F	22	dulcitol	chlamydospores	.	.	\N	\N	\N	\N	\N	\N	ANALYTE
23	F	21	melibiose	ascospores	NO3	.	\N	\N	\N	\N	\N	\N	ANALYTE
22	F	20	trehalose	pigment	gelatin	.	\N	\N	\N	\N	\N	\N	ANALYTE
21	F	19	xylose	germ tubes	urea	probe (histo)	\N	\N	\N	\N	\N	\N	ANALYTE
20	F	18	inositol	urea	T4	probe (blasto)	\N	\N	\N	\N	\N	\N	ANALYTE
19	F	17	raffinose	OTHER TESTS	T3	probe (cocci)	\N	\N	\N	\N	\N	\N	ANALYTE
18	F	16	cellobiose	galactose	T2	PROBE TESTS	\N	\N	\N	\N	\N	\N	ANALYTE
17	F	15	galactose	trehalose	T1	.	\N	\N	\N	\N	\N	\N	ANALYTE
16	F	14	lactose	lactose	37 degrees	lysozyme	\N	\N	\N	\N	\N	\N	ANALYTE
15	F	13	sucrose	sucrose	RT incubation	xanthine	\N	\N	\N	\N	\N	\N	ANALYTE
14	F	12	maltose	maltose	sabs without CH	tyrosine	\N	\N	\N	\N	\N	\N	ANALYTE
13	F	11	dextrose	dextrose	sabs with CH	casein	\N	\N	\N	\N	\N	\N	ANALYTE
12	F	10	ASSIMILATIONS	FERMENTATIONS	FILAMENTOUS	ACTINOMYCETES	\N	\N	\N	\N	\N	\N	ANALYTE
62	US VDRL	1	QL	QN:2	4	8	16	32	64	128	256	Final	RESULT
93	US USR	15	Titer	.	.	.	.	.	.	.	\N	\N	QC
96	US FTA	10	\N	\N	\N	\N	TPPA - control	.	.	.	-	.	QC
95	US FTA	9	\N	\N	\N	\N	TPPA + control	.	.	.	+	.	QC
49	US USR	11	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULTS Qualitative Expect	RESULTS Qualitative  Actual	RESULTS Quantitative Expect	RESULTS Quantitative Actual	\N	\N	QC
48	US USR	10	Rotation of Slides	178-182	__________	rotations/min	\N	\N	\N	\N	\N	\N	QC
47	US USR	9	Temp of Lab	23-29	__________	degrees C	\N	\N	\N	\N	\N	\N	QC
46	US USR	6	Sterile DI H20	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
45	US USR	8	USR working antigen	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
44	US USR	5	Phosphate Buffer	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
43	US USR	4	EDTA	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
42	US USR	3	Choline Chloride	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
41	US USR	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
40	US USR	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
52	US USR	14	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
51	US USR	13	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
50	US USR	12	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
55	HSV TYPING	3	Expiration Date:	________________	Negative Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
54	HSV TYPING	2	Lot:	________________	HSV2 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
53	HSV TYPING	1	HSV1 / HSV2 Typing Kit:	________________	HSV1 Positive Cells:	Lot _____________	\N	\N	\N	\N	\N	\N	QC
57	HSV TYPING	2	HSV-1 PC	.	.	.	.	.	.	.	\N	\N	RESULT
58	HSV TYPING	3	HSV-1 nc	.	.	.	.	.	.	.	\N	\N	RESULT
60	HSV TYPING	5	HSV-2 nc	.	.	.	.	.	.	.	\N	\N	RESULT
59	HSV TYPING	4	HSV-2 PC	.	.	.	.	.	.	.	\N	\N	RESULT
74	MICRO	6	Pigment	Mannitol	Casein	Gelatin	\N	\N	\N	\N	\N	\N	ANALYTE
73	MICRO	5	Hemolysis	Maltose	Trehalose	Litmus Milk	\N	\N	\N	\N	\N	\N	ANALYTE
72	MICRO	4	O2 Relation	Sucrose	Sorbose	Ornithine	\N	\N	\N	\N	\N	\N	ANALYTE
92	STREP	11	\N	\N	\N	\N	PFGE	\N	\N	\N	\N	\N	ANALYTE
35	US VDRL	8	Rotation of Slides	.	178 - 182	__________	rotation/min	\N	\N	\N	\N	\N	QC
34	US VDRL	7	Temp of Lab	.	23 - 29	__________	degrees C	\N	\N	\N	\N	\N	QC
36	US VDRL	9	CONTROLS	SOURCE	LOT	EXPIRE DATE	RESULT Qualitative Expect	RESULT Qualitative  Actual	RESULT Quantitative Expect	RESULT Quantitative Actual	\N	\N	QC
56	HSV TYPING	1	Specimen ID	Received Date	Source	Pass	HSV1	HSV2	Comments	Mailer	\N	\N	RESULT
27	VI	1	Comments	Results	Interpretation	\N	\N	\N	\N	\N	\N	\N	RESULT
32	US VDRL	5	VDRL working antigen	.	.	.	\N	\N	\N	\N	\N	\N	QC
31	US VDRL	4	10% Saline	.	.	.	\N	\N	\N	\N	\N	\N	QC
30	US VDRL	3	Kahn Saline 0.9%	.	.	.	\N	\N	\N	\N	\N	\N	QC
29	US VDRL	2	VDRL Antigen Kit	Difco	.	.	\N	\N	\N	\N	\N	\N	QC
28	US VDRL	1	REAGENT	SOURCE	LOT	EXPIRE DATE	\N	\N	\N	\N	\N	\N	QC
38	US VDRL	11	LPC	Difco	.	.	WR	.	.	.	\N	\N	QC
37	US VDRL	10	HPC	Difco	.	.	R	.	.	.	\N	\N	QC
39	US VDRL	12	NC	Difco	.	.	NR	.	.	.	\N	\N	QC
61	US USR	1	QL	QN: 2	4	8	16	32	64	128	256	Final	RESULT
68	STREP	6	Factors	PFGE	\N	Catalase	Lact	\N	\N	\N	\N	\N	ANALYTE
67	STREP	5	Group	Latex	Latex	Kilian	Suc	\N	\N	\N	\N	\N	ANALYTE
66	STREP	4	Typing pool	PYR	Hipp	Satellites	Malt	\N	\N	\N	\N	\N	ANALYTE
65	STREP	3	Bile sol	A disc	Camp	X+V	Dex	\N	\N	\N	\N	\N	ANALYTE
64	STREP	2	P disc	GmSt	GmSt	GmSt	GmSt	\N	\N	\N	\N	\N	ANALYTE
63	STREP	1	Strep pneumo	Group A Strep	Group B Strep	H Influenzae	N. meningitidis	\N	\N	\N	\N	\N	ANALYTE
70	MICRO	3	Spores	Lactose	Sorbitol	Arginine	\N	\N	\N	\N	\N	\N	ANALYTE
69	MICRO	2	42	Glucose	Salicin	Lysine	\N	\N	\N	\N	\N	\N	ANALYTE
71	MICRO	1	Colony morphology	.	Gram morphology	.	\N	\N	\N	\N	\N	\N	ANALYTE
79	MICRO	11	MacConkey	Fructose	Motility	Pyruvate	\N	\N	\N	\N	\N	\N	ANALYTE
78	MICRO	10	Serology	Inulin	.	6.5% salt	\N	\N	\N	\N	\N	\N	ANALYTE
77	MICRO	9	Satellites	Cellibiose	Alk Phos	Bile Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
76	MICRO	8	Kilian test	Arabinose	PZA	Esculin	\N	\N	\N	\N	\N	\N	ANALYTE
75	MICRO	7	X+V Req	Xylose	Starch	Cetrimide	\N	\N	\N	\N	\N	\N	ANALYTE
87	MICRO	19	Lecthinase	Ribose	Phenylalanine	.	\N	\N	\N	\N	\N	\N	ANALYTE
86	MICRO	18	Lipase	Rhamnose	Acetate	FREEZE	\N	\N	\N	\N	\N	\N	ANALYTE
85	MICRO	17	.	Raffinose	Citrate	PFGE	\N	\N	\N	\N	\N	\N	ANALYTE
84	MICRO	16	Optochin	MMP	MR         VP	LAP         PYR	\N	\N	\N	\N	\N	\N	ANALYTE
83	MICRO	15	Camp	Melibiose	Indol	Erythromycin	\N	\N	\N	\N	\N	\N	ANALYTE
82	MICRO	14	Bacitracin	Mannose	Nitite	Vancomycin	\N	\N	\N	\N	\N	\N	ANALYTE
81	MICRO	13	Catalase	Glycerol	Nitrate	Coagulase	\N	\N	\N	\N	\N	\N	ANALYTE
80	MICRO	12	Oxidase	Galactose	Urease	MGP	\N	\N	\N	\N	\N	\N	ANALYTE
91	STREP	10	\N	\N	\N	\N	Serology	\N	\N	\N	\N	\N	ANALYTE
90	STREP	9	\N	\N	\N	\N	TM	\N	\N	\N	\N	\N	ANALYTE
89	STREP	8	\N	\N	\N	Serology	Oxidase	\N	\N	\N	\N	\N	ANALYTE
88	STREP	7	\N	\N	\N	Oxidase	Catalase	\N	\N	\N	\N	\N	ANALYTE
94	US USR	7	Kahn's solution	MDH	.	.	\N	\N	\N	\N	\N	\N	QC
\.


--
-- Data for Name: worksheet_item; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheet_item (id, "position", worksheet_id) FROM stdin;
\.


--
-- Data for Name: worksheet_qc; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheet_qc (id, sort_order, wq_type, value, worksheet_analysis_id, qc_analyte_id) FROM stdin;
\.


--
-- Data for Name: worksheets; Type: TABLE DATA; Schema: clinlims; Owner: clinlims
--

COPY worksheets (id, sys_user_id, test_id, created, status, number_format) FROM stdin;
\.


--
-- Name: zip_code_seq; Type: SEQUENCE SET; Schema: clinlims; Owner: clinlims
--

SELECT pg_catalog.setval('zip_code_seq', 1, false);


--
-- Name: address_part_part_name_key; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY address_part
    ADD CONSTRAINT address_part_part_name_key UNIQUE (part_name);


--
-- Name: address_part_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY address_part
    ADD CONSTRAINT address_part_pk PRIMARY KEY (id);


--
-- Name: analysis_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_pk PRIMARY KEY (id);


--
-- Name: analyte_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analyte
    ADD CONSTRAINT analyte_pk PRIMARY KEY (id);


--
-- Name: analyzer_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analyzer
    ADD CONSTRAINT analyzer_pk PRIMARY KEY (id);


--
-- Name: analyzer_result_status_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analyzer_result_status
    ADD CONSTRAINT analyzer_result_status_pk PRIMARY KEY (id);


--
-- Name: analyzer_test_map_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analyzer_test_map
    ADD CONSTRAINT analyzer_test_map_pk PRIMARY KEY (analyzer_id, analyzer_test_name);


--
-- Name: anauser_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analysis_users
    ADD CONSTRAINT anauser_pk PRIMARY KEY (id);


--
-- Name: ani_samp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_animal
    ADD CONSTRAINT ani_samp_pk PRIMARY KEY (id);


--
-- Name: anqaev_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analysis_qaevent
    ADD CONSTRAINT anqaev_pk PRIMARY KEY (id);


--
-- Name: anstore_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analysis_storages
    ADD CONSTRAINT anstore_pk PRIMARY KEY (id);


--
-- Name: attachment_item_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY attachment_item
    ADD CONSTRAINT attachment_item_pk PRIMARY KEY (id);


--
-- Name: attachment_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_pk PRIMARY KEY (id);


--
-- Name: auxdata_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY aux_data
    ADD CONSTRAINT auxdata_pk PRIMARY KEY (id);


--
-- Name: auxfld_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY aux_field
    ADD CONSTRAINT auxfld_pk PRIMARY KEY (id);


--
-- Name: auxfldval_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY aux_field_values
    ADD CONSTRAINT auxfldval_pk PRIMARY KEY (id);


--
-- Name: code_element_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY code_element_type
    ADD CONSTRAINT code_element_type_pk PRIMARY KEY (id);


--
-- Name: code_element_xref_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY code_element_xref
    ADD CONSTRAINT code_element_xref_pk PRIMARY KEY (id);


--
-- Name: comm_anim_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY animal_common_name
    ADD CONSTRAINT comm_anim_pk PRIMARY KEY (id);


--
-- Name: cron_scheduler_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY quartz_cron_scheduler
    ADD CONSTRAINT cron_scheduler_pk PRIMARY KEY (id);


--
-- Name: ct_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY contact_type
    ADD CONSTRAINT ct_pk PRIMARY KEY (id);


--
-- Name: demog_hist_type_type_name_u; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY observation_history_type
    ADD CONSTRAINT demog_hist_type_type_name_u UNIQUE (type_name);


--
-- Name: demographic_history_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY observation_history_type
    ADD CONSTRAINT demographic_history_type_pk PRIMARY KEY (id);


--
-- Name: demographics_history_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY observation_history
    ADD CONSTRAINT demographics_history_pk PRIMARY KEY (id);


--
-- Name: dict_cat_desc_u; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY dictionary_category
    ADD CONSTRAINT dict_cat_desc_u UNIQUE (description);


--
-- Name: dict_cat_local_abbrev_u; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY dictionary_category
    ADD CONSTRAINT dict_cat_local_abbrev_u UNIQUE (local_abbrev);


--
-- Name: dict_dict_cat_id_dict_entry_u; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY dictionary
    ADD CONSTRAINT dict_dict_cat_id_dict_entry_u UNIQUE (dictionary_category_id, dict_entry);


--
-- Name: dict_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY dictionary
    ADD CONSTRAINT dict_pk PRIMARY KEY (id);


--
-- Name: dictionary_category_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY dictionary_category
    ADD CONSTRAINT dictionary_category_pk PRIMARY KEY (id);


--
-- Name: dist_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY district
    ADD CONSTRAINT dist_pk PRIMARY KEY (id);


--
-- Name: env_samp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_environmental
    ADD CONSTRAINT env_samp_pk PRIMARY KEY (id);


--
-- Name: ethnic_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY ethnicity
    ADD CONSTRAINT ethnic_pk PRIMARY KEY (id);


--
-- Name: gender_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY gender
    ADD CONSTRAINT gender_pk PRIMARY KEY (id);


--
-- Name: hist_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY history
    ADD CONSTRAINT hist_pk PRIMARY KEY (id);


--
-- Name: hl7_encoding_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_code_type
    ADD CONSTRAINT hl7_encoding_type_pk PRIMARY KEY (id);


--
-- Name: hum_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_human
    ADD CONSTRAINT hum_pk PRIMARY KEY (id);


--
-- Name: ia_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY instrument_analyte
    ADD CONSTRAINT ia_pk PRIMARY KEY (id);


--
-- Name: id; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analyzer_results
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: identity_type_uk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_identity_type
    ADD CONSTRAINT identity_type_uk UNIQUE (identity_type);


--
-- Name: il_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY instrument_log
    ADD CONSTRAINT il_pk PRIMARY KEY (id);


--
-- Name: import_status_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY import_status
    ADD CONSTRAINT import_status_pk PRIMARY KEY (id);


--
-- Name: import_status_saved_file_name_key; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY import_status
    ADD CONSTRAINT import_status_saved_file_name_key UNIQUE (saved_file_name);


--
-- Name: instru_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY instrument
    ADD CONSTRAINT instru_pk PRIMARY KEY (id);


--
-- Name: inv_recpt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY inventory_receipt
    ADD CONSTRAINT inv_recpt_pk PRIMARY KEY (id);


--
-- Name: invcomp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY inventory_component
    ADD CONSTRAINT invcomp_pk PRIMARY KEY (id);


--
-- Name: invitem_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY inventory_item
    ADD CONSTRAINT invitem_pk PRIMARY KEY (id);


--
-- Name: invloc_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY inventory_location
    ADD CONSTRAINT invloc_pk PRIMARY KEY (id);


--
-- Name: lab_order_item_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY lab_order_item
    ADD CONSTRAINT lab_order_item_pk PRIMARY KEY (id);


--
-- Name: lab_order_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY lab_order_type
    ADD CONSTRAINT lab_order_type_pk PRIMARY KEY (id);


--
-- Name: label_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_pk PRIMARY KEY (id);


--
-- Name: login_user_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY login_user
    ADD CONSTRAINT login_user_pk PRIMARY KEY (login_name);


--
-- Name: ma_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY method_analyte
    ADD CONSTRAINT ma_pk PRIMARY KEY (id);


--
-- Name: menu_element_id_key; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_element_id_key UNIQUE (element_id);


--
-- Name: message_org_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY message_org
    ADD CONSTRAINT message_org_pk PRIMARY KEY (id);


--
-- Name: method_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY method
    ADD CONSTRAINT method_pk PRIMARY KEY (id);


--
-- Name: methres_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY method_result
    ADD CONSTRAINT methres_pk PRIMARY KEY (id);


--
-- Name: mls_lab_tp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY mls_lab_type
    ADD CONSTRAINT mls_lab_tp_pk PRIMARY KEY (id);


--
-- Name: newborn_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_newborn
    ADD CONSTRAINT newborn_pk PRIMARY KEY (id);


--
-- Name: note_id; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_id PRIMARY KEY (id);


--
-- Name: oct_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY occupation
    ADD CONSTRAINT oct_pk PRIMARY KEY (id);


--
-- Name: or_properties_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY or_properties
    ADD CONSTRAINT or_properties_pkey PRIMARY KEY (property_id);


--
-- Name: or_properties_property_key_key; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY or_properties
    ADD CONSTRAINT or_properties_property_key_key UNIQUE (property_key);


--
-- Name: or_tags_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY or_tags
    ADD CONSTRAINT or_tags_pkey PRIMARY KEY (tag_id);


--
-- Name: ord_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT ord_pk PRIMARY KEY (id);


--
-- Name: orditem_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY order_item
    ADD CONSTRAINT orditem_pk PRIMARY KEY (id);


--
-- Name: org_contact_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT org_contact_pk PRIMARY KEY (id);


--
-- Name: org_hl7_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY org_hl7_encoding_type
    ADD CONSTRAINT org_hl7_pk PRIMARY KEY (organization_id, encoding_type_id);


--
-- Name: org_mlt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY org_mls_lab_type
    ADD CONSTRAINT org_mlt_pk PRIMARY KEY (org_mlt_id);


--
-- Name: org_org_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY organization_organization_type
    ADD CONSTRAINT org_org_type_pk PRIMARY KEY (org_id, org_type_id);


--
-- Name: org_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT org_pk PRIMARY KEY (id);


--
-- Name: org_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY organization_type
    ADD CONSTRAINT org_type_pk PRIMARY KEY (id);


--
-- Name: organization_address_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT organization_address_pk PRIMARY KEY (organization_id, address_part_id);


--
-- Name: pac_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY package_1
    ADD CONSTRAINT pac_pk PRIMARY KEY (id);


--
-- Name: pan_it_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY panel_item
    ADD CONSTRAINT pan_it_pk PRIMARY KEY (id);


--
-- Name: panel_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY panel
    ADD CONSTRAINT panel_pk PRIMARY KEY (id);


--
-- Name: pat_ident_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_identity_type
    ADD CONSTRAINT pat_ident_type_pk PRIMARY KEY (id);


--
-- Name: pat_identity_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_identity
    ADD CONSTRAINT pat_identity_pk PRIMARY KEY (id);


--
-- Name: pat_occupation_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_occupation
    ADD CONSTRAINT pat_occupation_pk PRIMARY KEY (id);


--
-- Name: pat_pat_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_patient_type
    ADD CONSTRAINT pat_pat_type_pk PRIMARY KEY (id);


--
-- Name: pat_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT pat_pk PRIMARY KEY (id);


--
-- Name: pat_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_type
    ADD CONSTRAINT pat_type_pk PRIMARY KEY (id);


--
-- Name: pay_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY payment_type
    ADD CONSTRAINT pay_type_pk PRIMARY KEY (id);


--
-- Name: person_address_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT person_address_pk PRIMARY KEY (person_id, address_part_id);


--
-- Name: person_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pk PRIMARY KEY (id);


--
-- Name: pk_chunking_history; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY chunking_history
    ADD CONSTRAINT pk_chunking_history PRIMARY KEY (id);


--
-- Name: pk_databasechangelog; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY databasechangelog
    ADD CONSTRAINT pk_databasechangelog PRIMARY KEY (id, author, filename);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_document_track; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY document_track
    ADD CONSTRAINT pk_document_track PRIMARY KEY (id);


--
-- Name: pk_document_type; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY document_type
    ADD CONSTRAINT pk_document_type PRIMARY KEY (id);


--
-- Name: pk_event_records; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY event_records
    ADD CONSTRAINT pk_event_records PRIMARY KEY (id);


--
-- Name: pk_event_records_offset_marker; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY event_records_offset_marker
    ADD CONSTRAINT pk_event_records_offset_marker PRIMARY KEY (id);


--
-- Name: pk_event_records_queue; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY event_records_queue
    ADD CONSTRAINT pk_event_records_queue PRIMARY KEY (id);


--
-- Name: pk_external_reference; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY external_reference
    ADD CONSTRAINT pk_external_reference PRIMARY KEY (id);


--
-- Name: pk_failed_event_retry_log; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY failed_event_retry_log
    ADD CONSTRAINT pk_failed_event_retry_log PRIMARY KEY (id);


--
-- Name: pk_failed_events; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY failed_events
    ADD CONSTRAINT pk_failed_events PRIMARY KEY (id);


--
-- Name: pk_markers; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY markers
    ADD CONSTRAINT pk_markers PRIMARY KEY (id);


--
-- Name: pk_menu; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (id);


--
-- Name: pk_qa_observation; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qa_observation
    ADD CONSTRAINT pk_qa_observation PRIMARY KEY (id);


--
-- Name: pk_qa_observation_type; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qa_observation_type
    ADD CONSTRAINT pk_qa_observation_type PRIMARY KEY (id);


--
-- Name: pk_sample_source; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_source
    ADD CONSTRAINT pk_sample_source PRIMARY KEY (id);


--
-- Name: pr_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient_relations
    ADD CONSTRAINT pr_pk PRIMARY KEY (id);


--
-- Name: progs_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY program
    ADD CONSTRAINT progs_pk PRIMARY KEY (id);


--
-- Name: proj_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT proj_pk PRIMARY KEY (id);


--
-- Name: project_org_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY project_organization
    ADD CONSTRAINT project_org_pk PRIMARY KEY (project_id, org_id);


--
-- Name: projparam_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY project_parameter
    ADD CONSTRAINT projparam_pk PRIMARY KEY (id);


--
-- Name: provider_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY provider
    ADD CONSTRAINT provider_pk PRIMARY KEY (id);


--
-- Name: qa_event_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qa_event
    ADD CONSTRAINT qa_event_pk PRIMARY KEY (id);


--
-- Name: qc_analyt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qc_analytes
    ADD CONSTRAINT qc_analyt_pk PRIMARY KEY (id);


--
-- Name: qc_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qc
    ADD CONSTRAINT qc_pk PRIMARY KEY (id);


--
-- Name: qrtz_blob_triggers_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_pkey PRIMARY KEY (trigger_name, trigger_group);


--
-- Name: qrtz_calendars_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_calendars
    ADD CONSTRAINT qrtz_calendars_pkey PRIMARY KEY (calendar_name);


--
-- Name: qrtz_cron_triggers_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_pkey PRIMARY KEY (trigger_name, trigger_group);


--
-- Name: qrtz_fired_triggers_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_fired_triggers
    ADD CONSTRAINT qrtz_fired_triggers_pkey PRIMARY KEY (entry_id);


--
-- Name: qrtz_job_details_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_job_details
    ADD CONSTRAINT qrtz_job_details_pkey PRIMARY KEY (job_name, job_group);


--
-- Name: qrtz_job_listeners_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_job_listeners
    ADD CONSTRAINT qrtz_job_listeners_pkey PRIMARY KEY (job_name, job_group, job_listener);


--
-- Name: qrtz_locks_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_locks
    ADD CONSTRAINT qrtz_locks_pkey PRIMARY KEY (lock_name);


--
-- Name: qrtz_paused_trigger_grps_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_paused_trigger_grps
    ADD CONSTRAINT qrtz_paused_trigger_grps_pkey PRIMARY KEY (trigger_group);


--
-- Name: qrtz_scheduler_state_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_scheduler_state
    ADD CONSTRAINT qrtz_scheduler_state_pkey PRIMARY KEY (instance_name);


--
-- Name: qrtz_simple_triggers_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_pkey PRIMARY KEY (trigger_name, trigger_group);


--
-- Name: qrtz_trigger_listeners_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_trigger_listeners
    ADD CONSTRAINT qrtz_trigger_listeners_pkey PRIMARY KEY (trigger_name, trigger_group, trigger_listener);


--
-- Name: qrtz_triggers_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_pkey PRIMARY KEY (trigger_name, trigger_group);


--
-- Name: race_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY race
    ADD CONSTRAINT race_pk PRIMARY KEY (id);


--
-- Name: receiver_code_element_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY receiver_code_element
    ADD CONSTRAINT receiver_code_element_pk PRIMARY KEY (id);


--
-- Name: referral_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY referral
    ADD CONSTRAINT referral_pk PRIMARY KEY (id);


--
-- Name: referral_reason_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY referral_reason
    ADD CONSTRAINT referral_reason_pk PRIMARY KEY (id);


--
-- Name: referral_result_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY referral_result
    ADD CONSTRAINT referral_result_pk PRIMARY KEY (id);


--
-- Name: referral_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY referral_type
    ADD CONSTRAINT referral_type_pk PRIMARY KEY (id);


--
-- Name: region_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pk PRIMARY KEY (id);


--
-- Name: report_external_import_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY report_external_import
    ADD CONSTRAINT report_external_import_pk PRIMARY KEY (id);


--
-- Name: report_queue_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY report_external_export
    ADD CONSTRAINT report_queue_pk PRIMARY KEY (id);


--
-- Name: report_queue_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY report_queue_type
    ADD CONSTRAINT report_queue_type_pk PRIMARY KEY (id);


--
-- Name: requester_type_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY requester_type
    ADD CONSTRAINT requester_type_pk PRIMARY KEY (id);


--
-- Name: result_inventory_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY result_inventory
    ADD CONSTRAINT result_inventory_pk PRIMARY KEY (id);


--
-- Name: result_limits_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY result_limits
    ADD CONSTRAINT result_limits_pk PRIMARY KEY (id);


--
-- Name: result_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_pk PRIMARY KEY (id);


--
-- Name: result_signature_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY result_signature
    ADD CONSTRAINT result_signature_pk PRIMARY KEY (id);


--
-- Name: rt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY reference_tables
    ADD CONSTRAINT rt_pk PRIMARY KEY (id);


--
-- Name: samp_org_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_organization
    ADD CONSTRAINT samp_org_pk PRIMARY KEY (id);


--
-- Name: samp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT samp_pk PRIMARY KEY (id);


--
-- Name: sampitem_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_pk PRIMARY KEY (id);


--
-- Name: sample_human_samp_id_u; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_human
    ADD CONSTRAINT sample_human_samp_id_u UNIQUE (samp_id);


--
-- Name: sample_pdf_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_pdf
    ADD CONSTRAINT sample_pdf_pk PRIMARY KEY (id);


--
-- Name: sample_projects_pk_i; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_projects
    ADD CONSTRAINT sample_projects_pk_i PRIMARY KEY (id);


--
-- Name: sample_qaevent_action_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_qaevent_action
    ADD CONSTRAINT sample_qaevent_action_pkey PRIMARY KEY (id);


--
-- Name: sample_qaevent_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_qaevent
    ADD CONSTRAINT sample_qaevent_pkey PRIMARY KEY (id);


--
-- Name: sample_requester_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_requester
    ADD CONSTRAINT sample_requester_pk PRIMARY KEY (sample_id, requester_id, requester_type_id);


--
-- Name: sample_source_name_key; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_source
    ADD CONSTRAINT sample_source_name_key UNIQUE (name);


--
-- Name: sampledom_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sample_domain
    ADD CONSTRAINT sampledom_pk PRIMARY KEY (id);


--
-- Name: sampletype_panel_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sampletype_panel
    ADD CONSTRAINT sampletype_panel_pkey PRIMARY KEY (id);


--
-- Name: sampletype_test_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY sampletype_test
    ADD CONSTRAINT sampletype_test_pkey PRIMARY KEY (id);


--
-- Name: sci_name_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY animal_scientific_name
    ADD CONSTRAINT sci_name_pk PRIMARY KEY (id);


--
-- Name: scr_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY state_code
    ADD CONSTRAINT scr_pk PRIMARY KEY (id);


--
-- Name: scrip_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY scriptlet
    ADD CONSTRAINT scrip_pk PRIMARY KEY (id);


--
-- Name: site_info_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY site_information
    ADD CONSTRAINT site_info_pk PRIMARY KEY (id);


--
-- Name: site_information_domain_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY site_information_domain
    ADD CONSTRAINT site_information_domain_pk PRIMARY KEY (id);


--
-- Name: source_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY source_of_sample
    ADD CONSTRAINT source_pk PRIMARY KEY (id);


--
-- Name: storage_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY storage_location
    ADD CONSTRAINT storage_pk PRIMARY KEY (id);


--
-- Name: su_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY storage_unit
    ADD CONSTRAINT su_pk PRIMARY KEY (id);


--
-- Name: sys_c003998; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY action
    ADD CONSTRAINT sys_c003998 PRIMARY KEY (id);


--
-- Name: sys_c003999; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY action
    ADD CONSTRAINT sys_c003999 UNIQUE (code);


--
-- Name: sys_c004009; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY analysis_qaevent_action
    ADD CONSTRAINT sys_c004009 PRIMARY KEY (id);


--
-- Name: sys_c004307; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY status_of_sample
    ADD CONSTRAINT sys_c004307 PRIMARY KEY (id);


--
-- Name: sys_mod_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_module
    ADD CONSTRAINT sys_mod_pk PRIMARY KEY (id);


--
-- Name: sys_role_mo_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_role_module
    ADD CONSTRAINT sys_role_mo_pk PRIMARY KEY (id);


--
-- Name: sys_use_mo_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_user_module
    ADD CONSTRAINT sys_use_mo_pk PRIMARY KEY (id);


--
-- Name: sys_use_se_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_user_section
    ADD CONSTRAINT sys_use_se_pk PRIMARY KEY (id);


--
-- Name: sys_user_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT sys_user_pk PRIMARY KEY (id);


--
-- Name: sys_usr_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_user_role
    ADD CONSTRAINT sys_usr_pk PRIMARY KEY (system_user_id, role_id);


--
-- Name: system_role_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (id);


--
-- Name: test_analyte_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_analyte
    ADD CONSTRAINT test_analyte_pk PRIMARY KEY (id);


--
-- Name: test_hl7_code_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_code
    ADD CONSTRAINT test_hl7_code_pk PRIMARY KEY (test_id, code_type_id);


--
-- Name: test_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_pk PRIMARY KEY (id);


--
-- Name: test_reflx_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT test_reflx_pk PRIMARY KEY (id);


--
-- Name: test_sect_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_section
    ADD CONSTRAINT test_sect_pk PRIMARY KEY (id);


--
-- Name: testfrmt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_formats
    ADD CONSTRAINT testfrmt_pk PRIMARY KEY (id);


--
-- Name: tst_rslt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT tst_rslt_pk PRIMARY KEY (id);


--
-- Name: tsttrlr_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_trailer
    ADD CONSTRAINT tsttrlr_pk PRIMARY KEY (id);


--
-- Name: tw_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_worksheets
    ADD CONSTRAINT tw_pk PRIMARY KEY (id);


--
-- Name: twi_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY test_worksheet_item
    ADD CONSTRAINT twi_pk PRIMARY KEY (id);


--
-- Name: type_of_test_result_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY type_of_test_result
    ADD CONSTRAINT type_of_test_result_pk PRIMARY KEY (id);


--
-- Name: typeosamp_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY type_of_sample
    ADD CONSTRAINT typeosamp_pk PRIMARY KEY (id);


--
-- Name: typofprovider_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY type_of_provider
    ADD CONSTRAINT typofprovider_pk PRIMARY KEY (id);


--
-- Name: unique_ids; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY external_reference
    ADD CONSTRAINT unique_ids UNIQUE (item_id, type);


--
-- Name: unique_uuid_constraint; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT unique_uuid_constraint UNIQUE (uuid);


--
-- Name: uom_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY unit_of_measure
    ADD CONSTRAINT uom_pk PRIMARY KEY (id);


--
-- Name: user_alert_map_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY user_alert_map
    ADD CONSTRAINT user_alert_map_pkey PRIMARY KEY (user_id, map_id);


--
-- Name: user_group_map_pkey; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY user_group_map
    ADD CONSTRAINT user_group_map_pkey PRIMARY KEY (user_id, map_id);


--
-- Name: workst_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY worksheets
    ADD CONSTRAINT workst_pk PRIMARY KEY (id);


--
-- Name: wq_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY worksheet_qc
    ADD CONSTRAINT wq_pk PRIMARY KEY (id);


--
-- Name: wrkst_anls_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY worksheet_analysis
    ADD CONSTRAINT wrkst_anls_pk PRIMARY KEY (id);


--
-- Name: wrkst_anlt_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY worksheet_analyte
    ADD CONSTRAINT wrkst_anlt_pk PRIMARY KEY (id);


--
-- Name: wrkst_item_pk; Type: CONSTRAINT; Schema: clinlims; Owner: clinlims; Tablespace: 
--

ALTER TABLE ONLY worksheet_item
    ADD CONSTRAINT wrkst_item_pk PRIMARY KEY (id);


--
-- Name: accnum_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX accnum_uk ON sample USING btree (accession_number);


--
-- Name: ad_afield_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ad_afield_fk_i ON aux_data USING btree (aux_field_id);


--
-- Name: af_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX af_analyte_fk_i ON aux_field USING btree (analyte_id);


--
-- Name: af_script_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX af_script_fk_i ON aux_field USING btree (scriptlet_id);


--
-- Name: afv_afield_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX afv_afield_fk_i ON aux_field_values USING btree (aux_field_id);


--
-- Name: analysis_lastupdated_idx; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX analysis_lastupdated_idx ON analysis USING btree (lastupdated);


--
-- Name: analysis_sampitem_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX analysis_sampitem_fk_i ON analysis USING btree (sampitem_id);


--
-- Name: analysis_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX analysis_test_fk_i ON analysis USING btree (test_id);


--
-- Name: analysis_test_sect_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX analysis_test_sect_fk_i ON analysis USING btree (test_sect_id);


--
-- Name: analyte_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX analyte_analyte_fk_i ON analyte USING btree (analyte_id);


--
-- Name: ani_samp_comm_anim_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ani_samp_comm_anim_fk_i ON sample_animal USING btree (comm_anim_id);


--
-- Name: ani_samp_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ani_samp_samp_fk_i ON sample_animal USING btree (samp_id);


--
-- Name: ani_samp_sci_name_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ani_samp_sci_name_fk_i ON sample_animal USING btree (sci_name_id);


--
-- Name: anqaev_anal_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anqaev_anal_fk_i ON analysis_qaevent USING btree (analysis_id);


--
-- Name: anqaev_qa_event_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anqaev_qa_event_fk_i ON analysis_qaevent USING btree (qa_event_id);


--
-- Name: anst_anal_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anst_anal_fk_i ON analysis_storages USING btree (analysis_id);


--
-- Name: anstore_storage_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anstore_storage_fk_i ON analysis_storages USING btree (storage_id);


--
-- Name: anus_anal_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anus_anal_fk_i ON analysis_users USING btree (analysis_id);


--
-- Name: anus_sysuser_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX anus_sysuser_fk_i ON analysis_users USING btree (system_user_id);


--
-- Name: attachmtitem_attachmt_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX attachmtitem_attachmt_fk_i ON attachment_item USING btree (attachment_id);


--
-- Name: env_samp_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX env_samp_samp_fk_i ON sample_environmental USING btree (samp_id);


--
-- Name: event_records_category_idx; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX event_records_category_idx ON event_records USING btree (category);


--
-- Name: hist_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX hist_sys_user_fk_i ON history USING btree (sys_user_id);


--
-- Name: hist_table_row_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX hist_table_row_i ON history USING btree (reference_id, reference_table);


--
-- Name: hum_pat_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX hum_pat_fk_i ON sample_human USING btree (patient_id);


--
-- Name: hum_provider_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX hum_provider_fk_i ON sample_human USING btree (provider_id);


--
-- Name: hum_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX hum_samp_fk_i ON sample_human USING btree (samp_id);


--
-- Name: ia_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ia_analyte_fk_i ON instrument_analyte USING btree (analyte_id);


--
-- Name: ia_instru_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ia_instru_fk_i ON instrument_analyte USING btree (instru_id);


--
-- Name: ia_method_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ia_method_fk_i ON instrument_analyte USING btree (method_id);


--
-- Name: il_instru_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX il_instru_fk_i ON instrument_log USING btree (instru_id);


--
-- Name: il_inv_item_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX il_inv_item_fk_i ON inventory_location USING btree (inv_item_id);


--
-- Name: instru_scrip_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX instru_scrip_fk_i ON instrument USING btree (scrip_id);


--
-- Name: inv_recpt_invitem_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX inv_recpt_invitem_fk_i ON inventory_receipt USING btree (invitem_id);


--
-- Name: invcomp_invitem_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX invcomp_invitem_fk_i ON inventory_component USING btree (invitem_id);


--
-- Name: invcomp_matcomp_fk_ii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX invcomp_matcomp_fk_ii ON inventory_component USING btree (material_component_id);


--
-- Name: invitem_invname_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX invitem_invname_uk ON inventory_item USING btree (name);


--
-- Name: invitem_uom_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX invitem_uom_fk_i ON inventory_item USING btree (uom_id);


--
-- Name: invloc_storage_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX invloc_storage_fk_i ON inventory_location USING btree (storage_id);


--
-- Name: invrec_org_fk_ii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX invrec_org_fk_ii ON inventory_receipt USING btree (org_id);


--
-- Name: label_script_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX label_script_fk_i ON label USING btree (scriptlet_id);


--
-- Name: ma_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ma_analyte_fk_i ON method_analyte USING btree (analyte_id);


--
-- Name: ma_method_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ma_method_fk_i ON method_analyte USING btree (method_id);


--
-- Name: methres_method_fk_iii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX methres_method_fk_iii ON method_result USING btree (method_id);


--
-- Name: methres_scrip_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX methres_scrip_fk_i ON method_result USING btree (scrip_id);


--
-- Name: mls_lab_tp_org_mlt_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX mls_lab_tp_org_mlt_fk_i ON mls_lab_type USING btree (org_mlt_org_mlt_id);


--
-- Name: note_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX note_sys_user_fk_i ON note USING btree (sys_user_id);


--
-- Name: obs_history_sample_idx; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX obs_history_sample_idx ON observation_history USING btree (sample_id);


--
-- Name: ord_org_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ord_org_fk_i ON orders USING btree (org_id);


--
-- Name: ord_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX ord_sys_user_fk_i ON orders USING btree (sys_user_id);


--
-- Name: orditem_inv_loc_fk_iii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX orditem_inv_loc_fk_iii ON order_item USING btree (inv_loc_id);


--
-- Name: orditem_ord_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX orditem_ord_fk_i ON order_item USING btree (ord_id);


--
-- Name: org_org_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX org_org_fk_i ON organization USING btree (org_id);


--
-- Name: org_org_mlt_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX org_org_mlt_fk_i ON organization USING btree (org_mlt_org_mlt_id);


--
-- Name: pan_it_panel_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX pan_it_panel_fk_i ON panel_item USING btree (panel_id);


--
-- Name: pat_person_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX pat_person_fk_i ON patient USING btree (person_id);


--
-- Name: patient_identity_patient_id_idx; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX patient_identity_patient_id_idx ON patient_identity USING btree (patient_id);


--
-- Name: pr_pat_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX pr_pat_fk_i ON patient_relations USING btree (pat_id);


--
-- Name: pr_pat_source_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX pr_pat_source_fk_i ON patient_relations USING btree (pat_id_source);


--
-- Name: proj_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX proj_sys_user_fk_i ON project USING btree (sys_user_id);


--
-- Name: project_script_fk_iii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX project_script_fk_iii ON project USING btree (scriptlet_id);


--
-- Name: projectparam_proj_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX projectparam_proj_fk_i ON project_parameter USING btree (project_id);


--
-- Name: provider_person_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX provider_person_fk_i ON provider USING btree (person_id);


--
-- Name: qaev_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX qaev_test_fk_i ON qa_event USING btree (test_id);


--
-- Name: qc_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX qc_sys_user_fk_i ON qc USING btree (sys_user_id);


--
-- Name: qc_uom_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX qc_uom_fk_i ON qc USING btree (uom_id);


--
-- Name: qcanlyt_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX qcanlyt_analyte_fk_i ON qc_analytes USING btree (analyte_id);


--
-- Name: report_import_date; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX report_import_date ON report_external_import USING btree (event_date);


--
-- Name: report_queue_date; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX report_queue_date ON report_external_export USING btree (event_date);


--
-- Name: result_analysis_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX result_analysis_fk_i ON result USING btree (analysis_id);


--
-- Name: result_analyte_fk_iii; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX result_analyte_fk_iii ON result USING btree (analyte_id);


--
-- Name: result_testresult_fk_1; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX result_testresult_fk_1 ON result USING btree (test_result_id);


--
-- Name: samp_org_org_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX samp_org_org_fk_i ON sample_organization USING btree (org_id);


--
-- Name: samp_org_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX samp_org_samp_fk_i ON sample_organization USING btree (samp_id);


--
-- Name: samp_package_1_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX samp_package_1_fk_i ON sample USING btree (package_id);


--
-- Name: samp_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX samp_sys_user_fk_i ON sample USING btree (sys_user_id);


--
-- Name: sampitem_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sampitem_samp_fk_i ON sample_item USING btree (samp_id);


--
-- Name: sampitem_samp_item_uk_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX sampitem_samp_item_uk_uk ON sample_item USING btree (id, sort_order);


--
-- Name: sampitem_sampitem_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sampitem_sampitem_fk_i ON sample_item USING btree (sampitem_id);


--
-- Name: sampitem_source_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sampitem_source_fk_i ON sample_item USING btree (source_id);


--
-- Name: sampitem_typeosamp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sampitem_typeosamp_fk_i ON sample_item USING btree (typeosamp_id);


--
-- Name: sampitem_uom_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sampitem_uom_fk_i ON sample_item USING btree (uom_id);


--
-- Name: sample_lastupdated_idx; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sample_lastupdated_idx ON sample USING btree (lastupdated);


--
-- Name: sample_projects_pk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX sample_projects_pk ON sample_projects USING btree (id);


--
-- Name: sampledom_dom_uk_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX sampledom_dom_uk_uk ON sample_domain USING btree (domain);


--
-- Name: sci_name_comm_anim_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sci_name_comm_anim_fk_i ON animal_scientific_name USING btree (comm_anim_id);


--
-- Name: source_dom_desc_uk_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX source_dom_desc_uk_uk ON source_of_sample USING btree (description, domain);


--
-- Name: sp_proj_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sp_proj_fk_i ON sample_projects USING btree (proj_id);


--
-- Name: sp_samp_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sp_samp_fk_i ON sample_projects USING btree (samp_id);


--
-- Name: storloc_parent_storloc_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX storloc_parent_storloc_fk_i ON storage_location USING btree (parent_storageloc_id);


--
-- Name: storloc_storunit_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX storloc_storunit_fk_i ON storage_location USING btree (storage_unit_id);


--
-- Name: sysrolemodule_sysmodule_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysrolemodule_sysmodule_fk_i ON system_role_module USING btree (system_module_id);


--
-- Name: sysrolemodule_sysuser_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysrolemodule_sysuser_fk_i ON system_role_module USING btree (system_role_id);


--
-- Name: sysusermodule_sysmodule_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysusermodule_sysmodule_fk_i ON system_user_module USING btree (system_module_id);


--
-- Name: sysusermodule_sysuser_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysusermodule_sysuser_fk_i ON system_user_module USING btree (system_user_id);


--
-- Name: sysusersect_sysuser_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysusersect_sysuser_fk_i ON system_user_section USING btree (system_user_id);


--
-- Name: sysusersect_testsect_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX sysusersect_testsect_fk_i ON system_user_section USING btree (test_section_id);


--
-- Name: test_desc_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX test_desc_uk ON test USING btree (description);


--
-- Name: test_label_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_label_fk_i ON test USING btree (label_id);


--
-- Name: test_method_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_method_fk_i ON test USING btree (method_id);


--
-- Name: test_reflx_tst_rslt_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_reflx_tst_rslt_fk_i ON test_reflex USING btree (tst_rslt_id);


--
-- Name: test_scriptlet_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_scriptlet_fk_i ON test USING btree (scriptlet_id);


--
-- Name: test_sect_org_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_sect_org_fk_i ON test_section USING btree (org_id);


--
-- Name: test_testformat_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_testformat_fk_i ON test USING btree (test_format_id);


--
-- Name: test_testsect_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_testsect_fk_i ON test USING btree (test_section_id);


--
-- Name: test_testtrailer_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_testtrailer_fk_i ON test USING btree (test_trailer_id);


--
-- Name: test_uom_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX test_uom_fk_i ON test USING btree (uom_id);


--
-- Name: testalyt_analyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testalyt_analyte_fk_i ON test_analyte USING btree (analyte_id);


--
-- Name: testalyt_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testalyt_test_fk_i ON test_analyte USING btree (test_id);


--
-- Name: testreflex_addtest_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testreflex_addtest_fk_i ON test_reflex USING btree (add_test_id);


--
-- Name: testreflex_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testreflex_test_fk_i ON test_reflex USING btree (test_id);


--
-- Name: testreflex_testanalyt_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testreflex_testanalyt_fk_i ON test_reflex USING btree (test_analyte_id);


--
-- Name: testresult_scriptlet_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX testresult_scriptlet_fk_i ON test_result USING btree (scriptlet_id);


--
-- Name: tst_rslt_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX tst_rslt_test_fk_i ON test_result USING btree (test_id);


--
-- Name: tw_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX tw_test_fk_i ON test_worksheets USING btree (test_id);


--
-- Name: twi_qc_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX twi_qc_fk_i ON test_worksheet_item USING btree (qc_id);


--
-- Name: twi_tw_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX twi_tw_fk_i ON test_worksheet_item USING btree (tw_id);


--
-- Name: typeosamp_dom_desc_uk_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX typeosamp_dom_desc_uk_uk ON type_of_sample USING btree (description, domain);


--
-- Name: typofprov_desc_uk_uk; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE UNIQUE INDEX typofprov_desc_uk_uk ON type_of_provider USING btree (description);


--
-- Name: wkshtanalysis_wkshtitem_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wkshtanalysis_wkshtitem_fk_i ON worksheet_analysis USING btree (worksheet_item_id);


--
-- Name: wkshtanalyte_result_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wkshtanalyte_result_fk_i ON worksheet_analyte USING btree (result_id);


--
-- Name: wkshtitem_wksht_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wkshtitem_wksht_fk_i ON worksheet_item USING btree (worksheet_id);


--
-- Name: wkshtqc_qcanalyte_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wkshtqc_qcanalyte_fk_i ON worksheet_qc USING btree (qc_analyte_id);


--
-- Name: wkshtqc_wkshtanalysis_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wkshtqc_wkshtanalysis_fk_i ON worksheet_qc USING btree (worksheet_analysis_id);


--
-- Name: workst_sys_user_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX workst_sys_user_fk_i ON worksheets USING btree (sys_user_id);


--
-- Name: workst_test_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX workst_test_fk_i ON worksheets USING btree (test_id);


--
-- Name: wrkst_anlt_wrkst_anls_fk_i; Type: INDEX; Schema: clinlims; Owner: clinlims; Tablespace: 
--

CREATE INDEX wrkst_anlt_wrkst_anls_fk_i ON worksheet_analyte USING btree (wrkst_anls_id);


--
-- Name: ad_afield_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY aux_data
    ADD CONSTRAINT ad_afield_fk FOREIGN KEY (aux_field_id) REFERENCES aux_field(id) MATCH FULL;


--
-- Name: af_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY aux_field
    ADD CONSTRAINT af_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: af_script_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY aux_field
    ADD CONSTRAINT af_script_fk FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: afv_afield_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY aux_field_values
    ADD CONSTRAINT afv_afield_fk FOREIGN KEY (aux_field_id) REFERENCES aux_field(id) MATCH FULL;


--
-- Name: analysis_panel_FK; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT "analysis_panel_FK" FOREIGN KEY (panel_id) REFERENCES panel(id) ON DELETE SET NULL;


--
-- Name: analysis_parent_analysis_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_parent_analysis_fk FOREIGN KEY (parent_analysis_id) REFERENCES analysis(id) MATCH FULL;


--
-- Name: analysis_parent_result_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_parent_result_fk FOREIGN KEY (parent_result_id) REFERENCES result(id) MATCH FULL;


--
-- Name: analysis_sampitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_sampitem_fk FOREIGN KEY (sampitem_id) REFERENCES sample_item(id) MATCH FULL;


--
-- Name: analysis_status_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_status_fk FOREIGN KEY (status_id) REFERENCES status_of_sample(id);


--
-- Name: analysis_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: analysis_test_sect_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT analysis_test_sect_fk FOREIGN KEY (test_sect_id) REFERENCES test_section(id) MATCH FULL;


--
-- Name: analyte_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyte
    ADD CONSTRAINT analyte_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: analyzer_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyzer_results
    ADD CONSTRAINT analyzer_fk FOREIGN KEY (analyzer_id) REFERENCES analyzer(id);


--
-- Name: analyzer_results_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyzer_results
    ADD CONSTRAINT analyzer_results_test_fk FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: analyzer_test_map_analyzer_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyzer_test_map
    ADD CONSTRAINT analyzer_test_map_analyzer_fk FOREIGN KEY (analyzer_id) REFERENCES analyzer(id);


--
-- Name: analyzer_test_map_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyzer_test_map
    ADD CONSTRAINT analyzer_test_map_test_fk FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: ani_samp_comm_anim_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_animal
    ADD CONSTRAINT ani_samp_comm_anim_fk FOREIGN KEY (comm_anim_id) REFERENCES animal_common_name(id) MATCH FULL;


--
-- Name: ani_samp_samp_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_animal
    ADD CONSTRAINT ani_samp_samp_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: ani_samp_sci_name_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_animal
    ADD CONSTRAINT ani_samp_sci_name_fk FOREIGN KEY (sci_name_id) REFERENCES animal_scientific_name(id) MATCH FULL;


--
-- Name: anqaev_anal_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_qaevent
    ADD CONSTRAINT anqaev_anal_fk FOREIGN KEY (analysis_id) REFERENCES analysis(id) MATCH FULL;


--
-- Name: anqaev_qa_event_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_qaevent
    ADD CONSTRAINT anqaev_qa_event_fk FOREIGN KEY (qa_event_id) REFERENCES qa_event(id) MATCH FULL;


--
-- Name: anst_anal_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_storages
    ADD CONSTRAINT anst_anal_fk FOREIGN KEY (analysis_id) REFERENCES analysis(id) MATCH FULL;


--
-- Name: anstore_storage_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_storages
    ADD CONSTRAINT anstore_storage_fk FOREIGN KEY (storage_id) REFERENCES storage_location(id) MATCH FULL;


--
-- Name: anus_anal_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_users
    ADD CONSTRAINT anus_anal_fk FOREIGN KEY (analysis_id) REFERENCES analysis(id) MATCH FULL;


--
-- Name: anus_sysuser_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analysis_users
    ADD CONSTRAINT anus_sysuser_fk FOREIGN KEY (system_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: attachmtitem_attachmt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY attachment_item
    ADD CONSTRAINT attachmtitem_attachmt_fk FOREIGN KEY (attachment_id) REFERENCES attachment(id) MATCH FULL;


--
-- Name: cd_elmt_xref_cd_elmt_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY code_element_xref
    ADD CONSTRAINT cd_elmt_xref_cd_elmt_type_fk FOREIGN KEY (code_element_type_id) REFERENCES code_element_type(id) MATCH FULL;


--
-- Name: cd_elmt_xref_message_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY code_element_xref
    ADD CONSTRAINT cd_elmt_xref_message_org_fk FOREIGN KEY (message_org_id) REFERENCES message_org(id) MATCH FULL;


--
-- Name: cd_elmt_xref_rcvr_cd_elmt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY code_element_xref
    ADD CONSTRAINT cd_elmt_xref_rcvr_cd_elmt_fk FOREIGN KEY (receiver_code_element_id) REFERENCES receiver_code_element(id) MATCH FULL;


--
-- Name: demographics_history_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY observation_history
    ADD CONSTRAINT demographics_history_type_fk FOREIGN KEY (observation_history_type_id) REFERENCES observation_history_type(id);


--
-- Name: dictionary_dict_cat_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY dictionary
    ADD CONSTRAINT dictionary_dict_cat_fk FOREIGN KEY (dictionary_category_id) REFERENCES dictionary_category(id) MATCH FULL;


--
-- Name: env_samp_samp_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_environmental
    ADD CONSTRAINT env_samp_samp_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: fk_doc_parent_id; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY document_track
    ADD CONSTRAINT fk_doc_parent_id FOREIGN KEY (parent_id) REFERENCES document_track(id);


--
-- Name: fk_doc_type; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY document_track
    ADD CONSTRAINT fk_doc_type FOREIGN KEY (document_type_id) REFERENCES document_type(id);


--
-- Name: fk_sample_sample_source; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT fk_sample_sample_source FOREIGN KEY (sample_source_id) REFERENCES sample_source(id) ON UPDATE RESTRICT;


--
-- Name: fk_sibling_reflex; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT fk_sibling_reflex FOREIGN KEY (sibling_reflex) REFERENCES test_reflex(id) ON DELETE CASCADE;


--
-- Name: fk_table_id; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY document_track
    ADD CONSTRAINT fk_table_id FOREIGN KEY (table_id) REFERENCES reference_tables(id);


--
-- Name: history_sysuer_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_sysuer_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: ia_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY instrument_analyte
    ADD CONSTRAINT ia_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: ia_instru_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY instrument_analyte
    ADD CONSTRAINT ia_instru_fk FOREIGN KEY (instru_id) REFERENCES instrument(id) MATCH FULL;


--
-- Name: ia_method_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY instrument_analyte
    ADD CONSTRAINT ia_method_fk FOREIGN KEY (method_id) REFERENCES method(id) MATCH FULL;


--
-- Name: identity_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_identity
    ADD CONSTRAINT identity_type_fk FOREIGN KEY (identity_type_id) REFERENCES patient_identity_type(id);


--
-- Name: il_instru_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY instrument_log
    ADD CONSTRAINT il_instru_fk FOREIGN KEY (instru_id) REFERENCES instrument(id) MATCH FULL;


--
-- Name: il_inv_item_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_location
    ADD CONSTRAINT il_inv_item_fk FOREIGN KEY (inv_item_id) REFERENCES inventory_item(id) MATCH FULL;


--
-- Name: inv_recpt_invitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_receipt
    ADD CONSTRAINT inv_recpt_invitem_fk FOREIGN KEY (invitem_id) REFERENCES inventory_item(id) MATCH FULL;


--
-- Name: invcomp_invitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_component
    ADD CONSTRAINT invcomp_invitem_fk FOREIGN KEY (invitem_id) REFERENCES inventory_item(id) MATCH FULL;


--
-- Name: invcomp_matcomp_fk_iii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_component
    ADD CONSTRAINT invcomp_matcomp_fk_iii FOREIGN KEY (material_component_id) REFERENCES inventory_item(id) MATCH FULL;


--
-- Name: inventory__location_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_inventory
    ADD CONSTRAINT inventory__location_fk FOREIGN KEY (inventory_location_id) REFERENCES inventory_location(id);


--
-- Name: invitem_uom_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_item
    ADD CONSTRAINT invitem_uom_fk FOREIGN KEY (uom_id) REFERENCES unit_of_measure(id) MATCH FULL;


--
-- Name: invloc_storage_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_location
    ADD CONSTRAINT invloc_storage_fk FOREIGN KEY (storage_id) REFERENCES storage_location(id) MATCH FULL;


--
-- Name: invrec_org_fk_iii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY inventory_receipt
    ADD CONSTRAINT invrec_org_fk_iii FOREIGN KEY (org_id) REFERENCES organization(id) MATCH FULL;


--
-- Name: lab_order_item_table_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY lab_order_item
    ADD CONSTRAINT lab_order_item_table_fk FOREIGN KEY (table_ref) REFERENCES reference_tables(id);


--
-- Name: lab_order_item_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY lab_order_item
    ADD CONSTRAINT lab_order_item_type_fk FOREIGN KEY (lab_order_type_id) REFERENCES lab_order_type(id);


--
-- Name: label_script_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_script_fk FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: ma_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY method_analyte
    ADD CONSTRAINT ma_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: ma_method_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY method_analyte
    ADD CONSTRAINT ma_method_fk FOREIGN KEY (method_id) REFERENCES method(id) MATCH FULL;


--
-- Name: menu_parent_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_parent_fk FOREIGN KEY (parent_id) REFERENCES menu(id);


--
-- Name: methres_method_fk_ii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY method_result
    ADD CONSTRAINT methres_method_fk_ii FOREIGN KEY (method_id) REFERENCES method(id) MATCH FULL;


--
-- Name: methres_scrip_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY method_result
    ADD CONSTRAINT methres_scrip_fk FOREIGN KEY (scrip_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: mls_lab_tp_org_mlt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY mls_lab_type
    ADD CONSTRAINT mls_lab_tp_org_mlt_fk FOREIGN KEY (org_mlt_org_mlt_id) REFERENCES org_mls_lab_type(org_mlt_id) MATCH FULL;


--
-- Name: note_sys_user_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_sys_user_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: ord_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT ord_org_fk FOREIGN KEY (org_id) REFERENCES organization(id) MATCH FULL;


--
-- Name: ord_sys_user_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT ord_sys_user_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: orditem_inv_loc_fk_ii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY order_item
    ADD CONSTRAINT orditem_inv_loc_fk_ii FOREIGN KEY (inv_loc_id) REFERENCES inventory_location(id) MATCH FULL;


--
-- Name: orditem_ord_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY order_item
    ADD CONSTRAINT orditem_ord_fk FOREIGN KEY (ord_id) REFERENCES orders(id) MATCH FULL;


--
-- Name: org_contact_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT org_contact_org_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: org_contact_person_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT org_contact_person_fk FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: org_hl7_encoding_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY org_hl7_encoding_type
    ADD CONSTRAINT org_hl7_encoding_id_fk FOREIGN KEY (encoding_type_id) REFERENCES test_code_type(id);


--
-- Name: org_hl7_org_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY org_hl7_encoding_type
    ADD CONSTRAINT org_hl7_org_id_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: org_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT org_org_fk FOREIGN KEY (org_id) REFERENCES organization(id) MATCH FULL;


--
-- Name: org_org_mlt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT org_org_mlt_fk FOREIGN KEY (org_mlt_org_mlt_id) REFERENCES org_mls_lab_type(org_mlt_id) MATCH FULL;


--
-- Name: organization_address_address_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT organization_address_address_fk FOREIGN KEY (address_part_id) REFERENCES address_part(id);


--
-- Name: organization_address_organization_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT organization_address_organization_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: organization_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY project_organization
    ADD CONSTRAINT organization_fk FOREIGN KEY (org_id) REFERENCES organization(id);


--
-- Name: organization_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_organization_type
    ADD CONSTRAINT organization_fk FOREIGN KEY (org_id) REFERENCES organization(id) ON DELETE CASCADE;


--
-- Name: organization_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY organization_organization_type
    ADD CONSTRAINT organization_type_fk FOREIGN KEY (org_type_id) REFERENCES organization_type(id);


--
-- Name: pan_it_panel_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY panel_item
    ADD CONSTRAINT pan_it_panel_fk FOREIGN KEY (panel_id) REFERENCES panel(id) MATCH FULL;


--
-- Name: parent_test_sec_test_sect_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_section
    ADD CONSTRAINT parent_test_sec_test_sect_fk FOREIGN KEY (parent_test_section) REFERENCES test_section(id) MATCH FULL;


--
-- Name: pat_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_occupation
    ADD CONSTRAINT pat_id_fk FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- Name: pat_person_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT pat_person_fk FOREIGN KEY (person_id) REFERENCES person(id) MATCH FULL;


--
-- Name: patient_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_identity
    ADD CONSTRAINT patient_fk FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- Name: patient_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_patient_type
    ADD CONSTRAINT patient_fk FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- Name: patient_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY observation_history
    ADD CONSTRAINT patient_fk FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- Name: patient_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_patient_type
    ADD CONSTRAINT patient_type_fk FOREIGN KEY (patient_type_id) REFERENCES patient_type(id);


--
-- Name: person_address_address_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT person_address_address_fk FOREIGN KEY (address_part_id) REFERENCES address_part(id);


--
-- Name: person_address_person_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT person_address_person_fk FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: pr_pat_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_relations
    ADD CONSTRAINT pr_pat_fk FOREIGN KEY (pat_id) REFERENCES patient(id) MATCH FULL;


--
-- Name: pr_pat_source_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY patient_relations
    ADD CONSTRAINT pr_pat_source_fk FOREIGN KEY (pat_id_source) REFERENCES patient(id) MATCH FULL;


--
-- Name: project_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY project_organization
    ADD CONSTRAINT project_fk FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_script_fk_ii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_script_fk_ii FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: project_sysuer_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_sysuer_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: projectparam_proj_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY project_parameter
    ADD CONSTRAINT projectparam_proj_fk FOREIGN KEY (project_id) REFERENCES project(id) MATCH FULL;


--
-- Name: prov_person_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY provider
    ADD CONSTRAINT prov_person_fk FOREIGN KEY (person_id) REFERENCES person(id) MATCH FULL;


--
-- Name: qa_observation_type_k; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qa_observation
    ADD CONSTRAINT qa_observation_type_k FOREIGN KEY (qa_observation_type_id) REFERENCES qa_observation_type(id);


--
-- Name: qaev_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qa_event
    ADD CONSTRAINT qaev_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: qc_sys_user_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qc
    ADD CONSTRAINT qc_sys_user_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: qc_uom_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qc
    ADD CONSTRAINT qc_uom_fk FOREIGN KEY (uom_id) REFERENCES unit_of_measure(id) MATCH FULL;


--
-- Name: qcanlyt_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qc_analytes
    ADD CONSTRAINT qcanlyt_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: qrtz_blob_triggers_trigger_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_trigger_name_fkey FOREIGN KEY (trigger_name, trigger_group) REFERENCES qrtz_triggers(trigger_name, trigger_group);


--
-- Name: qrtz_cron_triggers_trigger_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_trigger_name_fkey FOREIGN KEY (trigger_name, trigger_group) REFERENCES qrtz_triggers(trigger_name, trigger_group);


--
-- Name: qrtz_job_listeners_job_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_job_listeners
    ADD CONSTRAINT qrtz_job_listeners_job_name_fkey FOREIGN KEY (job_name, job_group) REFERENCES qrtz_job_details(job_name, job_group);


--
-- Name: qrtz_simple_triggers_trigger_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_trigger_name_fkey FOREIGN KEY (trigger_name, trigger_group) REFERENCES qrtz_triggers(trigger_name, trigger_group);


--
-- Name: qrtz_trigger_listeners_trigger_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_trigger_listeners
    ADD CONSTRAINT qrtz_trigger_listeners_trigger_name_fkey FOREIGN KEY (trigger_name, trigger_group) REFERENCES qrtz_triggers(trigger_name, trigger_group);


--
-- Name: qrtz_triggers_job_name_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_job_name_fkey FOREIGN KEY (job_name, job_group) REFERENCES qrtz_job_details(job_name, job_group);


--
-- Name: receiver_code_code_element_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY receiver_code_element
    ADD CONSTRAINT receiver_code_code_element_fk FOREIGN KEY (code_element_type_id) REFERENCES code_element_type(id) MATCH FULL;


--
-- Name: receiver_code_message_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY receiver_code_element
    ADD CONSTRAINT receiver_code_message_org_fk FOREIGN KEY (message_org_id) REFERENCES message_org(id) MATCH FULL;


--
-- Name: referral_analysis_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral
    ADD CONSTRAINT referral_analysis_fk FOREIGN KEY (analysis_id) REFERENCES analysis(id);


--
-- Name: referral_organization_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral
    ADD CONSTRAINT referral_organization_fk FOREIGN KEY (organization_id) REFERENCES organization(id) ON DELETE CASCADE;


--
-- Name: referral_reason_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral
    ADD CONSTRAINT referral_reason_fk FOREIGN KEY (referral_reason_id) REFERENCES referral_reason(id);


--
-- Name: referral_result_referral_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral_result
    ADD CONSTRAINT referral_result_referral_fk FOREIGN KEY (referral_id) REFERENCES referral(id) ON DELETE CASCADE;


--
-- Name: referral_result_result; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral_result
    ADD CONSTRAINT referral_result_result FOREIGN KEY (result_id) REFERENCES result(id);


--
-- Name: referral_result_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral_result
    ADD CONSTRAINT referral_result_test_fk FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: referral_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY referral
    ADD CONSTRAINT referral_type_fk FOREIGN KEY (referral_type_id) REFERENCES referral_type(id);


--
-- Name: report_queue_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY report_external_export
    ADD CONSTRAINT report_queue_type_fk FOREIGN KEY (type) REFERENCES report_queue_type(id);


--
-- Name: requester_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_requester
    ADD CONSTRAINT requester_type_fk FOREIGN KEY (requester_type_id) REFERENCES requester_type(id);


--
-- Name: result_analysis_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_analysis_fk FOREIGN KEY (analysis_id) REFERENCES analysis(id) MATCH FULL;


--
-- Name: result_analyte_fk_ii; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_analyte_fk_ii FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: result_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_inventory
    ADD CONSTRAINT result_fk FOREIGN KEY (result_id) REFERENCES result(id);


--
-- Name: result_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_signature
    ADD CONSTRAINT result_id_fk FOREIGN KEY (result_id) REFERENCES result(id);


--
-- Name: result_parent_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_parent_id_fk FOREIGN KEY (parent_id) REFERENCES result(id) ON DELETE CASCADE;


--
-- Name: result_testresult_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_testresult_fk FOREIGN KEY (test_result_id) REFERENCES test_result(id) MATCH FULL;


--
-- Name: role_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_role
    ADD CONSTRAINT role_fk FOREIGN KEY (role_id) REFERENCES system_role(id) ON DELETE CASCADE;


--
-- Name: role_parent_role_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT role_parent_role_fk FOREIGN KEY (grouping_parent) REFERENCES system_role(id);


--
-- Name: samp_org_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_organization
    ADD CONSTRAINT samp_org_org_fk FOREIGN KEY (org_id) REFERENCES organization(id) MATCH FULL;


--
-- Name: samp_org_samp_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_organization
    ADD CONSTRAINT samp_org_samp_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: samphuman_patient_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_human
    ADD CONSTRAINT samphuman_patient_fk FOREIGN KEY (patient_id) REFERENCES patient(id) MATCH FULL;


--
-- Name: samphuman_provider_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_human
    ADD CONSTRAINT samphuman_provider_fk FOREIGN KEY (provider_id) REFERENCES provider(id) MATCH FULL;


--
-- Name: samphuman_sample_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_human
    ADD CONSTRAINT samphuman_sample_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: sampitem_sampitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_sampitem_fk FOREIGN KEY (sampitem_id) REFERENCES sample_item(id) MATCH FULL;


--
-- Name: sampitem_sample_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_sample_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: sampitem_sourceosamp_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_sourceosamp_fk FOREIGN KEY (source_id) REFERENCES source_of_sample(id) MATCH FULL;


--
-- Name: sampitem_typeosamp_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_typeosamp_fk FOREIGN KEY (typeosamp_id) REFERENCES type_of_sample(id) MATCH FULL;


--
-- Name: sampitem_uom_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_item
    ADD CONSTRAINT sampitem_uom_fk FOREIGN KEY (uom_id) REFERENCES unit_of_measure(id) MATCH FULL;


--
-- Name: sample_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY observation_history
    ADD CONSTRAINT sample_fk FOREIGN KEY (sample_id) REFERENCES sample(id);


--
-- Name: sample_package_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_package_fk FOREIGN KEY (package_id) REFERENCES package_1(id) MATCH FULL;


--
-- Name: sample_qaevent_sampleitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_qaevent
    ADD CONSTRAINT sample_qaevent_sampleitem_fk FOREIGN KEY (sampleitem_id) REFERENCES sample_item(id);


--
-- Name: sample_status_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_status_fk FOREIGN KEY (status_id) REFERENCES status_of_sample(id);


--
-- Name: sample_sysuser_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_sysuser_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: sampletype_panel_panel_id_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sampletype_panel
    ADD CONSTRAINT sampletype_panel_panel_id_fkey FOREIGN KEY (panel_id) REFERENCES panel(id);


--
-- Name: sampletype_panel_sample_type_id_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sampletype_panel
    ADD CONSTRAINT sampletype_panel_sample_type_id_fkey FOREIGN KEY (sample_type_id) REFERENCES type_of_sample(id);


--
-- Name: sampletype_test_sample_type_id_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sampletype_test
    ADD CONSTRAINT sampletype_test_sample_type_id_fkey FOREIGN KEY (sample_type_id) REFERENCES type_of_sample(id);


--
-- Name: sampletype_test_test_id_fkey; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sampletype_test
    ADD CONSTRAINT sampletype_test_test_id_fkey FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: sampnewborn_sample_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_newborn
    ADD CONSTRAINT sampnewborn_sample_fk FOREIGN KEY (id) REFERENCES sample_human(id);


--
-- Name: sampproj_project_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_projects
    ADD CONSTRAINT sampproj_project_fk FOREIGN KEY (proj_id) REFERENCES project(id) MATCH FULL;


--
-- Name: sampproj_sample_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY sample_projects
    ADD CONSTRAINT sampproj_sample_fk FOREIGN KEY (samp_id) REFERENCES sample(id) MATCH FULL;


--
-- Name: sci_name_comm_anim_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY animal_scientific_name
    ADD CONSTRAINT sci_name_comm_anim_fk FOREIGN KEY (comm_anim_id) REFERENCES animal_common_name(id) MATCH FULL;


--
-- Name: status_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY analyzer_results
    ADD CONSTRAINT status_fk FOREIGN KEY (status_id) REFERENCES analyzer_result_status(id);


--
-- Name: storloc_parent_storloc_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY storage_location
    ADD CONSTRAINT storloc_parent_storloc_fk FOREIGN KEY (parent_storageloc_id) REFERENCES storage_location(id) MATCH FULL;


--
-- Name: storloc_storunit_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY storage_location
    ADD CONSTRAINT storloc_storunit_fk FOREIGN KEY (storage_unit_id) REFERENCES storage_unit(id) MATCH FULL;


--
-- Name: sysrolemodule_sysmodule_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_role_module
    ADD CONSTRAINT sysrolemodule_sysmodule_fk FOREIGN KEY (system_module_id) REFERENCES system_module(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: sysrolemodule_sysrole_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_role_module
    ADD CONSTRAINT sysrolemodule_sysrole_fk FOREIGN KEY (system_role_id) REFERENCES system_role(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: system_user_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_role
    ADD CONSTRAINT system_user_fk FOREIGN KEY (system_user_id) REFERENCES system_user(id) ON DELETE CASCADE;


--
-- Name: system_user_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_signature
    ADD CONSTRAINT system_user_id_fk FOREIGN KEY (system_user_id) REFERENCES system_user(id);


--
-- Name: sysusermodule_sysmodule_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_module
    ADD CONSTRAINT sysusermodule_sysmodule_fk FOREIGN KEY (system_module_id) REFERENCES system_module(id) MATCH FULL;


--
-- Name: sysusermodule_sysuser_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_module
    ADD CONSTRAINT sysusermodule_sysuser_fk FOREIGN KEY (system_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: sysusersect_sysuser_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_section
    ADD CONSTRAINT sysusersect_sysuser_fk FOREIGN KEY (system_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: sysusersect_testsect_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY system_user_section
    ADD CONSTRAINT sysusersect_testsect_fk FOREIGN KEY (test_section_id) REFERENCES test_section(id) MATCH FULL;


--
-- Name: test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_limits
    ADD CONSTRAINT test_fk FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: test_hl7_encoding_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_code
    ADD CONSTRAINT test_hl7_encoding_id_fk FOREIGN KEY (code_type_id) REFERENCES test_code_type(id);


--
-- Name: test_hl7_test_id_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_code
    ADD CONSTRAINT test_hl7_test_id_fk FOREIGN KEY (test_id) REFERENCES test(id);


--
-- Name: test_label_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_label_fk FOREIGN KEY (label_id) REFERENCES label(id) MATCH FULL;


--
-- Name: test_method_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_method_fk FOREIGN KEY (method_id) REFERENCES method(id) MATCH FULL;


--
-- Name: test_reflex_scriptlet_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT test_reflex_scriptlet_fk FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id);


--
-- Name: test_result_type_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY result_limits
    ADD CONSTRAINT test_result_type_fk FOREIGN KEY (test_result_type_id) REFERENCES type_of_test_result(id);


--
-- Name: test_scriptlet_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_scriptlet_fk FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: test_sect_org_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_section
    ADD CONSTRAINT test_sect_org_fk FOREIGN KEY (org_id) REFERENCES organization(id) MATCH FULL;


--
-- Name: test_testformat_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_testformat_fk FOREIGN KEY (test_format_id) REFERENCES test_formats(id) MATCH FULL;


--
-- Name: test_testsect_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_testsect_fk FOREIGN KEY (test_section_id) REFERENCES test_section(id) MATCH FULL;


--
-- Name: test_testtrailer_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_testtrailer_fk FOREIGN KEY (test_trailer_id) REFERENCES test_trailer(id) MATCH FULL;


--
-- Name: test_uom_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_uom_fk FOREIGN KEY (uom_id) REFERENCES unit_of_measure(id) MATCH FULL;


--
-- Name: testalyt_analyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_analyte
    ADD CONSTRAINT testalyt_analyte_fk FOREIGN KEY (analyte_id) REFERENCES analyte(id) MATCH FULL;


--
-- Name: testalyt_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_analyte
    ADD CONSTRAINT testalyt_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: testreflex_addtest_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT testreflex_addtest_fk FOREIGN KEY (add_test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: testreflex_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT testreflex_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: testreflex_testanalyt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT testreflex_testanalyt_fk FOREIGN KEY (test_analyte_id) REFERENCES test_analyte(id) MATCH FULL;


--
-- Name: testreflex_tstrslt_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_reflex
    ADD CONSTRAINT testreflex_tstrslt_fk FOREIGN KEY (tst_rslt_id) REFERENCES test_result(id) MATCH FULL;


--
-- Name: testresult_scriptlet_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT testresult_scriptlet_fk FOREIGN KEY (scriptlet_id) REFERENCES scriptlet(id) MATCH FULL;


--
-- Name: testresult_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT testresult_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: tw_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_worksheets
    ADD CONSTRAINT tw_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: twi_qc_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_worksheet_item
    ADD CONSTRAINT twi_qc_fk FOREIGN KEY (qc_id) REFERENCES qc(id) MATCH FULL;


--
-- Name: twi_tw_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY test_worksheet_item
    ADD CONSTRAINT twi_tw_fk FOREIGN KEY (tw_id) REFERENCES test_worksheets(id) MATCH FULL;


--
-- Name: wkshtanalysis_wkshtitem_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_analysis
    ADD CONSTRAINT wkshtanalysis_wkshtitem_fk FOREIGN KEY (worksheet_item_id) REFERENCES worksheet_item(id) MATCH FULL;


--
-- Name: wkshtanalyte_result_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_analyte
    ADD CONSTRAINT wkshtanalyte_result_fk FOREIGN KEY (result_id) REFERENCES result(id) MATCH FULL;


--
-- Name: wkshtitem_wksht_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_item
    ADD CONSTRAINT wkshtitem_wksht_fk FOREIGN KEY (worksheet_id) REFERENCES worksheets(id) MATCH FULL;


--
-- Name: wkshtqc_qcanalyte_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_qc
    ADD CONSTRAINT wkshtqc_qcanalyte_fk FOREIGN KEY (qc_analyte_id) REFERENCES qc_analytes(id) MATCH FULL;


--
-- Name: wkshtqc_wkshtanalysis_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_qc
    ADD CONSTRAINT wkshtqc_wkshtanalysis_fk FOREIGN KEY (worksheet_analysis_id) REFERENCES worksheet_analysis(id) MATCH FULL;


--
-- Name: workst_sys_user_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheets
    ADD CONSTRAINT workst_sys_user_fk FOREIGN KEY (sys_user_id) REFERENCES system_user(id) MATCH FULL;


--
-- Name: workst_test_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheets
    ADD CONSTRAINT workst_test_fk FOREIGN KEY (test_id) REFERENCES test(id) MATCH FULL;


--
-- Name: wrkst_anlt_wrkst_anls_fk; Type: FK CONSTRAINT; Schema: clinlims; Owner: clinlims
--

ALTER TABLE ONLY worksheet_analyte
    ADD CONSTRAINT wrkst_anlt_wrkst_anls_fk FOREIGN KEY (wrkst_anls_id) REFERENCES worksheet_analysis(id) MATCH FULL;


--
-- Name: clinlims; Type: ACL; Schema: -; Owner: clinlims
--

REVOKE ALL ON SCHEMA clinlims FROM PUBLIC;
REVOKE ALL ON SCHEMA clinlims FROM clinlims;
GRANT ALL ON SCHEMA clinlims TO clinlims;
GRANT USAGE ON SCHEMA clinlims TO "atomfeed-console";


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: failed_event_retry_log; Type: ACL; Schema: clinlims; Owner: clinlims
--

REVOKE ALL ON TABLE failed_event_retry_log FROM PUBLIC;
REVOKE ALL ON TABLE failed_event_retry_log FROM clinlims;
GRANT ALL ON TABLE failed_event_retry_log TO clinlims;
GRANT SELECT,UPDATE ON TABLE failed_event_retry_log TO "atomfeed-console";


--
-- Name: failed_events; Type: ACL; Schema: clinlims; Owner: clinlims
--

REVOKE ALL ON TABLE failed_events FROM PUBLIC;
REVOKE ALL ON TABLE failed_events FROM clinlims;
GRANT ALL ON TABLE failed_events TO clinlims;
GRANT SELECT,UPDATE ON TABLE failed_events TO "atomfeed-console";


--
-- Name: markers; Type: ACL; Schema: clinlims; Owner: clinlims
--

REVOKE ALL ON TABLE markers FROM PUBLIC;
REVOKE ALL ON TABLE markers FROM clinlims;
GRANT ALL ON TABLE markers TO clinlims;
GRANT SELECT,UPDATE ON TABLE markers TO "atomfeed-console";


--
-- PostgreSQL database dump complete
--

