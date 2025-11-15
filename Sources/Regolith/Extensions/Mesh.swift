//
//  Mesh.swift
//
//  Created by Zack Brown on 15/10/2025.
//

import Deltille
import Euclid
import Lattice

extension Mesh {
    
    public static func kite(_ kite: Triangle.Kite,
                            _ stencil: Triangle.Stencil,
                            _ height: Double,
                            _ color: Color) -> Mesh {
        
        let vertices = kite.vertices.map { stencil.vertex($0) }
        
        let base = vertices.path(color)
        let apex = base.translated(by: .init(0.0, height, 0.0))
        
        return Mesh.loft([base,
                          apex])
    }
}
