global function ShFurnace_Init

void function ShFurnace_Init()
{
    AddCallback_OnRegisteringCustomNetworkVars( FurnaceRegisterNetworkVars )
}

void function FurnaceRegisterNetworkVars()
{
    Remote_RegisterFunction( "ServerCallback_OpenEntityId" )
    Remote_RegisterFunction( "ServerCallback_CloseEntityId" )
}