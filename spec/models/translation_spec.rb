require 'spec_helper'

describe Translation do

  it { should validate_presence_of(:text_id) } 
  it { should validate_presence_of(:user_id) } 
  it { should validate_presence_of(:text) } 
  it { should belong_to(:user) } 
  it { should belong_to(:text) }
  it { should belong_to(:team) } 
end
