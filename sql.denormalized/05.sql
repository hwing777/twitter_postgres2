/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT
    '#' || tag as tag,
    count(*) as count
FROM (
    SELECT DISTINCT id_tweets, lang, tag
    FROM (
        SELECT DISTINCT
            id_tweets,
            lang,
            jsonb_array_elements(short)->>'text' as tag
        FROM (
            SELECT DISTINCT
            (data->'id') as id_tweets,
            (data->>'lang') as lang,
            (data->'entities'->'hashtags') as short,   
            COALESCE(data->'extended_tweet'->'full_text',data->'text') AS text
            FROM tweets_jsonb
        ) t1
        WHERE to_tsvector('english',t1.text)@@to_tsquery('english','coronavirus')
        UNION ALL
        SELECT DISTINCT
            id_tweets,
            lang,
            jsonb_array_elements(extended)->>'text' as tag
        FROM (
            SELECT DISTINCT
            (data->'id') as id_tweets,
            (data->>'lang') as lang,
            (data->'extended_tweet'->'entities'->'hashtags') as extended,
            COALESCE(data->'extended_tweet'->'full_text',data->'text') AS text
            FROM tweets_jsonb
        ) t2
        WHERE to_tsvector('english',t2.text)@@to_tsquery('english','coronavirus')
    ) t3
) t
WHERE lang='en'
GROUP BY (1)
ORDER BY count DESC,tag
LIMIT 1000;

