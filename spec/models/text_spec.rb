require 'spec_helper'

describe Text do 
  it { should belong_to(:user) }
  it { should belong_to(:team) }
  it { should have_one(:translation) }
  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:text) } 
  it { should validate_presence_of(:user_id) } 
end
