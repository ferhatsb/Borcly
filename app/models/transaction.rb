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

  validates :transaction_type, :presence => true
  validates :related_person_name, :presence => true
  validates :amount, :presence => true, :numericality  => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :related_person_email, :presence => true, :email_format => true

  validates_date :end_date, :after => :start_date


end
