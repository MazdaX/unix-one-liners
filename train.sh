#!/bin/bash
##==============================================================================##
##				Steam Locomotive loop YES!			##
##             		                  					##
##                       Copyright (C) 2017  Dr.Mazdak Salavati	 	        ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++##
##  This program is free software: you can redistribute it and/or modify	##
##  it under the terms of the GNU General Public License as published by	##
##  the Free Software Foundation, either version 3 of the License, or		##
##  (at your option) any later version.						##
##  This program is distributed in the hope that it will be useful,		##
##  but WITHOUT ANY WARRANTY; without even the implied warranty of		##
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the		##
##  GNU General Public License for more details.				##
##										##
##  You should have received a copy of the GNU General Public License		##
##  along with this program.  If not, see <http://www.gnu.org/licenses/>. 	##
##==============================================================================##
##
##This is a very sily game for train spotting in the terminal (bash shell)
##Before you run this you actually need to install the sl:
##sudo apt install sl
##Now you're good to go :) 
for i in {1..5} 
do 
echo "Train number: $i out of 5"
sleep 2s
sl -ae
done;
sleep 1s
echo "Press Ctrl+C to stop me :)"
sleep 2s
yes "Enough horsing around! Go back to work!!!!"
##Ctrl + C stops it (run at your own peril :)) 
