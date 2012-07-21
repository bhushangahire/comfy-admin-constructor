# ComfyAdminConstructor

**ComfyAdminConstructor** allows you to quickly and easily build basic admin interfaces in [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa).

Installation
------------

Add gem definition to your **Gemfile**:

      gem 'comfy-admin-constructor'

Then, from the Rails project's root run:

      bundle install

Requirements
------------

There are plans to make CAC more flexible in the future, but right now it assumes a few things about your CMS install:

* You access CMS at **/admin** and not /cms-admin
* You use HAML and SASS
* You don't store your models in sub-directories
* Your admin controllers and views are stored in **controllers/admin** and **views/admin**, respectively
* Your CMS initializer will need to specify a custom navigation template at **views/admin/_navigation.html.haml***

Planned Features
----------------

* More flexibility in where/how things are created
* Basic passing tests

Quick Start Guide
-----------------

**Before proceeding make sure you have CMS up and running, taking into account the requirements above.** Make sure you've created your first site.

All done? Good. Let's walk through creating your first admin interface using CAC.

Let's say my application needs a way to create/edit event listings. Some of the fields we might need include:

* Event title
* Start date/time
* End date/time
* Description
* Location

With CAC, this is easy. In the root of the Rails project, we simply type:

      rails g cms_admin EventListing title:string starts_at:datetime ends_at:datetime description:text location:string

CAC will automatically generate a bunch of files for us:

      create  app/models/event_listing.rb
      create  db/migrate/20120721145844_create_event_listings.rb
      create  app/controllers/admin/event_listings_controller.rb
      create  app/views/admin/event_listings/_form.html.haml
      create  app/views/admin/event_listings/edit.html.haml
      create  app/views/admin/event_listings/index.html.haml
      create  app/views/admin/event_listings/new.html.haml
       route  namespace(:admin){ resources :event_listings, :except => [:show] }

So, what happened there?

* The EventListing model was generated, with basic :presence => :true validation for all attributes
* A migration was generated to create the necessary table for our database (Note: Migrations are never run automatically. That's on you.)
* A controller, complete with ActiveRecord rescues, flash messages for success/failure messages, and more.
* Views for all the operations we'll need, along with a form.
* Added a new route
* Appended a new link to the navigation template