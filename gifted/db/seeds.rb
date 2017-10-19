require 'faker'

class Time
  def self.random(from = 0.0, to = Time.now)
    Time.at(from + rand * (to.to_f - from.to_f))
  end
end

module Seed
  def self.people(num)
    num.times { self.create_person }
  end

  def self.gifts(num)
    num.times { self.create_gift }
  end

  def self.holidays
    [
      {
        name: "Kwanzaa",
        month: 12,
        day: 26
      },
      {
        name: "Hanukkah",
        month: 12,
        day: 16
      },
      {
        name: "Christmas",
        month: 12,
        day: 25
      },
      {
        name: "Diwali",
        month: 10,
        day: 23
      },
      {
        name: "Vesak",
        month: 5,
        day: 13
      },
      {
        name: "Mother's Day",
        month: 5,
        day: 11
      },
      {
        name: "Father's Day",
        month: 6,
        day: 15
      }
    ].each do |holiday_attrs|
      Holiday.create!(holiday_attrs)
    end
  end

  def self.create_person
    person_attrs = {
      name: Faker::Name.name,
      birthday: Time.random( Time.local(1910, 1, 1) ),
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      address: Faker::Address.street_address \
                      + ' ' \
                      + Faker::Address.street_suffix,
      city: Faker::Address.city,
      zip_code: Faker::Address.zip_code,
      state: Faker::Address.state,
      country: Faker::Address.country
  }

    Person.create!(person_attrs)
  end

  def self.create_gift
    gift_attrs = {
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price,
      category: Faker::Commerce.department
    }

    Gift.create!(gift_attrs)
  end
end


Seed.people(30)
Seed.gifts(50)
Seed.holidays
