/* 3.1 Извлеките ID, имя и фамилию всех банковских сотрудников. Выполните сортировку по фамилии, а затем по имени.*/

SELECT emp_id, fname, lname
FROM employee
ORDER BY lname, fname;

/* Result
+--------+----------+-----------+
| emp_id | fname    | lname     |
+--------+----------+-----------+
|      2 | Susan    | Barker    |
|     13 | John     | Blake     |
|      6 | Helen    | Fleming   |
|     17 | Beth     | Fowler    |
|      5 | John     | Gooding   |
|      9 | Jane     | Grossman  |
|      4 | Susan    | Hawthorne |
|     12 | Samantha | Jameson   |
|     16 | Theresa  | Markham   |
|     14 | Cindy    | Mason     |
|      8 | Sarah    | Parker    |
|     15 | Frank    | Portman   |
|     10 | Paula    | Roberts   |
|      1 | Michael  | Smith     |
|      7 | Chris    | Tucker    |
|     18 | Rick     | Tulman    |
|      3 | Robert   | Tyler     |
|     11 | Thomas   | Ziegler   |
+--------+----------+-----------+
*/

/* 3.2 Извлеките ID счета, ID клиента и доступный остаток всех счетов, имеющих статус 'ACTIVE' (активный) и доступный остаток более 2500 долларов.*/

SELECT cust_id, account_id, avail_balance
FROM account
WHERE status = 'ACTIVE' AND avail_balance > 2500;

/*Result
+---------+------------+---------------+
| cust_id | account_id | avail_balance |
+---------+------------+---------------+
|       1 |          3 |       3000.00 |
|       4 |         10 |       5487.09 |
|       6 |         13 |      10000.00 |
|       7 |         14 |       5000.00 |
|       8 |         15 |       3487.19 |
|       9 |         18 |       9345.55 |
|      10 |         20 |      23575.12 |
|      11 |         22 |       9345.55 |
|      12 |         23 |      38552.05 |
|      13 |         24 |      50000.00 |
+---------+------------+---------------+
*/

/* 3.3 Напишите запрос к таблице account, возвращающий ID сотрудников, отрывших счета (используйте столбец account.open_emp_id). Результирующий набор должен включать по одной строке для каждого сотрудника.*/

SELECT DISTINCT open_emp_id
FROM account;

/*Result
+-------------+
| open_emp_id |
+-------------+
|           1 |
|          10 |
|          13 |
|          16 |
+-------------+
*/

/* 3.4 В этом запросе к нескольким наборам данных заполните пробелы (обозначенные как <число>) так, чтобы получить результат, приведенныйниже: 	
mysql> SELECT p.product_cd, a.cust_id, a.avail_balance 	
     > FROM product p INNER JOIN account <1> 	
     >   ON p.product_cd = <2> 	
     > WHERE p.<3> = 'ACCOUNT'; 
     */

SELECT p.product_cd, a.cust_id, a.
FROM product p INNER JOIN account
ON p.product_cd = a.product_cd
WHERE p.product_type_cd = 'ACCOUNT

/* Result
+------------+---------+---------------+
| product_cd | cust_id | avail_balance |
+------------+---------+---------------+
| CD         |       1 |       3000.00 |
| CD         |       6 |      10000.00 |
| CD         |       7 |       5000.00 |
| CD         |       9 |       1500.00 |
| CHK        |       1 |       1057.75 |
| CHK        |       2 |       2258.02 |
| CHK        |       3 |       1057.75 |
| CHK        |       4 |        534.12 |
| CHK        |       5 |       2237.97 |
| CHK        |       6 |        122.37 |
| CHK        |       8 |       3487.19 |
| CHK        |       9 |        125.67 |
| CHK        |      10 |      23575.12 |
| CHK        |      12 |      38552.05 |
| MM         |       3 |       2212.50 |
| MM         |       4 |       5487.09 |
| MM         |       9 |       9345.55 |
| SAV        |       1 |        500.00 |
| SAV        |       2 |        200.00 |
| SAV        |       4 |        767.77 |
| SAV        |       8 |        387.99 |
+------------+---------+---------------+
21 rows in set (0.00 sec)
*/     
     
  
