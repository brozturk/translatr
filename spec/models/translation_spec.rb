require 'spec_helper'

describe Translation do
  
  it { should validate_presence_of(:question) }
  it { should belong_to(:user) }

  it 'sets the time of the answer' do 
    translation = Translation.new(question: 'some thing that needs translating?')
    translation.answer = 'some answer'
    translation.set_time_of_answer
    translation.time_of_answer.should_not be_blank
  end
end
