require "spec_helper"
require "transferring_money"

describe TransferringMoney do
	let(:source) { Account.new }
	let(:destination) { Account.new }
	let(:source_account) { subject.source_account }
	let(:destination_account) { subject.destination_account }

	subject { TransferringMoney.new(source, destination) }

	describe "source" do
		it "should be a SourceAccount" do
			subject.source_account.should be_a(TransferringMoney::SourceAccount)
		end
	end

	describe "destination" do
		it "should be a DestinationAccount" do
			subject.destination_account.should be_a(TransferringMoney::DestinationAccount)
		end
	end

	describe "transfer" do
	end

	describe :SourceAccount do
		describe "#transfer_out" do
			before :each do
				source_account.stub(:context).and_return(subject)
			end

			it "should decrese_balance" do
				source_account.should_receive(:decrease_balance).with(42).once
				source_account.transfer_out(42)
			end
			it "should transfer_in destination account" do				
				destination_account.should_receive(:transfer_in).with(42).once
				source_account.transfer_out(42)
			end
		end
	end	

	describe :DestinationAccount do
		describe "#transfer_in" do
			it "should increse_balance" do
				destination_account.should_receive(:increse_balance).with(42).once
				destination_account.transfer_in(42)
			end
		end
	end
end