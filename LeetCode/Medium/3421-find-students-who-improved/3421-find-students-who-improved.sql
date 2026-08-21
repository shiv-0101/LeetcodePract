# Write your MySQL query statement below
SELECT DISTINCT student_id, subject, first_score, latest_score FROM (
    SELECT *, 
    first_value(score) OVER w AS first_score,
    last_value(score) OVER w AS  latest_score
    FROM Scores
    WINDOW w AS (PARTITION BY student_id, subject ORDER BY exam_date ROWS BETWEEN unbounded preceding AND unbounded following)
)T
WHERE first_score < latest_score
ORDER BY 1, 2;