--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    best_guess integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    frequent_games integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 650);
INSERT INTO public.games VALUES (2, 1, 378);
INSERT INTO public.games VALUES (3, 2, 717);
INSERT INTO public.games VALUES (4, 2, 805);
INSERT INTO public.games VALUES (5, 1, 149);
INSERT INTO public.games VALUES (6, 1, 618);
INSERT INTO public.games VALUES (7, 1, 203);
INSERT INTO public.games VALUES (8, 3, 621);
INSERT INTO public.games VALUES (9, 3, 933);
INSERT INTO public.games VALUES (10, 4, 669);
INSERT INTO public.games VALUES (11, 4, 40);
INSERT INTO public.games VALUES (12, 3, 650);
INSERT INTO public.games VALUES (13, 3, 59);
INSERT INTO public.games VALUES (14, 3, 32);
INSERT INTO public.games VALUES (15, 5, 10);
INSERT INTO public.games VALUES (16, 6, 816);
INSERT INTO public.games VALUES (17, 6, 936);
INSERT INTO public.games VALUES (18, 7, 726);
INSERT INTO public.games VALUES (19, 7, 976);
INSERT INTO public.games VALUES (20, 6, 494);
INSERT INTO public.games VALUES (21, 6, 711);
INSERT INTO public.games VALUES (22, 6, 174);
INSERT INTO public.games VALUES (23, 8, 508);
INSERT INTO public.games VALUES (24, 8, 262);
INSERT INTO public.games VALUES (25, 9, 291);
INSERT INTO public.games VALUES (26, 9, 658);
INSERT INTO public.games VALUES (27, 8, 277);
INSERT INTO public.games VALUES (28, 8, 421);
INSERT INTO public.games VALUES (29, 8, 8);
INSERT INTO public.games VALUES (30, 10, 523);
INSERT INTO public.games VALUES (31, 10, 443);
INSERT INTO public.games VALUES (32, 11, 892);
INSERT INTO public.games VALUES (33, 11, 853);
INSERT INTO public.games VALUES (34, 10, 608);
INSERT INTO public.games VALUES (35, 10, 354);
INSERT INTO public.games VALUES (36, 10, 782);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, 'user_1744997246497', 2);
INSERT INTO public.users VALUES (1, 'user_1744997246498', 5);
INSERT INTO public.users VALUES (4, 'user_1744997350706', 2);
INSERT INTO public.users VALUES (3, 'user_1744997350707', 5);
INSERT INTO public.users VALUES (5, 'Throkal', 1);
INSERT INTO public.users VALUES (7, 'user_1744997417118', 2);
INSERT INTO public.users VALUES (6, 'user_1744997417119', 5);
INSERT INTO public.users VALUES (9, 'user_1744997463657', 2);
INSERT INTO public.users VALUES (8, 'user_1744997463658', 5);
INSERT INTO public.users VALUES (11, 'user_1744997618332', 2);
INSERT INTO public.users VALUES (10, 'user_1744997618333', 5);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 36, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 11, true);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

