//
//  TerrainType.swift
//
//  Created by Zack Brown on 01/09/2023.
//

import Bivouac
import Foundation

public enum TerrainType: String,
                         CaseIterable,
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
            
        case .boreal: return .init(.init("63424B"),
                                   .init("3A243B"))
            
        case .chaparral: return .init(.init("BDA928"),
                                      .init("473F2D"))
            
        case .deciduous: return .init(.init("8B7D3A"),
                                      .init("534A32"))
            
        case .prairie: return .init(.init("FFA631"),
                                    .init("CB7E1F"))
          
        case .rainforest: return .init(.init("6B9362"),
                                       .init("2A603B"))
             
        case .scrubland: return .init(.init("F08F90"),
                                      .init("F2666C"))
            
        case .tundra: return .init(.init("C2DBDF"),
                                   .init("71A2A6"))
        }
    }
}
