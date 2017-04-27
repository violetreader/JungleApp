ActionMailer::Base.smtp_settings = {
  address:        'localhost', 			# default: localhost
  port:           '5432',                  # default: 25
  user_name:      '',
  password:       '',
  authentication: :plain                 # :plain, :login or :cram_md5
}