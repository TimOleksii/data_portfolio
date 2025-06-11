-- Task:
-- Show detailed test completion statistics for students 
-- from company with ID = 1.
--
-- Output should include:
-- - username: student's login
-- - email: student's email
-- - name: name of the test
-- - tq_value: the question text (value from testquestion)
-- - ta_value: the selected answer (can be NULL if skipped)
-- - is_correct: whether the answer was correct (true/false)
--
-- Notes:
-- - Only students who actually submitted answers are included
-- - Skipped questions are shown with NULL in the answer field

SELECT 
    u.username, 
    u.email, 
    t.name, 
    tq.value AS tq_value, 
    ta.value AS ta_value, 
    ta.is_correct 
FROM testresult res
JOIN users u ON res.user_id = u.id
JOIN test t ON res.test_id = t.id
JOIN testquestion tq ON res.question_id = tq.id
LEFT JOIN testanswer ta ON res.answer_id = ta.id
WHERE u.company_id = 1;