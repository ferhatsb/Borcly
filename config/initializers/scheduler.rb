require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every  '1m' do
  TransactionsNotifications.check_records
end