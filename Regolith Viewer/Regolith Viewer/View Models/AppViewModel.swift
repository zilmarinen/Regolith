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

@MainActor
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
    
    internal var apexHeight: Double { stencil.scale.edgeLength / 10.0 }
    internal var baseHeight: Double { stencil.scale.edgeLength / 2.0 }
    
    internal init() {
        
        updateScene()
        
        scene.rootNode.addChildNode(model)
        scene.rootNode.addChildNode(surface)
        
        model.addChildNode(wireframe)
    }
}

extension AppViewModel {
    
    private func updateScene() {
        
        updateModel()
        
        updateSurface()
    }
    
    private func updateModel() {
        
        let mesh = Mesh.kite(kite,
                             stencil,
                             baseHeight,
                             apexHeight,
                             .init(baseColor),
                             .init(apexColor))
        
        model.geometry = .init(mesh)
        wireframe.geometry = .init(wireframe: mesh)
    }
    
    private func updateSurface() {
        
        var mesh = Mesh([])
        
        for tile in Triangle.zero.perimeter {
            
            let color = tile.isPointy ? gridColor : gridAlternateColor
            
            guard let surface = Mesh.surface(tile.vertices.position(.tile),
                                             .init(color)) else { continue }
            
            mesh = mesh.merge(surface)
        }
        
        surface.geometry = .init(mesh)
    }
}
