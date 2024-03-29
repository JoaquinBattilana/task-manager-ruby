require_relative "Command.rb"
require_relative "../utilities/StringDate.rb"
require_relative "../exceptions/InvalidArguments.rb"

class SetCommand
	include Command
	DATE = 1
	GROUP = 2
	def initialize(holder, params)
		@holder= holder
		@text = params.join(" ")
		@group = nil
		@date = nil
		if(/^date_task(\stomorrow|\stoday|\s[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])*\s*/ =~ @text) #set default fecha
			@command = DATE
		elsif(/^group/ =~ @text) #set default grupo
			@command = GROUP
		else
			raise InvalidArguments
		end
	end

	def execute()
		case @command
		when DATE
			arr = @text.split(/\s+/)
			if(arr[-1] != 'date_task')
				@date = StringDate.new(arr[-1])
				puts "Date set to #{@date}"
			else
				@date = nil
				puts "Fixed-date removed"
			end
			@holder.set_date(@date)
		when GROUP
			arr = @text.split(/\s+/)
			if(arr[-1] != 'group')
				@group = arr[-1]
				@holder.set_group(@group)
				puts "Group set to #{@group}"
			else
				@holder.set_group(nil)
				puts "Fixed-group removed"
			end
		end
	end
end
