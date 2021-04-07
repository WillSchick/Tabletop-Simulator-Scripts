-- This script will report the total time of each player's turn after they choose to pass to the next player

prevTime = Time.time; -- global variable representing time of a turn's start

-- formats seconds into minutes
function formatSeconds(seconds) do
	minutes = (seconds / 60)
	seconds = math.fmod(seconds,60)
	return minutes .. "m " .. seconds .. "s"
end

-- Takes previous player and prints out their turn's length
function reportTime(prevPlayer) do
	if prevPlayer != null then
		seconds = formatSeconds(Time.time - prevTime)
		msg = prevPlayer.steam_name .. "'s turn took " .. seconds .. "."
		printToAll(msg, prevPlayer.color)
	end
end

-- Report the time of the last turn, and set a new timer for the current turn
function onPlayerTurn(player prevPlayer) do
	reportTime(prevPlayer)
	prevTime = Time.time
end

