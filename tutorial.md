Add gems `pg` `factory_girl_rails` `active_model_serializers`

RUN  rspec by running `rails generate rspec:install`.

RUN `rails g annotate:install`

This creates a spec folder.


create Restaurant model `rails g model restaurant name description`

create OpeningTime model `rails g model opening_time day opens_at:datetime closes_at:datetime restaurant:references`

create a migrate file `touch migrate`

Make it executable `chmod +x migrate`

Open the file and put in it `rake db:migrate && rake db:test:prepare`

Add serailzer for restaurant and opening times `rails g serializer restaurant` `rails g serializer opening_time`

Add tests for api index. 

Add model for `Menu` by running `rails g model menu restaurant:references period start_date:datetime end_date:datetime`

Add model for MenuItem by running `rails g model menu_item menu:references name description price:decimal`

Add routes for `Menu`