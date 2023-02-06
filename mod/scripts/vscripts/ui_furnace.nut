globalize_all_functions


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

void function FurnaceCallBack_NewTexture()
{
    ClientCommand( format("new_texture %d %s", FurnaceGetCurrentMesh(), FurnaceGetTexture() ) )
}
