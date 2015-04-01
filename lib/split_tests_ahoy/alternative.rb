module SplitTestsAhoy
  class Alternative
    attr_reader :name

    def initialize(options = {})
      @name = options[:name]

      raise ArgumentError, "name is required" if @name.blank?
    end
  end
end