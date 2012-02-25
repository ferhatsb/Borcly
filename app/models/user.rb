class User < ActiveRecord::Base

  devise :omniauthable
  has_many :transactions
  has_many :channels

  attr_accessible :email, :user_name

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)

    # update facebook account of current user
    if signed_in_resource
      hash_data = hash_from_omniauth(access_token)
      channel = Channel.find_by_provider(hash_data[:provider])
      if channel
        channel.save(hash_data)
      else
        Channel.create!(hash_data)
      end
    else
      #login to system
      data = access_token.extra.raw_info
      user = User.where(:email => data.email).first
      unless user
        user = User.create!(:email => data.email)
        user.create_channel(access_token)
      end
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)

    # update twitter account of current user
    if signed_in_resource
      hash_data = hash_from_omniauth(access_token)
      channel = Channel.find_by_provider(hash_data[:provider])
      if channel
        channel.save(hash_data)
      else
        Channel.create!(hash_data)
      end
    else
      data = access_token.extra.raw_info
      user = User.where(:user_name => data.user_name).first
      unless user
        user = User.create!(:user_name => data.screen_name)
        user.create_channel(access_token)
      end
    end
  end

  def create_channel(access_token)
    channel = Channel.new(hash_from_omniauth(access_token))
    channel.user = self
    channel.save!
    self
  end


  def hash_from_omniauth(omniauth)
    {
        :provider => omniauth['provider'],
        :uid => omniauth['uid'],
        :oauth_token => (omniauth['credentials']['token'] rescue nil),
        :oauth_token_secret => (omniauth['credentials']['secret'] rescue nil)
    }
  end

end
