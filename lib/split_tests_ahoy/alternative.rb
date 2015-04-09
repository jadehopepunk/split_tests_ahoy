module SplitTestsAhoy
  class Alternative
    attr_reader :name, :percent

    def self.load_from_config(experiment, config)
      options = {experiment: experiment}
      if config.is_a?(String)
        options[:name] = config
      else
        options = config
      end
      new(options)
    end

    def initialize(options = {})
      @name = options[:name]
      @percent = options[:percent]
      @experiment = options[:experiment]
      @metric = options[:metric].constantize if options[:metric]

      raise ArgumentError, "name is required" if @name.blank?
    end

    def weight
      percent / 100.0 if percent
    end

    def participant_count
      @experiment.participants.for_alternative_name(@name).count
    end

    def conversions_at(datetime = Time.now)
      metric.success_score_at(datetime)
    end

    def population_at(datetime = Time.now)
      metric.population_at(datetime)
    end

    def metric
      raise ArgumentError.new("no metric") unless @metric
      @metric.new(self)
    end
  end
end