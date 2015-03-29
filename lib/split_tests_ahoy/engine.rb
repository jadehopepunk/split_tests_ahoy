module SplitTestsAhoy
  class Engine < ::Rails::Engine
    isolate_namespace SplitTestsAhoy

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
