BEGIN;

CREATE INDEX tweet_tags_idx_tag_id ON tweet_tags(tag, id_tweets);

CREATE INDEX tweet_tags_idx_id ON tweet_tags(id_tweets);

CREATE INDEX tweets_idx_id ON tweets(id_tweets);

CREATE INDEX tweets_idx_fts ON tweets using gin(to_tsvector('english',text));

COMMIT;
