global function Furnace_Init
global function ServerCallback_CloseEntityId
global function ServerCallback_OpenEntityId

struct {
    bool chunked_data_in = false
    array<string> chunked_data
} file

void function Furnace_Init()
{
    AddServerToClientStringCommandCallback( "send_f_data", ProccesRawFurnaceData )

    ClientPushMapName( GetMapName() )
}

void function ProccesRawFurnaceData( array<string> args )
{
    if ( args.len() == 0 )
        return
    
    if ( args[0] == "START" )
    {
        file.chunked_data_in = true
        return
    }
    else if ( args[0] == "END" ) 
    {
        string assembled = file.chunked_data[0]

        for( int index = 1; index < file.chunked_data.len(); index++ )
            assembled = format( "%s%s", assembled, file.chunked_data[index] )

        printt( "assembled :", assembled )

        CompileMapFromRaw( assembled )

        file.chunked_data_in = false
        file.chunked_data.clear()

        return
    }
    else if ( !file.chunked_data_in ) 
    {
        return
    }

    string raw = args[0]

    printt( raw )

    file.chunked_data.append( raw )
}

void function ServerCallback_CloseEntityId()
{
    ClientRemoveMeshIndex()
}

void function ServerCallback_OpenEntityId( int id )
{
    ClientPushMeshIndex( id )
}
