//
//  Coordinate.swift
//  Regolith
//
//  Created by Zack Brown on 26/09/2025.
//

import Deltille

extension Coordinate {
    
    public var identifier: Int {
        
        x &* .bell ^
        y &* .delicate ^
        z &* .mersenne
    }
}
