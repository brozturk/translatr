require 'spec_helper'

feature 'user gets an email when' do
  background do 
    @team_leader = create(:user, leader: true)
    @user = create(:user)
    @team = create(:team, leader_id: @team_leader.id)
    @team_leader.leader_of_team = @team.id
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @leader_relationship = create(:user_team, user_id: @team_leader.id, team_id: @team.id, state: 'accepted')
    @text = create(:text, user_id: @team_leader.id, team_id: @team.id)
  end

  scenario 'a text has been created' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.email
    fill_in 'Şifre', with: @team_leader.password
    click_button 'Giriş'
    click_link @team.name
    visit new_team_text_path(@team)
    fill_in 'Başlık', with: 'a title' 
    fill_in 'Çevrilecekler', with: 'a text to be translated'  
    click_button 'Gönder'
    expect(open_last_email).to be_delivered_to [@user.email, @team_leader.email]
    expect(open_last_email).to have_body_text (/grupta çevrilmek üzere yeni bir metin/)
  end

  scenario 'a text has been updated' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.email
    fill_in 'Şifre', with: @team_leader.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link @text.title
    click_link 'Yazıyı Editle'
    fill_in 'Yeni yazıyı buraya girin', with: 'updated text'
    click_button 'Tamamdır'
    expect(page).to have_content 'Çeviri başarılı bir şekilde editlendi'
    expect(open_last_email).to have_body_text (/tarafından metin değişikliği yapılmıştır./)
    expect(open_last_email).to be_delivered_to [@user.email, @team_leader.email]
  end
end
