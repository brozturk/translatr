require 'spec_helper'

feature 'Translator can' do 

  background do 
      @translator = FactoryGirl.create(:user, translator: true, leader: false)
      @other_user = FactoryGirl.create(:user)
      @team = FactoryGirl.create(:team)
      relationship = FactoryGirl.create(:user_team, user_id: @translator.id, team_id: @team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
      @text = FactoryGirl.create(:text, user_id: @other_user.id, team_id: @team.id)
      @translation = FactoryGirl.create(:translation, text_id: @text.id, user_id: @translator.id, team_id: @team.id)
  end

  scenario 'edit a translation he or she created' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link @text.title
    expect(page).to have_content 'Çeviriyi Sil'
    expect(page).to have_content 'Çeviriyi Editle'
    click_link 'Çeviriyi Editle'
    expect(page).not_to have_content 'Bunu yapmaya izniniz yok'
    expect(page).to have_content @translation.translation_text
    expect(page).to have_content @text.title
    expect(page).to have_content @text.text
    fill_in 'Düzenlenmiş Çeviriyi Buraya Gir', with: 'edited text'
    click_button 'Düzenle'
    expect(current_path).to eq text_path(@text)
    expect(page).to have_content 'edited text'
  end
end
