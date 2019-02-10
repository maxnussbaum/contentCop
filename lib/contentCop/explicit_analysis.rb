require "ibm_watson"
require "dotenv/load"

EXPRESSION = /shit|piss|fuck|cunt|cocksucker|motherfucker|tits|ass|bastard|bitch|crap|cunt|frigger|nigga|nigger|prick|whore|twat/
CATEGORIES = [
  /\/society\/crime/,
  /\/society\/racism/,
  /\/society\/sex/
]



def regex_analysis(lyrics)
  return true if lyrics.match(EXPRESSION)
  return false
end

def watson_analysis(lyrics)
  return false if lyrics.empty?
  watson = IBMWatson::NaturalLanguageUnderstandingV1.new(
    version: "2018-11-16",
    iam_apikey: ENV["IAM_APIKEY"]
    #iam_url: ENV["IAM_URL"]
  )

  response = watson.analyze(
    features: {categories: {limit: 5}},
    text: lyrics
  ).result

  #response = JSON.parse(response)
  categories = response["categories"]
  match = false
  categories.each do |cat|
    puts cat["label"]
    CATEGORIES.each do |reg_cat|
      match = true if cat["label"].match(reg_cat)
      break
    end
    break if match == true
  end
  return match
end

def explicit_analyze(lyrics)
  regex_response = regex_analysis(lyrics)
  watson_response = watson_analysis(lyrics)
  return (regex_response || watson_response)
  #return watson_response
end