//
//  AppViewModel.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Bivouac
import Deltille
import Dependencies
import Euclid
import Foundation
import Regolith
import SceneKit
import SwiftUI

class AppViewModel: ObservableObject {
    
    @Dependency(\.terrainCache) var terrainCache
    
    @Published var terrainType: TerrainType = .boreal {
        
        didSet {
            
            guard oldValue != terrainType else { return }
            
            updateScene()
        }
    }
    
    @Published var kite: Deltille.Grid.Triangle.Kite = .epsilon {
        
        didSet {
            
            guard oldValue != kite else { return }
            
            updateScene()
        }
    }
    
    @Published var elevation: Deltille.Grid.Triangle.Kite.Elevation = .base {
        
        didSet {
            
            guard oldValue != elevation else { return }
            
            updateScene()
        }
    }
    
    @Published var profile: Mesh.Profile = .init(polygonCount: 0,
                                                 vertexCount: 0)
    
    internal let scene = ModelViewScene()
    
    private let operationQueue = OperationQueue()
    
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
                
            case .success(let meshes): terrainCache.merge(meshes)
            case .failure(let error): fatalError(error.localizedDescription)
            }
            
            self.updateScene()
        }
    }
    
    private func updateScene() {
        
        scene.clear()
        
        scene.render(surface: [Grid.Triangle.zero.position])

        guard let mesh = terrainCache.mesh(kite,
                                           terrainType,
                                           elevation) else { return }
        
        let geometry = SCNGeometry(mesh)
        
        //geometry.program = Program(function: .geometry)
        
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

extension AppViewModel {
 
    func presentExportModal() {
        
        let panel = NSOpenPanel()
        
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.isExtensionHidden = true
        panel.showsHiddenFiles = false
        panel.showsTagField = false
        
        panel.begin { [weak self] response in
            
            switch response {
                
            case .OK:
                
                guard let self,
                      let url = panel.urls.first else { return }
                
                let operation = AssetCacheExportOperation(terrainCache,
                                                          url)
                
                operation.enqueue(on: self.operationQueue)
                
            default: break
            }
        }
    }
}
