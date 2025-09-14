//
//  AppViewModel.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Deltille
import Euclid
import Foundation
import Regolith
import SceneKit
import SwiftUI

internal class AppViewModel: ObservableObject {
    
    @Published internal var kite: Triangle.Kite = .delta {
        
        didSet {
            
            guard oldValue != kite else { return }
            
            updateScene()
        }
    }
    
    internal let scene = SCNScene()
    
    internal let stencil = Triangle.zero.stencil(.tile)
    
    internal let apexColor: NSColor = .apex
    internal let baseColor: NSColor = .base
    
    internal let gridColor: NSColor = .grid
    internal let gridAlternateColor: NSColor = .gridAlternate
    
    internal let model = SCNNode()
    internal let wireframe = SCNNode()
    internal let surface = SCNNode()
    
    internal init() {
        
        updateScene()
        
        scene.rootNode.addChildNode(model)
        scene.rootNode.addChildNode(surface)
        
        model.addChildNode(wireframe)
    }
}

extension AppViewModel {
    
    private func updateScene() {
        
        updateKite()
        
        updateSurface()
    }
    
    private func updateKite() {
        
        let apex = kite.mesh(stencil,
                             .apex,
                             .init(apexColor))
        
        let base = kite.mesh(stencil,
                             .base,
                             .init(baseColor))
        
        let displacement = Triangle.Kite.Slice.base.displacement(stencil.scale)
        
        let mesh = base.union(apex.translated(by: .init(0.0, displacement, 0.0)))
        
        model.geometry = .init(mesh)
        wireframe.geometry = .init(wireframe: mesh)
    }
    
    private func updateSurface() {
        
        var mesh = Mesh([])
        
        for tile in Triangle.zero.perimeter {
            
            let color: NSColor = tile.isPointy ? gridColor : gridAlternateColor
            
            mesh = mesh.merge(tile.mesh(.tile,
                                        .init(color)))
        }
        
        surface.geometry = .init(mesh)
    }
}
