require 'spec_helper'

  feature 'User sees a list of users and translators' do
    scenario 'and sees translators by clicking on a tab' do 
    user1 = create(:user)
    user2 = create(:user)
    translator = create(:user, translator: true)
    create_user_and_login
    visit users_path
    expect(page).to have_content user1.name
    expect(page).to have_content user2.name
    expect { click_link 'Çevirmenler' }.to have_content translator.name
  end
end
