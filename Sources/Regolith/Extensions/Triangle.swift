//
//  Kite.swift
//
//  Created by Zack Brown on 23/08/2023.
//

import Deltille
import Euclid
import Lattice

extension Triangle {
    
    public var pattern: Triangle.Kite.Pattern {
        
        let patterns = Kite.Pattern.allCases
        
        return patterns[abs(vertex.position.identifier) % patterns.count]
    }
    
    public func kite(index: Int) -> Triangle.Kite {
        
        let kites = pattern.kites
        
        return kites[((abs(vertex.position.identifier) % kites.count) + index) % kites.count]
    }
}
