require 'set_notation_helper'
 
ActiveRecord::Base.send :include, SetNotationHelper
 
RAILS_DEFAULT_LOGGER.debug "** [SetNotationHelper] loaded. Let's say that our universe contains the numbers 1, 2, 3, and 4. Let A be the set containing the numbers 1 and 2; that is, A = {1, 2}"