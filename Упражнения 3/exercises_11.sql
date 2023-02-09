/* 11.1 Перепишите следующий запрос, использующий простое выражение case, таким образом, чтобы получить аналогичные результаты с помощью выражения case с перебором вариантов. Попытайтесь свести к минимуму количество блоков when.
SELECT emp_id, 	
  CASE title 	
    WHEN 'President' THEN 'Management' 	
    WHEN 'Vice President' THEN 'Management' 	
    WHEN 'Treasurer' THEN 'Management' 	
    WHEN 'Loan Manager' THEN 'Management' 	
    WHEN 'Operations Manager' THEN 'Operations' 	
    WHEN 'Head Teller' THEN 'Operations' 	
    WHEN 'Teller' THEN 'Operations' 	
    ELSE 'Unknown' 	
  END 	
FROM employee;	
*/
SELECT emp_id,
    CASE
        WHEN title IN ('President', 'Vice President', 'Treasurer', 'Loan Manager')  THEN 'Management'
        WHEN title IN ('Operations Manager', 'Head Teller', 'Teller') THEN 'Operations'
        ELSE 'Unknown'
    END Status
FROM employee;

/*RESULT
+--------+------------+
| emp_id | Status     |
+--------+------------+
|      1 | Management |
|      2 | Management |
|      3 | Management |
|      4 | Operations |
|      5 | Management |
|      6 | Operations |
|      7 | Operations |
|      8 | Operations |
|      9 | Operations |
|     10 | Operations |
|     11 | Operations |
|     12 | Operations |
|     13 | Operations |
|     14 | Operations |
|     15 | Operations |
|     16 | Operations |
|     17 | Operations |
|     18 | Operations |
+--------+------------+
18 rows in set (0.00 sec)
*/

/* 11.2 Перепишите следующий запрос так, чтобы результирующий набор содержал всего одну строку и четыре столбца (по одному для каждого отделения). Назовите столбцы branch_1, branch_2 и т. д.
mysql> SELECT open_branch_id, COUNT(*) 	
     > FROM account 	
     > GROUP BY open_branch_id; */
     
SELECT
(SELECT COUNT(*) FROM account WHERE open_branch_id = 1) branch_1,
(SELECT COUNT(*) FROM account WHERE open_branch_id = 2) branch_2,
(SELECT COUNT(*) FROM account WHERE open_branch_id = 3) branch_3,
(SELECT COUNT(*) FROM account WHERE open_branch_id = 4) branch_4;
/*RESULT
+----------+----------+----------+----------+
| branch_1 | branch_2 | branch_3 | branch_4 |
+----------+----------+----------+----------+
|        8 |        7 |        3 |        6 |
+----------+----------+----------+----------+
*/



