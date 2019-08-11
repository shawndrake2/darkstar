-----------------------------------
-- Area: Full Moon Mountain
-- Name: Windurst Mission 9-2 Moon Reading
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    dsp.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBcnmRegister(player, instance)
end

function onBcnmEnter(player, instance)
end

function onBcnmLeave(player, instance, leavecode)
    if leavecode == dsp.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(WINDURST) ~= dsp.mission.id.windurst.MOON_READING) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == dsp.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if
        csid == 32001 and
        player:getCurrentMission(WINDURST) == dsp.mission.id.windurst.MOON_READING and
        player:getVar("MissionStatus") == 2
    then
        player:setVar("MissionStatus", 3)
    end
end