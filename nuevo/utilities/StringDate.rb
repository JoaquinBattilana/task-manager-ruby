require "date"

class StringDate
	include Comparable
	attr_reader :date
	
	@@PREDEFINED_DATES={"yesterday"=>lambda{Date.today-1}, "tomorrow"=>lambda{Date.today+1}, "today"=>lambda{Date.today}}
	@@PREDEFINED_RANGES={"this-week" => lambda{StringDate.new("today")..StringDate.new(Date.today+6)}}
	
	def initialize(string)
		if(@@PREDEFINED_DATES.has_key?(string))
			@date=@@PREDEFINED_DATES[string].call
		elsif(string.is_a?(Date))
			@date=string
		else
			@date=Date.strptime(string, '%d/%m/%Y')
		end
	end
	def to_s
		if (@date== Date.today)
			return "today"
		elsif (@date==(Date.today+1))
			return "tomorrow"
		elsif (@date==(Date.today-1))
			return "yesterday"
		else
			return @date.strftime('%d/%m/%Y')
		end
	end
	def ==(other)
		return false if (other.nil? || !(other.is_a?(StringDate)))
		@date==other.date
	end
	def <=>(other)
		return nil if (other.nil? || !(other.is_a?(StringDate)))
		@date<=>other.date
	end
	def is_in?(range)
		if(@@PREDEFINED_RANGES.has_key?(range))
			return @@PREDEFINED_RANGES[range].call === self
		end
		range===self
	end
	def succ()
		StringDate.new(@date+1)
	end
	def +(other)
		return nil unless other.is_a?(StringDate)
		new StringDate(@date + other)
	end
end
