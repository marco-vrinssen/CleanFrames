-- Hides auras on arena frames, nameplates, and raid frames

local function hide(element)
    if element then
        element:Hide()
        element:SetScript("OnShow", element.Hide)
    end
end

local function updateArenaFrames()
    for i = 1, 5 do
        local arenaFrame = _G["CompactArenaFrameMember" .. i]
        if arenaFrame then
            hide(arenaFrame.name)
            hide(arenaFrame.DebuffFrame)
            hide(arenaFrame.castBar)
        end
    end
end

local function hideNameplateBuffs(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken)
    if not nameplate then return end
    
    local unitFrame = nameplate.UnitFrame
    if not unitFrame or unitFrame:IsForbidden() then return end

    local buffsFrame = unitFrame.BuffFrame
    if not buffsFrame then return end

    if not buffsFrame._cleanFramesHook then
        buffsFrame._cleanFramesHook = true
        buffsFrame:HookScript("OnShow", function(frame)
            frame:Hide()
        end)
    end
    
    buffsFrame:Hide()
end

local function hideRaidFrameAuras(frame)
    if not frame or frame:IsForbidden() then 
        return 
    end

    if CompactUnitFrame_HideAllBuffs then
        CompactUnitFrame_HideAllBuffs(frame)
    end

    if CompactUnitFrame_HideAllDebuffs then
        CompactUnitFrame_HideAllDebuffs(frame)
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
eventFrame:SetScript("OnEvent", function(_, eventName, unitToken)
    if eventName == "ARENA_OPPONENT_UPDATE" then
        updateArenaFrames()
    elseif eventName == "NAME_PLATE_UNIT_ADDED" then
        hideNameplateBuffs(unitToken)
    end
end)

hooksecurefunc("CompactUnitFrame_UpdateAuras", hideRaidFrameAuras)
