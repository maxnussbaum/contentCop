require "ibm_watson"
require "dotenv/load"

EXPRESSION = /shit|piss|fuck|cunt|cocksucker|motherfucker|tits|ass|bastard|bitch|crap|cunt|frigger|nigga|nigger|prick|whore|twat/


def regex_analysis(lyrics)
  return true if lyrics.match(EXPRESSION)
  return false
end

def watson_analysis(lyrics)
  watson = IBMWatson::NaturalLanguageUnderstandingV1.new(
    version: "2018-11-16"
    iam_apikey: ENV["IAM_APIKEY"],
    iam_url: ENV["IAM_URL"]
  )

  response = watson.analyze(
    features: {categories: {limit: 3}},
    text: lyrics
  ).body.to_s

  response = JSON.parse(response)
  categories = response["categories"]
  categories.each do |cat|
    puts cat["label"]
  end
  return false
end

def explicit_analyze(lyrics)
  regex_response = regex_analysis(lyrics)
  watson_response = watson_analysis(lyrics)
  return (regex_response || watson_response)
end