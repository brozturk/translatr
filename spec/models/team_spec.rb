require 'spec_helper'

describe Team do 
  it {should have_and_belong_to_many(:users)}
  it {should validate_presence_of(:name)}
  it {should have_many(:texts).through(:users)}
  it {should have_many(:translations).through(:users)}
end
