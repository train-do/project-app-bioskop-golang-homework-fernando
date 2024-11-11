--
-- PostgreSQL database dump
--

-- Dumped from database version 16rc1
-- Dumped by pg_dump version 16rc1

-- Started on 2024-11-11 20:49:34

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 27270)
-- Name: Cinema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cinema" (
    id integer NOT NULL,
    name character varying NOT NULL,
    location character varying NOT NULL,
    seats integer NOT NULL
);


ALTER TABLE public."Cinema" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 27295)
-- Name: CinemaSeat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CinemaSeat" (
    id integer NOT NULL,
    cinema_id integer NOT NULL,
    seat_id integer NOT NULL
);


ALTER TABLE public."CinemaSeat" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 27312)
-- Name: CinemaSeatSchedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CinemaSeatSchedule" (
    id integer NOT NULL,
    cinema_seat_id integer NOT NULL,
    schedule_id integer NOT NULL,
    status character varying DEFAULT 'available'::character varying NOT NULL
);


ALTER TABLE public."CinemaSeatSchedule" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 27311)
-- Name: CinemaSeatSchedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CinemaSeatSchedule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CinemaSeatSchedule_id_seq" OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 229
-- Name: CinemaSeatSchedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CinemaSeatSchedule_id_seq" OWNED BY public."CinemaSeatSchedule".id;


--
-- TOC entry 227 (class 1259 OID 27294)
-- Name: CinemaSeat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CinemaSeat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CinemaSeat_id_seq" OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 227
-- Name: CinemaSeat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CinemaSeat_id_seq" OWNED BY public."CinemaSeat".id;


--
-- TOC entry 221 (class 1259 OID 27269)
-- Name: Cinema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cinema_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cinema_id_seq" OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 221
-- Name: Cinema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cinema_id_seq" OWNED BY public."Cinema".id;


--
-- TOC entry 232 (class 1259 OID 27332)
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    order_code character varying NOT NULL,
    cinema_seat_schedule_id integer NOT NULL,
    transaction_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 27331)
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_id_seq" OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 231
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 218 (class 1259 OID 27245)
-- Name: Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payment" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Payment" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 27244)
-- Name: Payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Payment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Payment_id_seq" OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 217
-- Name: Payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Payment_id_seq" OWNED BY public."Payment".id;


--
-- TOC entry 226 (class 1259 OID 27288)
-- Name: Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Schedule" (
    id integer NOT NULL,
    date date NOT NULL,
    "time" time(0) without time zone NOT NULL
);


ALTER TABLE public."Schedule" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 27287)
-- Name: Schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Schedule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Schedule_id_seq" OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 225
-- Name: Schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Schedule_id_seq" OWNED BY public."Schedule".id;


--
-- TOC entry 224 (class 1259 OID 27279)
-- Name: Seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seat" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Seat" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 27278)
-- Name: Seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Seat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Seat_id_seq" OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 223
-- Name: Seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Seat_id_seq" OWNED BY public."Seat".id;


--
-- TOC entry 220 (class 1259 OID 27254)
-- Name: Transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    transaction_code character varying NOT NULL,
    payment_id integer NOT NULL,
    payment_details json NOT NULL
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 27253)
-- Name: Transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transaction_id_seq" OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 219
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- TOC entry 216 (class 1259 OID 27231)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    email character varying NOT NULL,
    token character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 27230)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 215
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 4732 (class 2604 OID 27273)
-- Name: Cinema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema" ALTER COLUMN id SET DEFAULT nextval('public."Cinema_id_seq"'::regclass);


--
-- TOC entry 4735 (class 2604 OID 27298)
-- Name: CinemaSeat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeat" ALTER COLUMN id SET DEFAULT nextval('public."CinemaSeat_id_seq"'::regclass);


--
-- TOC entry 4736 (class 2604 OID 27315)
-- Name: CinemaSeatSchedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeatSchedule" ALTER COLUMN id SET DEFAULT nextval('public."CinemaSeatSchedule_id_seq"'::regclass);


--
-- TOC entry 4738 (class 2604 OID 27335)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 4730 (class 2604 OID 27248)
-- Name: Payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment" ALTER COLUMN id SET DEFAULT nextval('public."Payment_id_seq"'::regclass);


--
-- TOC entry 4734 (class 2604 OID 27291)
-- Name: Schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule" ALTER COLUMN id SET DEFAULT nextval('public."Schedule_id_seq"'::regclass);


--
-- TOC entry 4733 (class 2604 OID 27282)
-- Name: Seat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat" ALTER COLUMN id SET DEFAULT nextval('public."Seat_id_seq"'::regclass);


--
-- TOC entry 4731 (class 2604 OID 27257)
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- TOC entry 4728 (class 2604 OID 27234)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 4923 (class 0 OID 27270)
-- Dependencies: 222
-- Data for Name: Cinema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cinema" (id, name, location, seats) FROM stdin;
1	Cinema XXI	Jakarta	100
2	Cinema CGV	Bandung	90
\.


--
-- TOC entry 4929 (class 0 OID 27295)
-- Dependencies: 228
-- Data for Name: CinemaSeat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CinemaSeat" (id, cinema_id, seat_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
45	1	45
46	1	46
47	1	47
48	1	48
49	1	49
50	1	50
51	1	51
52	1	52
53	1	53
54	1	54
55	1	55
56	1	56
57	1	57
58	1	58
59	1	59
60	1	60
61	1	61
62	1	62
63	1	63
64	1	64
65	1	65
66	1	66
67	1	67
68	1	68
69	1	69
70	1	70
71	1	71
72	1	72
73	1	73
74	1	74
75	1	75
76	1	76
77	1	77
78	1	78
79	1	79
80	1	80
81	1	81
82	1	82
83	1	83
84	1	84
85	1	85
86	1	86
87	1	87
88	1	88
89	1	89
90	1	90
91	1	91
92	1	92
93	1	93
94	1	94
95	1	95
96	1	96
97	1	97
98	1	98
99	1	99
100	1	100
101	2	1
102	2	2
103	2	3
104	2	4
105	2	5
106	2	6
107	2	7
108	2	8
109	2	9
110	2	10
111	2	11
112	2	12
113	2	13
114	2	14
115	2	15
116	2	16
117	2	17
118	2	18
119	2	19
120	2	20
121	2	21
122	2	22
123	2	23
124	2	24
125	2	25
126	2	26
127	2	27
128	2	28
129	2	29
130	2	30
131	2	31
132	2	32
133	2	33
134	2	34
135	2	35
136	2	36
137	2	37
138	2	38
139	2	39
140	2	40
141	2	41
142	2	42
143	2	43
144	2	44
145	2	45
146	2	46
147	2	47
148	2	48
149	2	49
150	2	50
151	2	51
152	2	52
153	2	53
154	2	54
155	2	55
156	2	56
157	2	57
158	2	58
159	2	59
160	2	60
161	2	61
162	2	62
163	2	63
164	2	64
165	2	65
166	2	66
167	2	67
168	2	68
169	2	69
170	2	70
171	2	71
172	2	72
173	2	73
174	2	74
175	2	75
176	2	76
177	2	77
178	2	78
179	2	79
180	2	80
181	2	81
182	2	82
183	2	83
184	2	84
185	2	85
186	2	86
187	2	87
188	2	88
189	2	89
190	2	90
191	2	91
192	2	92
193	2	93
194	2	94
195	2	95
196	2	96
197	2	97
198	2	98
199	2	99
200	2	100
\.


--
-- TOC entry 4931 (class 0 OID 27312)
-- Dependencies: 230
-- Data for Name: CinemaSeatSchedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CinemaSeatSchedule" (id, cinema_seat_id, schedule_id, status) FROM stdin;
1	1	1	available
2	2	1	available
3	3	1	available
4	4	1	available
5	5	1	available
6	6	1	available
7	7	1	available
8	8	1	available
9	9	1	available
10	10	1	available
11	11	1	available
12	12	1	available
13	13	1	available
14	14	1	available
15	15	1	available
16	16	1	available
17	17	1	available
18	18	1	available
19	19	1	available
20	20	1	available
21	21	1	available
22	22	1	available
23	23	1	available
24	24	1	available
25	25	1	available
26	26	1	available
27	27	1	available
28	28	1	available
29	29	1	available
30	30	1	available
31	31	1	available
32	32	1	available
33	33	1	available
34	34	1	available
35	35	1	available
36	36	1	available
37	37	1	available
38	38	1	available
39	39	1	available
40	40	1	available
41	41	1	available
42	42	1	available
43	43	1	available
44	44	1	available
45	45	1	available
46	46	1	available
47	47	1	available
48	48	1	available
49	49	1	available
50	50	1	available
51	51	1	available
52	52	1	available
53	53	1	available
54	54	1	available
55	55	1	available
56	56	1	available
57	57	1	available
58	58	1	available
59	59	1	available
60	60	1	available
61	61	1	available
62	62	1	available
63	63	1	available
64	64	1	available
65	65	1	available
66	66	1	available
67	67	1	available
68	68	1	available
69	69	1	available
70	70	1	available
71	71	1	available
72	72	1	available
73	73	1	available
74	74	1	available
75	75	1	available
76	76	1	available
77	77	1	available
78	78	1	available
79	79	1	available
80	80	1	available
81	81	1	available
82	82	1	available
83	83	1	available
84	84	1	available
85	85	1	available
86	86	1	available
87	87	1	available
88	88	1	available
89	89	1	available
90	90	1	available
91	91	1	available
92	92	1	available
93	93	1	available
94	94	1	available
95	95	1	available
96	96	1	available
97	97	1	available
98	98	1	available
99	99	1	available
100	100	1	available
101	101	1	available
102	102	1	available
103	103	1	available
104	104	1	available
105	105	1	available
106	106	1	available
107	107	1	available
108	108	1	available
109	109	1	available
110	110	1	available
111	111	1	available
112	112	1	available
113	113	1	available
114	114	1	available
115	115	1	available
116	116	1	available
117	117	1	available
118	118	1	available
119	119	1	available
120	120	1	available
121	121	1	available
122	122	1	available
123	123	1	available
124	124	1	available
125	125	1	available
126	126	1	available
127	127	1	available
128	128	1	available
129	129	1	available
130	130	1	available
131	131	1	available
132	132	1	available
133	133	1	available
134	134	1	available
135	135	1	available
136	136	1	available
137	137	1	available
138	138	1	available
139	139	1	available
140	140	1	available
141	141	1	available
142	142	1	available
143	143	1	available
144	144	1	available
145	145	1	available
146	146	1	available
147	147	1	available
148	148	1	available
149	149	1	available
150	150	1	available
151	151	1	available
152	152	1	available
153	153	1	available
154	154	1	available
155	155	1	available
156	156	1	available
157	157	1	available
158	158	1	available
159	159	1	available
160	160	1	available
161	161	1	available
162	162	1	available
163	163	1	available
164	164	1	available
165	165	1	available
166	166	1	available
167	167	1	available
168	168	1	available
169	169	1	available
170	170	1	available
171	171	1	available
172	172	1	available
173	173	1	available
174	174	1	available
175	175	1	available
176	176	1	available
177	177	1	available
178	178	1	available
179	179	1	available
180	180	1	available
181	181	1	available
182	182	1	available
183	183	1	available
184	184	1	available
185	185	1	available
186	186	1	available
187	187	1	available
188	188	1	available
189	189	1	available
190	190	1	available
191	191	1	available
192	192	1	available
193	193	1	available
194	194	1	available
195	195	1	available
196	196	1	available
197	197	1	available
198	198	1	available
199	199	1	available
200	200	1	available
201	1	2	available
202	2	2	available
203	3	2	available
204	4	2	available
205	5	2	available
206	6	2	available
207	7	2	available
208	8	2	available
209	9	2	available
210	10	2	available
211	11	2	available
212	12	2	available
213	13	2	available
214	14	2	available
215	15	2	available
216	16	2	available
217	17	2	available
218	18	2	available
219	19	2	available
220	20	2	available
221	21	2	available
222	22	2	available
223	23	2	available
224	24	2	available
225	25	2	available
226	26	2	available
227	27	2	available
228	28	2	available
229	29	2	available
230	30	2	available
231	31	2	available
232	32	2	available
233	33	2	available
234	34	2	available
235	35	2	available
236	36	2	available
237	37	2	available
238	38	2	available
239	39	2	available
240	40	2	available
241	41	2	available
242	42	2	available
243	43	2	available
244	44	2	available
245	45	2	available
246	46	2	available
247	47	2	available
248	48	2	available
249	49	2	available
250	50	2	available
251	51	2	available
252	52	2	available
253	53	2	available
254	54	2	available
255	55	2	available
256	56	2	available
257	57	2	available
258	58	2	available
259	59	2	available
260	60	2	available
261	61	2	available
262	62	2	available
263	63	2	available
264	64	2	available
265	65	2	available
266	66	2	available
267	67	2	available
268	68	2	available
269	69	2	available
270	70	2	available
271	71	2	available
272	72	2	available
273	73	2	available
274	74	2	available
275	75	2	available
276	76	2	available
277	77	2	available
278	78	2	available
279	79	2	available
280	80	2	available
281	81	2	available
282	82	2	available
283	83	2	available
284	84	2	available
285	85	2	available
286	86	2	available
287	87	2	available
288	88	2	available
289	89	2	available
290	90	2	available
291	91	2	available
292	92	2	available
293	93	2	available
294	94	2	available
295	95	2	available
296	96	2	available
297	97	2	available
298	98	2	available
299	99	2	available
300	100	2	available
301	101	2	available
302	102	2	available
303	103	2	available
304	104	2	available
305	105	2	available
306	106	2	available
307	107	2	available
308	108	2	available
309	109	2	available
310	110	2	available
311	111	2	available
312	112	2	available
313	113	2	available
314	114	2	available
315	115	2	available
316	116	2	available
317	117	2	available
318	118	2	available
319	119	2	available
320	120	2	available
321	121	2	available
322	122	2	available
323	123	2	available
324	124	2	available
325	125	2	available
326	126	2	available
327	127	2	available
328	128	2	available
329	129	2	available
330	130	2	available
331	131	2	available
332	132	2	available
333	133	2	available
334	134	2	available
335	135	2	available
336	136	2	available
337	137	2	available
338	138	2	available
339	139	2	available
340	140	2	available
341	141	2	available
342	142	2	available
343	143	2	available
344	144	2	available
345	145	2	available
346	146	2	available
347	147	2	available
348	148	2	available
349	149	2	available
350	150	2	available
351	151	2	available
352	152	2	available
353	153	2	available
354	154	2	available
355	155	2	available
356	156	2	available
357	157	2	available
358	158	2	available
359	159	2	available
360	160	2	available
361	161	2	available
362	162	2	available
363	163	2	available
364	164	2	available
365	165	2	available
366	166	2	available
367	167	2	available
368	168	2	available
369	169	2	available
370	170	2	available
371	171	2	available
372	172	2	available
373	173	2	available
374	174	2	available
375	175	2	available
376	176	2	available
377	177	2	available
378	178	2	available
379	179	2	available
380	180	2	available
381	181	2	available
382	182	2	available
383	183	2	available
384	184	2	available
385	185	2	available
386	186	2	available
387	187	2	available
388	188	2	available
389	189	2	available
390	190	2	available
391	191	2	available
392	192	2	available
393	193	2	available
394	194	2	available
395	195	2	available
396	196	2	available
397	197	2	available
398	198	2	available
399	199	2	available
400	200	2	available
\.


--
-- TOC entry 4933 (class 0 OID 27332)
-- Dependencies: 232
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, order_code, cinema_seat_schedule_id, transaction_id, user_id) FROM stdin;
\.


--
-- TOC entry 4919 (class 0 OID 27245)
-- Dependencies: 218
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" (id, name) FROM stdin;
1	Credit Card
2	Bank Transfer
3	Digital Wallet
\.


--
-- TOC entry 4927 (class 0 OID 27288)
-- Dependencies: 226
-- Data for Name: Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Schedule" (id, date, "time") FROM stdin;
1	2024-11-10	18:00:00
2	2024-11-10	21:00:00
\.


--
-- TOC entry 4925 (class 0 OID 27279)
-- Dependencies: 224
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seat" (id, name) FROM stdin;
1	A1
2	A2
3	A3
4	A4
5	A5
6	A6
7	A7
8	A8
9	A9
10	A10
11	B1
12	B2
13	B3
14	B4
15	B5
16	B6
17	B7
18	B8
19	B9
20	B10
21	C1
22	C2
23	C3
24	C4
25	C5
26	C6
27	C7
28	C8
29	C9
30	C10
31	D1
32	D2
33	D3
34	D4
35	D5
36	D6
37	D7
38	D8
39	D9
40	D10
41	E1
42	E2
43	E3
44	E4
45	E5
46	E6
47	E7
48	E8
49	E9
50	E10
51	F1
52	F2
53	F3
54	F4
55	F5
56	F6
57	F7
58	F8
59	F9
60	F10
61	G1
62	G2
63	G3
64	G4
65	G5
66	G6
67	G7
68	G8
69	G9
70	G10
71	H1
72	H2
73	H3
74	H4
75	H5
76	H6
77	H7
78	H8
79	H9
80	H10
81	I1
82	I2
83	I3
84	I4
85	I5
86	I6
87	I7
88	I8
89	I9
90	I10
91	J1
92	J2
93	J3
94	J4
95	J5
96	J6
97	J7
98	J8
99	J9
100	J10
\.


--
-- TOC entry 4921 (class 0 OID 27254)
-- Dependencies: 220
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaction" (id, transaction_code, payment_id, payment_details) FROM stdin;
\.


--
-- TOC entry 4917 (class 0 OID 27231)
-- Dependencies: 216
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, username, password, email, token) FROM stdin;
\.


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 229
-- Name: CinemaSeatSchedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CinemaSeatSchedule_id_seq"', 400, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 227
-- Name: CinemaSeat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CinemaSeat_id_seq"', 200, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 221
-- Name: Cinema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cinema_id_seq"', 2, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 231
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 217
-- Name: Payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Payment_id_seq"', 3, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 225
-- Name: Schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Schedule_id_seq"', 2, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 223
-- Name: Seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Seat_id_seq"', 100, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 219
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 1, false);


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 215
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- TOC entry 4760 (class 2606 OID 27320)
-- Name: CinemaSeatSchedule CinemaSeatSchedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeatSchedule"
    ADD CONSTRAINT "CinemaSeatSchedule_pkey" PRIMARY KEY (id);


--
-- TOC entry 4758 (class 2606 OID 27300)
-- Name: CinemaSeat CinemaSeat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeat"
    ADD CONSTRAINT "CinemaSeat_pkey" PRIMARY KEY (id);


--
-- TOC entry 4752 (class 2606 OID 27277)
-- Name: Cinema Cinema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema"
    ADD CONSTRAINT "Cinema_pkey" PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2606 OID 27341)
-- Name: Order Order_order_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_order_code_key" UNIQUE (order_code);


--
-- TOC entry 4764 (class 2606 OID 27339)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 4746 (class 2606 OID 27252)
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- TOC entry 4756 (class 2606 OID 27293)
-- Name: Schedule Schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_pkey" PRIMARY KEY (id);


--
-- TOC entry 4754 (class 2606 OID 27286)
-- Name: Seat Seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_pkey" PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 27261)
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- TOC entry 4750 (class 2606 OID 27263)
-- Name: Transaction Transaction_transaction_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_transaction_code_key" UNIQUE (transaction_code);


--
-- TOC entry 4740 (class 2606 OID 27243)
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- TOC entry 4742 (class 2606 OID 27239)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4744 (class 2606 OID 27241)
-- Name: User User_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);


--
-- TOC entry 4768 (class 2606 OID 27321)
-- Name: CinemaSeatSchedule CinemaSeatSchedule_cinema_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeatSchedule"
    ADD CONSTRAINT "CinemaSeatSchedule_cinema_seat_id_fkey" FOREIGN KEY (cinema_seat_id) REFERENCES public."CinemaSeat"(id);


--
-- TOC entry 4769 (class 2606 OID 27326)
-- Name: CinemaSeatSchedule CinemaSeatSchedule_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeatSchedule"
    ADD CONSTRAINT "CinemaSeatSchedule_schedule_id_fkey" FOREIGN KEY (schedule_id) REFERENCES public."Schedule"(id);


--
-- TOC entry 4766 (class 2606 OID 27301)
-- Name: CinemaSeat CinemaSeat_cinema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeat"
    ADD CONSTRAINT "CinemaSeat_cinema_id_fkey" FOREIGN KEY (cinema_id) REFERENCES public."Cinema"(id);


--
-- TOC entry 4767 (class 2606 OID 27306)
-- Name: CinemaSeat CinemaSeat_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CinemaSeat"
    ADD CONSTRAINT "CinemaSeat_seat_id_fkey" FOREIGN KEY (seat_id) REFERENCES public."Seat"(id);


--
-- TOC entry 4770 (class 2606 OID 27342)
-- Name: Order Order_cinema_seat_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_cinema_seat_schedule_id_fkey" FOREIGN KEY (cinema_seat_schedule_id) REFERENCES public."CinemaSeatSchedule"(id);


--
-- TOC entry 4771 (class 2606 OID 27347)
-- Name: Order Order_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES public."Transaction"(id);


--
-- TOC entry 4772 (class 2606 OID 27352)
-- Name: Order Order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- TOC entry 4765 (class 2606 OID 27264)
-- Name: Transaction Transaction_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_payment_id_fkey" FOREIGN KEY (payment_id) REFERENCES public."Payment"(id);


-- Completed on 2024-11-11 20:49:34

--
-- PostgreSQL database dump complete
--

