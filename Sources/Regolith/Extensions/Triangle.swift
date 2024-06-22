//
//  Triangle.swift
//
//  Created by Zack Brown on 23/08/2023.
//

import Bivouac
import Deltille
import Euclid

extension Grid.Triangle.Kite {
    
    public static let apex = Double(Grid.Triangle.Scale.tile.edgeLength) / 10.0
    public static let base = Double(Grid.Triangle.Scale.tile.edgeLength) / 2.0
    
    public enum Elevation: String,
                           CaseIterable,
                           Identifiable {
        
        case apex = "Apex"
        case base = "Base"
        
        public var id: String { rawValue }
        
        public var peak: Double {
            
            switch self {
                
            case .apex: return Grid.Triangle.Kite.apex
            case .base: return Grid.Triangle.Kite.base
            }
        }
    }
    
    public func mesh(using stencil: Grid.Triangle.Stencil,
                     colorPalette: ColorPalette,
                     elevation: Elevation) throws -> Mesh {
        
        let stencilVertices = vertices.map { stencil.vertex($0) }
        
        switch elevation {
            
        case .apex: return Mesh.wrap(stencilVertices,
                                     colorPalette.primary, 
                                     colorPalette.primary,
                                     elevation.peak)
            
        case .base: return Mesh.wrap(stencilVertices,
                                     nil,
                                     colorPalette.secondary,
                                     elevation.peak)
        }
    }
}
