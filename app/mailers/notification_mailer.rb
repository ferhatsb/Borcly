class NotificationMailer < ActionMailer::Base
  default :from => "notifications@example.com"

  def notification(transaction)
    @transaction  = transaction
    mail(:to => "<#{transaction.related_person_email}>", :subject => "Borcly borc bildirimi")
  end
end
