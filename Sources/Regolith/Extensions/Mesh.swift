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
                            _ baseHeight: Double,
                            _ apexHeight: Double,
                            _ baseColor: Color,
                            _ apexColor: Color) -> Self {
        
        let outline = kite.vertices.map {
            
            stencil.vertex($0)
        }
        
        let apexElevation = Vector(0.0, baseHeight + apexHeight, 0.0)
        let baseElevation = Vector(0.0, baseHeight, 0.0)
        
        guard let surface = Polygon.surface(outline.map { $0 + apexElevation },
                                            apexColor) else { return .empty }
        
        var polygons = [surface]
        
        for i in outline.indices {
            
            let j = (i + 1) % outline.count
            
            let v0 = outline[i]
            let v1 = outline[j]
            
            let a0 = v0 + apexElevation
            let a1 = v1 + apexElevation
            
            let b0 = v0 + baseElevation
            let b1 = v1 + baseElevation
            
            guard let apex = Polygon.surface([b0, b1, a1, a0],
                                             apexColor),
                  let base = Polygon.surface([v0, v1, b1, b0],
                                                   baseColor) else { continue }
            
            polygons.append(contentsOf: [apex,
                                         base])
        }
        
        return Mesh(polygons)
    }
}
