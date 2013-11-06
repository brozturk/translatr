require 'spec_helper'

feature 'a leader who is also a translator can' do 
  background do 
    @user = create(:user, leader: true, translator: true)
    @other_user = create(:user)
    @team = create(:team)
    @team.leader_id = @user.id
    @other_team = create(:team)
    relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    relationship2 = create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
    @other_text = create(:text, user_id: @other_user.id,  team_id: @team.id)
    @users_translation = create(:translation, user_id: @user.id, team_id: @team.id, text_id: @other_text.id)
  end
  scenario 'view translator and leader related links' do 
   visit new_session_path
   fill_in 'Mail Adresi', with: @user.email
   fill_in 'Şifre', with: @user.password
   click_button 'Giriş'
   visit team_texts_path(@team)
   expect(page).to have_content 'Grubu Yönet'
   expect(page).not_to have_content 'Benim Çevirilerim'
   expect(page).not_to have_content 'Yeni Çeviri'
   click_link @other_text.title
   expect(page).to have_content @users_translation.translation_text
   expect(page).to have_content 'Çeviriyi Editle'
   expect(page).to have_content 'Çeviriyi Sil'
  end
end
