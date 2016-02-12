function parallel;
	set -lx SHELL bash
	command parallel $argv
end
