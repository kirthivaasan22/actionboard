class Invoice < ApplicationRecord

  has_many :collections, dependent: :destroy

  validates :reference, uniqueness: true

  def self.create_invoice_records
    $invoice_records.each do |resource|
      begin
        invoice = Invoice.new(
          reference: resource[:reference],
          invoice_date: resource[:invoice_date].to_time,
          customer: resource[:customer_name],
          brand_manager: resource[:brand_manager],
          narration: resource[:narration],
          amount: resource[:amount],
          balance_due: resource[:amount]
        )
        invoice.save
      rescue Exception => e
        next
      end
    end
  end

end
