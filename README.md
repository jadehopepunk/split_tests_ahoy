# split_tests_ahoy

A split testing framework that uses the ahoy-matey gem for metrics and identity.

Heavily influenced by the split gem at
https://github.com/splitrb/split

In particular the API is almost identical and migration from that gem isn't too hard.

## Why?

I found that both the split and vanity gems had their own solutions for tracking the identity of each visiting browser, and that this
solution wasn't available or general enough for me to use for tracking metrics. I ended up using the excellent ahoy-matey gem
for metrics:

https://github.com/ankane/ahoy

Ahoy-matey provides a Visit record for each unique visitor to the site, and generates a unique id for them. This gem uses this visit
record for the split tests, and so a given unique visitor will always see the same alternative for one of your experiments. 
The ahoy-matey gem handles anonymous visitors keeping their same visit record when they become a logged in user, and associating
that visit record with a user in your database.

## Setup

If you are using bundler add split to your Gemfile:

``` ruby
gem 'split_tests_ahoy'
```

Then, install database migrations from this gem

``` ruby
rake split_tests_ahoy:install:migrations
rake db:migrate
```

This gem is a rails engine, and only works outside of rails if you can support the load paths set up by rails engines.

## Usage

To begin your ab test use the `ahoy_split_test` method, naming your experiment with the first argument and then the different alternatives which you wish to test on as the other arguments.

`ahoy_split_test` returns one of the alternatives, if a user has already seen that test they will get the same alternative as before, which you can use to split your code on.

It can be used to render different templates, show different text or any other case based logic.

`finished` is used to make a completion of an experiment, or conversion.

Example: View

```erb
<% ahoy_split_test("login_button", "/images/button1.jpg", "/images/button2.jpg") do |button_file| %>
  <%= img_tag(button_file, :alt => "Login!") %>
<% end %>
```

## Configuration

You can override the default configuration options of Split like so:

```ruby
SplitTestsAhoy.alternative_selector = MySelectorClass.new
SplitTestsAhoy.experiments = {
}
```

### Experiment configuration

Instead of providing the experiment options inline, you can store them
in a hash.

```ruby
SplitTestsAhoy.experiments = {
  "my_first_experiment" => {
    :alternatives => ["a", "b"]
  },
  "my_second_experiment" => {
    :alternatives => [
      { :name => "a", :percent => 67 },
      { :name => "b", :percent => 33 }
    ]
  }
}
```

You can also store your experiments in a YAML file:

```ruby
SplitTestsAhoy.experiments = YAML.load_file "config/experiments.yml"
```

You can then define the YAML file like:

```yaml
my_first_experiment:
  alternatives:
    - a
    - b
my_second_experiment:
  alternatives:
    - name: a
      percent: 67
    - name: b
      percent: 33
```

This simplifies the calls from your code:

```ruby
ahoy_split_test("my_first_experiment")
```

