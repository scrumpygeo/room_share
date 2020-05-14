require 'faker'
require 'csv'

Booking.destroy_all
Room.destroy_all
User.destroy_all

# puts 'Creating 5 users...'
# 5.times do
#   user = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "abcdefgh12345678"
#   )
#   user.save!
# end

# use csv for rooms

# CSV.foreach("db/RoomData.csv", headers: true) do |line|
#   Room.new line_to_hash.except(%w{latitude longitude user})
# end

csv_text = File.read(Rails.root.join('db', 'room.csv'))
csv = CSV.parse(csv_text, headers:true, :encoding => 'ISO-8859-1')

puts 'Creating rooms...'
csv.each do |row|
  r = Room.new
  r.name = row['name']
  r.description = row['description']
  r.street = row['street']
  r.city = row['city']
  r.price = row['price']
  r.guest_nr = row['guest_nr']
  r.user = User.all.sample
  r.photo = "https://source.unsplash.com/400x300/?bedrooms"
  r.save!
end

puts "There are now #{Room.count} rows in the rooms table"

puts 'Creating 10 bookings...'
10.times do
  booking = Booking.new(
    start_date: 20200612,
    end_date: 20200619,
    user: User.all.sample,
    room: Room.all.sample,
    guest_nr: 2,
    status:  ["Pending", "Confirmed"].sample,
    price:  5*rand(25..50)
  )
  booking.save!
end

puts 'Finito!'