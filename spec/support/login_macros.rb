module LoginMacros
  def create_user_and_login
    @user = create(:user)
    visit root_path
    fill_in 'Mail Adresi', with: @user.email 
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
  end

  def login
    visit root_path
    fill_in 'Mail Adresi', with: @user.email 
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
  end

  def fill_in_form 
    @user = create(:user)
    fill_in 'Mail Adresi', with: @user.email 
    fill_in 'Şifre', with: @user.password
  end

  def login_with_invalid_info
    @user = create(:user)
    visit root_path
    fill_in 'Mail Adresi', with: 'somewrongemail@example.com' 
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
  end
end
