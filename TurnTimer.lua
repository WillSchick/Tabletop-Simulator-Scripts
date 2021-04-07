-- This script will report the total time of each player's turn after they choose to pass to the next player

prevTime = Time.time; -- global variable representing time of a turn's start
prevPlayer = null;

-- Sets previous player to current player's turn


-- formats seconds into minutes
function formatSeconds(seconds) 
	if seconds == nil then
		return 0
	end

	minutes = math.floor((seconds / 60))
	seconds = math.floor(math.fmod(seconds,60))
	
	if minutes <= 0 then 
		return seconds .. "s"
	elseif seconds < 10 then 
		return "0" .. seconds .. "s"
	else 
		return seconds .. "s"
	end
end

-- Takes previous player and prints out their turn's length
function reportTime(prevPlayer) 
	if prevPlayer.steam_name != nil then
		seconds = formatSeconds(Time.time - prevTime)
		msg = prevPlayer.steam_name .. "'s turn took " .. seconds .. "."
		printToAll(msg, prevPlayer.color)
	end
end

-- Report the time of the last turn, and set a new timer for the current turn
function onPlayerTurn(player)
	prevPlayer = Player[Turns.getPreviousTurnColor()]
	reportTime(prevPlayer)
	
	-- write new time 
	prevTime = Time.time
end