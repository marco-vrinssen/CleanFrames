-- Hides buffs and debuffs on raid frames

local function hideRaidFrameBuffsAndDebuffs(raidFrame)
	if not raidFrame or raidFrame:IsForbidden() then
		return
	end

	if CompactUnitFrame_HideAllBuffs then
		CompactUnitFrame_HideAllBuffs(raidFrame)
	end

	if CompactUnitFrame_HideAllDebuffs then
		CompactUnitFrame_HideAllDebuffs(raidFrame)
	end
end

hooksecurefunc("CompactUnitFrame_UpdateAuras", hideRaidFrameBuffsAndDebuffs)
