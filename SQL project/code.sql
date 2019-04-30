SQL Codes

1.1 How many campaigns & sources does CoolTShirts use?

(1) SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

(2) SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

(3) SELECT DISTINCT utm_source,utm_campaign
FROM page_visits;


1.2 What pages are on the CoolTShirts website?

SELECT DISTINCT page_name
FROM page_visits;


2.1 How many first touches is each campaign responsible for?

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT (*) AS first_touch_count
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP By utm_source
ORDER BY first_touch_count DESC;


2.2 How many last touches is each campaign responsible for?

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT (*) AS last_touch_count
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP By utm_source
ORDER BY last_touch_count DESC;


2.3 How many visitors make a purchase?

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT COUNT (page_name) AS 'Number of purchases made'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  WHERE page_name='4 - purchase';


2.4 How many last touches on the purchase page is each campaign responsible for?

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
COUNT (page_name) AS 'Number of purchases made'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name='4 - purchase'
GROUP BY 1
ORDER BY 2 DESC;


2.5 What is the typical user journey?

SELECT page_name,
COUNT (page_name) AS 'number of visits'
FROM page_visits
GROUP BY 1;
