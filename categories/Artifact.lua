-- flavor of the expansion, gets their own category
local L = select(2, ...)[3]

local categoryName = L['Artifact Power']
local categoryIndex = 10

local ARTIFACT_SPELL_NAME = GetItemSpell(138783)

local categoryFilter = function(bagID, slotID, itemID)
	local custom = BackpackCustomCategory[itemID]
	if(custom and custom == categoryIndex) then
		return true
	else
		local spellName = GetItemSpell(itemID)
		if(spellName and spellName == ARTIFACT_SPELL_NAME) then
			-- pretty much unique
			return true
		end
	end
end

Backpack:AddCategory(categoryIndex, categoryName, 'ArtifactPower', categoryFilter)
