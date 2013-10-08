require 'spec_helper'

describe Translation do

  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:text) } 
  it { should belong_to(:user) } 
  it { should belong_to(:text) }
end
