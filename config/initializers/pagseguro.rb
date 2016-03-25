PagSeguro.configure do |config|
  config.token       = "3B6812567B324158BC2802BEDDD71CC3"# "38EC8F5B4254438A8A4EDC3796EA0D16"
  config.email       = "deivisson.bruno@gmail.com"
  config.environment = :sandbox # ou :sandbox. O padrão é production.
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end