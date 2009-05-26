SetNotationHelper
=================

A library providing set notation support via a named_scope for ActiveRecord models. 

Have you ever wanted to manipulate a set of resources from the database from a URL but were not sure how? Let me suggest using set notation for the ID.

    GET /sounds/{1,2,3}

Install the gem and add it to your environment to add support for all your models.

To use:
  
    sound = Sound.in_set("{1,2,3}")
    

Installation
------------

    sudo gem install dmichael-set-notation-helper -s http://gems.github.com
    
Add the gem to your environment.rb file
    
    config.gem "set-notation-helper", :lib => 'set_notation_helper'
    

Matching for sets in your routes
---------------------------
    
If you are interested in matching for sets in the routes you can do something like this

    regexes = [
      /%7B\s*([\d\-,(%20)*]*)\s*%7D/, 
      /\{\s*([\d\-,\s*]*)\s*\}/
    ]
  	
  	regexes.each do |regex|
      map.with_options( :controller => 'sounds', :action => 'index', :id => regex, :conditions => { :method => :get }) do |r|
        r.connect "/#{resource}/:id.:format"
        r.connect "/#{resource}/:id"
      end
    end
