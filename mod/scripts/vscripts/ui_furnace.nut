global function FurnaceCallBack_ComfirmedCompilationEnded
global function FurnaceCallBack_NewGrid
global function FurnaceCallBack_InstantSnap
global function FurnaceCallBack_NewBrush
global function FurnaceCallBack_NewEyeDistance

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

void function FurnaceCallBack_NewBrush()
{
    ClientCommand( "cb" )
}

void function FurnaceCallBack_NewEyeDistance()
{
    ClientCommand( "new_eye_distance " + FurnaceGetEyeDistance() )
}