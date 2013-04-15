namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(first_name: "Donald",
                    last_name: "Draper",
                    username: "don",
                    email: "d.draper@scdp.com",
                    password: "password",
                    password_confirmation: "password")
  admin.toggle!(:admin)
  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    username = first_name.downcase.sub(" ", "_") + "_" + n.to_s
    email_name = first_name.downcase.sub(" ", "_") + "." + last_name.downcase.sub(" ", "_")
    email = "#{email_name}@scdp.com"
    password = "password"
    User.create!(first_name: first_name,
                last_name: last_name,
                username: username,
                email: email,
                password: password,
                password_confirmation: password)
  end
end