module WrestlersHelper

	def sub_and_tag_display(x, y)
		if x == 0 || x == nil || x == ""
			return y
		elsif y == 0 || y == nil || y == ""
			return x
		else
			return "#{x}-#{y}"
		end
	end
end
