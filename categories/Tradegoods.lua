local L = select(2, ...)[3]

local categoryName = L['Trade Goods']
local categoryIndex = 40

local categoryFilter = function(bagID, slotID, itemID)
	local custom = BackpackCustomCategory[itemID]
	if(custom and custom == categoryIndex) then
		return true
	elseif(not custom) then
		-- tradegoods/reagents
		local _, _, _, _, _, itemClass = GetItemInfoInstant(itemID)
		return itemClass == LE_ITEM_CLASS_TRADEGOODS
	end
end

Backpack:AddCategory(categoryIndex, categoryName, 'TradeGoods', categoryFilter)
