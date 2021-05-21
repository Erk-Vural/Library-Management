--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

-- Started on 2020-08-14 21:19:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 717 (class 1247 OID 25241)
-- Name: year; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


ALTER DOMAIN public.year OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 25321)
-- Name: clear_after(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clear_after() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
DELETE FROM inventory WHERE book.new.book_id=NULL
AND inventory.book_id=book.old.book_id;
  RETURN NULL;
END$$;


ALTER FUNCTION public.clear_after() OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 25320)
-- Name: is_active(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_active() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    NEW.active = true ;
    RETURN NEW;
END $$;


ALTER FUNCTION public.is_active() OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 25318)
-- Name: is_existed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_existed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
IF EXISTS (SELECT 1 FROM account a WHERE a.account_id = new.account_id) THEN
  return a.account =new.account;
END IF;
END $$;


ALTER FUNCTION public.is_existed() OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 25114)
-- Name: last_updated(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;


ALTER FUNCTION public.last_updated() OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 25480)
-- Name: me_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.me_delete(_account_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
 delete from member
 where member.account_id = _account_id;
 if found then --deleted successfully
  return 1;
 else
  return 0;
 end if;
end

$$;


ALTER FUNCTION public.me_delete(_account_id integer) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 25475)
-- Name: me_insert(character varying, character varying, character varying, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.me_insert(_first_name character varying, _last_name character varying, _email character varying, _address_id smallint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
 insert into member(member.first_name,member.last_name, member.email, member.address_id)
 values(_first_name, _lastname, _email, _address_id);
 if found then --inserted successfully
  return 1;
 else return 0; -- inserted fail
 end if;
end

$$;


ALTER FUNCTION public.me_insert(_first_name character varying, _last_name character varying, _email character varying, _address_id smallint) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 25474)
-- Name: me_select(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.me_select() RETURNS TABLE(account_id integer, first_name character varying, last_name character varying, email character varying, address_id smallint)
    LANGUAGE plpgsql
    AS $$ begin
  return query
 select member.account_id, member.first_name,member.last_name, member.email, member.address_id   from member order by account_id;
 end
 
$$;


ALTER FUNCTION public.me_select() OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 25479)
-- Name: me_update(integer, character varying, character varying, character varying, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.me_update(_account_id integer, _first_name character varying, _last_name character varying, _email character varying, _address_id smallint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
 begin
  update member
 set 
  member.first_name = _first_name,
  member.last_name = _last_name,
  member.email =  _email,
  member.address_id = _address_id
 
 where member.account_id = _account_id;
 if found then --updated successfully
  return 1;
 else --updated fail
  return 0;
 end if;
 end
 
$$;


ALTER FUNCTION public.me_update(_account_id integer, _first_name character varying, _last_name character varying, _email character varying, _address_id smallint) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 25471)
-- Name: u_login(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.u_login(_username character varying, _password character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$begin

	if (select count (*) from librarian where librarian.username = $1 and librarian.password = $2) > 0 then
		return 1; 
	else
		return 0;
	end if;
end
	$_$;


ALTER FUNCTION public.u_login(_username character varying, _password character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 24994)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    account_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    email character varying(20) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    address_id smallint DEFAULT 6 NOT NULL,
    library_id smallint DEFAULT 1 NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 25469)
-- Name: account_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.account ALTER COLUMN account_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.account_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 24989)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    address_id integer NOT NULL,
    address character varying(50) NOT NULL,
    postal_code character varying(10),
    district character varying(20),
    phone character varying(20),
    city_id smallint NOT NULL
);


ALTER TABLE public.address OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25236)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.address ALTER COLUMN address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 24979)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    first_name character varying(25) NOT NULL,
    last_name character varying(25) NOT NULL
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25234)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.author ALTER COLUMN author_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.author_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 204 (class 1259 OID 24941)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    publish_date date,
    number_of_pages integer,
    language_id smallint NOT NULL,
    rental_rate numeric(4,2) DEFAULT 1.99
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24954)
-- Name: book_author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_author (
    author_id smallint NOT NULL,
    book_id smallint NOT NULL
);


ALTER TABLE public.book_author OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24936)
-- Name: book_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_category (
    book_id smallint NOT NULL,
    category_id smallint NOT NULL
);


ALTER TABLE public.book_category OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 24931)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25409)
-- Name: author_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.author_info AS
 SELECT a.author_id,
    a.first_name,
    a.last_name,
    b.title AS book_title
   FROM ((((public.author a
     LEFT JOIN public.book_author ba ON ((a.author_id = ba.author_id)))
     LEFT JOIN public.book b ON ((ba.book_id = b.book_id)))
     LEFT JOIN public.book_category bc ON ((ba.book_id = bc.book_id)))
     LEFT JOIN public.category c ON ((bc.category_id = c.category_id)))
  GROUP BY a.author_id, a.first_name, a.last_name, b.title;


ALTER TABLE public.author_info OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25232)
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book ALTER COLUMN book_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 25419)
-- Name: book_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.book_list AS
 SELECT book.book_id AS bid,
    book.title,
    book.description,
    category.name AS category,
    book.rental_rate AS price,
    book.number_of_pages,
    author.first_name AS author_first_name,
    author.last_name AS author_last_name
   FROM ((((public.category
     LEFT JOIN public.book_category ON ((category.category_id = book_category.category_id)))
     LEFT JOIN public.book ON ((book_category.book_id = book.book_id)))
     JOIN public.book_author ON ((book.book_id = book_author.book_id)))
     JOIN public.author ON ((book_author.author_id = author.author_id)))
  GROUP BY book.book_id, book.title, book.description, category.name, book.rental_rate, book.number_of_pages, author.first_name, author.last_name;


ALTER TABLE public.book_list OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25230)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 209 (class 1259 OID 24969)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city character varying(20) NOT NULL,
    country_id smallint NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25228)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.city ALTER COLUMN city_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 208 (class 1259 OID 24964)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    country_id integer NOT NULL,
    country character varying(20) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25226)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.country ALTER COLUMN country_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 207 (class 1259 OID 24959)
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    inventory_id integer NOT NULL,
    book_id smallint NOT NULL,
    library_id smallint DEFAULT 1 NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    is_avaliable boolean DEFAULT true NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25224)
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory ALTER COLUMN inventory_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 205 (class 1259 OID 24949)
-- Name: language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.language (
    language_id integer NOT NULL,
    name character(20) NOT NULL
);


ALTER TABLE public.language OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25222)
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.language ALTER COLUMN language_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.language_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 25259)
-- Name: librarian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.librarian (
    librarian_id integer NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(20) NOT NULL
)
INHERITS (public.account);


ALTER TABLE public.librarian OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25431)
-- Name: librarian_librarian_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.librarian ALTER COLUMN librarian_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.librarian_librarian_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 210 (class 1259 OID 24974)
-- Name: library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.library (
    library_id integer NOT NULL,
    address_id smallint NOT NULL
);


ALTER TABLE public.library OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25218)
-- Name: library_library_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.library ALTER COLUMN library_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.library_library_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 25265)
-- Name: member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member (
    member_id integer NOT NULL,
    create_date timestamp without time zone DEFAULT now()
)
INHERITS (public.account);


ALTER TABLE public.member OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25329)
-- Name: member_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.member_list AS
 SELECT me.member_id AS id,
    (((me.first_name)::text || ' '::text) || (me.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN me.active THEN 'active'::text
            ELSE ''::text
        END AS notes,
    me.library_id AS lid
   FROM (((public.member me
     JOIN public.address a ON ((me.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));


ALTER TABLE public.member_list OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25433)
-- Name: member_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.member ALTER COLUMN member_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.member_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 24984)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    rental_id smallint NOT NULL,
    librarian_id smallint NOT NULL,
    member_id smallint NOT NULL
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25214)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.payment ALTER COLUMN payment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 25019)
-- Name: rental; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rental (
    rental_id integer NOT NULL,
    rental_date timestamp without time zone NOT NULL,
    return_date timestamp without time zone,
    inventory_id integer NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    librarian_id smallint NOT NULL,
    member_id smallint NOT NULL,
    rental_duration integer DEFAULT 5
);


ALTER TABLE public.rental OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25212)
-- Name: rental_rental_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rental ALTER COLUMN rental_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rental_rental_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9223372
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 25344)
-- Name: rents_by_book_category; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rents_by_book_category AS
 SELECT c.name AS category,
    sum(p.amount) AS total_rents
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.book b ON ((i.book_id = b.book_id)))
     JOIN public.book_category bc ON ((b.book_id = bc.book_id)))
     JOIN public.category c ON ((bc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;


ALTER TABLE public.rents_by_book_category OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25334)
-- Name: rents_by_library; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rents_by_library AS
 SELECT (((c.city)::text || ','::text) || (cy.country)::text) AS store,
    sum(p.amount) AS total_rents
   FROM ((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.library l ON ((i.library_id = l.library_id)))
     JOIN public.address a ON ((l.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
  GROUP BY cy.country, c.city, l.library_id
  ORDER BY cy.country, c.city;


ALTER TABLE public.rents_by_library OWNER TO postgres;

--
-- TOC entry 2818 (class 2604 OID 25341)
-- Name: librarian active; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian ALTER COLUMN active SET DEFAULT false;


--
-- TOC entry 2820 (class 2604 OID 25439)
-- Name: librarian address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian ALTER COLUMN address_id SET DEFAULT 6;


--
-- TOC entry 2819 (class 2604 OID 25436)
-- Name: librarian library_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian ALTER COLUMN library_id SET DEFAULT 1;


--
-- TOC entry 2817 (class 2604 OID 25262)
-- Name: librarian last_update; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian ALTER COLUMN last_update SET DEFAULT now();


--
-- TOC entry 2822 (class 2604 OID 25342)
-- Name: member active; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member ALTER COLUMN active SET DEFAULT false;


--
-- TOC entry 2825 (class 2604 OID 25440)
-- Name: member address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member ALTER COLUMN address_id SET DEFAULT 6;


--
-- TOC entry 2824 (class 2604 OID 25437)
-- Name: member library_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member ALTER COLUMN library_id SET DEFAULT 1;


--
-- TOC entry 2821 (class 2604 OID 25268)
-- Name: member last_update; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member ALTER COLUMN last_update SET DEFAULT now();


--
-- TOC entry 3038 (class 0 OID 24994)
-- Dependencies: 214
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (account_id, first_name, last_name, email, active, address_id, library_id, last_update) FROM stdin;
\.


--
-- TOC entry 3037 (class 0 OID 24989)
-- Dependencies: 213
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (address_id, address, postal_code, district, phone, city_id) FROM stdin;
5	orhan mah. bagcesme	41	1	0123 23 32 123	10
6	beylikduzu	34	75	0123 23 32 127	11
\.


--
-- TOC entry 3035 (class 0 OID 24979)
-- Dependencies: 211
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (author_id, first_name, last_name) FROM stdin;
1	john	abasiyanik
2	dolphin	emre
3	crishtian	ronaldo
4	bilge	ali
5	nuri 	cankan
\.


--
-- TOC entry 3028 (class 0 OID 24941)
-- Dependencies: 204
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (book_id, title, description, publish_date, number_of_pages, language_id, rental_rate) FROM stdin;
2	yuzuklerin efendisi	\N	1943-08-15	1100	3	4.00
3	harry potter	\N	1998-08-15	4252	3	2.00
4	suc ve ceza	\N	1832-08-15	600	2	4.00
5	savas ve baris	\N	1785-08-15	300	2	4.00
6	sefiller	\N	1810-08-15	1245	5	6.00
\.


--
-- TOC entry 3030 (class 0 OID 24954)
-- Dependencies: 206
-- Data for Name: book_author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_author (author_id, book_id) FROM stdin;
\.


--
-- TOC entry 3027 (class 0 OID 24936)
-- Dependencies: 203
-- Data for Name: book_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_category (book_id, category_id) FROM stdin;
2	5
3	5
4	5
5	5
6	5
\.


--
-- TOC entry 3026 (class 0 OID 24931)
-- Dependencies: 202
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, name) FROM stdin;
1	polisiye
2	komedi\n
3	romantik
4	korku
5	roman
\.


--
-- TOC entry 3033 (class 0 OID 24969)
-- Dependencies: 209
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, city, country_id) FROM stdin;
10	kocaeli	1
11	istanbul	1
12	sakarya	1
\.


--
-- TOC entry 3032 (class 0 OID 24964)
-- Dependencies: 208
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (country_id, country) FROM stdin;
1	turkey
2	bulgaria\n
3	greece
4	germany\n
\.


--
-- TOC entry 3031 (class 0 OID 24959)
-- Dependencies: 207
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (inventory_id, book_id, library_id, last_update, is_avaliable) FROM stdin;
5	2	1	2020-08-13 16:45:59.21515	t
6	3	1	2020-08-13 16:46:47.834502	t
7	4	1	2020-08-13 16:46:47.834502	t
8	5	1	2020-08-13 16:46:47.834502	t
\.


--
-- TOC entry 3029 (class 0 OID 24949)
-- Dependencies: 205
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.language (language_id, name) FROM stdin;
1	turkish\n            
2	russian             
3	english             
4	german              
5	french              
6	polish              
7	spanish             
\.


--
-- TOC entry 3051 (class 0 OID 25259)
-- Dependencies: 227
-- Data for Name: librarian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.librarian (account_id, first_name, last_name, email, active, address_id, library_id, last_update, librarian_id, username, password) FROM stdin;
\N	erk	vural	example3@gmail.com	f	6	1	2020-08-14 06:59:32.65879	2	admin	123
\.


--
-- TOC entry 3034 (class 0 OID 24974)
-- Dependencies: 210
-- Data for Name: library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.library (library_id, address_id) FROM stdin;
1	5
\.


--
-- TOC entry 3052 (class 0 OID 25265)
-- Dependencies: 228
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.member (account_id, first_name, last_name, email, active, address_id, library_id, last_update, member_id, create_date) FROM stdin;
\N	can	yılmaz	example1@gmail.com	f	6	1	2020-08-14 06:57:24.161334	11	2020-08-14 06:57:24.161334
\N	caner	kaya	example2@gmail.com	f	6	1	2020-08-14 06:57:51.258808	12	2020-08-14 06:57:51.258808
\.


--
-- TOC entry 3036 (class 0 OID 24984)
-- Dependencies: 212
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (payment_id, amount, rental_id, librarian_id, member_id) FROM stdin;
\.


--
-- TOC entry 3039 (class 0 OID 25019)
-- Dependencies: 215
-- Data for Name: rental; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rental (rental_id, rental_date, return_date, inventory_id, last_update, librarian_id, member_id, rental_duration) FROM stdin;
\.


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 236
-- Name: account_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_account_id_seq', 1, false);


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 226
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_address_id_seq', 6, true);


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 225
-- Name: author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_author_id_seq', 5, true);


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 224
-- Name: book_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_book_id_seq', 6, true);


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 223
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 5, true);


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 222
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 12, true);


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 221
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_country_id_seq', 4, true);


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 220
-- Name: inventory_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 8, true);


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 219
-- Name: language_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.language_language_id_seq', 7, true);


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 234
-- Name: librarian_librarian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.librarian_librarian_id_seq', 2, true);


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 218
-- Name: library_library_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.library_library_id_seq', 1, true);


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 235
-- Name: member_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_member_id_seq', 12, true);


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 217
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 1, false);


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 216
-- Name: rental_rental_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_rental_id_seq1', 1, false);


--
-- TOC entry 2859 (class 2606 OID 24999)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (account_id);


--
-- TOC entry 2856 (class 2606 OID 24993)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 2850 (class 2606 OID 24983)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 2837 (class 2606 OID 25391)
-- Name: book_author book_author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_pkey PRIMARY KEY (author_id, book_id);


--
-- TOC entry 2829 (class 2606 OID 24940)
-- Name: book_category book_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category
    ADD CONSTRAINT book_category_pkey PRIMARY KEY (book_id, category_id);


--
-- TOC entry 2831 (class 2606 OID 24948)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 2827 (class 2606 OID 24935)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 2845 (class 2606 OID 24973)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 2843 (class 2606 OID 24968)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 2841 (class 2606 OID 24963)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- TOC entry 2835 (class 2606 OID 24953)
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2867 (class 2606 OID 25264)
-- Name: librarian librarian_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian
    ADD CONSTRAINT librarian_pkey PRIMARY KEY (librarian_id);


--
-- TOC entry 2848 (class 2606 OID 24978)
-- Name: library library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_pkey PRIMARY KEY (library_id);


--
-- TOC entry 2869 (class 2606 OID 25270)
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (member_id);


--
-- TOC entry 2854 (class 2606 OID 24988)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 2865 (class 2606 OID 25023)
-- Name: rental rental_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);


--
-- TOC entry 2851 (class 1259 OID 25375)
-- Name: idx_actor_last_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_actor_last_name ON public.author USING btree (last_name);


--
-- TOC entry 2860 (class 1259 OID 25207)
-- Name: idx_fk_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_address_id ON public.account USING btree (address_id);


--
-- TOC entry 2838 (class 1259 OID 25392)
-- Name: idx_fk_book_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_book_id ON public.book_author USING btree (book_id);


--
-- TOC entry 2857 (class 1259 OID 25206)
-- Name: idx_fk_city_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id);


--
-- TOC entry 2846 (class 1259 OID 25201)
-- Name: idx_fk_country_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_country_id ON public.city USING btree (country_id);


--
-- TOC entry 2863 (class 1259 OID 25116)
-- Name: idx_fk_inventory_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);


--
-- TOC entry 2832 (class 1259 OID 25204)
-- Name: idx_fk_language_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_language_id ON public.book USING btree (language_id);


--
-- TOC entry 2852 (class 1259 OID 25196)
-- Name: idx_fk_rental_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_rental_id ON public.payment USING btree (rental_id);


--
-- TOC entry 2861 (class 1259 OID 25208)
-- Name: idx_fk_store_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_store_id ON public.account USING btree (library_id);


--
-- TOC entry 2862 (class 1259 OID 25209)
-- Name: idx_last_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_last_name ON public.account USING btree (last_name);


--
-- TOC entry 2839 (class 1259 OID 25199)
-- Name: idx_library_id_book_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_library_id_book_id ON public.inventory USING btree (library_id, book_id);


--
-- TOC entry 2833 (class 1259 OID 25359)
-- Name: idx_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_title ON public.book USING btree (title);


--
-- TOC entry 2890 (class 2620 OID 25322)
-- Name: inventory clear_after; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER clear_after AFTER DELETE ON public.inventory FOR EACH ROW EXECUTE FUNCTION public.clear_after();


--
-- TOC entry 2892 (class 2620 OID 25339)
-- Name: account is_active; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER is_active AFTER UPDATE OF active ON public.account FOR EACH ROW EXECUTE FUNCTION public.is_active();


--
-- TOC entry 2893 (class 2620 OID 25319)
-- Name: account is_existed; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER is_existed BEFORE INSERT ON public.account FOR EACH ROW EXECUTE FUNCTION public.is_existed();


--
-- TOC entry 2891 (class 2620 OID 25210)
-- Name: account last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.account FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 2889 (class 2620 OID 25200)
-- Name: inventory last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.inventory FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 2894 (class 2620 OID 25115)
-- Name: rental last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.rental FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 2876 (class 2606 OID 25059)
-- Name: city 	fk_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT "	fk_city" FOREIGN KEY (country_id) REFERENCES public.country(country_id);


--
-- TOC entry 2887 (class 2606 OID 25271)
-- Name: librarian account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.librarian
    ADD CONSTRAINT account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2888 (class 2606 OID 25276)
-- Name: member account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2882 (class 2606 OID 25094)
-- Name: account account_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2883 (class 2606 OID 25099)
-- Name: account account_library_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_library_id_fkey FOREIGN KEY (library_id) REFERENCES public.library(library_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2873 (class 2606 OID 25380)
-- Name: book_author book_author_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2874 (class 2606 OID 25393)
-- Name: book_author book_author_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2871 (class 2606 OID 25069)
-- Name: book_category book_category_book_id_fkeybook; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category
    ADD CONSTRAINT book_category_book_id_fkeybook FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2870 (class 2606 OID 25064)
-- Name: book_category book_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category
    ADD CONSTRAINT book_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2872 (class 2606 OID 25084)
-- Name: book book_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2881 (class 2606 OID 25089)
-- Name: address fk_address_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES public.city(city_id);


--
-- TOC entry 2875 (class 2606 OID 25054)
-- Name: inventory inventory_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2877 (class 2606 OID 25014)
-- Name: library library_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2879 (class 2606 OID 25291)
-- Name: payment payment_librarian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_librarian_id_fkey FOREIGN KEY (librarian_id) REFERENCES public.librarian(librarian_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2880 (class 2606 OID 25296)
-- Name: payment payment_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(member_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2878 (class 2606 OID 25044)
-- Name: payment payment_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2884 (class 2606 OID 25029)
-- Name: rental rental_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2885 (class 2606 OID 25281)
-- Name: rental rental_librarian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_librarian_id_fkey FOREIGN KEY (librarian_id) REFERENCES public.librarian(librarian_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2886 (class 2606 OID 25286)
-- Name: rental rental_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(member_id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2020-08-14 21:19:44

--
-- PostgreSQL database dump complete
--

