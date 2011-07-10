require 'rubygems'
gem 'twitter4r'
require 'yaml'
require 'twitter'

CONFIG = YAML::load_file "conf.yml"

puts CONFIG
Twitter::Client.configure do |conf|
  conf.oauth_consumer_token = APPCONFIG[:oauth_consumer_token]
  conf.oauth_consumer_secret = APPCONFIG[:oauth_consumer_secret]
end

@client = Twitter::Client.new(:oauth_access => {
  :key => USERCONFIG[:userkey],
  :secret => USERCONFIG[:usersecret]
})

@userWhitelist = ['davejlong']

def every_n_seconds(n)
  loop do
    before = Time.now
    yield n
    interval = n-(Time.now-before)
    sleep(interval) if interval > 0
  end
end

every_n_seconds(10) do |span|
  m = @client.messages :received
    startDate = (Time.now-span)
    endDate = Time.now
    puts "Checking messages between #{startDate} and #{endDate} \n"

    m.each do |message|
    if message.created_at > startDate && message.created_at < endDate
      puts "Sender: #{message.sender.screen_name}"
      puts "Message: #{message.text}\r\n"
      if(@userWhitelist.include? message.sender.screen_name)
        s = @client.status :post, "@#{message.sender.screen_name}, I will '#{message.text}'"
        
        # PUT CODE TO DO SOEMTHING HERE
        # I will add something here when I actually have an Arduino board to test this app out on
        
      end
    end
  end
end