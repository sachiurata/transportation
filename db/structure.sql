SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger;


--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger_data;


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA topology;


--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id bigint NOT NULL,
    user_name character varying NOT NULL,
    password_digest character varying NOT NULL,
    role integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: answer_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.answer_options (
    id bigint NOT NULL,
    answer_id bigint NOT NULL,
    question_option_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: answer_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.answer_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answer_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.answer_options_id_seq OWNED BY public.answer_options.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.answers (
    id bigint NOT NULL,
    subject_type character varying NOT NULL,
    subject_id bigint NOT NULL,
    question_id bigint NOT NULL,
    free_text text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN answers.subject_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.answers.subject_id IS '''Child''など';


--
-- Name: COLUMN answers.free_text; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.answers.free_text IS '自由回答';


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: children; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.children (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    postcode character varying,
    school_name character varying,
    grade integer NOT NULL,
    school_type integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN children.school_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.children.school_type IS 'enum: elementary, secondary, high';


--
-- Name: children_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.children_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: children_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.children_id_seq OWNED BY public.children.id;


--
-- Name: question_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.question_options (
    id bigint NOT NULL,
    question_id bigint NOT NULL,
    text character varying NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN question_options.text; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.question_options.text IS '選択肢の文言';


--
-- Name: COLUMN question_options.display_order; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.question_options.display_order IS '表示順';


--
-- Name: question_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.question_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: question_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.question_options_id_seq OWNED BY public.question_options.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id bigint NOT NULL,
    text text NOT NULL,
    question_type integer NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN questions.text; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.questions.text IS '質問文';


--
-- Name: COLUMN questions.question_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.questions.question_type IS 'enum: multiple_choice, free_text, multiple_choice_and_free_text';


--
-- Name: COLUMN questions.display_order; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.questions.display_order IS '表示順';


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: requested_routes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.requested_routes (
    id bigint NOT NULL,
    subject_type character varying NOT NULL,
    subject_id bigint NOT NULL,
    start_point_name character varying,
    start_point_location public.geometry NOT NULL,
    end_point_name character varying,
    end_point_location public.geometry NOT NULL,
    purpose character varying,
    comment text,
    is_existing_service_available boolean NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    survey_id bigint NOT NULL
);


--
-- Name: COLUMN requested_routes.start_point_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_routes.start_point_name IS '出発地名';


--
-- Name: COLUMN requested_routes.start_point_location; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_routes.start_point_location IS '出発地点';


--
-- Name: COLUMN requested_routes.end_point_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_routes.end_point_name IS '目的地名';


--
-- Name: COLUMN requested_routes.end_point_location; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_routes.end_point_location IS '目的地点';


--
-- Name: COLUMN requested_routes.purpose; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_routes.purpose IS '通学,部活,習い事など';


--
-- Name: requested_routes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.requested_routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requested_routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.requested_routes_id_seq OWNED BY public.requested_routes.id;


--
-- Name: requested_times; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.requested_times (
    id bigint NOT NULL,
    requested_route_id bigint NOT NULL,
    requested_day character varying NOT NULL,
    requested_time time without time zone NOT NULL,
    departure_or_arrival character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN requested_times.requested_day; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_times.requested_day IS '曜日';


--
-- Name: COLUMN requested_times.requested_time; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_times.requested_time IS '希望時間帯';


--
-- Name: COLUMN requested_times.departure_or_arrival; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.requested_times.departure_or_arrival IS '出発 or 到着';


--
-- Name: requested_times_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.requested_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requested_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.requested_times_id_seq OWNED BY public.requested_times.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.surveys (
    id bigint NOT NULL,
    admin_user_id bigint NOT NULL,
    survey_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.surveys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.surveys_id_seq OWNED BY public.surveys.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    postcode character varying,
    num_of_objects integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN user_profiles.num_of_objects; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.user_profiles.num_of_objects IS '調査対象者の数';


--
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    user_name character varying NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: answer_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answer_options ALTER COLUMN id SET DEFAULT nextval('public.answer_options_id_seq'::regclass);


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: children id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.children ALTER COLUMN id SET DEFAULT nextval('public.children_id_seq'::regclass);


--
-- Name: question_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options ALTER COLUMN id SET DEFAULT nextval('public.question_options_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: requested_routes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_routes ALTER COLUMN id SET DEFAULT nextval('public.requested_routes_id_seq'::regclass);


--
-- Name: requested_times id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_times ALTER COLUMN id SET DEFAULT nextval('public.requested_times_id_seq'::regclass);


--
-- Name: surveys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surveys ALTER COLUMN id SET DEFAULT nextval('public.surveys_id_seq'::regclass);


--
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: answer_options answer_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answer_options
    ADD CONSTRAINT answer_options_pkey PRIMARY KEY (id);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: children children_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_pkey PRIMARY KEY (id);


--
-- Name: question_options question_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: requested_routes requested_routes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_routes
    ADD CONSTRAINT requested_routes_pkey PRIMARY KEY (id);


--
-- Name: requested_times requested_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_times
    ADD CONSTRAINT requested_times_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: surveys surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surveys
    ADD CONSTRAINT surveys_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_admin_users_on_user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_user_name ON public.admin_users USING btree (user_name);


--
-- Name: index_answer_options_on_answer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answer_options_on_answer_id ON public.answer_options USING btree (answer_id);


--
-- Name: index_answer_options_on_question_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answer_options_on_question_option_id ON public.answer_options USING btree (question_option_id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_question_id ON public.answers USING btree (question_id);


--
-- Name: index_answers_on_subject; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_subject ON public.answers USING btree (subject_type, subject_id);


--
-- Name: index_children_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_children_on_user_id ON public.children USING btree (user_id);


--
-- Name: index_question_options_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_question_options_on_question_id ON public.question_options USING btree (question_id);


--
-- Name: index_requested_routes_on_subject; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_requested_routes_on_subject ON public.requested_routes USING btree (subject_type, subject_id);


--
-- Name: index_requested_routes_on_survey_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_requested_routes_on_survey_id ON public.requested_routes USING btree (survey_id);


--
-- Name: index_requested_times_on_requested_route_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_requested_times_on_requested_route_id ON public.requested_times USING btree (requested_route_id);


--
-- Name: index_surveys_on_admin_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_surveys_on_admin_user_id ON public.surveys USING btree (admin_user_id);


--
-- Name: index_user_profiles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_profiles_on_user_id ON public.user_profiles USING btree (user_id);


--
-- Name: requested_times fk_rails_16f74434d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_times
    ADD CONSTRAINT fk_rails_16f74434d3 FOREIGN KEY (requested_route_id) REFERENCES public.requested_routes(id);


--
-- Name: answers fk_rails_3d5ed4418f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_rails_3d5ed4418f FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: user_profiles fk_rails_87a6352e58; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT fk_rails_87a6352e58 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: children fk_rails_a51d7cfb22; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT fk_rails_a51d7cfb22 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: answer_options fk_rails_acb3faeaf6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answer_options
    ADD CONSTRAINT fk_rails_acb3faeaf6 FOREIGN KEY (question_option_id) REFERENCES public.question_options(id);


--
-- Name: question_options fk_rails_b9c5f61cf9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT fk_rails_b9c5f61cf9 FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: answer_options fk_rails_c8739a0222; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answer_options
    ADD CONSTRAINT fk_rails_c8739a0222 FOREIGN KEY (answer_id) REFERENCES public.answers(id);


--
-- Name: surveys fk_rails_df5d515ccb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surveys
    ADD CONSTRAINT fk_rails_df5d515ccb FOREIGN KEY (admin_user_id) REFERENCES public.admin_users(id);


--
-- Name: requested_routes fk_rails_f315e5e539; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requested_routes
    ADD CONSTRAINT fk_rails_f315e5e539 FOREIGN KEY (survey_id) REFERENCES public.surveys(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public, topology, tiger;

INSERT INTO "schema_migrations" (version) VALUES
('20251015082350'),
('20251015081523'),
('20251015075319'),
('20251009080532'),
('20251009050239'),
('20251009050153'),
('20251009050009'),
('20251009045848'),
('20251009045639'),
('20251009044953'),
('20250904235509'),
('20250904051813'),
('20250904035633'),
('20250904033230'),
('20250904030955'),
('20250904000000');

