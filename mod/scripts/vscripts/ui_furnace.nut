global function FurnaceCallBack_ComfirmedCompilationEnded
global function FurnaceCallBack_NewGrid
global function FurnaceCallBack_InstantSnap
global function FurnaceCallBack_NewBrush
global function FurnaceCallBack_NewEyeDistance
global function FurnaceCallBack_DeleteMesh
global function FurnaceCallBack_NudgeZUp
global function FurnaceCallBack_NudgeZDown
global function FurnaceCallBack_NudgeYUp
global function FurnaceCallBack_NudgeYDown
global function FurnaceCallBack_NudgeXUp
global function FurnaceCallBack_NudgeXDown


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

void function FurnaceCallBack_DeleteMesh()
{
    ClientCommand( "delete_mesh " + FurnaceGetCurrentMesh() )
}

void function FurnaceCallBack_NudgeZUp()
{
    ClientCommand( format("nudge_z %d %d", FurnaceGetCurrentMesh(), FurnaceGetNudgeValue() ) )
}

void function FurnaceCallBack_NudgeZDown()
{
    ClientCommand( format("nudge_z %d %d", FurnaceGetCurrentMesh(), -FurnaceGetNudgeValue() ) )
}

void function FurnaceCallBack_NudgeYUp()
{
    ClientCommand( format("nudge_y %d %d", FurnaceGetCurrentMesh(), FurnaceGetNudgeValue() ) )
}

void function FurnaceCallBack_NudgeYDown()
{
    ClientCommand( format("nudge_y %d %d", FurnaceGetCurrentMesh(), -FurnaceGetNudgeValue() ) )
}

void function FurnaceCallBack_NudgeXUp()
{
    ClientCommand( format("nudge_x %d %d", FurnaceGetCurrentMesh(), FurnaceGetNudgeValue() ) )
}

void function FurnaceCallBack_NudgeXDown()
{
    ClientCommand( format("nudge_x %d %d", FurnaceGetCurrentMesh(), -FurnaceGetNudgeValue() ) )
}
