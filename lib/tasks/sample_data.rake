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
    last_name: "Sterling",
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
  product_file = 'db/products_sample.txt'
  File.foreach(product_file) do |file_line|

    # split columns
    #file_line = file_line.encode("utf-8", "binary", :invalid => :replace, :undef => :replace)
    row = file_line.split("|")

    # Product
    sku = row[1].strip.to_s
    short_name = row[2].strip[0..64]
    name = row[2].strip.downcase.titleize

    # Save product
    product = Product.create!(
      sku: sku,
      short_name: short_name,
      name: name,
      description: nil,
      reference: nil,
      is_active: true,
      last_sale: rand(1..100).hours.ago,
      last_buy: rand(1..10).days.ago)
    # Save first stock with original cost
    cost = row[3].strip().to_f
    price = cost + (cost * 30 / 100)
    product.stocks.create!(
      cost: cost,
      price: price,
      quantity: rand(10...1000))

    # me estoy complicando con esto??? >:/
    for i in (1..10).to_a.sample(rand(3..10))

      # change the cost
      cost_change_percentage = rand(-10..-1)
      cost = row[3].strip().to_f
      cost += cost * cost_change_percentage / 100

      # change the price
      price_change_percentage = rand(10..25)
      price = cost + (cost * price_change_percentage / 100)

      # Save stock
      product.stocks.create!(
        cost: cost,
        price: price,
        quantity: rand(5...100))
    end
  end

  #99.times do |n|
  #  sku = Faker::Lorem.characters(6).upcase + "-#{n}"
  #  short_name = Faker::Lorem.characters(22).upcase
  #  name = Faker::Lorem.characters(120)
  #  #description = Faker::Lorem.words(12)
  #  Product.create!(
  #    sku: sku,
  #    short_name: short_name,
  #    name: name,
  #    description: nil,
  #    reference: nil,
  #    is_active: true,
  #    last_sale: n.hours.ago,
  #    last_buy: n.days.ago)
  #end
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
