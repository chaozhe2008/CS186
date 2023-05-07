-- Before running drop any existing views
DROP VIEW IF EXISTS q0;
DROP VIEW IF EXISTS q1i;
DROP VIEW IF EXISTS q1ii;
DROP VIEW IF EXISTS q1iii;
DROP VIEW IF EXISTS q1iv;
DROP VIEW IF EXISTS q2i;
DROP VIEW IF EXISTS q2ii;
DROP VIEW IF EXISTS q2iii;
DROP VIEW IF EXISTS q3i;
DROP VIEW IF EXISTS q3ii;
DROP VIEW IF EXISTS helper;
DROP VIEW IF EXISTS q3iii;
DROP VIEW IF EXISTS q4i;
DROP VIEW IF EXISTS q4ii;
DROP VIEW IF EXISTS q4iii;
DROP VIEW IF EXISTS q4iv;
DROP VIEW IF EXISTS q4v;

-- Question 0
CREATE VIEW q0(era)
AS
  SELECT MAX(era)
  FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
    SELECT namefirst, namelast, birthyear
    FROM people
    WHERE namefirst LIKE '% %'
    ORDER BY namefirst, namelast
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
    SELECT birthyear, AVG(height), count(*)
    FROM people
    GROUP BY birthyear
    ORDER BY birthyear
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
    SELECT birthyear, AVG(height), count(*)
    FROM people
    GROUP BY birthyear
    HAVING AVG(height) > 70
    ORDER BY birthyear
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
    SELECT namefirst, namelast, people.playerid, yearid
    FROM people
    JOIN halloffame ON people.playerID = halloffame.playerID
    WHERE inducted = 'Y'
    ORDER BY yearid DESC, people.playerid ASC;
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
    SELECT namefirst, namelast, q.playerid, s.schoolID, yearid
    FROM q2i q, schools s, collegeplaying c
    WHERE q.playerID = c.playerID
    AND c.schoolID = s.schoolID
    AND s.schoolState = 'CA'
    ORDER BY q.yearid DESC, s.schoolID, q.playerid;
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
    SELECT p.playerid, namefirst, namelast, c.schoolid
    FROM people p
    JOIN (halloffame h LEFT OUTER JOIN collegeplaying c on h.playerID = c.playerid)
    ON p.playerID = h.playerID
    WHERE h.inducted = 'Y'
    ORDER BY p.playerID DESC, c.schoolID
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
    SELECT b.playerid, namefirst, namelast, b.yearid,
           (b.h + b.h2b + 2 * b.h3b + 3 * b.hr) * 1.0 /b.ab as slg
    FROM people as p, batting as b
    WHERE b.ab > 50 and p.playerID = b.playerID
    ORDER BY slg DESC, b.yearID, p.playerID
    LIMIT 10
;

-- Question 3ii

CREATE VIEW helper(playerid, sumab, sumh, sumh2b, sumh3b, sumhr)
AS
    SELECT playerid, sum(ab) as sumab, sum(b.h) as sumh, sum(b.h2b) as sumh2b,
           sum(b.h3b) as sumh3b, sum(b.hr) as sumbr
    FROM batting b
    GROUP BY playerid
    HAVING sum(ab) > 50
;

CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
    SELECT p.playerid, namefirst, namelast,
           (helper.sumh + helper.sumh2b + 2 * helper.sumh3b + 3 * helper.sumhr) * 1.0 / helper.sumab as lslg
    FROM people as p, helper
    WHERE p.playerID = helper.playerID
    ORDER BY lslg DESC, p.playerID
    LIMIT 10
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
    SELECT namefirst, namelast,
       (helper.sumh + helper.sumh2b + 2 * helper.sumh3b + 3 * helper.sumhr) * 1.0 / helper.sumab as lslg
    FROM people as p, helper
    WHERE p.playerID = helper.playerID
    AND lslg > (
        SELECT (helper.sumh + helper.sumh2b + 2 * helper.sumh3b + 3 * helper.sumhr) * 1.0 / helper.sumab
        FROM helper
        WHERE playerid = 'mayswi01'
        )
    ORDER BY lslg DESC, p.playerID
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg)
AS
    SELECT yearid, min(salary), max(salary), avg(salary)
    FROM salaries as s
    GROUP BY yearid
    ORDER BY yearID
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count) AS
WITH range AS (
    SELECT MIN(salary) AS lowest, MAX(salary) AS highest, CAST (((MAX(salary) - MIN(salary))/10) AS INT) AS bucket FROM salaries where yearid = 2016
)
SELECT binid, lowest + binid * bucket, lowest + (binid + 1) * bucket, count(*)
FROM binids b, salaries s, range
WHERE (salary between lowest + binid * bucket and lowest + (binid + 1) * bucket)
  AND yearid = 2016
GROUP BY binid
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff) AS
    WITH pre AS (
            SELECT (yearid + 1) as adjusted, MIN(salary) as mini, MAX(salary) as maxi, AVG(salary) as aver
            FROM salaries
            GROUP BY adjusted
        ),
        curr AS(
            SELECT (yearid) as year, MIN(salary) as mini, MAX(salary) as maxi, AVG(salary) as aver
            FROM salaries
            GROUP BY year
        )
    SELECT curr.year as yearid, curr.mini - pre.mini AS mindiff, curr.maxi - pre.maxi AS maxdiff, curr.aver - pre.aver AS avgdiff
    FROM pre, curr
    WHERE pre.adjusted = curr.year
    ORDER BY curr.year
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
    SELECT p.playerid, p.namefirst, p.namelast, s.salary, s.yearid
    FROM people as p , salaries as s
    WHERE yearID = 2000
    AND s.playerID = p.playerID
    AND s.salary = (SELECT MAX(salary)
                    FROM salaries
                    WHERE yearid = 2000)
    UNION

    SELECT p.playerid, p.namefirst, p.namelast, s.salary, s.yearid
    FROM people as p , salaries as s
    WHERE yearID = 2001
      AND s.playerID = p.playerID
      AND s.salary = (SELECT MAX(salary)
                      FROM salaries
                      WHERE yearid = 2001)
;


-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
    SELECT ast.teamid, MAX(s.salary) - MIN(s.salary) as diff
    FROM allstarfull as ast, salaries as s
    WHERE s.teamID = ast.teamID
    AND s.playerID = ast.playerID
    AND ast.yearID = 2016
    AND s.yearID = 2016
    GROUP BY ast.teamid
;

