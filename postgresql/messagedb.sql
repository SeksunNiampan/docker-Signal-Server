--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: signal; Tablespace: 
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO signal;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: signal; Tablespace: 
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO signal;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: signal; Tablespace: 
--

CREATE TABLE messages (
    id bigint NOT NULL,
    type smallint NOT NULL,
    relay text NOT NULL,
    "timestamp" bigint NOT NULL,
    source text NOT NULL,
    source_device integer NOT NULL,
    destination text NOT NULL,
    destination_device integer NOT NULL,
    message bytea,
    content bytea
);


ALTER TABLE public.messages OWNER TO signal;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: signal
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO signal;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: signal
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: signal
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: signal
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	moxie	messagedb.xml	2018-03-05 11:18:52.076585	1	EXECUTED	7:05fa61c47d01b66dbdf3912314ee9eb6	createTable tableName=messages; createIndex indexName=destination_index, tableName=messages; createIndex indexName=destination_and_type_index, tableName=messages		\N	3.5.3	\N	\N	0248731761
2	moxie	messagedb.xml	2018-03-05 11:18:52.134954	2	EXECUTED	7:53bf280b713a397e0e8a07c972278653	addColumn tableName=messages; dropNotNullConstraint columnName=message, tableName=messages		\N	3.5.3	\N	\N	0248731761
3	moxie	messagedb.xml	2018-03-05 11:18:52.179215	3	EXECUTED	7:c9afe1018c5cd80430d0d80277eea00f	sql		\N	3.5.3	\N	\N	0248731761
4	moxie	messagedb.xml	2018-03-05 11:18:52.223203	4	EXECUTED	7:f297d5a62d52ea61c350d3534bc4a510	sql; sql		\N	3.5.3	\N	\N	0248731761
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: signal
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: signal
--

COPY messages (id, type, relay, "timestamp", source, source_device, destination, destination_device, message, content) FROM stdin;
1	3		1521193706024	+66811112222	1	+66867619017	1	\N	\\x3308a9f7de07122105c4d913a5065ce0ed02a5fa27974247cedc0a7ad7012617bbbda0dd5473601f701a21052e086085c02192442150d8952a184b4143c4e471722159eed77c13a921e4ab2622d301330a2105b2979f50feb233f2cf6fa33389d95b3a3c5ab1b08cf36b093237f22b740e3b401000180022a001f4896ffdc42c98e30939d5e4c2511c6429bbf05f14131963958d633e111a1e321c0ed52f541c2ac843eb180789be421e36b0e2478bf36f41f597d30e838a722185dd8f29a22e012f9ad89607b99b1ca8b855b7c61bd90447495c6dde1ec888a60936dabe43dfacf313fb377abbd062399460425b02e3c4cfa3abdbc7116030afb39f952d1655be9c7d18266c1dc202f906d047af6050fe1e3a065efd65d2bcd11be48dfd267d27ed28e45130f79cf002
2	3		1521193726971	+66811112222	1	+66867619017	1	\N	\\x3308a9f7de07122105c4d913a5065ce0ed02a5fa27974247cedc0a7ad7012617bbbda0dd5473601f701a21052e086085c02192442150d8952a184b4143c4e471722159eed77c13a921e4ab2622f302330a2105b2979f50feb233f2cf6fa33389d95b3a3c5ab1b08cf36b093237f22b740e3b401001180022c002fbe49998c971ac7a91f483c2476e4f0833d59dfdd8dab65f9e2df3f915066e54b650b3a7d6d581f5baccc8747cc79e79a2f8c4470396eab4a7be7dcd86db661744e79ddcfb839516fe4ed905f515d72717d64426d83e09e99c16d7c937c0e26824fe7ad55ba6d3b8a1ff303c4d56408106a3a4938b3b4d1852970fdd1eb3485f34c2a7e75f156d90fd75cc40acccaf8ac8a1d21d43e12e08800cb402d701c68b4f7e9cdb73538d961201128cecbced4dcf9a3cffd9953e1d5bb438d5eab656aee9b24ad6c1c5049e9e4a4e820bd22bb05836519a1694e717d07dd57527e9320882689beb1e9291ddb6b4be3510d64559ddbb5790d6a9895e5e60bc152969b0fbda5788d61f0e6db88cef54b8a95053a76a5857fe40c580f2a732586e86741ea844d9666e7b11157e581b84766780bfbbad4c2bd1773a73cc72feb3392512b3bfb1fa37b0bdb3a0d328e45130f79cf002
3	3		1521193790617	+66811112222	1	+66867619017	1	\N	\\x3308a9f7de07122105c4d913a5065ce0ed02a5fa27974247cedc0a7ad7012617bbbda0dd5473601f701a21052e086085c02192442150d8952a184b4143c4e471722159eed77c13a921e4ab2622d301330a2105b2979f50feb233f2cf6fa33389d95b3a3c5ab1b08cf36b093237f22b740e3b401002180022a0013e0cf6c80cc4fe038f9bba6afd388cb9ef884b5ed577b9b7612aa31a6156bb07cfaf3f2f4c67026b054ad5057fae1782deac90c5f4eafec45f9ef9dde1f65497dcaadc56309f0e94c29f69ee74740af67f33321ba4db5b65f519563b5b995445f926fba5bb2ede7ddee55ffce328274eb5a3698fe6058453f14a711d99191908ea7c6593eed1058a521e41f91b85b69b10ffdba9bf79d3d9fb83dd85f50bd1b391bb9483542496b828e45130f79cf002
4	3		1521193796285	+66811112222	1	+66867619017	1	\N	\\x3308a9f7de07122105c4d913a5065ce0ed02a5fa27974247cedc0a7ad7012617bbbda0dd5473601f701a21052e086085c02192442150d8952a184b4143c4e471722159eed77c13a921e4ab2622f302330a2105b2979f50feb233f2cf6fa33389d95b3a3c5ab1b08cf36b093237f22b740e3b401003180022c002dddcc160f3e0cbed64f34e63c2c1d4df1e842e07d143c94a5e38c57523d3831fe21778cba42d5aec9078351fd9725fadec697d42507bdf034632bbad73ff0d4c2e2847bbe10c1163a1845ee3e56bed5971cefc7a055741d19f90875b70053c7014158f3efbb5374c116c0c8667f2e696872c52f7da8a8c203b5df4299f5c234c557e3d4c1047446f4fc4533c285301386f868fd0bb3bf5bc94b3c548e903c9ffbe824a08578a7f9590be6c30072d8550f9f1429be09aad3dcd329b415012925b16972f566b193a4173b14e3645f6fb5f89c8556e719777797f2f2c1e66faec8e9cbc0382b6e8db9c8862bffa484baef78d381357931810eb10b32988864c4424b441d3ffbce4ca6dac20178874082c6bcf9294893c4be1107dcb44d4cf5ba0f26c9ff32bd72b5c802d32f0ef8ac65de833bda51ce20690429510643dbcd8d4e2a1ad80b7903f433628e45130f79cf002
\.


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: signal
--

SELECT pg_catalog.setval('messages_id_seq', 4, true);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: signal; Tablespace: 
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_messages; Type: CONSTRAINT; Schema: public; Owner: signal; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT pk_messages PRIMARY KEY (id);


--
-- Name: destination_and_type_index; Type: INDEX; Schema: public; Owner: signal; Tablespace: 
--

CREATE INDEX destination_and_type_index ON messages USING btree (destination, destination_device, type);


--
-- Name: destination_index; Type: INDEX; Schema: public; Owner: signal; Tablespace: 
--

CREATE INDEX destination_index ON messages USING btree (destination, destination_device);


--
-- Name: bounded_message_queue; Type: RULE; Schema: public; Owner: signal
--

CREATE RULE bounded_message_queue AS
    ON INSERT TO messages DO  DELETE FROM messages
  WHERE (messages.id IN ( SELECT messages_1.id
           FROM messages messages_1
          WHERE ((messages_1.destination = new.destination) AND (messages_1.destination_device = new.destination_device))
          ORDER BY messages_1."timestamp" DESC
         OFFSET 1000));


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

