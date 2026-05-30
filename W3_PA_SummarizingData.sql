--Question 1
SELECT min(num_1) AS minimum,
       max(num_1) AS maximum
FROM sec1103;
https://github.com/layjen6644/Structured-Query-Language-SQL/tree/main
--Question 2
SELECT min(num_1) as minimum,
       max(num_1) as maximum
FROM sec1103
WHERE row_id < 8;

--Question 3
SELECT COUNT(*) AS total_rows,
       COUNT(num_1) AS non_null_num,
       COUNT(*) - COUNT(num_1) AS null_num
FROM sec1106;

--Question 4
SELECT COUNT(distinct (num_1 || '+' || num_2))
FROM sec1103;

--Question 5
SELECT num_1,
       num_2,
       num_1 + num_2 AS row_sum
FROM sec1103;

SELECT SUM(num_1),
       SUM(num_2),
       SUM(num_1) + SUM(num_2) AS total_sum
FROM sec1103;

SELECT num_1,
       num_2,
       NVL(num_1, 0) + NVL(num_2, 0) AS correct_sum
FROM sec1103;

--Question 6
SELECT col_1,
       SUM(col_3) AS SUM_col_3
FROM sec1202
GROUP BY col_1;

--Question 7
SELECT col_1,
       col_2,
       SUM(col_3) AS SUM_col_3
FROM sec1202
GROUP BY col_1,
         col_2;

--Question 8
SELECT *
FROM sec1202;

SELECT SUM(col_3) AS total_col_3
FROM sec1202;

--Question 9
SELECT col_1,
       SUM(col_2) AS sum_col_2
FROM sec1211
GROUP BY col_1
HAVING SUM(col_2) > 20;
