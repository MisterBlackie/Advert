--[[
	sv_advert.lua
]]--
AdvertAllCommands = "/advert"

util.AddNetworkString("EnvoyerMessageJoueurAdvert")
util.AddNetworkString("EnvoyerMessageErreurAdvert")

function AdvertEveryone(str, ply)
	local CommandStart, CommandEnd = string.find(str, AdvertAllCommands, 1)
	local PlayerName = ply:Name()
	local JobColor = ply:getJobTable().color

	net.Start("EnvoyerMessageJoueurAdvert")
	net.WriteString(PlayerName)
	net.WriteString(string.sub(str, CommandEnd + 1)) // Rajout de +1 pour arriver à l'espace et non le dernier caractère de la commande
	net.WriteColor(JobColor)
	net.Send(player.GetAll())
end

function EnvoyerErreurAdvert(ply)
	net.Start("EnvoyerMessageErreurAdvert")
	net.Send(ply)
end


hook.Add("PlayerSay", "Faire un advert au gens", function (ply, str)
	if !IsValid(ply) then return "" end
	strtest = string.lower(str)
	if string.sub(strtest, 1, 7) == AdvertAllCommands and string.len(strtest) > 8 then 
		AdvertEveryone(str, ply)
		return ""
	elseif string.sub(strtest, 1, 7) == AdvertAllCommands then
		EnvoyerErreurAdvert(ply)
		return ""
	end
end)