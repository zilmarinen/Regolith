//
//  AppViewModel.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Bivouac
import Deltille
import Euclid
import Foundation
import Regolith
import SceneKit

class AppViewModel: ObservableObject {
    
    @Published var terrainType: TerrainType = .boreal {
        
        didSet {
            
            guard oldValue != terrainType else { return }
            
            updateScene()
        }
    }
    
    @Published var kite: Grid.Triangle.Kite = .epsilon {
        
        didSet {
            
            guard oldValue != kite else { return }
            
            updateScene()
        }
    }
    
    @Published var elevation: Grid.Triangle.Kite.Elevation = .base {
        
        didSet {
            
            guard oldValue != elevation else { return }
            
            updateScene()
        }
    }
    
    @Published var profile: Mesh.Profile = .init(polygonCount: 0,
                                                 vertexCount: 0)
    
    internal let scene = ModelViewScene()
    
    private let operationQueue = OperationQueue()
    
    private var cache: TerrainCache?
    
    init() {
        
        generateCache()
    }
}

extension AppViewModel {
    
    private func generateCache() {
        
        let operation = RegolithCacheOperation()
        
        operation.enqueue(on: operationQueue) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
                
            case .success(let cache): self.cache = cache
            case .failure(let error): fatalError(error.localizedDescription)
            }
            
            self.updateScene()
        }
    }
    
    private func updateScene() {
        
        scene.clear()
        
        scene.render(surface: Grid.Triangle.zero.perimeter)

        guard let cache,
              let mesh = cache.mesh(for: kite,
                                    terrainType: terrainType,
                                    elevation: elevation) else { return }
        
        let geometry = SCNGeometry(mesh)
        
        geometry.program = Program(function: .geometry)
        
        scene.model.geometry = geometry
        
        updateProfile(for: mesh)
    }
    
    private func updateProfile(for mesh: Mesh) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self else { return }
            
            self.profile = mesh.profile
        }
    }
}
