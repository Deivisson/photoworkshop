Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, "1546622365584604", "4bc84a16267c4328eae57226706bf209",
  #     								:client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}},
  #               			scope: 'email', info_fields: 'email, name', secure_image_url: true

  # provider :twitter, "a76VtYhlqqpePvTJiZeEwXGI8", "iUNicoJovnDp3qkiFeog6bk9C5kkCwe1YufQHTuDchl4bw3qky",
  #                 :client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}},
  #                 scope: 'email', info_fields: 'email, name', secure_image_url: true
end


