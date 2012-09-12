require File.dirname(__FILE__) + "/context" 
require File.dirname(__FILE__) + "/account" 
require File.dirname(__FILE__) + "/context_accesor" 

class TransferringMoney
	include Context

	def self.transfer(source_account_id, destination_account_id, amount)
		source = Account.find(source_account_id)
		destination = Account.find(destination_account_id)
		TransferringMoney.new(source, destination).transfer(amount)
	end

	attr_reader :source_account, :destination_account

	def initialize(source, destination)
		@source_account = source.extend(SourceAccount)
		@destination_account = destination.extend(DestinationAccount)
	end

	def transfer(amount)
		in_context do
			@source_account.transfer_out(amount)
		end
	end

	module SourceAccount
		include ContextAccesor

		def transfer_out(amount)
			decrease_balance(amount)
			context.destination_account.transfer_in(42)
		end
	end

	module DestinationAccount
		include ContextAccesor

		def transfer_in(amount)
			increse_balance(amount)
		end
	end
end