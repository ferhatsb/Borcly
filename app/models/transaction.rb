class Transaction < ActiveRecord::Base
  TYPES = {'credit' => 'Alacak', 'debit' => 'Borc'}
  belongs_to :user

  attr_accessible:transaction_type, :related_person_name, :amount, :end_date, :start_date, :related_person_email

  scope :debits, lambda {
    where("transactions.type = ?", 'debit')
  }

  scope :credits, lambda {
    where("transactions.type = ?", 'credit')
  }

end
