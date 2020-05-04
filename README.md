# Room Share App for booking and offering rooms for rent

Version 1: 

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


===
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


Next:
  - seed
  - 

  ActiveRecord::HasManyThroughSourceAssociationNotFoundError: Could not find the source association(s) "booking" or :bookings in model Room. Try 'has_many :bookings, :through => :rooms, :source => <name>'. Is it one of user?

