-- Customizes arena frame elements for better visibility

local hookedDebuffFrames = {}

local function hideElement(element)
	if element then
		element:Hide()
		element:SetScript("OnShow", element.Hide)
	end
end

local function customizeArenaFrame()
	for arenaIndex = 1, 5 do
		local arenaFrame = _G["CompactArenaFrameMember" .. arenaIndex]
		if arenaFrame then

		-- Hide name
		hideElement(arenaFrame.name)

		-- Position and resize debuff frame
		local debuffFrame = arenaFrame.DebuffFrame
		if debuffFrame and not hookedDebuffFrames[debuffFrame] then
			debuffFrame:SetSize(40, 40)
			debuffFrame:SetParent(arenaFrame)
			debuffFrame:ClearAllPoints()
			debuffFrame:SetPoint("BOTTOMLEFT", arenaFrame, "BOTTOMLEFT", 4, 4)
			
			hooksecurefunc(debuffFrame, "SetPoint", function(self)
				if not self.positionLocked then
					self.positionLocked = true
					self:ClearAllPoints()
					self:SetPoint("BOTTOMLEFT", arenaFrame, "BOTTOMLEFT", 4, 4)
					self.positionLocked = false
				end
			end)
			
			hookedDebuffFrames[debuffFrame] = true
		end

		-- Position and resize CC remover frame
			local ccRemover = arenaFrame.CcRemoverFrame
			if ccRemover then
				ccRemover:ClearAllPoints()
				ccRemover:SetSize(40, 40)
				ccRemover:SetPoint("TOPLEFT", arenaFrame, "TOPRIGHT", 0, 0)
			end

			-- Hide casting bar
			local castBar = arenaFrame.CastingBarFrame
			if castBar then
				hideElement(castBar)
			end

		end
	end
end

local arenaEventFrame = CreateFrame("Frame")
arenaEventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
arenaEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
arenaEventFrame:SetScript("OnEvent", customizeArenaFrame)
