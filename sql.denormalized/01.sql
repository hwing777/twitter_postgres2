/*
 * Count the number of tweets that use #coronavirus
 */

SELECT count(distinct id_tweets)
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        (data->'entities'->'hashtags') as short,
        (data->'extended_tweet'->'entities'->'hashtags') as extended
    FROM tweets_jsonb
) t
WHERE short@>'[{"text": "coronavirus"}]'::jsonb OR extended@>'[{"text": "coronavirus"}]'::jsonb
;
