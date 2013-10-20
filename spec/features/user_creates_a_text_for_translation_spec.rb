require 'spec_helper'

feature 'user creates a text for translation: ' do 
  background do 
    @team_leader = create(:user)
    @user = create(:user)
    @team = create(:team)
    @team.leader_id = @team_leader.id
    @team_leader.leader_of_team = @team.id
    @team_leader.leader = true
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @leader_relationship = create(:user_team, user_id: @team_leader.id, team_id: @team.id, state: 'accepted')
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.email
    fill_in 'Şifre', with: @team_leader.password
    click_button 'Giriş'
    click_link @team.name
    visit new_team_text_path(@team)
    fill_in 'Başlık', with: 'a title' 
    fill_in 'Çevrilecekler', with: 'a text to be translated'  
    click_button 'Gönder'
    visit user_path(@team_leader)
    click_link 'Çıkış Yap'
  end

  scenario 'team members can view it' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit user_path(@user)
    visit team_texts_path(@team)
    expect(page).to have_content 'a title'
    expect(page).to have_content 'a text to be translated'
  end

  scenario 'it can be translated' do 
    @translator = create(:user, translator: true)
    translator_relationship = create(:user_team, user_id: @translator.id, team_id: @team.id, state: 'accepted')
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    expect(page).to have_content 'a title'
    expect(page).to have_content 'a text to be translated'
    click_link 'a title'
    fill_in 'Çeviri', with: 'çevrilecek bir metin'
    click_button 'Çevir'
    expect(page).to have_content 'çevrilecek bir metin'
    expect(page).not_to have_field('Çeviri', :type => 'textarea')
  end
end
