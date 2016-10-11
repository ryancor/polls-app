Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook,
			 '252413555155388', 'f329dd903c09a0374d79fa800165a769',
             scope: 'public_profile,email,user_birthday', display: 'popup'
end
