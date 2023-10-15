//
//  TerrainType.swift
//
//  Created by Zack Brown on 30/09/2023.
//

import Bivouac
import Foundation

extension TerrainType {
    
    public var colorPalette: ColorPalette {
        
        switch self {
            
        case .boreal: return .init(primary: .init(.systemGreen),
                                   secondary: .init(.systemBrown))
            
        case .chaparral: return .init(primary: .init(.systemTeal),
                                      secondary: .init(.systemGray))
            
        case .deciduous: return .init(primary: .init(.systemTeal),
                                      secondary: .init(.systemGray))
            
        case .prairie: return .init(primary: .init(.systemTeal),
                                    secondary: .init(.systemGray))
          
        case .rainforest: return .init(primary: .init(.systemTeal),
                                       secondary: .init(.systemGray))
             
        case .scrubland: return .init(primary: .init(.systemTeal),
                                      secondary: .init(.systemGray))
            
        case .tundra: return .init(primary: .init(.systemGreen),
                                   secondary: .init(.systemBrown))
        }
    }
}
