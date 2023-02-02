global function FurnaceCallBack_ComfirmedCompilationEnded
global function FurnaceCallBack_NewGrid
global function FurnaceCallBack_InstantSnap

void function FurnaceCallBack_ComfirmedCompilationEnded()
{
    ClientCommand( "compile_done" )
}

void function FurnaceCallBack_NewGrid()
{
    ClientCommand( "new_grid " + FurnaceGetGrid()  )
}

void function FurnaceCallBack_InstantSnap()
{
    ClientCommand( "snap_instant" )
}