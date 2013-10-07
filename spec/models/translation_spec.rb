require 'spec_helper'

describe Translation do

  it { should validate_presence_of(:question) }
  it { should belong_to(:user) }

end
