[![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20Mac-lightgray.svg)]()
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)


# Introduction
Regolith is a Swift package written to facilitate the generation of terrain tilesets for use in [Wave Function Collapse](https://en.wikipedia.org/wiki/Wave_function_collapse) and [Marching Cube](https://en.wikipedia.org/wiki/Marching_cubes) based terrain generation systems. Primarily built for use within [Harvest](https://github.com/zilmarinen/Harvest) and [Orchard](https://github.com/zilmarinen/Orchard), Regolith generates a comprehensive, low poly set of triangular kite configurations that can be used as a tileset for terrain mesh generation.

## About
Regolith was built as a prototyping tool to allow for rapid development and visual feedback of terrain tilesets that are generated programmatically. By pre-generating tile variations we can reduce the amount of time and effort required to create a complete set by hand. An example `Regolith Viewer` application is included to facilitate the visualisation of each triangle kite configuration to validate the generated mesh output.

## Inspiration
Heavily inspired by [Oskar Stålberg](https://oskarstalberg.tumblr.com)'s work on [WFC](https://www.youtube.com/watch?v=0bcZb-SsnrA) systems for [Townscaper](https://www.townscapergame.com) and [Bad North](https://twitter.com/BadNorthGame) and also [BorisTheBrave](https://twitter.com/boris_brave)'s superb tutorials on [WFC](https://www.boristhebrave.com/2020/04/13/wave-function-collapse-explained/) and [Model Synthesis](https://www.boristhebrave.com/2021/10/26/model-synthesis-and-modifying-in-blocks/), the aim of this project is to generate complex geometric shapes that tesselate correctly on a 3D grid system without the use of any third party modelling tools.

# Kites & Patterns

Using a concept known as [Ortho-Tiling](https://www.boristhebrave.com/2023/05/31/ortho-tiles/) we can predefine a custom set of `Kite` configurations that encode the vertices that form the perimeter of each shape. Whilst only seven such kites are needed here to describe a complete set, an additional kite is defined as an optimisation should a triangle have a uniform elevation and material distribution along all vertices. Triangular tile variations can be derived by combining kite triplets to create different tessellating `Kite.Pattern`s. Additional tiling variations can also be achieved by rotating the base pattern in intervals of 120 degrees.

![Kite Patterns](Images/kite_patterns.png)

# Meshes

The geometry for each kite is generated from its predefined vertices and extruded to create a 3D `Mesh` for both the base and apex of a tile.  The resulting meshes can be used within [CSG](https://en.wikipedia.org/wiki/Constructive_solid_geometry) operations to create more complex patterns. Combining the results of the CSG operations on different `Kite`s allows for multiple styles within a single tile which vastly increases the diversity of the resulting tileset. 

![Regolith Viewer](Images/regolith_viewer.png)

## Dependencies
[Euclid](https://github.com/nicklockwood/Euclid) is a Swift library for creating and manipulating 3D geometry and is used extensively within this project for mesh generation and vector operations.

[PeakOperation](https://github.com/3Squared/PeakOperation) is a Swift microframework providing enhancement and conveniences to [`Operation`](https://developer.apple.com/documentation/foundation/operation). 

