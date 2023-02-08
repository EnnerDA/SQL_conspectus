/* 10.1 Напишите запрос, возвращающий все типы счетов и открытые счета этих типов (для соединения с таблицей product используйте столбец product_cd таблицы account). Должны быть включены все типы счетов, даже если не был открыт ни один счет определенного типа. */

SELECT p.product_cd, a.account_id, a.open_date
FROM product p LEFT OUTER JOIN account a
USING(product_cd);
/*RESULT
+------------+------------+------------+
| product_cd | account_id | open_date  |
+------------+------------+------------+
| AUT        |       NULL | NULL       |
| BUS        |         21 | 2002-10-01 |
| BUS        |         22 | 2004-03-22 |
| CD         |          3 | 2004-06-30 |
| CD         |         13 | 2004-12-28 |
| CD         |         14 | 2004-01-12 |
| CD         |         19 | 2004-06-30 |
| CHK        |          1 | 2000-01-15 |
| CHK        |          4 | 2001-03-12 |
| CHK        |          6 | 2002-11-23 |
| CHK        |          8 | 2003-09-12 |
| CHK        |         11 | 2004-01-27 |
| CHK        |         12 | 2002-08-24 |
| CHK        |         15 | 2001-05-23 |
| CHK        |         17 | 2003-07-30 |
| CHK        |         20 | 2002-09-30 |
| CHK        |         23 | 2003-07-30 |
| MM         |          7 | 2002-12-15 |
| MM         |         10 | 2004-09-30 |
| MM         |         18 | 2004-10-28 |
| MRT        |       NULL | NULL       |
| SAV        |          2 | 2000-01-15 |
| SAV        |          5 | 2001-03-12 |
| SAV        |          9 | 2000-01-15 |
| SAV        |         16 | 2001-05-23 |
| SBL        |         24 | 2004-02-22 |
+------------+------------+------------+
*/

/* 10.2 Переформулируйте запрос из упражнения 10.1 и примените другой тип внешнего соединения (т. е. если в упражнении 10.1 использовалось левостороннее внешнее соединение, используйте правостороннее), так чтобы результаты были, как в упражнении 10.1. */

SELECT p.product_cd, a.account_id, a.open_date
FROM account a RIGHT OUTER JOIN product p
USING(product_cd);

/* 10.3 Проведите внешнее соединение таблицы account с таблицами individual и business (посредством столбца account.cust_id) таким образом, чтобы результирующий набор содержал по одной строке для каждого счета. Должны быть включены столбцы count.account_id, account.product_cd, individual.fname, individual.lname и business.name.	*/

SELECT a.account_id, a.product_cd, i.fname, i.lname, b.name
FROM account a LEFT OUTER JOIN individual i USING(cust_id)
LEFT OUTER JOIN business b ON a.cust_id = b.cust_id;

/*RESULT 
+------------+------------+----------+---------+------------------------+
| account_id | product_cd | fname    | lname   | name                   |
+------------+------------+----------+---------+------------------------+
|          1 | CHK        | James    | Hadley  | NULL                   |
|          2 | SAV        | James    | Hadley  | NULL                   |
|          3 | CD         | James    | Hadley  | NULL                   |
|          4 | CHK        | Susan    | Tingley | NULL                   |
|          5 | SAV        | Susan    | Tingley | NULL                   |
|          6 | CHK        | Frank    | Tucker  | NULL                   |
|          7 | MM         | Frank    | Tucker  | NULL                   |
|          8 | CHK        | John     | Hayward | NULL                   |
|          9 | SAV        | John     | Hayward | NULL                   |
|         10 | MM         | John     | Hayward | NULL                   |
|         11 | CHK        | Charles  | Frasier | NULL                   |
|         12 | CHK        | John     | Spencer | NULL                   |
|         13 | CD         | John     | Spencer | NULL                   |
|         14 | CD         | Margaret | Young   | NULL                   |
|         15 | CHK        | Louis    | Blake   | NULL                   |
|         16 | SAV        | Louis    | Blake   | NULL                   |
|         17 | CHK        | Richard  | Farley  | NULL                   |
|         18 | MM         | Richard  | Farley  | NULL                   |
|         19 | CD         | Richard  | Farley  | NULL                   |
|         20 | CHK        | NULL     | NULL    | Chilton Engineering    |
|         21 | BUS        | NULL     | NULL    | Chilton Engineering    |
|         22 | BUS        | NULL     | NULL    | Northeast Cooling Inc. |
|         23 | CHK        | NULL     | NULL    | Superior Auto Body     |
|         24 | SBL        | NULL     | NULL    | AAA Insurance Inc.     |
+------------+------------+----------+---------+------------------------+ */

/* 10.4 Разработайте запрос, который сформирует набор {1, 2, 3,…, 99, 100}. 
(Совет: используйте перекрестное соединение как минимум с двумя подзапросами в блоке from.)	*/

select (ones.num + tens.num + handers.num)
from
(select 0 num UNION ALL
select 1 num UNION ALL
select 2 num UNION ALL
select 3 num UNION ALL
select 4 num UNION ALL
select 5 num UNION ALL
select 6 num UNION ALL
select 7 num UNION ALL
select 8 num UNION ALL
select 9 num) ones
CROSS JOIN
(select 0 num UNION ALL
select 10 num UNION ALL
select 20 num UNION ALL
select 30 num UNION ALL
select 40 num UNION ALL
select 50 num UNION ALL
select 60 num UNION ALL
select 70 num UNION ALL
select 80 num UNION ALL
select 90 num) tens
CROSS JOIN
(select 0 num UNION ALL
select 100 num) handers
WHERE (ones.num + tens.num + handers.num) BETWEEN 1 and 100;











