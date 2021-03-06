use Mix.Config

config :exvcr, [
  vcr_cassette_library_dir:    "test/fixture/vcr_cassettes",
  custom_cassette_library_dir: "test/fixture/custom_cassettes",
  filter_url_params:           true,
  filter_sensitive_data:       [
    # https://regex101.com/r/bQ3pD9/1
    [pattern: "api_key\=.[^&\"]*", placeholder: "api_key=PAGARME_API_KEY"],
    [pattern: "ip\":\".[^\\\"]*", placeholder: "ip\":\"0.0.0.0"],
  ],
  response_headers_blacklist: ["Set-Cookie", "X-Iinfo"]
]
