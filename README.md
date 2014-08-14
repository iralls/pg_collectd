Using pg_stat_statements (http://www.postgresql.org/docs/9.3/static/pgstatstatements.html),
PostgreSQL very nicely records stored procedure execution times. This can be very handy to
measure and track. Given that PostgreSQL libraries default (as far as I have seen) to using
'SELECT * FROM <procedure_name>' when invoking stored procedures (something like 'callproc'
in psycopg2), this sql view provides collectd with a nice place to query for this information.
