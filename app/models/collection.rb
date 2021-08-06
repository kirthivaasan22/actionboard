class Collection < ApplicationRecord

  belongs_to :invoice

  after_create :update_invoice_due_and_collection_amount

  validate :validate_amount

  def self.create_collection_records
    $collection_records.each do |resource|
      inv = Invoice.find_by(reference: resource[:reference])
      if inv.present?
        collection = inv.collections.new(
          amount: resource[:amount].to_i.abs,
          collection_date: resource[:collection_date].to_time
        )
        collection.save
      else
        next
      end
    end
  end

  def update_invoice_due_and_collection_amount
    invoice = self.invoice
    invoice.balance_due -= self.amount
    invoice.total_collection += self.amount
    invoice.save
  end

  def validate_amount
    invoice = self.invoice
    errors.add(:amount, :invalid) if self.amount > invoice.balance_due
  end

end
