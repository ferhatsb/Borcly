class TransactionsNotifications

  def self.check_records
    User.all.each do |user|

      user.transactions.not_paid_overdue.each do |transaction|

        if transaction.end_date < Date.today
          transaction.status = 'overdue'
          transaction.save!
        elsif transaction.end_date - Date.today <= 5 && !transaction.notified

          if user.channels.find_by_provider('twitter')
            #credit owner
            owner_tweet_account = Twitter::Client.new(:oauth_token => user.channels.find_by_provider('twitter').oauth_token,
                                                :oauth_token_secret => user.channels.find_by_provider('twitter').oauth_token_secret,
                                                :consumer_key => user.channels.find_by_provider('twitter').consumer_key,
                                                :consumer_secret => user.channels.find_by_provider('twitter').consumer_secret) rescue nil

            owner_tweet_account.update("Borcly borc bildirimi - #{transaction.related_person_name} vermis oldugunuz  #{transaction.amount} miktarindaki borcun vadesi #{transaction.end_date} tarhinde sona eriyor.")
          end

          NotificationMailer.notification(transaction)

          transaction.notified = true
          transaction.save!

        end
      end
    end
  end

end


#  @graph = Koala::Facebook::API.new(User.first.channels.find_by_provider('facebook').oauth_token)
#  friends = @graph.get_connections("me", "friends")
#  @graph.get_connections("koppel", "likes")
