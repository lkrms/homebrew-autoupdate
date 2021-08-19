try
	set tailLog to do shell script "tail -r ~/Library/Logs/com.github.domt4.homebrew-autoupdate/*.out | grep -E -m1 'taps|date'"
on error
	set tailLog to "Logs not found; cannot show summary!"
end try

try
	display notification "Homebrew has been updated" with title "brew-autoupdate" subtitle tailLog sound name "Submarine"
	delay 2
end try

