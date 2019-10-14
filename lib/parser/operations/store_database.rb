
module Operations
    class StoreDatabase
      include Dry::Transaction::Operation
      include Import[:logger]
  
      def call(input)
        result = Purchase.create(input[:purchase])
        if result
          Parser.logger.info "Purchase created #{result.attributes} with: \n 
                              lots #{result.lots.to_a} \n
                              lots_item #{result.lots.to_a}"
          Success(result)
        else 
          return Failure(result)
        end
      end
    end
  end