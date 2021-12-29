/* A user(user_id) could write a comment(content_id, type)
to a post(target_id) or post(content_id, type) by him/herself.

Table schema is shown as below:
| DATE | USER_ID | CONTENT_ID | CONTENT_TYPE (COMMENT/POST) | TARGET_ID |

Q: What is the comment distribution?
*/

WITH cte AS (
SELECT t2.id AS ID, COALESCE(num_comments, 0) AS num_comments
FROM (
		(SELECT DISTINCT content_id AS ID
		FROM t1
		WHERE TYPE = 'post') t2
		LEFT JOIN
		(SELECT target_id AS ID, COUNT(target_id) AS num_comments
		FROM t1
		WHERE TYPE = 'comment'
		GROUP BY target_id) t3) t4)

SELECT num_comments, COUNT(ID) AS freq
FROM cte
GROUP BY num_comments
ORDER BY num_comments ASC

-- Source: https://www.techielearning.com/blog/sql-interview
