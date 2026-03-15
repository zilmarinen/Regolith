//
//  Mesh.swift
//
//  Created by Zack Brown on 15/10/2025.
//

import Bivouac
import Deltille
import Euclid

extension Mesh {
    
    public static func kite(_ kite: Triangle.Kite,
                            _ stencil: Triangle.Stencil,
                            _ height: Double,
                            _ color: Color) -> Self {
        
        let vertices = kite.vertices.map {
            
            stencil.vertex($0)
        }
        
        let base = vertices.path(color)
        let apex = base.translated(by: .init(0.0, height, 0.0))
        
        return .loft([base,
                      apex])
    }
}
