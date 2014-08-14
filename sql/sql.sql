CREATE EXTENSION pg_stat_statements;

CREATE OR REPLACE VIEW pg_procedure_stats AS WITH total_calls AS (
									SELECT SUM(calls)
									FROM pg_stat_statements
									WHERE substring(substring(left(regexp_replace(upper(query), '\s+', ' ', 'g'), 100) from 'FROM +[a-zA-Z_]+(?=\()') from '[a-zA-Z_]+$') IS NOT NULL
							)
							SELECT
								round((SUM(total_time) / SUM(calls))::numeric, 2) AS average_time,
								round((SUM(calls) / (SELECT * FROM total_calls) * 100), 2) AS percent_of_queries,
								substring(substring(left(regexp_replace(upper(query), '\s+', ' ', 'g'), 100) from 'FROM +[a-zA-Z_]+(?=\()') from '[a-zA-Z_]+$') AS query_short
							FROM pg_stat_statements
							WHERE substring(substring(left(regexp_replace(upper(query), '\s+', ' ', 'g'), 100) from 'FROM +[a-zA-Z_]+(?=\()') from '[a-zA-Z_]+$') IS NOT NULL
							GROUP BY query_short
							ORDER BY 1 DESC;
