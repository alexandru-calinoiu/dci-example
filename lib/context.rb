require File.dirname(__FILE__) + "/context_accesor" 

module Context
	include ContextAccesor

	def context=(ctx)
		Thread.current[:context] = ctx
	end

	def in_context
		old_context = self.context
		self.context = self
		res = yield
		self.context = old_context
	end
end