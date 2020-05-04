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


puts 'Creating 10 rooms...'
10.times do
  room = Room.new(
    name:    Faker::Address.community,
    description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote,
    address: Faker::Address.street_address, 
    city: Faker::Address.city,
    price:  rand(25..50),
    guest_nr: rand(1..4),
    user: User.all.sample
  )
  room.photo = "https://source.unsplash.com/400x300/?house,home"
  room.save!
end

puts 'Creating 10 bookings...'
10.times do
  booking = Booking.new(
    start_date: 20200612,
    end_date: 20200619,
    user: User.all.sample,
    room: Room.all.sample
  )
  booking.save!
end

puts 'Finito!'