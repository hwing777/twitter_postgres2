/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

SELECT
    '#' || tag as tag,
    count(*) as count
FROM (
    SELECT DISTINCT
        id_tweets,
        jsonb_array_elements(short)->>'text' as tag
    FROM (
        SELECT
        (data->'id') as id_tweets,
        (data->'entities'->'hashtags') as short,   
        (data->'extended_tweet'->'entities'->'hashtags') as extended
        FROM tweets_jsonb
    ) t1
    WHERE t1.short@>'[{"text": "coronavirus"}]'::jsonb OR t1.extended@>'[{"text": "coronavirus"}]'::jsonb
    UNION
    SELECT DISTINCT
        id_tweets,
        jsonb_array_elements(extended)->>'text' as tag
    FROM (
        SELECT
        (data->'id') as id_tweets,
        (data->'entities'->'hashtags') as short,   
        (data->'extended_tweet'->'entities'->'hashtags') as extended
        FROM tweets_jsonb
    ) t2
    WHERE t2.short@>'[{"text": "coronavirus"}]'::jsonb OR t2.extended@>'[{"text": "coronavirus"}]'::jsonb
) t
GROUP BY (1)
ORDER BY count DESC,tag
LIMIT 1000;
