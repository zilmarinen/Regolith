//
//  Kite.swift
//
//  Created by Zack Brown on 23/08/2023.
//

import Deltille
import Euclid
import Lattice

extension Triangle.Kite {
    
    public enum Slice: String,
                       CaseIterable,
                       Identifiable {
        
        case apex
        case base
        
        public var id: String { rawValue.capitalized }
        
        public func displacement(_ scale: Triangle.Scale) -> Double {
            
            (self == .apex ? 0.1 : 0.5) * scale.edgeLength
        }
    }
    
    public func mesh(_ stencil: Triangle.Stencil,
                     _ slice: Slice,
                     _ color: Color) -> Mesh {
        
        let volume = Volume(stencil: stencil,
                            vertices: vertices,
                            displacement: slice.displacement(stencil.scale))
        
        return volume.mesh(color)
    }
}

