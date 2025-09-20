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
        
        return patterns[vertex.position.sum % patterns.count]
    }
}
