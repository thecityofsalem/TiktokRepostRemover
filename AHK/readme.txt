#- Description of scripts
AHK\ImgDetect.ahk uses images in "\Buttons"  to verify that the button is actually there.
KeyBinds <
	F1:: Starts Script
	F2:: Coordinates Teller
	>
	
AHK\Click.ahk just uses x and y that i got from my browser lol, you probably will need to recalibrate.
KeyBinds <
	F1:: Starts Script
	F2:: Coordinates Teller
	F3:: Change Coordinates
	F5:: Cancel Current Change (if you are on repost, itll go to scroll, if you are on scroll, itll finish will the same coordinates without changing it)
	>

#- fixes
Okay, these are some simple fixes that might work for you!

On line 60, (or hit CTRL + F, lookup coordinate) theres shit for getting coordinates. This will be used to adjust where your mouse is, if it misses.

Step 1. Hover in the middle of the buttons, and hit F2 and remember both coordinates.
Step 2. change em to that ig

