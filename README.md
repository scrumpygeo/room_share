# Room Share App for booking and offering rooms for rent

Version 1: 

Home has all flats available with location search bar on it - default has last 6 added (b4 login and after)
Dashboard has list of bookings for current user
Rooms/index - list as result of query; all if none




User posts room(s) he/she wishes to rent and availability dates

Room images loaded via cloudinary

Customer selects room and date, makes a reservation and waits for confirmatory email from owner.

Initial Schema:


```
  +--------------+       +-------------+
  |     users    |       |   room      |
  +--------------+       +-------------+
+-| id           |---+   | id          |-+
| | first_name   |   |   | name        | |
| | last_name    |   |   | description | |
| | address      |   +-->| owner_id    | |
| | phone_number |       +-------------+ |
| +--------------+                       |
|                                        |
|            +-------------+             |
|            |  bookings   |             |
|            +-------------+             |
|            | id          |             |
|            | start_time  |             |
|            | end_time    |             |
+----------->| customer_id |             |
             | room_id     |<------------+
             +-------------+

```



1. 
rails g model room name:string description:string user:references
rails g model booking start_date:date end_date:date room:references user:references
rails g model dashboard
rails db:migrate

- add fields to User:
	first_name
	last_name
	
rails generate migration AddNameToUser first_name:string last_name:string first_name:string


user
has_many :rooms
  has_many :bookings, through: :rooms



2. ROUTES
==========

Shallow Nesting:

  https://edgeguides.rubyonrails.org/routing.html#shallow-nesting


    resources :rooms do
      resources :bookings, shallow: true
    end

  is same as:

    resources :rooms do
      resources :bookings, only: [:index, :new, :create]
    end
    resources :bookings, only: [:show, :edit, :update, :destroy]

==

rails db:drop db:create db:migrate
===

3. SEED & MODEL MODIF.

Next:
  - seed
  - 

add to room:
  price
  address:string
  nr_guests:integer
  photo:string

rails generate migration AddInfoToRoom price:decimal address:string, city:string, guest_nr:integer photo:string

  def change
    add_column :rooms, :price, :decimal
    add_column :rooms, :address, :string
    add_column :rooms, :city, :string
    add_column :rooms, :guest_nr, :integer
    add_column :rooms, :photo, :string
  end

in view:
  currency converted to bigdecimal: on output:
    number_to_currency(price, :unit => "€")
    #=> €1,234.01


NEED PRICE AND Nr GUESTS IN BOOKING

  rails generate migration AddInfoToBooking price:decimal guest_nr:integer


4. CONTROLLERS
==============

rails g controller rooms index

rails g controller bookings

rails g dashboard index



5. Look at adding geolocation

  add geocoder gem
  rails g migration add_lat_to_rooms latitude:float longitude:float


6. change address to street
  also change seed

  rails g migration ChangeColumnName

    def change
      rename_column :rooms, :address, :street
    end
  
  rails db:reset db:migrate


7. Delete booking **only if pending**



Next Section
============

map.
  - google or mapbox




Later
======

Let user offer room for rent

i.  room.user_id = room owner
ii. room/new to create new room

iii. to edit/delete room: add buttons on 

iv. user.host = true if he has registered to be a host


  <img class="booking-image hidden-xs" width: 400, height: 300, crop: :fill, src="https://source.unsplash.com/400x300/?bedrooms&rand=<%= rand( 9999) %>" />
<div class="col-sm-6 col-md-8 col-lg-9 col-xl-10"









