//
//  Triangle.swift
//
//  Created by Zack Brown on 23/08/2023.
//

import Bivouac
import Euclid

extension Grid.Triangle.Kite {
    
    public enum Elevation: String,
                           CaseIterable,
                           Identifiable {
        
        case apex = "Apex"
        case base = "Base"
        
        public var id: String { rawValue }
        
        public var peak: Vector {
            
            switch self {
                
            case .apex: return Vector(0.0, Grid.Triangle.Kite.apex, 0.0)
            case .base: return Vector(0.0, Grid.Triangle.Kite.base, 0.0)
            }
        }
    }
    
    public func mesh(using stencil: Grid.Triangle.Stencil,
                     colorPalette: ColorPalette,
                     elevation: Elevation) throws -> Mesh {
        
        let color = (elevation == .apex ? colorPalette.primary : colorPalette.secondary)
        let peak = elevation.peak
        let points = vertices(for: stencil.scale).map { stencil.vertex(for: $0) }
        
        var polygons: [Polygon] = []
        
        let apex = points.map { Vertex($0 + peak,
                                       .up,
                                       nil,
                                       color) }
        
        let base = points.map { Vertex($0,
                                       -.up,
                                       nil,
                                       color) }
        
        try polygons.glue(Polygon(apex))
        try polygons.glue(Polygon(base.reversed()))
        
        for i in points.indices {
            
            let j = (i + 1) % points.count
            
            let v0 = points[i]
            let v1 = points[j]
            let v2 = v1 + peak
            let v3 = v0 + peak
            
            let face = Polygon.Face([v0,
                                     v1,
                                     v2,
                                     v3],
                                    color: color)
            
            try polygons.glue(face?.polygon)
        }
        
        return Mesh(polygons)
    }
}
