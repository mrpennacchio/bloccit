if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           '2525',
    authentication: :plain,
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
    domain:         'herokucom',
    enable_starttls_auto: true
  }
end
# runs when our app starts. we use this to set config options or applicatoin settings
# In this case we need to configure some special settings to send emails
# We assign the username and password to environment variables
# they provide a reference point to information without revealing underlying data values

#sensitive data like API keys and passwords should not be stored i ngithub
