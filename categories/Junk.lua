local P, E, L = unpack(select(2, ...))

local categoryName = L['Junk']
local categoryIndex = 1e3

local categoryFilter = function(bagID, slotID, itemID)
	local custom = BackpackCustomCategory[itemID]
	if(custom and custom == categoryIndex) then
		return true
	elseif(not custom) then
		local _, _, _, quality = Backpack:GetContainerItemInfo(bagID, slotID)
		return quality == LE_ITEM_QUALITY_POOR
	end
end

Backpack:AddCategory(categoryIndex, categoryName, 'Junk', categoryFilter)

local lastNumItems = 0
local function Update(event)
	if(BackpackDB.autoSellJunk) then
		if(event == 'MERCHANT_SHOW' or lastNumItems > 0) then
			lastNumItems = 0

			local Container = P.GetCategoryContainer(Backpack, 1e3)
			for _, Slot in next, Container.slots do
				lastNumItems = lastNumItems + 1
				UseContainerItem(Slot.bagID, Slot.slotID)
			end
		end
	end
end

local function OnClick(self)
	BackpackDB.autoSellJunk = not BackpackDB.autoSellJunk
	self.Texture:SetDesaturated(not BackpackDB.autoSellJunk)
end

local function Init(self)
	local Button = P.CreateContainerButton('ToggleSellJunk', categoryIndex)
	Button:SetScript('OnClick', OnClick)
	Button.tooltipText = L['Toggle auto-vendoring']

	Button.Texture:SetDesaturated(not BackpackDB.autoSellJunk)
	self.ToggleSellJunk = Button

	P.Fire('PostCreateSellJunk', Button)
end

Backpack:AddModule('SellJunk', Init, Update, false, 'MERCHANT_SHOW', 'MERCHANT_CLOSED', 'BAG_UPDATE_DELAYED')
