require "spec_helper"
require "context"

describe :Context do
	subject {
		Class.new do
			extend Context
		end
	}

	it "should set a context in current thread"	do
		context = mock(:context)
		subject.context = context
		Thread.current[:context].should == context
	end

	describe "#in_context" do
		it "shold restore the old context" do
			context = mock(:context)
			subject.context = context
			subject.in_context do

			end
			subject.context.should eq context
		end
	end
end