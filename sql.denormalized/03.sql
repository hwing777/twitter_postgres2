/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */

SELECT 
    lang,
    count(*) as count
FROM (
    SELECT DISTINCT
        id_tweets,
        lang
    FROM (
        SELECT
        (data->'id') as id_tweets,
        (data->>'lang') as lang,
        (data->'entities'->'hashtags') as short,   
        (data->'extended_tweet'->'entities'->'hashtags') as extended
        FROM tweets_jsonb
    ) t1
    WHERE t1.short@>'[{"text": "coronavirus"}]'::jsonb OR t1.extended@>'[{"text": "coronavirus"}]'::jsonb
) t
GROUP BY lang
ORDER BY count DESC,lang
;
