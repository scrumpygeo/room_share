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

