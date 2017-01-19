script <PriceFixer.ash>

boolean testForFit(item it)
{
	//Adjust these two values according to your preferences
	int minPrice = 100000;
	int minAmount = 1000;

	if((historical_price(it) > minPrice) || (item_amount(it) > minAmount) || ((historical_price(it) == 0) && it.tradeable))
		return true;

	return false;
}

void main()
{
	int[item] inventory = get_inventory(); //Gets your inventory contents item numbers, so if you have 1 of item 52 and 0 of item 53, then it adds a 52 to the array but not 53

	foreach it in inventory
		if(testForFit(it))
		{
			wait(2);
			mall_price(it);
		}
}
