require 'spec_helper'

describe Team do 
  it { should have_many(:users).through(:user_teams) }
  it { should validate_presence_of(:name) }
  it { should have_many(:texts).through(:users) }
  it { should have_many(:translations).through(:users) }
end
