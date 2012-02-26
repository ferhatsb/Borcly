class Transaction < ActiveRecord::Base

  STATUS = {:paid => 'Odendi', :not_paid => 'Odenmedi', :overdue => 'Vadesi Gecmis'}

  belongs_to :user

  attr_accessible :status, :related_person_name, :amount, :end_date, :start_date, :related_person_email, :related_person_twitter, :related_person_facebook


  def broadcast
    message_text = "#{related_person_name} vermis oldugum  #{amount} miktarindaki borcu odemedi."

    begin
      if user.channels.find_by_provider('twitter')
        #credit owner
        owner_tweet_account = Twitter::Client.new(:oauth_token => user.channels.find_by_provider('twitter').oauth_token,
                                                  :oauth_token_secret => user.channels.find_by_provider('twitter').oauth_token_secret,
                                                  :consumer_key => user.channels.find_by_provider('twitter').consumer_key,
                                                  :consumer_secret => user.channels.find_by_provider('twitter').consumer_secret) rescue nil
        owner_tweet_account.update(message_text)
      end

      if user.channels.find_by_provider('facebook')
        facebook_account = Koala::Facebook::API.new(user.channels.find_by_provider('facebook').oauth_token)
        facebook_account.put_object("me", "feed", :message => message_text)
      end

    rescue Exception => e
      false
    end


  end

  scope :paid, lambda {
    where("transactions.status = ?", 'paid')
  }

  scope :not_paid, lambda {
    where("transactions.status = ?", 'not_paid')
  }

  scope :overdue, lambda {
    where("transactions.status = ?", 'overdue')
  }

  scope :not_paid_overdue, lambda {
    param = %w(not_paid overdue)
    where("transactions.status in (?)", param)
  }

  validates :related_person_name, :presence => true
  validates :amount, :presence => true, :numericality => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :related_person_email, :presence => true, :email_format => true

  validates_date :end_date, :after => :start_date


end
