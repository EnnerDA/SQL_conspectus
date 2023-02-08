/* Создаётся таблица с н6ужным количеством строк в зависимости от даты указанной в блоке WHERE  и столбцами даты и названия дня недели.*/

SELECT DATE_ADD('2023-01-01', INTERVAL (ones.num + tens.num + hunders.num) DAY) dt,
DAYNAME(DATE_ADD('2023-01-01', INTERVAL (ones.num + tens.num + hunders.num) DAY)) day
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num ) ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num ) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num UNION ALL
SELECT 400 num ) hunders
WHERE DATE_ADD('2023-01-01', INTERVAL (ones.num + tens.num + hunders.num) DAY) 
BETWEEN '2023-02-01' AND '2023-03-01';

/*RESULT
+------------+-----------+
| dt         | day       |
+------------+-----------+
| 2023-02-01 | Wednesday |
| 2023-02-02 | Thursday  |
| 2023-02-03 | Friday    |
| 2023-02-04 | Saturday  |
| 2023-02-05 | Sunday    |
| 2023-02-06 | Monday    |
| 2023-02-07 | Tuesday   |
| 2023-02-08 | Wednesday |
| 2023-02-09 | Thursday  |
| 2023-02-10 | Friday    |
| 2023-02-11 | Saturday  |
| 2023-02-12 | Sunday    |
| 2023-02-13 | Monday    |
| 2023-02-14 | Tuesday   |
| 2023-02-15 | Wednesday |
| 2023-02-16 | Thursday  |
| 2023-02-17 | Friday    |
| 2023-02-18 | Saturday  |
| 2023-02-19 | Sunday    |
| 2023-02-20 | Monday    |
| 2023-02-21 | Tuesday   |
| 2023-02-22 | Wednesday |
| 2023-02-23 | Thursday  |
| 2023-02-24 | Friday    |
| 2023-02-25 | Saturday  |
| 2023-02-26 | Sunday    |
| 2023-02-27 | Monday    |
| 2023-02-28 | Tuesday   |
| 2023-03-01 | Wednesday |
+------------+-----------+*/
