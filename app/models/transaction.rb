class Transaction < ActiveRecord::Base

  STATUS = {:paid => 'Odendi', :not_paid => 'Odenmedi', :overdued => 'Vadesi Gecmis'}

  belongs_to :user

  attr_accessible :status, :related_person_name, :amount, :end_date, :start_date, :related_person_email

  scope :paid, lambda {
    where("transactions.status = ?", 'paid')
  }

  scope :not_paid_overdue, lambda {
    param = %w(not_paid overdued)
    where("transactions.status in (?)", param )
  }

  validates :related_person_name, :presence => true
  validates :amount, :presence => true, :numericality  => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :related_person_email, :presence => true, :email_format => true

  validates_date :end_date, :after => :start_date


end
