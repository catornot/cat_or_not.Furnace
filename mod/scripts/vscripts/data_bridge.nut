global function FDataBridge_Init
global function FurnaceCallBack_ComfirmedCompilationEnded

void function FDataBridge_Init()
{
    AddClientCommandCallback( "compile_done", CompileDoneForClient )
}

bool function CompileDoneForClient( entity player, array<string> args )
{
    Chat_ServerBroadcast( player.GetPlayerName() + " is done compiling!" )
    printt( player.GetPlayerName(), "is done compiling!" )

    return true
}

void function FurnaceCallBack_ComfirmedCompilationEnded() 
{
    printt( "FurnaceCallBack_ComfirmedCompilationEnded" )

    thread SendFurnaceData()
}

void function SendFurnaceData()
{
    wait 1

    array<string> data_base64 = GetFurnace64BaseData( GetMapName() )

    if ( data_base64.len() == 0 )
        return

    printt( "sending furnace data to players" )

    wait 1
    
    foreach( entity player in GetPlayerArray() )
    {
        NSSendInfoMessageToPlayer( player, "Server map compiled" )

        WaitFrame()
        
        if ( !NSIsDedicated() && player == GetPlayerArray()[0] )
        {
            NSSendInfoMessageToPlayer( player, "you share the map with the server no compiling needed" )
        }
        else {
            NSSendInfoMessageToPlayer( player, "Compiling map" )
            
            WaitFrame()

            thread SendChunkedData( player, data_base64 )
        }
    }
}

void function SendChunkedData( entity player, array<string> data )
{
    EndSignal( player, "OnDestroy" )

    ServerToClientStringCommand( player, "send_f_data START" )

    WaitFrame()

    foreach( string chunk in data )
    {
        string command = format( "send_f_data %s", chunk )

        ServerToClientStringCommand( player, command )

        WaitFrame()
    }

    ServerToClientStringCommand( player, "send_f_data END" )
}