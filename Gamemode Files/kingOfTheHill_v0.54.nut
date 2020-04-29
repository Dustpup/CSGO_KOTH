//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Script Think  KING OF THE HILL                                       // SCRIPT: Script THINK             //
////////////////////////////////////////////////////////////////////////// DATE: APRIL 17, 2020             //
// DDDDDD   UU   UU   SSSSS   TTTTTTT  PPPPP   UU   UU  PPPPP           // DESCRIPTION: Used to add and     //
// DD   DD  UU   UU  SSS        TTT    PP  PP  UU   UU  PP  PP          // remove players from the counter  //
// DD   DD  UU   UU   SSSSS     TTT    PPPPP   UU   UU  PPPPP           // it also turns off counter for    //
// DD   DD  UU   UU       SS    TTT    PP      UU   UU  PP              // SCRIPT VER: 0.5v                 //
// DDDDDD    UUUUU    SSSSS     TTT    PP       UUUUU   PP              //                                  //
//////////////////////////////////////////////////////////////////////////                                  //
// CREATED BY: Brandon T. COOK AKA. [DUSTPUP]                           //                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  KK    K  IIIIIIIII   NNNN     NN    GGGGG           OOOOOO    FFFFFFF    TTTTTTTTT  HH   HH  EEEEEEE   //
///  KK   K       II      NNNNN    NN  GGG   GGG        OO    OO   FF         TTTTTTTTT  HH   HH  EE        //
///  KK  K        II      NN NNN   NN  GG               OO    OO   FF            TTT     HH   HH  EE        //
///  KKKK         II      NN  NNN  NN  GG   GGG         OO    OO   FFFFF         TTT     HHHHHHH  EEEEE     //
///  KK  K        II      NN   NNN NN  GG     GG        OO    OO   FF            TTT     HH   HH  EEEEE     //
///  KK   K       II      NN    NNNNN  GG    GGG        OO    OO   FF            TTT     HH   HH  EE        //
///  KK    K  IIIIIIIII   NN     NNNN    GGGGG           OOOOOO    FF            TTT     HH   HH  EEEEEEE   //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///                                              ...........................................................//
///    HHH    HHH    III    LLL        LLL       ......................[|FFF................................//
///    HHH    HHH    III    LLL        LLL       ......................[|FFF................................//
///    HHH    HHH           LLL        LLL       ......................[|...................................//
///    HHHHHHHHHH    III    LLL        LLL       .............00000000000000000000..........................//
///    HHH    HHH    III    LLL        LLL       ..........000000000000000000000000000......................//
///    HHH    HHH    III    LLLLLLL    LLLLLLLLL ........000000000000000000000000000000000..................//
///    HHH    HHH    III    LLLLLLL    LLLLLLLLL .......0000000000000000000000000000000000000000............//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

debug_script <- true;

game_t_onHillCount   <- 0;
game_ct_onHillCount  <- 0;
game_counter         <- 0;
game_counter_mult    <- 0;

game_timer_counter   <- null;
game_timer_round     <- null;

game_t_win 			     <- false;
game_ct_win 			 <- false;
game_isMixedHill		 <- false;
game_isGameCounterRuning <- false;
game_hasGameEnded		 <- false;
game_isWarmup 			 <- false;
game_isRoundTimerUp      <- false;
GAME_ALLOW_MIXED_HILL    <- true;
ROUND_KICKBOTS           <- true;
const ROUND_TIME = 5;

const ROUND_COUNTER_MULTIPLIER = 1;
const GAME_MIN_GAMECOUNTER     = -100;
const GAME_MAX_GAMECOUNTER     = 100;
const GAME_TERRORIST_TAKE      = -11;
const GAME_C_TERRORIST_TAKE    = 11;
const GAME_MIN_NEUTRAL         = -10;
const GAME_MAX_NEUTRAL         = 10;
const GAME_TRIGGER_VARS = "43726561746564204279204272616E646F6E20542E20436F6F6B20414B41205B445553545055505D";

MAP_RELAY_T_TAKE    <- "hill_terrorist";
MAP_RELAY_CT_TAKE   <- "hill_ct";
MAP_RELAY_N_TAKE    <- "hill_neut";
MAP_END_ROUND_ENT   <- "captured_the_hill";
MAP_GAME_TIMER      <- "game_timer";
MAP_GAME_COUNTER    <- "hill_timer";

WEAPON_LOADOUT <- {};
SPAWN_COLLECTION <- [];
LOADOUTS <- [1,9];

WEAPON_LOADOUT[1] <- "deagle, hegrenade, knife";
WEAPON_LOADOUT[2] <- "glock, ak47, hegrenade, knife";
WEAPON_LOADOUT[3] <- "glock, sg556, hegrenade, knife";
WEAPON_LOADOUT[4] <- "glock, mp7, flashbang, knife";
WEAPON_LOADOUT[5] <- "glock, famas, hegrenade, knife";
WEAPON_LOADOUT[6] <- "glock, mac10, molotov, knife";
WEAPON_LOADOUT[7] <- "glock, sawedoff, hegrenade, knife";
WEAPON_LOADOUT[8] <- "p250, galilar, hegrenade, knife";
WEAPON_LOADOUT[9] <- "glock, nova, flashbang, knife";

// After The Entities Spawn
function OnPostSpawn()
{
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("// DDDDDD   UU   UU   SSSSS   TTTTTTT  PPPPP   UU   UU  PPPPP           //////////////////////////////////////");
	printl("// DD   DD  UU   UU  SSS        TTT    PP  PP  UU   UU  PP  PP          //////////////////////////////////////");
	printl("// DD   DD  UU   UU   SSSSS     TTT    PPPPP   UU   UU  PPPPP           //////////////////////////////////////");
	printl("// DD   DD  UU   UU       SS    TTT    PP      UU   UU  PP              //////////////////////////////////////");
	printl("// DDDDDD    UUUUU    SSSSS     TTT    PP       UUUUU   PP              //////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("// CREATED BY: Brandon T. COOK AKA. [DUSTPUP]                           //////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("//  KK    K  IIIIIIIII   NNNN     NN    GGGGG           OOOOOO    FFFFFFF    TTTTTTTTT  HH   HH  EEEEEEE    //");
	printl("//  KK   K       II      NNNNN    NN  GGG   GGG        OO    OO   FF         TTTTTTTTT  HH   HH  EE         //");
	printl("//  KK  K        II      NN NNN   NN  GG               OO    OO   FF            TTT     HH   HH  EE         //");
	printl("//  KKKK         II      NN  NNN  NN  GG   GGG         OO    OO   FFFFF         TTT     HHHHHHH  EEEEE      //");
	printl("//  KK  K        II      NN   NNN NN  GG     GG        OO    OO   FF            TTT     HH   HH  EEEEE      //");
	printl("//  KK   K       II      NN    NNNNN  GG    GGG        OO    OO   FF            TTT     HH   HH  EE         //");
	printl("//  KK    K  IIIIIIIII   NN     NNNN    GGGGG           OOOOOO    FF            TTT     HH   HH  EEEEEEE    //");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	printl("///                                              ...........................................................//");
	printl("///    HHH    HHH    III    LLL        LLL       ......................[|FFF................................//");
	printl("///    HHH    HHH    III    LLL        LLL       ......................[|FFF................................//");
	printl("///    HHH    HHH           LLL        LLL       ......................[|...................................//");
	printl("///    HHHHHHHHHH    III    LLL        LLL       .............00000000000000000000..........................//");
	printl("///    HHH    HHH    III    LLL        LLL       ..........000000000000000000000000000......................//");
	printl("///    HHH    HHH    III    LLLLLLL    LLLLLLLLL ........000000000000000000000000000000000..................//");
	printl("///    HHH    HHH    III    LLLLLLL    LLLLLLLLL .......0000000000000000000000000000000000000000............//");
	printl("//////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	
	DEBUG_Write("-----------------------------------------------------------");
	DEBUG_Write("-|SCRIPT IS IN DEBUG MODE. ALL CONSOLE CALLS ARE ACTIVE! |-");
	DEBUG_Write("-----------------------------------------------------------");
	
	game_isWarmup =  ScriptIsWarmupPeriod();
}

// Script logic_script OnThink
function GameThink()
{
	
	// is not in warmup or running after end of round
	if(!game_isWarmup && !game_hasGameEnded)
	{
		// Measure hill count
		game_counter_mult = game_ct_onHillCount - game_t_onHillCount;
		DEBUG_Write(game_counter);
		// Check for a mixed hill of t's and ct's
		if(game_ct_onHillCount > 0 && game_t_onHillCount > 0)
		{
			game_isMixedHill = true;
		}
		else
		{
			game_isMixedHill = false;
		}
		
		// Start Game Logic. See if anyone is on the hill trigger.
		if((game_ct_onHillCount > 0 || game_t_onHillCount > 0)
		&& game_counter_mult != 0)
		{
				// Start Timer If SomeOne Is On The Hill
				if(!game_isGameCounterRuning)
				{
					Game_StartTimer();
					game_isGameCounterRuning = true;
				}
				
				if(game_counter <= GAME_TERRORIST_TAKE && !game_t_win)
				{
					Game_TakeHill_T();
				}
				
				if(game_counter >= GAME_C_TERRORIST_TAKE && !game_ct_win)
				{
					Game_TakeHill_CT();
				}
				
				if(game_counter >= GAME_MIN_NEUTRAL &&
				game_counter <= GAME_MAX_NEUTRAL && (game_ct_win||game_t_win))
				{
					Game_NeutralizeHill();
				}
				
		}
		else // If No One is On the Hill
		{
			 // Stop Timer If No One Is On The Hill
			if(game_isGameCounterRuning)
			{
				Game_StopTimer();
				game_isGameCounterRuning = false;
			}
		}
		
		// GAME END SEQUENCE // FINISH ROUND
		if( game_isRoundTimerUp ||
		game_counter <= GAME_MIN_GAMECOUNTER ||
		game_counter >= GAME_MAX_GAMECOUNTER )
		{
			game_hasGameEnded = true;
			
			if(game_ct_win) 
			{
				EntFire(MAP_END_ROUND_ENT,"EndRound_CounterTerroristsWin","7",0);
			}
			if(game_t_win)
			{
				EntFire(MAP_END_ROUND_ENT,"EndRound_TerroristsWin","7",0);
			}
			if(!game_ct_win && !game_t_win)
			{
				EntFire(MAP_END_ROUND_ENT,"EndRound_Draw","7",0);
			}
		}
		
		
		
	}
}

// Init the Gamemode objects
function InitGamemode()
{
    CheckYoSelf(); // Make sure Gamemode is correctly set

	ScriptSetRadarHidden(true);
	
	if(ROUND_KICKBOTS)
	{ SendToConsoleServer("bot_quota 0"); }
	else
	{ SendToConsoleServer("bot_quota 10");}

	DEBUG_Write("GAMEMODE: Round Time Set Too: " + ROUND_TIME + " Minutes.");
	
	SendToConsoleServer("mp_roundtime " + ROUND_TIME);
	SendToConsoleServer("mp_respawn_on_death_t 1");
	SendToConsoleServer("mp_respawn_on_death_ct 1");
	
	game_timer_counter <- Entities.FindByName(null,MAP_GAME_COUNTER);
	game_timer_round   <- Entities.FindByName(null,MAP_GAME_TIMER);
	
	game_timer_counter.__KeyValueFromFloat("RefireTime",ROUND_COUNTER_MULTIPLIER);
	game_timer_round.__KeyValueFromFloat("RefireTime",(60*ROUND_TIME));
	EntFire(game_timer_round,"Enable","",0);
}

// Change Gamemode if not correctly set
function CheckYoSelf()
{
	local reck = ScriptGetGameMode();
	local yoSelf = ScriptGetGameType();
	local map = GetMapName();
	
	if(reck != 0 || yoSelf != 3)
	{
		SendToConsoleServer("game_mode 0; game_type 3; map "+ map );
	}
}

// When the actual round starts
function OnRoundStart()
{
	
}

// When the round Logic_timer is up
function OnRoundEnd()
{
	game_isRoundTimerUp = true;
}

// Setup The Game Spawns with special requirements/
function Game_SetupSpawnPoint()
{
	//local ent <- null;
	
	//while(( ent = Entities.FindByName( ent )))
	//{
	//	
	//}
}


// Set the spawn points with special weapons
function Game_SetupLoadOuts()
{
	
}

// Start The Hill Counter
function Game_StartTimer()
{
    DEBUG_Write("HillCounter Started!");
	EntFire(MAP_GAME_COUNTER, "Enable", "",0);
}

// Stop The Hill Counter
function Game_StopTimer()
{
	DEBUG_Write("HillCounter Stopped!");
	EntFire(MAP_GAME_COUNTER, "Disable", "",0);
}

// On Hill Timer Fired
function Game_Event_OnTimer()
{
	if(!game_isWarmup && !game_hasGameEnded)
	{
		game_counter += game_counter_mult;
	}
}

// Adds to the count of players on the hill for terrorist
function Game_AddToHill_T()
{
	ScriptPrintMessageCenterTeam(3,"Terrorist Are On The HILL!");
    game_t_onHillCount++;
	
	DEBUG_Write("[|||||||||||||||||||||||||||||||||||]");
    DEBUG_Write(" HILL TRIGGERED: Terrorist");
    DEBUG_Write("[|||||||||||||||||||||||||||||||||||]");

}

// Adds to the count of players on the hill for Counter terrorist 
function Game_AddToHill_CT()
{
	ScriptPrintMessageCenterTeam(2," Counter Terrorist Are On The HILL!");
    game_ct_onHillCount++;
	
	DEBUG_Write("[||||||||||||||||||||||||||||||||||]");
    DEBUG_Write(" HILL TRIGGERED: Counter Terrorist");
    DEBUG_Write("[|||||||||||||||||||||||||||||||||||]");
}

// Reverse Of AddToHill
function Game_RemoveFromHill_T()
{
	game_t_onHillCount--;
}

// Reverse Of AddToHill()
function Game_RemoveFromHill_CT()
{
	game_ct_onHillCount--;
}

// Set Game Win Conditions Towards Terrorist
function Game_TakeHill_T()
{
    game_ct_win = false; 
    game_t_win = true;
	EntFire(MAP_RELAY_T_TAKE,"Trigger","",0);
	
	DEBUG_Write("T TAKE HILL");
}

// Set Game Win Conditions Towards Counter Terrorist.
function Game_TakeHill_CT()
{
    game_ct_win = true;
    game_t_win = false;
	EntFire(MAP_RELAY_CT_TAKE,"Trigger","",0);
	
	DEBUG_Write("CT TAKE HILL");
}

// Set Game Win Conditions Towards Draw. 
function Game_NeutralizeHill()
{
	game_ct_win = false;
    game_t_win  = false;
	EntFire(MAP_RELAY_N_TAKE,"Trigger","",0);
	
	DEBUG_Write("N TAKE HILL");
}

//write a line to console if in debug mode.
function DEBUG_Write(writeLine)
{
	if (debug_script)
	{ printl(writeLine);}
}