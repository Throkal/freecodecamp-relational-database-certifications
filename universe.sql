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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    size integer,
    description text,
    name character varying(255) NOT NULL,
    has_life boolean DEFAULT false NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: kitayverse; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.kitayverse (
    kitayverse_id integer NOT NULL,
    name character varying(255) NOT NULL,
    has_rin boolean DEFAULT true NOT NULL,
    food_amount integer
);


ALTER TABLE public.kitayverse OWNER TO freecodecamp;

--
-- Name: kitayverse_kitayverse_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.kitayverse_kitayverse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kitayverse_kitayverse_id_seq OWNER TO freecodecamp;

--
-- Name: kitayverse_kitayverse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.kitayverse_kitayverse_id_seq OWNED BY public.kitayverse.kitayverse_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    has_life boolean DEFAULT false NOT NULL,
    radius integer,
    has_oil boolean DEFAULT true NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    temparature_in_celsius numeric,
    has_life boolean DEFAULT false NOT NULL,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    radius integer NOT NULL,
    name character varying(255) NOT NULL,
    color character varying(255) NOT NULL,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: kitayverse kitayverse_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.kitayverse ALTER COLUMN kitayverse_id SET DEFAULT nextval('public.kitayverse_kitayverse_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 100, 'A spiral galaxy with many stars', 'Andromeda', true);
INSERT INTO public.galaxy VALUES (2, 50, 'An elliptical galaxy with a bright core', 'M32', false);
INSERT INTO public.galaxy VALUES (3, 25, 'An irregular galaxy with active star formation', 'NGC 147', true);
INSERT INTO public.galaxy VALUES (4, 200, 'A barred spiral galaxy with distinct arms', 'Milky Way', true);
INSERT INTO public.galaxy VALUES (5, 75, 'A lenticular galaxy with a smooth appearance', 'NGC 5866', false);
INSERT INTO public.galaxy VALUES (6, 10, 'A dwarf galaxy orbiting the Milky Way', 'Sagittarius Dwarf Spheroidal', false);


--
-- Data for Name: kitayverse; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.kitayverse VALUES (1, 'Kitay', true, 1000);
INSERT INTO public.kitayverse VALUES (2, 'Nezha', true, 1);
INSERT INTO public.kitayverse VALUES (3, 'Rin', true, 999);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', false, 1700, true, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', false, 10, true, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', false, 5, true, 4);
INSERT INTO public.moon VALUES (4, 'Io', false, 1800, true, 5);
INSERT INTO public.moon VALUES (5, 'Europa', false, 1500, true, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', false, 2600, true, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', false, 2400, true, 5);
INSERT INTO public.moon VALUES (8, 'Amalthea', false, 80, true, 5);
INSERT INTO public.moon VALUES (9, 'Himalia', false, 70, true, 5);
INSERT INTO public.moon VALUES (10, 'Elara', false, 40, true, 5);
INSERT INTO public.moon VALUES (11, 'Pasiphae', false, 30, true, 5);
INSERT INTO public.moon VALUES (12, 'Sinope', false, 20, true, 5);
INSERT INTO public.moon VALUES (13, 'Lysithea', false, 20, true, 5);
INSERT INTO public.moon VALUES (14, 'Carme', false, 20, true, 5);
INSERT INTO public.moon VALUES (15, 'Ananke', false, 10, true, 5);
INSERT INTO public.moon VALUES (16, 'Leda', false, 10, true, 5);
INSERT INTO public.moon VALUES (17, 'Thebe', false, 50, true, 5);
INSERT INTO public.moon VALUES (18, 'Adrastea', false, 10, true, 5);
INSERT INTO public.moon VALUES (19, 'Metis', false, 20, true, 5);
INSERT INTO public.moon VALUES (20, 'Callirrhoe', false, 5, true, 5);
INSERT INTO public.moon VALUES (21, 'Themisto', false, 5, true, 5);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 167.0, false, 4);
INSERT INTO public.planet VALUES (2, 'Venus', 464.0, false, 4);
INSERT INTO public.planet VALUES (3, 'Earth', 15.0, true, 4);
INSERT INTO public.planet VALUES (4, 'Mars', -65.0, false, 4);
INSERT INTO public.planet VALUES (5, 'Jupiter', -110.0, false, 4);
INSERT INTO public.planet VALUES (6, 'Saturn', -190.0, false, 4);
INSERT INTO public.planet VALUES (7, 'Uranus', -210.0, false, 4);
INSERT INTO public.planet VALUES (8, 'Neptune', -200.0, false, 4);
INSERT INTO public.planet VALUES (9, 'Sirius b I', -100.0, false, 1);
INSERT INTO public.planet VALUES (10, 'Sirius b II', 20.0, false, 1);
INSERT INTO public.planet VALUES (11, 'Sirius b III', -50.0, false, 1);
INSERT INTO public.planet VALUES (12, 'Sirius b IV', 50.0, false, 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 10, 'Sirius', 'White', 4);
INSERT INTO public.star VALUES (2, 18, 'Rigel', 'Blue-white', 4);
INSERT INTO public.star VALUES (3, 15, 'Proxima Centauri', 'Red Dwarf', 4);
INSERT INTO public.star VALUES (4, 696340, 'Sun', 'Yellow', 4);
INSERT INTO public.star VALUES (5, 22, 'Alpheratz', 'Blue-white', 1);
INSERT INTO public.star VALUES (6, 28, 'Mirach', 'Red', 1);
INSERT INTO public.star VALUES (7, 32, 'Deneb Kaitos', 'Yellow', 5);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: kitayverse_kitayverse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.kitayverse_kitayverse_id_seq', 3, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: kitayverse kitayverse_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.kitayverse
    ADD CONSTRAINT kitayverse_name_key UNIQUE (name);


--
-- Name: kitayverse kitayverse_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.kitayverse
    ADD CONSTRAINT kitayverse_pkey PRIMARY KEY (kitayverse_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

