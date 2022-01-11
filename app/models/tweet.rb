class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  # assign a pubish_at timestamp
  after_initialize do
    # ||= means if a value already exists on form, leave it. But if nil, set it to default value.
    self.publish_at ||= 24.hours.from_now
  end

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  # question mark returns boolean, if it has a value will return true, if nil then return false
  # if tweet id column is empty then it is not published, if it has a value it is published
  def published?
    tweet_id?
  end

  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    #update tweet object response created from twitter gem
    update(tweet_id: tweet.id)
  end

end