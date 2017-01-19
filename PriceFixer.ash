script <PriceFixer.ash>

boolean have_store()
{
	return !(contains_text(visit_url("managestore.php"), "Buy a Store:"));
}

boolean have_DC()
{
	return !(contains_text(visit_url("museum.php?place=collections"), "Buy a Display Case"));
}

boolean testForFit(item it)
{
	int minPrice = 1000000; //Adjust this value according to your preferences
	
	if(historical_age(it) < 1) //Skip updating if it's been recently refreshed
		return false;

	if((historical_price(it) > minPrice) || ((item_amount(it) * historical_price(it)) > minPrice) || ((historical_price(it) == 0) && it.tradeable)) //Update whitelist conditions
		return true;

	return false;
}

void main()
{
	boolean store = have_store(); //Checks for a store and stores it for later use so we don't hit the server needlessly
	boolean DC = have_DC(); //Same thing for display case

	foreach it in $items[]
	{
		//Enumerates total item count
		int amount = available_amount(it) + storage_amount(it);
		if(store)
			amount = amount + shop_amount(it);
//Disabled because KoLmafia can't update your display case quickly, reenable at your own peril!		if(DC)
		//	amount = amount + display_amount(it);

		if((amount > 0) && testForFit(it))
		{
			wait(2);
			mall_price(it);
		}
	}

	print("Done! Prices priced according to standard ruling (5th cheapest in mall).", "blue");
}
