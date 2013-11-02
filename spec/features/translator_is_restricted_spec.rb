require 'spec_helper'

feature 'Translator is restricted' do 

  background do 
      @translator = FactoryGirl.create(:user, translator: true, leader: false)
      @other_translator = FactoryGirl.create(:user, translator: true, leader: false)
      @other_user = FactoryGirl.create(:user)
      @random_user = FactoryGirl.create(:user)

      @team = FactoryGirl.create(:team)
      @other_team = FactoryGirl.create(:team)

      relationship = FactoryGirl.create(:user_team, user_id: @translator.id, team_id: @team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
      realtionship3 = FactoryGirl.create(:user_team, user_id: @other_translator.id, team_id: @team.id, state: 'accepted')
      realtionship4 = FactoryGirl.create(:user_team, user_id: @random_user.id, team_id: @other_team.id, state: 'accepted')

      @text = FactoryGirl.create(:text, user_id: @other_user.id, team_id: @team.id)
      @other_text = FactoryGirl.create(:text, user_id: @random_user.id, team_id: @other_team.id)
      @other_team_text = FactoryGirl.create(:text, user_id: @other_user.id, team_id: @team.id)

      @translation = FactoryGirl.create(:translation, text_id: @text.id, user_id: @translator.id, team_id: @team.id)
      @other_translation = FactoryGirl.create(:translation, text_id: @other_team_text.id, user_id: @other_translator.id, team_id: @team.id)
  end

  scenario 'when trying to view texts that do not belong to a team he is a member of ' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit team_texts_path(@other_team)
    expect(page).to have_content 'Bunu yapmaya izniniz yok'
    visit text_path(@other_text)
    expect(page).to have_content 'Bunu yapmaya izniniz yok'
    visit team_texts_path(@team)
    expect(page).not_to have_content 'Bunu yapmaya izniniz yok'
  end

  scenario 'when trying to edit a translation that they do not own' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link @other_team_text.title
    expect(page).not_to have_content 'Çeviriyi Sil'
    expect(page).not_to have_content 'Çeviriyi Editle'
    visit edit_translation_path(@other_translation)
    expect(page).to have_content 'Bunu yapmaya izniniz yok'
    visit team_texts_path(@team)
    click_link @text.title
    expect(page).to have_content 'Çeviriyi Sil'
    expect(page).to have_content 'Çeviriyi Editle'
    click_link 'Çeviriyi Editle'
    expect(page).not_to have_content 'Bunu yapmaya izniniz yok'
    expect(page).to have_content @translation.translation_text
    expect(page).to have_content @text.title
    expect(page).to have_content @text.text
  end

  scenario 'when trying do delete a translation that they do not own' do
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link @other_team_text.title
    expect(page).not_to have_content 'Çeviriyi Sil'
    expect(page).not_to have_content 'Çeviriyi Editle'
    visit edit_translation_path(@other_translation)
    expect(page).to have_content 'Bunu yapmaya izniniz yok'
    visit team_texts_path(@team)
    click_link @text.title
    expect(page).to have_content 'Çeviriyi Sil'
    expect(page).to have_content 'Çeviriyi Editle'
    click_link 'Çeviriyi Sil'
    expect(page).not_to have_content 'Bunu yapmaya izniniz yok'
    expect(page).not_to have_content @translation.translation_text
    expect(page).to have_content @text.title
    expect(page).to have_content @text.text

  end
end
