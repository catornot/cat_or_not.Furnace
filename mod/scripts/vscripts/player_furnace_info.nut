global function PlayerInfo_Init
global function GetGridForPlayer
global function GetEyeDistanceForPlayer

struct {
    table<int,float> grids
    table<int,float> eye_dis
} file

void function PlayerInfo_Init()
{
    AddClientCommandCallback( "new_grid", NewGridPush )
    AddClientCommandCallback( "new_eye_distance", NewEyeDistancePush )
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
        printt("invalid grid :(")
    }

    return true
}

bool function NewEyeDistancePush( entity player, array<string> args )
{
    try {
        file.eye_dis[player.GetUID()] = args[0].tofloat()
    }
    catch( err ) {
        printt("invalid distance :(")
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

float function GetEyeDistanceForPlayer( entity player )
{
    return file.eye_dis[player.GetUID()]
} 

void function SetupFurnacePlayer( entity player )
{
    file.grids[player.GetUID()] <- 16.0
    file.eye_dis[player.GetUID()] <- 1000.0
}