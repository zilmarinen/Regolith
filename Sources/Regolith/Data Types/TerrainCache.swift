//
//  TerrainCache.swift  
//
//  Created by Zack Brown on 15/10/2023.
//

import Bivouac
import Euclid
import Foundation

public struct TerrainCache {
    
    public static func identifier(for kite: Grid.Triangle.Kite,
                                  terrainType: TerrainType,
                                  elevation: Grid.Triangle.Kite.Elevation) -> String { "\(kite.id)_\(terrainType.id)_\(elevation.id)" }
    
    public let meshes: [String : Mesh]
    
    public func mesh(for kite: Grid.Triangle.Kite,
                     terrainType: TerrainType,
                     elevation: Grid.Triangle.Kite.Elevation) -> Mesh? { meshes[Self.identifier(for: kite,
                                                                                                terrainType: terrainType,
                                                                                                elevation: elevation)] }
}
