Business Context
Sleepy is a health tech startup helping users improve sleep quality through a combination of a minimalist wearable bracelet and a mobile app. The bracelet has no display—its main function is to collect data for personalized recommendations (like air flow, bedtime adjustment, temperature, etc.) delivered via the app.

Monetization:

The product is monetized via a monthly subscription of 9,9 euro.

The first 14 days are free, then a paywall is shown.

If the user connects a payment card, access continues with auto-renewal.

Customer acquisition cost (CAC) is 5 euro per user.

Data specifics:

You're given a CSV file with only 2 columns:

user – unique user ID

dt – the date of an app login

The data contains only one login per user per day.

Only activity during free trial or after payment is recorded.

Post-trial usage without payment is not included in this dataset.

 Objective
You are a newly hired product analyst at Sleepy and were asked to prepare a comprehensive analysis for the company’s upcoming strategy session, attended by C-level execs and investors. Your task is to answer 13 critical questions using the given dataset to support key business decisions on product retention, monetization, and growth.

 Questions to Answer
By how many percentage points does the n-day retention drop after the paywall is shown?
(Round up to the nearest whole number)

Does the first subscription payment (whenever it occurs) cover the cost of acquisition?
(Give the net profit or loss in absolute value)

What percentage of users convert immediately after the trial ends (on day 14)?
(Provide a number only, no % sign)

How many users pay for the subscription later (after day 14)?

On which day does n-day retention reach its peak after the paywall is shown?
(Answer in zero-based format: day 0 is first day)

On which day do we fully recoup the CAC?
(Answer in zero-based format: day 0 is first day)

What is the average user lifetime (in days) using the area under the retention curve?
(Round down to the nearest whole number)

What is the average user lifetime (in months), assuming 30-day months?
(Round down to the nearest whole number)

What is the average user lifetime (in weeks), assuming 7-day weeks?
(Round down to the nearest whole number)

What is the LTV using the most realistic LT estimate from above?
(Use the one that best fits the shape of the retention curve)

What is the sticky factor?
(Average DAU ÷ average MAU for the whole period. Round down to a whole number)

How many times is LT (by user span) greater than LT (by n-day retention)?
(Compare in days. Round down to the nearest whole number)

Which calendar month had the highest MAU?
(Format: YYYY-MM)