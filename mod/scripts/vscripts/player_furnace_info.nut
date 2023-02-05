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
    AddClientCommandCallback( "delete_mesh", DeleteMesh )
    AddClientCommandCallback( "nudge_z", NudgeZ )
    AddClientCommandCallback( "nudge_y", NudgeY )
    AddClientCommandCallback( "nudge_x", NudgeX )

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

bool function DeleteMesh( entity player, array<string> args )
{
    if ( args.len() != 1 )
        return true

    try {
        RemoveMesh( args[0].tointeger() )

        Remote_CallFunction_NonReplay( player, "ServerCallback_CloseEntityId" )
        
        GetEnt( args[0] ).Destroy()
    } 
    catch(err) {
        
    }

    return true
}

bool function NudgeZ( entity player, array<string> args )
{
    if ( args.len() != 2 )
        return true

    entity node = GetEnt( args[0] )

    Nudge( player, node, <0,0,args[1].tofloat()> )

    return true
}

bool function NudgeY( entity player, array<string> args )
{
    if ( args.len() != 2 )
        return true

    entity node = GetEnt( args[0] )

    Nudge( player, node, <0,args[1].tofloat(),0> )

    return true
}

bool function NudgeX( entity player, array<string> args )
{
    if ( args.len() != 2 )
        return true

    entity node = GetEnt( args[0] )

    Nudge( player, node, <args[1].tofloat(),0,0> )

    return true
}

void function Nudge( entity player, entity node, vector dir )
{
    if ( !IsValid( node ) )
        Remote_CallFunction_NonReplay( player, "ServerCallback_CloseEntityId" )
    
    table data
    
    data.dir <- dir

    node.Signal( "MoveNessieNode", data )
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