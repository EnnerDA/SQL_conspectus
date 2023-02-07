/* 9.1 Создайте запрос к таблице account, использующий условие фильтрации с несвязанным подзапросом к таблице product для поиска всех кредитных счетов (product.product_type_cd = 'LOAN'). Должны быть выбраны ID счета, код счета, ID клиента и доступный остаток.	*/

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN 
(SELECT product_cd from product where product_type_cd = 'LOAN');
/* RESULT 
+------------+------------+---------+---------------+
| account_id | product_cd | cust_id | avail_balance |
+------------+------------+---------+---------------+
|         21 | BUS        |      10 |          0.00 |
|         22 | BUS        |      11 |       9345.55 |
|         24 | SBL        |      13 |      50000.00 |
+------------+------------+---------+---------------+
3 rows in set (0.00 sec)*/

/* 9.2 Переработайте запрос из упражнения 9.1, используя связанный подзапрос к таблице product для получения того же результата. */

SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account a
WHERE EXISTS(
 SELECT 1
 FROM product p
 WHERE p.product_type_cd = 'LOAN'
   AND p.product_cd = a.product_cd);
/*RESULT 
+------------+------------+---------+---------------+
| account_id | product_cd | cust_id | avail_balance |
+------------+------------+---------+---------------+
|         21 | BUS        |      10 |          0.00 |
|         22 | BUS        |      11 |       9345.55 |
|         24 | SBL        |      13 |      50000.00 |
+------------+------------+---------+---------------+
3 rows in set (0.00 sec)*/

*/ 9.3 Соедините следующий запрос с таблицей employee, чтобы показать уровень квалификации каждого сотрудника:
SELECT 'trainee' name, '2004 01 01' start_dt, '2005 12 31' end_dt 	
UNION ALL 	
SELECT 'worker' name, '2002 01 01' start_dt, '2003 12 31' end_dt 	
UNION ALL 	
SELECT 'mentor' name, '2000 01 01' start_dt, '2001 12 31' end_d	

Дайте подзапросу псевдоним levels (уровни) и включите ID сотрудника, имя, фамилию и квалификацию (levels.name). (Совет: в условии соединения определяйте диапазон, в который попадает столбец employee.start_date, с помощью условия неравенства.)	

SELECT e.emp_id, e.fname, e.lname, lavel.name
FROM employee e INNER JOIN (
SELECT 'trainee' name, '2004 01 01' start_dt, '2005 12 31' end_dt
UNION ALL
SELECT 'worker' name, '2002 01 01' start_dt, '2003 12 31' end_dt
UNION ALL
SELECT 'mentor' name, '2000 01 01' start_dt, '2001 12 31' end_d)
lavel
ON e.start_date BETWEEN lavel.start_dt AND lavel.end_dt;
/*RESULT
+--------+--------+-----------+---------+
| emp_id | fname  | lname     | name    |
+--------+--------+-----------+---------+
|      6 | Helen  | Fleming   | trainee |
|      7 | Chris  | Tucker    | trainee |
|      2 | Susan  | Barker    | worker  |
|      4 | Susan  | Hawthorne | worker  |
|      8 | Sarah  | Parker    | worker  |
|      9 | Jane   | Grossman  | worker  |
|     10 | Paula  | Roberts   | worker  |
|     14 | Cindy  | Mason     | worker  |
|     17 | Beth   | Fowler    | worker  |
|     18 | Rick   | Tulman    | worker  |
|      3 | Robert | Tyler     | mentor  |
|     11 | Thomas | Ziegler   | mentor  |
|     13 | John   | Blake     | mentor  |
+--------+--------+-----------+---------+*/

/* 9.4 Создайте запрос к таблице employee для получения ID, имени и фамилии сотрудника вместе с названиями отдела и отделения, к которым он приписан. Не используйте соединение таблиц.	*/
 SELECT e.emp_id ID, CONCAT(e.fname, ' ', e.lname) Employee,
 (SELECT d.name FROM department d WHERE e.dept_id = d.dept_id) Departament,
 (SELECT b.name FROM branch b WHERE b.branch_id = e.assigned_branch_id) Branch
 FROM employee e;
/*RESULT
+----+------------------+----------------+---------------+
| ID | Employee         | Departament    | Branch        |
+----+------------------+----------------+---------------+
|  1 | Michael Smith    | Administration | Headquarters  |
|  2 | Susan Barker     | Administration | Headquarters  |
|  3 | Robert Tyler     | Administration | Headquarters  |
|  4 | Susan Hawthorne  | Operations     | Headquarters  |
|  5 | John Gooding     | Loans          | Headquarters  |
|  6 | Helen Fleming    | Operations     | Headquarters  |
|  7 | Chris Tucker     | Operations     | Headquarters  |
|  8 | Sarah Parker     | Operations     | Headquarters  |
|  9 | Jane Grossman    | Operations     | Headquarters  |
| 10 | Paula Roberts    | Operations     | Woburn Branch |
| 11 | Thomas Ziegler   | Operations     | Woburn Branch |
| 12 | Samantha Jameson | Operations     | Woburn Branch |
| 13 | John Blake       | Operations     | Quincy Branch |
| 14 | Cindy Mason      | Operations     | Quincy Branch |
| 15 | Frank Portman    | Operations     | Quincy Branch |
| 16 | Theresa Markham  | Operations     | So. NH Branch |
| 17 | Beth Fowler      | Operations     | So. NH Branch |
| 18 | Rick Tulman      | Operations     | So. NH Branch |
+----+------------------+----------------+---------------+
*/


