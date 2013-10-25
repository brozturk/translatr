RSpec::Matchers.define :allow_action do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end

  failure_message_for_should do |permission|
    "expected to have permission for these actions"
  end

  failure_message_for_should_not do |permission|
    "expected to not have permission for these actions"
  end

  description do 
    "allow access to the %{*args} actions"
  end
end
