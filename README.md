# **5Dim's mod**
![logo](logo.png)

## **Global Links**

- [Patreon](https://www.patreon.com/5Dim)
- [Download from ModPortal](https://mods.factorio.com/mods/McGuten)
- [Issues](https://github.com/McGuten/Factorio5DimMods/issues)
- [Discord comunity](https://discord.gg/CTEMFd9)

## Description

This mod is a **total conversion** and it has **tons of modules** and we recommend use all in your game.

## Mod list
### Core module
  - **Core**.
    - Core, library and settings of 5Dim's mod.
    - You can install our modules in your current saved game without any problem.
    -  **REQUIRED for any other module**

### Optional modules
  - **Automation**.
    - Add a lot of new tiers oil refineries, new tiers of assembling machine, chemical plants and laboratories.
  - **Battlefield**.
    - Add 2 new laser turret, 2 new gun turret, new tesla turret, new tiers of walls, gates and new radars.
  - **Decoration**.
    - Add some new items to decorate your base like numbers and letters.
  - **Enemies**.
    - Add a lot of new biters, spitter and spawners, recommended for experimented players, be carefull.
  - **Energy**.
    - Add more divertidity for electric stuffs.
  - **Equipment**.
    - Improve your character with a new bundle of objects for your power armor.
  - **Infinite Research**.
    - Include some of infinity technologies and other new technolgies.
  - **Logistics**.
    - Logistics network enhanced with tiers of worker robots and powerfull beacons.
  - **Mining**.
    - Extracts all kind of resources at high productivity also obtain water from everywhere.
  - **Module**.
    - Adds a brand new merged modules and 10 tiers of the rest of the modules.
  - **Nuclear**.
    - If you are a mad of nuclear power with this mod you can upgrade all your blueprints to a new level.
  - **Ores**.
    - Add a lot of new ores to make factorio more fun **(Require [Bob Library](https://mods.factorio.com/mod/boblibrary))**.
    - **Coming soon**
  - **Resources**.
    - Add a new intermediate to improve your basic resources from ores.
  - **Storage**.
    - If you hate limitated capacity of storage tanks, this mod extends its by new tiers.
  - **Trains**.
    - We know that you loves trains so we are created more tiers of locomotives and wagons.
  - **Transport**.
    - You can move all of your stuff along your base efficiently with a new bundle of transport belt, loaders and inserters **(Require [Bob Inserters](https://mods.factorio.com/mod/bobinserters))**.

### Utility modules
  - **Automated Fuel and Ammo**.
    - Automatically fills vehicles and building when you place it on the floor.
  - **Bot Recaller**.
    - Utility mod to help recall/collect bots within a network.
  - **Locales**.
    - Add translates for 5dim's mod.

## Translations
1. If you want to translate the mod to other lang you should use the follow template
2. [5Dim's Locale > locale > en.example](5dim_locale/locale/en.example)
3. You should use this template to translate the mod and upload it with [Pull Request](https://github.com/McGuten/Factorio5DimMods/pulls)

## Errors

### **If you have problems with missing items or you add the mod in mid game you should use this command**
You also should **empty your inventory**, sometimes your inventory would lost.

This command will refresh all your technologies.
```lua
/c tech = {}
for name,technology in pairs(game.player.force.technologies) do
  if technology.researched == true then
    table.insert( tech, technology.name )
  end
end
game.player.force.reset()
for _, tech_name in pairs(tech) do
  for name,technology in pairs(game.player.force.technologies) do
    if (technology.name == tech_name) then
      technology.researched = true
    end
  end
end
```


## Images

![core](core-settings.png)
![mod](mod-settings.png)
