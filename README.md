# Twituino - From Twitter to Arduino

Twituino is designed to interact between Twitter and an Arduino board to do almost anything in the world. The way that it works is that 
Twituino is setup as an application on Twitter.  Then it is given a user to monitor.  Each time a message is sent to that user, Twituino
will check the username of the sender against a whitelist and then run some code.  After Twituino has successfully run the code it will
send a reply to the user letting it know that it is done.

## Setup
There are a few pieces that need to be setup for Twituino to do it's job.  The first thing is to register both a new twitter account and a
new twitter app with that account.  After both of those pieces are setup open the conf.yml file and plugin the necessary settings. Twituino 
uses a whitelist to make sure that only certain users can tell it to do things.  Open twituino.rb and add your username to the whitelist. 
Twituino automatically loops through the whitelist following any users that it isn't already following.

1. Create a twitter account for Twituino to use
2. Create a twitter app on dev.twitter.com for Twituino
3. Plug the user keys and app keys into the conf.yml file
4. Add your username to the whitelist in twituino.rb

## Adding the Arduino code
Twituino is only a wrapper for interacting with Arduino.  The actual code is up to you.  In fact you don't even need to use Twituino with 
and Arduino board.  Anything that you might want to interact with through Twitter messaging can be done with Twituino.  To add code that will 
run when Twituino receives a message look for the comment at the end of twituino.rb marking the spot where Twituino has validated the message.

If you want me to put some Arduino code in there please head over to my [Amazon withlist](https://www.amazon.com/wishlist/3O8DD5T5C2HMD/) and 
buy me an Arduino to test this out with.

## Licensing
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


