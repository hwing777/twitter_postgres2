BEGIN;

create index hashtags_idx on tweets_jsonb using gin((data->'entities'->'hashtags'));
create index hashtags_extended_idx on tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags'));


create index text_idx on tweets_jsonb using gin(COALESCE(data->'extended_tweet'->'full_text',data->'text'));
create index text_idx_full on tweets_jsonb using gin((to_tsvector('english',COALESCE(data->'extended_tweet'->'full_text',data->'text'))));


CREATE INDEX tweets_jsonb_idx_tag_hashtags ON tweets_jsonb USING gin((to_tsvector('english',data->'entities'->'hashtags')));
CREATE INDEX tweets_jsonb_idx_tag_extended_hashtags ON tweets_jsonb USING gin((to_tsvector('english',data->'extended_tweet'->'entities'->'hashtags')));

COMMIT;
