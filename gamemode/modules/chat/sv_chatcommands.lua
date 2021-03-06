--[[---------------------------------------------------------
Talking
 ---------------------------------------------------------]]
local function Whisper(ply, args)
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return ""
        end
        DarkRP.talkToRange(ply, "(" .. DarkRP.getPhrase("whisper") .. ") " .. ply:Nick(), text, GAMEMODE.Config.whisperDistance)
    end
    return args, DoSay
end
DarkRP.defineChatCommand("w", Whisper, 1.5)

local function Yell(ply, args)
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return ""
        end
        DarkRP.talkToRange(ply, "(" .. DarkRP.getPhrase("yell") .. ") " .. ply:Nick(), text, GAMEMODE.Config.yellDistance)
    end
    return args, DoSay
end
DarkRP.defineChatCommand("y", Yell, 1.5)

local function Me(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return ""
    end

    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            local col = team.GetColor(ply:Team())
            local name = ply:Nick()
            for _, target in ipairs(player.GetAll()) do
                DarkRP.talkToPerson(target, col, name .. " " .. text)
            end
        else
            DarkRP.talkToRange(ply, ply:Nick() .. " " .. text, "", GAMEMODE.Config.meDistance)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("me", Me, 1.5)

local function MayorBroadcast(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return ""
    end
    local Team = ply:Team()
    if not RPExtraTeams[Team] or not RPExtraTeams[Team].mayor then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("incorrect_job", DarkRP.getPhrase("broadcast")))
        return ""
    end
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return
        end

        local col = team.GetColor(ply:Team())
        local col2 = Color(170, 0, 0, 255)
        local phrase = DarkRP.getPhrase("broadcast")
        local name = ply:Nick()
        for _, v in ipairs(player.GetAll()) do
            DarkRP.talkToPerson(v, col, phrase .. " " .. name, col2, text, ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("broadcast", MayorBroadcast, 1.5)

-- here's the new easter egg. Easier to find, more subtle, doesn't only credit FPtje and unib5
-- WARNING: DO NOT EDIT THIS
-- You can edit DarkRP but you HAVE to credit the original authors!
-- You even have to credit all the previous authors when you rename the gamemode.
-- local CreditsWait = true
local function GetDarkRPAuthors(ply, args)
    local target = DarkRP.findPlayer(args) -- Only send to one player. Prevents spamming
    target = IsValid(target) and target or ply

    if target ~= ply then
        if ply.CreditsWait then DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("wait_with_that")) return "" end
        ply.CreditsWait = true
        timer.Simple(60, function() if IsValid(ply) then ply.CreditsWait = nil end end) -- so people don't spam it
    end

    local rf = RecipientFilter()
    rf:AddPlayer(target)
    if ply ~= target then
        rf:AddPlayer(ply)
    end

    umsg.Start("DarkRP_Credits", rf)
    umsg.End()

    return ""
end
DarkRP.defineChatCommand("credits", GetDarkRPAuthors, 50)
