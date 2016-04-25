
class String

	def is_range?
		if self !~ /\A(\d{4}).*(\d{4})\Z/
			return false
		else
			result = [$1.to_i, $2.to_i]
			result[1] += 1 unless self =~ /\.\.\./
			result
		end
	end
end