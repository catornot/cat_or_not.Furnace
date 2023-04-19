# cat_or_not.Furnace
In game map editor for Titanfall 2

[plugin](https://github.com/catornot/furnace)

# omg docs?

## Installing

the installing process is slight complex

after installing 
1. the furnace plugin
2. the Funace mod

you need to add `furnace.env` to the `R2Northstar/plugins` folder

**profiles are not supported**

then the content would look smth like this
```bash
PATH_MOD="R2Northstar/mods/cat_or_not.Furnace/mod/maps/compile/"
PATH_COMPILER="MRVN-radiant/remap.exe"
```

1. `PATH_MOD` the path to the `compile` folder in `cat_or_not.Furnace` mod
2. `PATH_COMPILER` the path to `remap` compiler (yes you need to download [MRVN-radiant](https://github.com/MRVN-Radiant/MRVN-Radiant/actions))

## Using the mod
you get a cool window to edit the map, I think the ux is fine, so you'll be fine `;)`

![ui_showcase](https://user-images.githubusercontent.com/41955154/233191170-ff742797-56e6-4894-b694-dbe226a8c7b3.png)

both the plugin and mod must be working or else stuff will break

to actually edit the map load the map `mp_default` with the `map` command.
this is the map that furnace uses. you can add other maps to the `compile` folder with the `furace` format

## workflow

1. click buttons and make stuff appear
2. run `compile_map` command and wait until the server and everyone had there map compiled
3. reload server with `reload` command
4. repeat
   
the buttons do cool things
- **Snap To Closest Node** => snaps view to closest corner mesh
- **Create New Brush** => creates a brush from your view ( is affected by the **Eye Dis** text box )
- **Create New Brush ( 2 points )** => creates a brush from your coordinates
- all the **Nudge*** buttons => move the mesh skeleton by the nudge amount in a direction

the text entries with **Push** button don't update the values unless you click the **Push** button

Text Entries
- **Grid** => snaps the meshes to a power of that value ( kinda bad - Synthali )
- **Eye Dis** => how far the second point is from the player's view
- **Texture** => the texture for the mesh (a list of textures can be accessed with the `dump_textures` command )
- **Nudge Amount** => nudge amount
  
^^^^ stuff isn't saved between server reloads so push the **Grid** and **Eye Dis** again

TODO: save it

I think that is everything

if you have any issues you can contact me (`cat_or_not#3394`) in the [Northstar](https://discord.com/invite/9x2rqEbEaN) discord server. Please no dms!