-- Hides auras on arena frames

local function hideFrameElementPermanently(frameElement)
	if frameElement then
		frameElement:Hide()
		frameElement:SetScript("OnShow", frameElement.Hide)
	end
end

local function hideArenaFrameElements()
	for arenaFrameIndex = 1, 5 do
		local compactArenaFrame = _G["CompactArenaFrameMember" .. arenaFrameIndex]
		if compactArenaFrame then
			hideFrameElementPermanently(compactArenaFrame.name)
			hideFrameElementPermanently(compactArenaFrame.DebuffFrame)
			hideFrameElementPermanently(compactArenaFrame.castBar)
		end
	end
end

local arenaEventFrame = CreateFrame("Frame")
arenaEventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
arenaEventFrame:SetScript("OnEvent", function()
	hideArenaFrameElements()
end)
