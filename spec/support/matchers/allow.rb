RSpec::Matchers.define :allow do |*args| 
  match do |permission|
    permisssion.allow?(*args).should be_true
  end
end
