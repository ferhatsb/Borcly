desc "This task is called by the Heroku scheduler add-on"
task :check_debits => :environment do
  puts "Checking debits..."
  TransactionsNotifications.check_records
  puts "done."
end