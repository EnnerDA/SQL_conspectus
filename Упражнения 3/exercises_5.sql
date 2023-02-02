/* 5.1 Заполните в следующем запросе пробелы (обозначенные как <число>), чтобы получить такие результаты:
mysql> SELECT e.emp_id, e.fname, e.lname, b.name 	
     > FROM employee e INNER JOIN <1> b 	
     >   ON e.assigned_branch_id = b.<2>;	
*/
SELECT e.emp_id, e.fname, e.lname, b.name
FROM employee e INNER JOIN branch b
ON e.assigned_branch_id = b.branch_id;

/*RESULT
+--------+----------+-----------+---------------+
| emp_id | fname    | lname     | name          |
+--------+----------+-----------+---------------+
|      1 | Michael  | Smith     | Headquarters  |
|      2 | Susan    | Barker    | Headquarters  |
|      3 | Robert   | Tyler     | Headquarters  |
|      4 | Susan    | Hawthorne | Headquarters  |
|      5 | John     | Gooding   | Headquarters  |
|      6 | Helen    | Fleming   | Headquarters  |
|      7 | Chris    | Tucker    | Headquarters  |
|      8 | Sarah    | Parker    | Headquarters  |
|      9 | Jane     | Grossman  | Headquarters  |
|     10 | Paula    | Roberts   | Woburn Branch |
|     11 | Thomas   | Ziegler   | Woburn Branch |
|     12 | Samantha | Jameson   | Woburn Branch |
|     13 | John     | Blake     | Quincy Branch |
|     14 | Cindy    | Mason     | Quincy Branch |
|     15 | Frank    | Portman   | Quincy Branch |
|     16 | Theresa  | Markham   | So. NH Branch |
|     17 | Beth     | Fowler    | So. NH Branch |
|     18 | Rick     | Tulman    | So. NH Branch |
+--------+----------+-----------+---------------+
18 rows in set (0.00 sec)
*/

/* 5.2 Напишите запрос, по которому для каждого клиента физического лица (customer.cust_type_cd = 'I') возвращаются ID счета, федеральный ID(customer.fed_id) и тип созданного счета (product.name). */

SELECT a.account_id, c.fed_id, p.name
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
INNER JOIN product p
ON a.product_cd = p.product_cd
WHERE c.cust_type_cd = 'I';

/* RESULT
+------------+-------------+------------------------+
| account_id | fed_id      | name                   |
+------------+-------------+------------------------+
|          1 | 111-11-1111 | checking account       |
|          2 | 111-11-1111 | savings account        |
|          3 | 111-11-1111 | certificate of deposit |
|          4 | 222-22-2222 | checking account       |
|          5 | 222-22-2222 | savings account        |
|          6 | 333-33-3333 | checking account       |
|          7 | 333-33-3333 | money market account   |
|          8 | 444-44-4444 | checking account       |
|          9 | 444-44-4444 | savings account        |
|         10 | 444-44-4444 | money market account   |
|         11 | 555-55-5555 | checking account       |
|         12 | 666-66-6666 | checking account       |
|         13 | 666-66-6666 | certificate of deposit |
|         14 | 777-77-7777 | certificate of deposit |
|         15 | 888-88-8888 | checking account       |
|         16 | 888-88-8888 | savings account        |
|         17 | 999-99-9999 | checking account       |
|         18 | 999-99-9999 | money market account   |
|         19 | 999-99-9999 | certificate of deposit |
+------------+-------------+------------------------+
19 rows in set (0.00 sec)
*/

/* 5.3 Создайте запрос для выбора всех сотрудников, начальник которых приписан к другому отделу. Извлечь ID, имя и фамилию сотрудника.*/

SELECT e1.emp_id, e1.fname, e1.lname, b1.name, 
e2.fname Boss_fname, e2.lname Boss_lname, b2.name Boss_branch
FROM employee e1 INNER JOIN branch b1
ON e1.assigned_branch_id = b1.branch_id
INNER JOIN employee e2
ON e1.superior_emp_id = e2.emp_id
INNER JOIN branch b2
ON e2.assigned_branch_id = b2.branch_id
WHERE b1.name != b2.name;



