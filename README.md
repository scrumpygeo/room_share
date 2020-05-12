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

rails g controller dashboards index



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


8. mapbox section



9. create room



10. create dashboard
    rails g controller dashboard index





Later
======

Let user offer room for rent

i.  room.user_id = room owner
ii. room/new to create new room

iii. to edit/delete room: add buttons on 

iv. user.host = true if he has registered to be a host


  <img class="booking-image hidden-xs" width: 400, height: 300, crop: :fill, src="https://source.unsplash.com/400x300/?bedrooms&rand=<%= rand( 9999) %>" />
<div class="col-sm-6 col-md-8 col-lg-9 col-xl-10"


User(#16360) expected, got [#<User id: 27, email: "julio.dickinson@jones.io", created_at: "2020-05-11 15:25:13", updated_at: "2020-05-11 15:25:13", first_name: "Antonia", last_name: "Kirlin">, "https://source.unsplash.com/400x300/?bedrooms"] which is an instance of Array(#4240)



room show
 <%= image_tag @room.photo, class: "d-block w-100 rounded mt-3", width: 400, height: 300 %>


     <%= f.input :photo, as: :string, required: false %>  in form - removed

CLOUDINARY SETUP  
---------------

1. add gem 'cloudinary'
2.   rails active_storage:install
      -> u now have config/storage.yml file

      # config/storage.yml
      cloudinary:
        service: Cloudinary
      Replace :local by :cloudinary in the config:

      # config/environments/development.rb
      config.active_storage.service = :cloudinary

3. rails db:migrate 

4. in rooms.rb model add:
     has_one_attached :photo       # or image - callit whatever.


5. View & Controller
    <!-- app/views/articles/_form.html.erb -->
    <%= simple_form_for(article) do |f| %>
      <!-- [...] -->
      <%= f.input :photo, as: :file %>
      <!-- [...] -->
    <% end %>


6.  # app/controllers/articles_controller.rb
    def article_params
      params.require(:article).permit(:title, :body, :photo)
    end



7. Displaying the image
    <!-- app/views/articles/show.html.erb -->
    <%= cl_image_tag @article.photo.key, height: 300, width: 400, crop: :fill %>

8. Usage in background-image
  Example: Card component.

  You must use cl_image_path

<div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('<%= cl_image_path @article.photo.key, height: 300, width: 400, crop: :fill %>')">
  Cool article
</div>


9. Seed
You can upload from a URL.

require "open-uri"

file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
article = Article.new(title: 'NES', body: "A great console")
article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')

10.  Here we write article.photo.attach(...) because we wrote has_one_attached :photo in app/models/article.rb

      Helpful Active Storage methods
      @article.photo.attached? #=> true/false
      @article.photo.purge #=> Destroy the photo

11. Multiple images
    If you want to have many attached images, you can define a different relationship in your model:

    class Article < ApplicationRecord
      has_many_attached :photos
    end


12. View & Controller
      <!-- app/views/articles/_form.html.erb -->
      <%= simple_form_for(article) do |f| %>
        <!-- [...] -->
        <%= f.input :photos, as: :file, input_html: { multiple: true } %>
        <!-- [...] -->
      <% end %>
      # app/controllers/articles_controller.rb
      def article_params
        params.require(:article).permit(:title, :body, photos: [])
      end
      <!-- app/views/articles/show.html.erb -->
      <% @article.photos.each do |photo| %>
        <%= cl_image_tag photo.key, height: 300, width: 400, crop: :fill %>
      <% end %>


13.  Production
Replace :local by :cloudinary in the config:

# config/environments/production.rb
config.active_storage.service = :cloudinary
Make sure to push your CLOUDINARY_URL env variable to Heroku:

heroku config:set CLOUDINARY_URL=cloudinary://166....
Check with:

heroku config



