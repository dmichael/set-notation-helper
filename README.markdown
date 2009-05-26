SetNotationHelper
=================

A library providing set notation support for ActiveRecord models. Include this module in the models you want to support set notation finders and you are all set.

To use:
  
    sound = Sound.in_set("{1,2,3}")
    

Installation
------------

    sudo gem install set-notation-helper -s http://gems.github.com
    
Add the gem to your environment.rb file
    
    config.gem "set-notation-helper", :lib => 'set_notation_helper'
    

Matching for sets in your routes
---------------------------
    
If you are interested in matching for sets in the routes you can do something like this

    regexes = [
      /%7B\s*([\d\-,(%20)*]*)\s*%7D/, 
      /\{\s*([\d\-,\s*]*)\s*\}/
    ]
  	
  	set_regexes.each do |regex|
      map.with_options( :controller => 'sounds', :action => 'index', :id => regex, :conditions => { :method => :get }) do |r|
        r.connect "/#{resource}/:id.:format"
        r.connect "/#{resource}/:id"
      end
    end
