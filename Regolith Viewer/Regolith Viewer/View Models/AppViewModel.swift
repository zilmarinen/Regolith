//
//  AppViewModel.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Bivouac
import Euclid
import Foundation
import Regolith
import SceneKit

class AppViewModel: ObservableObject {
    
    enum Constant {
        
        static let cameraY = 1.5
        static let cameraZ = 1.5
        
        static let primaryColor = Color(0.47, 0.61, 0.32)
        static let secondaryColor = Color(0.52, 0.39, 0.27)
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
    
    let scene = Scene()
    
    private let operationQueue = OperationQueue()
    private let triangle = Grid.Triangle(.zero)
    private var stencil: Grid.Triangle.Stencil { triangle.stencil(for: .tile) }
    
    private let colorPalette = ColorPalette(primary: Constant.primaryColor,
                                            secondary: Constant.secondaryColor,
                                            tertiary: .black,
                                            quaternary: .black)
    
    init() {
        
        scene.camera.position = SCNVector3(0, Constant.cameraY, Constant.cameraZ)
        scene.camera.look(at: SCNVector3(stencil.vertex(for: .v0)))
        
        updateScene()
    }
}

extension AppViewModel {
    
    private func createNode(with mesh: Mesh?) -> SCNNode? {
        
        guard let mesh else { return nil }
        
        let node = SCNNode()
        let wireframe = SCNNode()
        let material = SCNMaterial()
        
        node.geometry = SCNGeometry(mesh)
        node.geometry?.firstMaterial = material
        
        wireframe.geometry = SCNGeometry(wireframe: mesh)
        
        node.addChildNode(wireframe)
        
        return node
    }
    
    private func updateScene() {
        
        let operation = KiteMeshOperation(kite: kite,
                                          colorPalette: colorPalette,
                                          elevation: elevation,
                                          stencil: stencil)
        
        operation.enqueue(on: operationQueue) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
                
            case .success(let mesh):
                
                self.scene.clear()
                
                self.updateSurface()
                
                guard let node = self.createNode(with: mesh) else { return }
                
                self.scene.rootNode.addChildNode(node)
                
            case .failure(let error):
                
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func updateSurface() {
        
        let vertices = triangle.vertices(for: .tile).map { Vertex($0, .up) }
        
        guard let polygon = Polygon(vertices) else { return }
        
        let mesh = Mesh([polygon])
        
        guard let node = createNode(with: mesh) else { return }
        
        scene.rootNode.addChildNode(node)
    }
}
