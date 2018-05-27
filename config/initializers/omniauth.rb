opts = { scope: 'user:email'}

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, "gpoyyR4Bhh9ekzEqea7ASjcq", "1005727625857-9ccapoo9bd6avq4ndm220nivfq4jb0v5.apps.googleusercontent.com"

    provider :github, "e89be330b545152e6d27", "02ed3ae160b2e6ff8156f1ea275435973f6c1a92"

end