/* 6.1 Имеются множество A = {L M N O P} и множество B = {P Q R S T}. Какие множества будут получены в результате следующих операций:	*/
A union B = {L M N O P Q R S T}
A union all B = {L M N O P P Q R S T}
A intersect B = {P}
A except B  = {L M N O}

/* 6.2 Напишите составной запрос для выбора имен и фамилий всех клиентов физических лиц, а также имен и фамилий всех сотрудников. */

SELECT fname, lname
FROM employee
UNION
SELECT fname, lname
FROM individual;

/*RESULT
27 rows in set (0.00 sec)
*/

/* 6.3 Отсортируйте результаты упражнения 6.2 по столбцу lname.	*/

SELECT fname, lname
FROM employee
UNION
SELECT fname, lname
FROM individual
ORDER BY lname;
/*RESULT
+----------+-----------+
| fname    | lname     |
+----------+-----------+
| Susan    | Barker    |
| John     | Blake     |
| Louis    | Blake     |
| Richard  | Farley    |
| Helen    | Fleming   |
| Beth     | Fowler    |
| Charles  | Frasier   |
| John     | Gooding   |
| Jane     | Grossman  |
| James    | Hadley    |
| Susan    | Hawthorne |
| John     | Hayward   |
| Samantha | Jameson   |
| Theresa  | Markham   |
| Cindy    | Mason     |
| Sarah    | Parker    |
| Frank    | Portman   |
| Paula    | Roberts   |
| Michael  | Smith     |
| John     | Spencer   |
| Susan    | Tingley   |
| Frank    | Tucker    |
| Chris    | Tucker    |
| Rick     | Tulman    |
| Robert   | Tyler     |
| Margaret | Young     |
| Thomas   | Ziegler   |
+----------+-----------+
27 rows in set (0.00 sec)
*/
