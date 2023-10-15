//
//  TerrainCacheOperation.swift
//
//  Created by Zack Brown on 15/10/2023.
//

import Bivouac
import Euclid
import Foundation
import PeakOperation

public class TerrainCacheOperation: ConcurrentOperation,
                                    ProducesResult {
    
    public var output: Result<TerrainCache, Error> = Result { throw ResultError.noResult }
    
    public override func execute() {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: name ?? String(describing: self),
                                  attributes: .concurrent)
        
        let stencil = Grid.Triangle.zero.stencil(for: .tile)
        
        var errors: [Error] = []
        var meshes: [String : Mesh] = [:]
        
        for kite in Grid.Triangle.Kite.allCases {
            
            for terrainType in TerrainType.allCases {
                
                for elevation in Grid.Triangle.Kite.Elevation.allCases {
                    
                    let operation = KiteMeshOperation(kite: kite,
                                                      colorPalette: terrainType.colorPalette,
                                                      elevation: elevation,
                                                      stencil: stencil)
                    
                    group.enter()
                    
                    operation.enqueue(on: internalQueue) { result in
                        
                        queue.async(flags: .barrier) {
                            
                            switch result {
                                
                            case .success(let mesh): meshes[TerrainCache.identifier(for: kite,
                                                                                    terrainType: terrainType,
                                                                                    elevation: elevation)] = mesh
                            case .failure(let error): errors.append(error)
                            }
                            
                            group.leave()
                        }
                    }
                }
            }
        }
        
        group.wait()
        
        self.output = errors.isEmpty ? .success(.init(meshes: meshes)) : .failure(MeshError.errors(errors))
        
        finish()
    }
}
