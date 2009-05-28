require File.join(File.dirname(__FILE__), '..', 'lib', 'set_notation_helper')
 
ActiveRecord::Base.send(:include, SetNotationHelper)
 
RAILS_DEFAULT_LOGGER.debug <<-STR
  ** [SetNotationHelper] loaded. \n
  Let's say that our universe contains the numbers 1, 2, 3, and 4. \n
  Let A be the set containing the numbers 1 and 2; \n
  that is, A = {1, 2}
STR