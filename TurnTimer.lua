-- This script will report the total time of each player's turn after they choose to pass to the next player

prevTime = Time.time; -- global variable representing time of a turn's start
prevPlayer = null;

-- Sets previous player to current player's turn


-- formats seconds into a string as "x minutes... y seconds..."
function formatSeconds(seconds) 
	if seconds == nil then
		seconds = 0
	end

    -- printToAll("(Debug) raw time:" .. seconds .. ".", Color(1,  1,  0))

	minutes = math.floor((seconds / 60))
	seconds = math.floor(seconds % 60)
	
	if minutes <= 0 then 
		return seconds .. "s"
	else
		return minutes .. "m, " .. seconds .. "s"
	end
end

-- Takes previous player and prints out their turn's length
function reportTime(prevPlayer, formattedTime) 
	if prevPlayer.steam_name != nil then
        col = prevPlayer.color
		msg = prevPlayer.steam_name .. "'s turn took " .. formattedTime .. "."

		-- Only start reporting averages AFTER turn 2.
		if (numTurns[col] > 1) then
			msg = msg .. " (avg:" .. formatSeconds(getAvgTurnTime(col)) .. ")"; 
		end

        broadcastToAll(msg, col)
	end
end

-- Report the time of the last turn, and set a new timer for the current turn
function onPlayerTurn(player)
    -- Get the player object of the last player
    prevPlayerNDX = Turns.getPreviousTurnColor()
	prevPlayer = Player[prevPlayerNDX]

    -- Format time of last turn
    turnSecs = Time.time - prevTime
    formattedTime = formatSeconds(turnSecs)
	
	-- Add to average tables
	numTurns[prevPlayer.color] = numTurns[prevPlayer.color] + 1;
	turnTimes[prevPlayer.color] = turnTimes[prevPlayer.color] + turnSecs;

    -- Print the player and time
	reportTime(prevPlayer, formattedTime)
	
	-- update prev time 
	prevTime = Time.time
end

function onLoad(scriptState)
	turnTimes = {}
	numTurns = {}

	for _, col in ipairs(Player.getColors()) do
		formatCol(col);
	end 
end

-- Formats table for new player
function onPlayerConnect(player)
	formatCol(player.color);
end

function onPlayerChangeColor(newCol)
	formatCol(newCol);
end

function formatCol(col) 
	--broadcastToAll("formatting " .. col .. ".");
	turnTimes[col] = 0;
	numTurns[col] = 0;
end

function getAvgTurnTime(col)
	return math.floor((turnTimes[col] / numTurns[col]));
end
