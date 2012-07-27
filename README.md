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

* You don't store your models in sub-directories
* Your CMS initializer specifies a custom navigation template at **/[your admix route prefix]/_navigation**

Upcoming Features
----------------

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
      create  app/controllers/cms-admin/event_listings_controller.rb
      create  app/views/cms-admin/event_listings/_form.html.haml
      create  app/views/cms-admin/event_listings/edit.html.haml
      create  app/views/cms-admin/event_listings/index.html.haml
      create  app/views/cms-admin/event_listings/new.html.haml
       route  namespace(:cms-admin){ resources :event_listings, :except => [:show] }

So, what happened there?

* CAC checked which admin_prefix we are using in CMS. (Defaults to **cms-admin**)
* The EventListing model was generated
* A migration was generated to create the necessary table for our database (Note: Migrations are **never** run automatically. That's on you.)
* A controller, complete with ActiveRecord rescues, success/failure flash messages, and more.
* Views for all the operations we'll need, along with a form. (Uses HAML if available, ERB if not)
* Added a new route
* Appended a new link to the navigation template

That's it! CAC gives you all the basics. If you need to do something a little more complicated, it's easy to make any changes you like.

---

ComfyAdminConstructor is released under the [MIT license](https://github.com/bgilham/comfy-admin-constructor/blob/master/LICENSE)

Copyright 2012 Brian Gilham, [The Working Group Inc](http://www.twg.ca)