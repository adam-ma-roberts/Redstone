int GetMapPlayerCount(const char[] checkMap)
{
	if (ND_IsHighSlotMap(checkMap))
		return GetSlotCount(32, 32, 32);
		
	else if (ND_IsBalancedMap(checkMap))
		return GetSlotCount(28, 30, 32);
	
	else if (ND_IsLargeMap(checkMap))
		return GetSlotCount(26, 28, 30);
		
	else if (ND_IsTinyMap(checkMap))
		return GetSlotCount(24, 26, 26);

	/* oasis, coast, hydro, roadwork, corner */
	return GetSlotCount(26, 26, 28);
}

bool ND_IsHighSlotMap(const char[] checkMap)
{
	return  ND_StockMapEquals(checkMap, ND_Silo)
	     || ND_StockMapEquals(checkMap, ND_Hydro)
	     || ND_StockMapEquals(checkMap, ND_Oilfield)
	     || ND_StockMapEquals(checkMap, ND_Downtown);
}

bool ND_IsBalancedMap(const char[] checkMap) 
{
	return	   ND_MapEqualsAnyMetro(checkMap)
		|| ND_StockMapEquals(checkMap, ND_Clocktower)
		|| ND_StockMapEquals(checkMap, ND_Gate);
}

bool ND_IsLargeMap(const char[] checkMap)
{
	return	   ND_CustomMapEquals(checkMap, ND_Rock)
		|| ND_CustomMapEquals(checkMap, ND_Nuclear);
}

bool ND_IsTinyMap(const char[] checkMap)
{
	return 	   ND_CustomMapEquals(checkMap, ND_Mars)
		|| ND_CustomMapEquals(checkMap, ND_Sandbrick)
		|| ND_CustomMapEquals(checkMap, ND_Port);
		//ND_CustomMapEquals(checkMap, ND_Corner)
}

int GetSlotCount(int min, int med, int max)
{
	if (!ND_GEA_AVAILBLE() || !eSkillBasedSlots())
		return max;	
		
	float avSkill = ND_GetEnhancedAverage();	
	return avSkill < g_Cvar[LowSkill].IntValue  ? max : avSkill < g_Cvar[HighSkill].IntValue ? med : min;
}

bool eSkillBasedSlots() {
	return ND_GetClientCount() > g_Cvar[MinPlayServerSlots].IntValue;
}
