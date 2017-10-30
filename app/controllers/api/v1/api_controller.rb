module Api
  
  module V1
    
    class ApiController < ActionController::Base
      
      #respond_to :json
        
      before_action :valid_request_format
      
      private
      
        #Invalid format request
        def valid_request_format
          if request.format != :json
            render  status: 406,
                    json: {
                            success: false, 
                            message: "The request must be json", 
                            code_error: 1
                           }
            return 
          end
          true
        end
        
    end
    
  end
  
end