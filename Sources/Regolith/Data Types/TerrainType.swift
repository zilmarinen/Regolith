//
//  TerrainType.swift
//
//  Created by Zack Brown on 01/09/2023.
//

import Bivouac
import Foundation

public enum TerrainType: String,
                         CaseIterable,
                         Codable,
                         Identifiable {
    
    case boreal
    case chaparral
    case deciduous
    case prairie
    case rainforest
    case scrubland
    case tundra
    
    public var id: String { rawValue.capitalized }
    
    public var transitions: [TerrainType] {
        
        switch self {
            
        case .boreal: return [.chaparral, .deciduous, .tundra]
        case .chaparral: return [.boreal, .prairie, .scrubland]
        case .deciduous: return [.boreal, .rainforest, .scrubland]
        case .prairie: return [.chaparral]
        case .rainforest: return [.deciduous]
        case .scrubland: return [.chaparral, .deciduous]
        case .tundra: return [.boreal]
        }
    }
}

extension TerrainType {
    
    public var colorPalette: ColorPalette {
        
        switch self {
            
        case .boreal: return .init("63424B",
                                   "3A243B")
            
        case .chaparral: return .init("BDA928",
                                      "473F2D")
            
        case .deciduous: return .init("8B7D3A",
                                      "534A32")
            
        case .prairie: return .init("FFA631",
                                    "CB7E1F")
          
        case .rainforest: return .init("6B9362",
                                       "2A603B")
             
        case .scrubland: return .init("F08F90",
                                      "F2666C")
            
        case .tundra: return .init("C2DBDF",
                                   "71A2A6")
        }
    }
}
