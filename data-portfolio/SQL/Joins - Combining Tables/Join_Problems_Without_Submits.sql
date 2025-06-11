-- Task:
-- Show problems that were never submitted by any user.
-- The result should include:
-- - name: name of the problem
-- - path: URL path to the problem (from page table)
-- - have_submits: boolean indicating whether any submits exist (false in this case)
--
-- This helps identify which tasks are unused or need more attention.

SELECT 
    p.name, 
    page.path,
    CASE 
        WHEN c.id IS NULL THEN false
        ELSE true
    END AS have_submits
FROM problem p 
LEFT JOIN codesubmit c ON c.problem_id = p.id
JOIN page ON page.id = p.page_id
WHERE c.id IS NULL;