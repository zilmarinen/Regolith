//
//  AppViewModel.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Deltille
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
    
    internal init() {
        
        updateScene()
    }
}

extension AppViewModel {
    
    private func updateScene() {
        
        clear()
        
        updateKite()
        
        updateSurface()
    }
    
    private func clear() {
        
        scene.rootNode.childNodes.forEach {
            
            $0.removeFromParentNode()
        }
    }
    
    private func updateKite() {
        
        let apex = kite.mesh(stencil,
                             .apex,
                             .init(apexColor))
        
        let base = kite.mesh(stencil,
                             .base,
                             .init(baseColor))
        
        let apexNode = SCNNode(geometry: .init(apex))
        let baseNode = SCNNode(geometry: .init(base))
        
        let displacement = Triangle.Kite.Slice.base.displacement(stencil.scale)
        
        apexNode.position = SCNVector3(0, displacement, 0)
        
        scene.rootNode.addChildNode(apexNode)
        scene.rootNode.addChildNode(baseNode)
    }
    
    private func updateSurface() {
        
        for tile in Triangle.zero.perimeter {
            
            let mesh = tile.mesh(.tile)
            
            let node = SCNNode(geometry: .init(mesh))
            
            scene.rootNode.addChildNode(node)
        }
    }
}
