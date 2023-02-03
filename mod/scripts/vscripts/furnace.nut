global function Furnace_Init

void function Furnace_Init()
{
    PrecacheModel( $"models/domestic/nessy_doll.mdl" )

    InitKeyTracking()

    AddClientCommandCallback( "cb", CreateBrush )
    

    PushMapName( GetMapName() )

    
    array<vector> points = GetMeshes( GetMapName() )

    for( int n = 0; n < points.len(); n += 2 )
    {
        vector point1 = points[n]
        vector point2 = points[n+1]

        // printt( point1, point2 )

        entity ent1 = CreatePropDynamic( $"models/domestic/nessy_doll.mdl", point1, <0,0,0>, SOLID_VPHYSICS, 10000 )
        entity ent2 = CreatePropDynamic( $"models/domestic/nessy_doll.mdl", point2, <0,0,0>, SOLID_VPHYSICS, 10000 )
        
        SetupEditableSkeleton( ent1, ent2, n/2 )

    }
}

bool function CreateBrush( entity player, array<string> args )
{
    try {
        if ( args.len() > 0 )
            thread CreateBrushThreaded( player, args[0].tointeger() )
        else 
            thread CreateBrushThreaded( player )
            
    } 
    catch( err ) {
        thread CreateBrushThreaded( player )
    }
    return true
}

void function CreateBrushThreaded( entity player, int lenght = 1000 )
{
    player.EndSignal( "OnDeath" )
    player.EndSignal( "OnDestroy" )

    entity point1 = CreatePropDynamic( $"models/domestic/nessy_doll.mdl", player.GetOrigin(), player.GetAngles(), SOLID_VPHYSICS, 10000 )
    entity point2 = CreatePropDynamic( $"models/domestic/nessy_doll.mdl", player.GetViewVector() * lenght + player.EyePosition(), -player.GetAngles(), SOLID_VPHYSICS, 10000 )
    
    point1.NotSolid()
    point2.NotSolid()

    string unique_id = UniqueString( "CurrentMode" )

    NSCreateStatusMessageOnPlayer( player, "Mode", "Eye Building", unique_id )

    OnThreadEnd(
	function() : ( player, unique_id, point1, point2 )
		{
            if ( IsValid( player ) ) 
                NSDeleteStatusMessageOnPlayer( player, unique_id )
            
            if ( !IsValid( player ) || !IsAlive( player ) )
            {
                point1.Destroy()
                point2.Destroy()
                return
            }
		}
	)

    array<bool> keys = GetPlayerKeysList( player )

    for(;;) {
        lenght = GetEyeDistanceForPlayer( player ).tointeger()
        float snap = GetGridForPlayer( player )
        point1.SetOrigin( ClampToGrid( player.GetOrigin(), snap  ))
        point2.SetOrigin( ClampToGrid( player.GetViewVector() * lenght + player.EyePosition(), snap ) )

        point1.SetAngles( player.GetAngles() )
        point2.SetAngles( -player.GetAngles() )

        keys = GetPlayerKeysList( player )

        if ( keys[KU] && keys[KD] )
            break

        wait 0
    }

    point1.Solid()
    point2.Solid()

    int index = PushMesh( point1.GetOrigin(), point2.GetOrigin() )
    SetupEditableSkeleton( point1, point2, index )
}

void function SetupEditableSkeleton( entity point1, entity point2, int index )
{
    GenerateBrushSkeleton( point1, point2 )

    point2.SetUsable()
    point2.SetUsableByGroup( "pilot" )
    point2.SetUsePrompts( "Hold %use% to delete this skeleton mesh", "Press %use% to delete this skeleton mesh" )

    point1.SetUsable()
    point1.SetUsableByGroup( "pilot" )
    point1.SetUsePrompts( "Hold %use% to delete this skeleton mesh", "Press %use% to delete this skeleton mesh" )

    point1.SetScriptName( "nessie_node" )
    point2.SetScriptName( "nessie_node" )

    thread EditableSkeletonThink( point2, point1, index )
    thread EditableSkeletonThink( point1, point2, index )
}

void function EditableSkeletonThink( entity point, entity other_point, int index )
{
    EndSignal( point, "OnDestroy" )
    EndSignal( other_point, "OnDestroy" )

    OnThreadEnd(
	function() : ( point, other_point )
		{
            if ( !IsValid( point ) )
                return
            
            foreach( entity child in __GetChildren( point ) )
            {
                if ( IsValid( child ) )
                    child.Destroy()
            }

            point.Destroy()
            
            if ( !IsValid( other_point ) )
                return
            
            foreach( entity child in __GetChildren( other_point ) )
            {
                if ( IsValid( child ) )
                    child.Destroy()
            }
            
            other_point.Destroy()
        }
	)
    
    WaitFrame()

    for(;;)
    {
        entity player = expect entity( point.WaitSignal( "OnPlayerUse" ).player )

        RemoveMesh( index )

        break
    }
}

void function GenerateBrushSkeleton( entity point1, entity point2 )
{
    vector pt1 = point1.GetOrigin()
    vector pt2 = point2.GetOrigin()
    
    float min_z = min( pt1.z, pt2.z )
    float max_z = max( pt1.z, pt2.z )

    CreateSkeletonRope( [ 
        <pt1.x,pt1.y,min_z>, <pt1.x,pt2.y,min_z>, <pt2.x,pt2.y,min_z>,
        <pt1.x,pt1.y,min_z>, <pt2.x,pt1.y,min_z>, <pt2.x,pt2.y,min_z>,
        <pt1.x,pt1.y,max_z>, <pt1.x,pt2.y,max_z>, <pt2.x,pt2.y,max_z>,
        <pt1.x,pt1.y,max_z>, <pt2.x,pt1.y,max_z>, <pt2.x,pt2.y,max_z> 
    ], 
    point1 )
}

void function CreateSkeletonRope( array< vector > pts, entity parent_ent  )
{
    array<entity> ropes
    string next_name = UniqueString( "unique_rope" )

    entity rope = CreateEntity( "move_rope" )
    rope.kv.NextKey = next_name
    rope.kv.Width = "5"
    rope.kv.TextureScale = "1"
    rope.kv.RopeMaterial = "cable/zipline.vmt"
    rope.SetOrigin( pts[ pts.len() - 1 ] )
    ropes.append( rope )

    foreach ( vector pt in pts )
    {
        entity rope_key = CreateEntity( "keyframe_rope" )
        
        rope_key.kv.Width = "5"
        rope_key.kv.TextureScale = "1"
        rope_key.kv.RopeMaterial = "cable/zipline.vmt"
        rope_key.SetOrigin( pt )
        SetTargetName( rope_key, next_name )
        ropes.append( rope_key )

        next_name = UniqueString( "unique_rope" )

        rope_key.kv.NextKey = next_name
    }

    foreach( entity r in ropes )
    {
        DispatchSpawn( r )
        r.SetParent( parent_ent )
    }
}

vector function ClampToGrid( vector point, float multiple = 16.0  )
{
    return < ((point.x + multiple - 1) / multiple) * multiple, ((point.y + multiple - 1) / multiple) * multiple, ((point.z + multiple - 1) / multiple) * multiple >
}

array<entity> function __GetChildren( entity parentEnt )
{
    array<entity> ents
	entity childEnt = parentEnt.FirstMoveChild()
	entity nextChildEnt

	while ( childEnt != null )
	{
		nextChildEnt = childEnt.NextMovePeer()
		ents.append( nextChildEnt )

		childEnt = nextChildEnt
	}

    return ents
}