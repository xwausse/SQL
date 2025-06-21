
 Puzzle 1: Finding Distinct Values Based on Two Columns
Goal: (a, b) and (b, a) should be treated as duplicates and only one retained.
 Method 1: Use LEAST and GREATEST to Normalize the Pair Order

SELECT DISTINCT
    LEAST(col1, col2) AS col1,
    GREATEST(col1, col2) AS col2
FROM InputTbl;
 Method 2: Use CASE WHEN to Normalize the Pair

SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;
 Puzzle 2: Removing Rows Where All Columns Have Zero
Goal: Remove rows like (0,0,0,0)
SELECT * 
FROM TestMultipleZero
WHERE COALESCE(A, 0) + COALESCE(B, 0) + COALESCE(C, 0) + COALESCE(D, 0) > 0;
 Puzzle 3: Find Those with Odd id
SELECT * 
FROM section1 
WHERE id % 2 = 1;
 Puzzle 4: Person with the Smallest id
SELECT TOP 1 * 
FROM section1 
ORDER BY id ASC;
Alternatively:
SELECT * 
FROM section1 
WHERE id = (SELECT MIN(id) FROM section1);
 Puzzle 5: Person with the Highest id
SELECT TOP 1 * 
FROM section1 
ORDER BY id DESC;
Alternatively:
SELECT * 
FROM section1 
WHERE id = (SELECT MAX(id) FROM section1);
Puzzle 6: People Whose Name Starts with 'B'
SELECT * 
FROM section1 
WHERE name LIKE 'B%';
 Puzzle 7: Return Only Rows Where Code Contains Literal Underscore _
⚠ _ is a wildcard in LIKE, so we need to escape it
-- Using ESCAPE character:
SELECT * 
FROM ProductCodes 
WHERE Code LIKE '%\_%' ESCAPE '\';
