#if SERVER
global function SvShFurnace_Init
#elseif CLIENT
global function ClShFurnace_Init
#endif

#if SERVER
void function SvShFurnace_Init()
{
    printt( "do smth" )
}

#elseif CLIENT
void function ClShFurnace_Init()
{
    printt( "do smth" )
}
#endif