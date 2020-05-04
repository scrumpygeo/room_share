require 'faker'

Booking.destroy_all
Room.destroy_all
User.destroy_all

puts 'Creating 10 users...'
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456"
  )
  user.save!
end

puts 'Creating Fred'
user = User.new(
  first_name: 'Fred',
  last_name: 'Bloggs',
  email: 'fred@bloggs.me',
  password: '123456'
)
user.save!

puts 'Creating Wilma'
user = User.new(
  first_name: 'Wilma',
  last_name: 'Flintstone',
  email: 'wilma@flintstone.me',
  password: '123456'
)
user.save!

puts 'Finito!'