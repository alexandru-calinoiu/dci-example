require "spec_helper"
require "context_accesor"

describe :ContextAccesor do
	subject {
		Class.new do
			extend ContextAccesor
		end
	}

	it "should return the context in the current thread" do
		context = mock(:context)
		Thread.current[:context] = context
		subject.context.should eq context
	end
end