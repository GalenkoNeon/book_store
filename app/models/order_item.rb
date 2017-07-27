# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  before_save :finalize

  def unit_price
    return  self[:unit_price] if persisted?
    book.price
  end

  def total_price
    unit_price * quantity
  end

  private

  def book_present
    errors.add(:book, 'is not valid or is not active.') if book.nil?
  end

  def order_present
    errors.add(:order, 'is not a valid order.') if order.nil?
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
