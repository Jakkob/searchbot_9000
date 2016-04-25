module Google
  class Search

  	attr_accessor :proxy

  	def initialize options = {}, &block
      @type = self.class.to_s.split('::').last.downcase.to_sym
      @version = options.delete(:version) || 1.0
      @offset = options.delete(:offset) || 0
      @size = options.delete(:size) || :large
      @language = options.delete(:language) || :en
      @query = options.delete(:query)
      @api_key = options.delete(:api_key) || :notsupplied
      @proxy = options.delete(:proxy) || nil # Added this line to allow instance-local proxy use.
      @options = options
      raise Error, 'Do not initialize Google::Search; Use a subclass such as Google::Search::Web' if @type == :search
      yield self if block
    end

    def get_raw
      @sent = true
      if @proxy
      	return open(get_uri, :proxy_http_basic_authentication => [URI.parse("#{@proxy[:protocol]}://#{@proxy[:host]}:#{@proxy[:port]}"), "#{@proxy[:user]}", "#{@proxy[:password]}"]).read if !@proxy[:user].nil? && !@proxy[:password].nil?
      	return open(get_uri, :proxy => "#{@proxy[:protocol]}://#{@proxy[:host]}:#{@proxy[:port]}/")
      end
      open(get_uri).read
    end

    class Item

    	def get_simple_hash
    		{
    			:title => @title,
    			:url => @uri,
    			:rank => @index + 1
    		}
    	end
    end
  end
end