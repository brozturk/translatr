require 'spec_helper'

feature 'user resets password' do 

  scenario 'by clicking the password reset link' do 
    user = create(:user)
    visit new_session_path
    click_link 'Hatırlatalım!'
    fill_in 'Mail Adresi', with: user.email
    click_button 'Şifremi Hatırlat!'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Şifrenizi yenilemeniz için göderdiğimiz maildeki linke tıklamanız gerekiyor'
    expect(open_last_email).to have_body_text (/Şifrenizi yenilemek için linke tıklayın/)
    expect(open_last_email).to be_delivered_to user.email
  end
end
