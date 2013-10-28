require 'spec_helper'

feature 'user is restricted' do
  background do 
    @user = create(:user)
    @other_user = create(:user)
    @team = create(:team)
    @other_team = create(:team)
    relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    relationship2 = create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
    @users_text = create(:text, user_id: @user.id, team_id: @team.id)
    @other_text = create(:text, user_id: @other_user.id,  team_id: @team.id)
  end
  scenario 'when deleting texts except the ones they created' do 
   visit new_session_path
   fill_in 'Mail Adresi', with: @user.email
   fill_in 'Şifre', with: @user.password
   click_button 'Giriş'
   visit text_path(@other_text)
   expect(page).not_to have_content 'Yazıyı Sil'
   expect(page).not_to have_content 'Yazıyı Editle'
   visit text_path(@users_text)
   expect(page).to have_content 'Yazıyı Sil'
   expect(page).to have_content 'Yazıyı Editle'
   click_link 'Yazıyı Sil'
   expect(current_path).to eq team_texts_path(@team)
   expect(page).to have_content 'Yazınız ve varsa çevirisi silindi'
  end

  scenario 'when editing texts except the ones they created' do 
   visit new_session_path
   fill_in 'Mail Adresi', with: @user.email
   fill_in 'Şifre', with: @user.password
   click_button 'Giriş'
   visit text_path(@other_text)
   expect(page).not_to have_content 'Yazıyı Sil'
   expect(page).not_to have_content 'Yazıyı Editle'
   visit text_path(@users_text)
   expect(page).to have_content 'Yazıyı Sil'
   expect(page).to have_content 'Yazıyı Editle'
   click_link 'Yazıyı Editle'
   expect(current_path).to eq edit_text_path(@users_text)
   fill_in 'Yeni yazıyı buraya girin', with: 'edited text'
   click_button 'Tamamdır'
   expect(page).to have_content 'edited text'
  end
  
  scenario 'when trying to visit the page of a team they do not belong to' do 
   visit new_session_path
   fill_in 'Mail Adresi', with: @user.email
   fill_in 'Şifre', with: @user.password
   click_button 'Giriş'
   visit team_texts_path(@other_team)
   expect(page).to have_content 'Bunu yapmaya izniniz yok'
   visit team_texts_path(@team)
   expect(page).not_to have_content 'Bunu yapmaya izniniz yok'
   expect(current_path).to eq team_texts_path(@team)
  end
end
