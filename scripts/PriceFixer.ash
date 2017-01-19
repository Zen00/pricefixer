script <PriceFixer.ash>

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
	foreach it in $items[]
	{
		//Enumerates total item count
		int amount = available_amount(it) + storage_amount(it);

		if((amount > 0) && testForFit(it))
		{
			wait(2);
			mall_price(it);
		}
	}

	print("Done! Prices priced according to standard ruling (5th cheapest in mall).", "blue");
}
