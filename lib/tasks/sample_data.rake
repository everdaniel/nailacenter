namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_products
    make_customers
    make_suppliers
  end
end

def make_users
  admin = User.create!(
    first_name: "Donald",
    last_name: "Draper",
    username: "don",
    email: "d.draper@scdp.com",
    password: "password",
    password_confirmation: "password")
  admin.toggle!(:admin)
  
  sales = User.create!(
    first_name: "Roger",
    last_name: "Sterlink",
    username: "roger",
    email: "r.sterling@scdp.com",
    password: "password",
    password_confirmation: "password")

  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    username = first_name.downcase.sub(" ", "_") + "_" + n.to_s
    email = Faker::Internet.email(first_name)
    password = "password"
    User.create!(
      first_name: first_name,
      last_name: last_name,
      username: username,
      email: email,
      password: password,
      password_confirmation: password)
  end
end

def make_products
  99.times do |n|
    sku = Faker::Lorem.characters(6).upcase + "-#{n}"
    short_name = Faker::Lorem.characters(22).upcase
    name = Faker::Lorem.characters(120)
    #description = Faker::Lorem.words(12)
    Product.create!(
      sku: sku,
      short_name: short_name,
      name: name,
      description: nil,
      reference: nil,
      is_active: true,
      last_sale: n.hours.ago,
      last_buy: n.days.ago)
  end
end

def make_customers
  99.times do |n|
    first_name = Faker::Name.first_name
    code = first_name.downcase.sub(" ", "_") + "_" + n.to_s
    email = Faker::Internet.email(first_name)
    password = "password"
    Customer.create!(
      code: first_name,
      company_name: Faker::Company.name,
      first_name: first_name,
      last_name: Faker::Name.last_name,
      mobile: Faker::PhoneNumber.cell_phone,
      phone: Faker::PhoneNumber.phone_number)
  end
end

def make_suppliers
  99.times do |n|
    company_name = Faker::Company.name
    company_short_name = company_name.gsub(/[^0-9a-z ]/i, '')[0, 31].downcase.sub(" ", "_")
    Supplier.create!(
      short_name: company_short_name,
      name: company_name,
      description: nil)
  end
end