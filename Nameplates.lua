-- Hides buff frames on nameplates

local function hideNameplateBuffFrames(nameplateUnitToken)
	local nameplateFrame = C_NamePlate.GetNamePlateForUnit(nameplateUnitToken)
	if not nameplateFrame then return end

	local nameplateUnitFrame = nameplateFrame.UnitFrame
	if not nameplateUnitFrame or nameplateUnitFrame:IsForbidden() then return end

	local nameplateBuffFrame = nameplateUnitFrame.BuffFrame
	if not nameplateBuffFrame then return end

	if not nameplateBuffFrame._cleanFramesHook then
		nameplateBuffFrame._cleanFramesHook = true
		nameplateBuffFrame:HookScript("OnShow", function(buffFrame)
			buffFrame:Hide()
		end)
	end

	nameplateBuffFrame:Hide()
end

local nameplateEventFrame = CreateFrame("Frame")
nameplateEventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
nameplateEventFrame:SetScript("OnEvent", function(_, _, nameplateUnitToken)
	hideNameplateBuffFrames(nameplateUnitToken)
end)
