module SetNotationHelper
  
  def self.included(base)
    # These methods are made available to both the class and instances
    base.extend(SetNotationHelper)
  end  

  def inherited(subclass)
    # base.send :include, ClassMethods
    subclass.class_eval do
      # This scope accepts either a String in the form "{1,2,3}" **OR** an Integer
      named_scope :in_set, lambda { |*args|
        value = args.first
  
        # A string input is either a set or an integer in disguise
        unless value.is_a?(String) || value.is_a?(Integer)
          logger.error "[SetNotationHelper] You have given the helper something it cant use: #{value.class}. No filter applied!"
          return {} 
        end
  
        if is_set?(value)
          { :conditions => "#{table_name}.id IN (#{ parse_set(value).to_a.join(',') })" }
        else
          { :conditions => "#{table_name}.id = #{ value.to_i }" }
        end
      }
    end
  end
      
  def set_limit
    100000
  end
  
  def is_set_or_range?(input)
    if is_set?(input) or is_range?(input)
      return true
    end
    return false
  end
  
  def is_range?(range)
    if range && range.is_a?(String) && range.split('-').size > 1 && !match_set(range)
      return true
    end
    return false
  end
  
  def match_set(set)
    return if set.blank? || !set.is_a?(String)
    set.match( /\{\s*(.*)\s*\}/ )
  end
  
  def is_set?(set)
    if match_set(set)
      return true
    end
    return false
  end
  
  def parse_set(set)
    match = match_set(set)
    if !match then return Set.new(set) end

    set = match[1].split(',')
    set.each_with_index{|element, i|
      if is_range?(element)
        set[i] = element.to_range.collect
        set.flatten!
      end
    }
    if set.size > set_limit
      @messages[:info] = "Your resultset has been truncated to #{set_limit} results"
    end
    set = Set.new(set[0..set_limit-1])
    return set
  end
   
  def convert_range_to_limits(input)        
    if !is_range?(input) then return false end
  
    # turn this String into a Range
    range  = input.to_range
    limit  = range.collect.size
    offset = range.first - 1

    return limit, offset
  end
end
