# frozen_string_literal: true

namespace :db do
  desc ' GENERATE COUPONS '.center(46, '=')
  task seed_coupons: :environment do
    (1..7).each do |coupon|
      Coupon.find_or_create_by(name: "D1234567890000#{coupon}") do |item|
        item.name = "D1234567890000#{coupon}"
        item.value = "#{coupon}.00".to_f
      end
    end
    puts ' Coupons was succesfuly saved to DB '.center(80, '=')
  end
end