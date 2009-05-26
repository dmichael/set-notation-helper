SetNotationHelper
=================

A library providing set notation support for ActiveRecord models. Include this module in the models you want to support set notation finders and you are all set.

To use:
  
  class Sound < ActiveRecord::Base
    include NamedScopeHelper
  end
  
  sound = Sound.in_set("{1,2,3}")