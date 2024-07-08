//
//  Dependencies.swift
//
//  Created by Zack Brown on 08/07/2024.
//

import Dependencies

extension DependencyValues {
    
    public var terrainCache: TerrainCache {
        
        get { self[TerrainCache.self] }
        set { self[TerrainCache.self] = newValue }
    }
}
