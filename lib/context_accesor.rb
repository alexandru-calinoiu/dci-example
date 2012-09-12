module ContextAccesor
	def context
		Thread.current[:context]
	end
end