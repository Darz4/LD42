

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

sprites = {}
spriteGroups =
{
    floor1 = { 'tiles/Tile_herbground_1', 'tiles/Tile_herbground_3' },
    floor2 = { 'tiles/Tile_herbground_2', 'tiles/Tile_herbground_4' },
}

spriteFlags =
{
    roots =
    {
        ['Plants/Roots/Root_10'] = { false, true, false, false },
        ['Plants/Roots/Root_11']= { true, false, false, false },
        ['Plants/Roots/Root_12'] = { false, false, true, false },
        ['Plants/Roots/Root_20'] = { true, false, false, true },
        ['Plants/Roots/Root_21'] = { false, false, true, true },
        ['Plants/Roots/Root_22'] = { false, true, true, false },
        ['Plants/Roots/Root_23'] = { true, true, false, false },
        ['Plants/Roots/Root_30'] = { true, false, true, false },
        ['Plants/Roots/Root_31'] = { false, true, false, true },
        ['Plants/Roots/Root_40'] = { true, false, true, true },
        ['Plants/Roots/Root_41'] = { true, true, true, false },
        ['Plants/Roots/Root_42'] = { true, true, false, true },
        ['Plants/Roots/Root_43'] = { false, true, true, true },
        ['Plants/Roots/Root_50a'] = { true, true, true, true },
        ['Plants/Roots/Root_50b'] = { true, true, true, true },
    },
    
    seed =
    {
        -- TODO: we need base, L and R assets
        ['Plants/Roots/Root_base_D'] = { false, false, false, true },
        ['Plants/Roots/Root_base_DL'] = { true, false, false, true },
        ['Plants/Roots/Root_base_DLR'] = { true, false, true, true },
        ['Plants/Roots/Root_base_DR'] = { false, false, true, true },
        ['Plants/Roots/Root_base_LR'] = { true, false, true, false },
    }
}

flagsSprites = {}