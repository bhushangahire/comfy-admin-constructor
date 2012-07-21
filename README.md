# ComfyAdminConstructor

*ComfyAdminConstructor* allows you to quickly and easily build basic admin interfaces in [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa).

Installation
------------

Add gem definition to your Gemfile:

      gem 'comfy-admin-constructor'

Then, from the Rails project's root run:

      bundle install

Requirements
------------

There are plans to make CAC more flexible in the future, but right now it assumes a few things about your CMS install:

* You access CMS at /admin and not /cms-admin
* You use HAML and SASS
* You don't store your models in sub-directories
* Your admin controllers and views are stored in controllers/admin and views/admin, respectively

Quick Start Guide
-----------------

