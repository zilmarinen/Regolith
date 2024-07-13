//
//  TerrainCache.swift  
//
//  Created by Zack Brown on 15/10/2023.
//

import Bivouac
import Deltille
import Dependencies
import Euclid

public final class TerrainCache: AssetCache,
                                 DependencyKey {
    
    static public var liveValue = TerrainCache([:])
    
    static public func identifier(_ kite: Grid.Triangle.Kite,
                                  _ terrainType: TerrainType,
                                  _ elevation: Grid.Triangle.Kite.Elevation) -> String {
        
        "\(kite.id)_\(terrainType.id)_\(elevation.id)"
    }
    
    public func mesh(_ kite: Grid.Triangle.Kite,
                     _ terrainType: TerrainType,
                     _ elevation: Grid.Triangle.Kite.Elevation) -> Mesh? {
        
        mesh(Self.identifier(kite,
                             terrainType,
                             elevation))
    }
}
