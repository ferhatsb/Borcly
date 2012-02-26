class User < ActiveRecord::Base

  devise :omniauthable
  has_many :transactions
  has_many :channels

  attr_accessible :email, :user_name

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)

    # update facebook account of current user
    if signed_in_resource
      hash_data = User.hash_from_omniauth(access_token)
      channel = signed_in_resource.channels.find_by_provider(hash_data[:provider])
      if channel
        channel.save(hash_data)
      else
        channel = Channel.new(hash_data)
        channel.user = signed_in_resource
        channel.save!
      end
      signed_in_resource
    else
      #login to system
      data = User.hash_from_omniauth(access_token)
      channel = Channel.find_by_uid_and_provider(data[:uid], data[:provider])
      if channel
        channel.user
      else
        user = User.create!(:email => access_token.extra.raw_info.email)
        user.create_channel(access_token)
      end
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)

    # update twitter account of current user
    if signed_in_resource
      hash_data = User.hash_from_omniauth(access_token)
      channel = signed_in_resource.channels.find_by_provider(hash_data[:provider])
      if channel
        channel.save(hash_data)
      else
        channel = Channel.new(hash_data)
        channel.user = signed_in_resource
        channel.save!
      end
      signed_in_resource
    else
      data = User.hash_from_omniauth(access_token)
      channel = Channel.find_by_uid_and_provider(data[:uid], data[:provider])
      if channel
        channel.user
      else
        user = User.create!(:user_name => access_token.extra.raw_info.screen_name)
        user.create_channel(access_token)
      end
    end
  end

  def create_channel(access_token)
    channel = Channel.new(User.hash_from_omniauth(access_token))
    channel.user = self
    channel.save!
    self
  end


  def self.hash_from_omniauth(omniauth)
    {
        :provider => omniauth['provider'],
        :uid => omniauth['uid'],
        :oauth_token => (omniauth['credentials']['token'] rescue nil),
        :oauth_token_secret => (omniauth['credentials']['secret'] rescue nil),
        :consumer_key => (omniauth['extra']['access_token'].consumer.key rescue nil),
        :consumer_secret => (omniauth['extra']['access_token'].consumer.secret rescue nil)
    }
  end

end
