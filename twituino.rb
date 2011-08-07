=begin
  Copyright (C) 2011  [David Long](http://davejlong.com)
  
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
=end

require 'rubygems'
gem 'twitter4r'
require 'yaml'
require 'twitter'
require 'serialport'

CONFIG = YAML::load_file "conf.yml"

userWhitelist = ['davejlong']

def follow_whitelist whitelist, user
  whitelist.each do |friend|
    user = @client.user friend
    @client.friend :add, friend #if !user.friends.include? user
  end
end

def every_n_seconds n
  loop do
    before = Time.now
    yield n
    interval = n-(Time.now-before)
    sleep(interval) if interval > 0
  end
end

Twitter::Client.configure do |conf|
  conf.oauth_consumer_token = CONFIG['app']['oauth_consumer_token']
  conf.oauth_consumer_secret = CONFIG['app']['oauth_consumer_secret']
end

@client = Twitter::Client.new(:oauth_access => {
  :key => CONFIG['user']['key'],
  :secret => CONFIG['user']['secret']
})

# Create the serial port connection for Arduino
@sp = SerialPort.new CONFIG['serial']['port'], CONFIG['serial']['baud']

follow_whitelist userWhitelist, CONFIG['user']['screenname']

every_n_seconds(15) do |span|
  m = @client.messages :received
  startDate = (Time.now-span)
  endDate = Time.now
  puts "Checking messages (#{startDate} and #{endDate}) \n"
  
  @sp.write 0 #Make sure the LED is off
  
  m.each do |message|
    if message.created_at > startDate && message.created_at < endDate
      puts "Sender: #{message.sender.screen_name}"
      puts "Message: #{message.text}\r\n"
      if(userWhitelist.include? message.sender.screen_name)
        @client.status :post, "@#{message.sender.screen_name}, I will '#{message.text}'"
        
        @sp.write 1 # Write to the serial port
      end
    end
  end
end