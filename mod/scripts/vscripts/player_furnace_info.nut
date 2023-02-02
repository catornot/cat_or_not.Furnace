global function PlayerInfo_Init
global function GetGridForPlayer

struct {
    table<int,float> grids
} file

void function PlayerInfo_Init()
{
    AddClientCommandCallback( "new_grid", NewGridPush )
    AddClientCommandCallback( "snap_instant", InstantSnapView )

    AddCallback_OnClientConnected( SetupFurnacePlayer )

    foreach( entity player in GetPlayerArray() )
        SetupFurnacePlayer( player )
}

bool function NewGridPush( entity player, array<string> args )
{
    try {
        file.grids[player.GetUID()] = args[0].tofloat()
    }
    catch( err ) {
        printt("invalid snap :(")
    }

    return true
}

bool function InstantSnapView( entity player, array<string> args )
{
    entity closest = GetClosest( GetEntArrayByScriptName( "nessie_node" ), player.GetOrigin() )

    vector org1 = closest.GetOrigin()
    vector org2 = player.GetOrigin()
    vector vec = org1 - org2
    vector angles = VectorToAngles( vec )
    player.SetAngles( angles )

    return true
}

float function GetGridForPlayer( entity player )
{
    return file.grids[player.GetUID()]
} 

void function SetupFurnacePlayer( entity player )
{
    file.grids[player.GetUID()] <- 16.0
}