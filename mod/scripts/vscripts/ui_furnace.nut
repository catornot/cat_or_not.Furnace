globalize_all_functions


void function FurnaceCallBack_ComfirmedCompilationEnded()
{
    ClientCommand( "compile_done" )
}

void function FurnaceCallBack_NewGrid( float grid )
{
    ClientCommand( "new_grid " + grid  )
}

void function FurnaceCallBack_InstantSnap()
{
    ClientCommand( "snap_instant" )
}

void function FurnaceCallBack_NewBrush()
{
    ClientCommand( "cb" )
}

void function FurnaceCallBack_NewBrushStaged()
{
    ClientCommand( "cbs" )
}

void function FurnaceCallBack_NewEyeDistance( float distance )
{
    ClientCommand( "new_eye_distance " + distance )
}

void function FurnaceCallBack_DeleteMesh( int mesh )
{
    ClientCommand( "delete_mesh " + mesh )
}

void function FurnaceCallBack_NudgeZUp( int mesh, float nudge )
{
    ClientCommand( format("nudge_z %d %d", mesh, nudge ) )
}

void function FurnaceCallBack_NudgeZDown( int mesh, float nudge )
{
    ClientCommand( format("nudge_z %d %d", mesh, -nudge ) )
}

void function FurnaceCallBack_NudgeYUp( int mesh, float nudge )
{
    ClientCommand( format("nudge_y %d %d", mesh, nudge ) )
}

void function FurnaceCallBack_NudgeYDown( int mesh, float nudge )
{
    ClientCommand( format("nudge_y %d %d", mesh, -nudge ) )
}

void function FurnaceCallBack_NudgeXUp( int mesh, float nudge )
{
    ClientCommand( format("nudge_x %d %d", mesh, nudge ) )
}

void function FurnaceCallBack_NudgeXDown( int mesh, float nudge )
{
    ClientCommand( format("nudge_x %d %d", mesh, -nudge ) )
}

void function FurnaceCallBack_NewTexture( int mesh, string texture )
{
    ClientCommand( format("new_texture %d %s", mesh, texture ) )
}
