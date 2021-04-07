-- Automatically promotes all players in the game.

-- Called when the script finishes loading
function onload()
	modAll()
end

-- Promotes newly joined players
function onPlayerConnect(player)
	msg = 'Modding new player: ' .. player.steam_name
	broadcastToAll(msg, player.color)
	player.promote()
end

-- Loop through and promote unpromotedp layers
function modAll()
	for _, player in ipairs(Player.getPlayers()) do
		if player.promoted == false and player.admin == false then
			msg = "Modding: " .. player.steam_name
			broadcastToAll(msg, player.color)
			player.promote()
		end
	end
end