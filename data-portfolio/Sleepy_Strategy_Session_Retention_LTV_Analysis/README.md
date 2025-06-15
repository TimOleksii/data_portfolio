# Sleepy Retention Analysis – Strategy Session

This repository contains an analytical case study for Sleepy, a sleep-tech startup offering a wearable bracelet and mobile app that delivers personalized sleep improvement recommendations.

The company uses a 14-day free trial, after which users encounter a paywall to start a monthly subscription (9,9 Euro). The customer acquisition cost is 5 euro. Your task as a product analyst was to support a strategic session with data-driven answers to key product and monetization questions.

## Live Google Sheet

https://docs.google.com/spreadsheets/d/1pgK1XBMaAEaXFTfeloIYHsnVvHwz3_DQ22e5FH7atIA/edit?usp=sharing

Each tab in the spreadsheet contains calculations and answers to one or more questions.  
You can click on any cell to see:
- the pivot tables used,
- formulas applied,
- logic behind cohort construction, retention curves, LTV modeling, and sticky factor.

## Questions Answered

1. By how many percentage points does the n-day retention drop after the paywall is shown?  
   Round up to the nearest whole number.

2. Does the first subscription payment (whenever it occurs) cover the cost of acquisition?  
   Provide the net profit or loss in absolute value.

3. What percentage of users convert immediately after the trial ends (on day 14)?  
   Provide a number only, no % sign.

4. How many users pay for the subscription later (after day 14)?

5. On which day does n-day retention reach its peak after the paywall is shown?  
   Use zero-based format: if day 21 (counting from 1), enter 20.

6. On which day do we fully recoup the CAC?  
   Use zero-based format.

7. What is the average user lifetime (in days) using the area under the retention curve?  
   Round down to the nearest whole number.

8. What is the average user lifetime (in months), assuming 30-day months?  
   Round down to the nearest whole number.

9. What is the average user lifetime (in weeks), assuming 7-day weeks?  
   Round down to the nearest whole number.

10. What is the LTV using the most realistic LT estimate from above?  
    Use the retention-based LT that best reflects real usage.

11. What is the sticky factor?  
    Average DAU ÷ average MAU for the whole period. Round down to a whole number.

12. How many times is LT (by user span) greater than LT (by n-day retention)?  
    Compare in days. Round down to the nearest whole number.

13. Which calendar month had the highest MAU?  
    Format: YYYY-MM (e.g., 2024-07).

All calculations are done directly in Google Sheets using filters, pivots, and formulas.  
No scripts, no code — just transparent spreadsheet logic.