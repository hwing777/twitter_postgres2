/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT
    count(*)
FROM (
    SELECT
    COALESCE(data->'extended_tweet'->'full_text',data->'text') AS text,
    data->>'lang' AS lang
    FROM tweets_jsonb
) t
WHERE to_tsvector('english',text)@@to_tsquery('english','coronavirus')
  AND lang='en'
;
