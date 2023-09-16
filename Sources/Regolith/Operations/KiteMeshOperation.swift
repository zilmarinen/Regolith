//
//  KiteMeshOperation.swift
//
//  Created by Zack Brown on 26/08/2023.
//

import Bivouac
import Euclid
import Foundation
import PeakOperation

public class KiteMeshOperation: ConcurrentOperation,
                                ProducesResult {
    
    public var output: Result<Mesh, Error> = Result { throw ResultError.noResult }
    
    private let kite: Grid.Triangle.Kite
    private let colorPalette: ColorPalette
    private let elevation: Grid.Triangle.Kite.Elevation
    private let stencil: Grid.Triangle.Stencil
    
    public init(kite: Grid.Triangle.Kite,
                colorPalette: ColorPalette,
                elevation: Grid.Triangle.Kite.Elevation,
                stencil: Grid.Triangle.Stencil) {
        
        self.kite = kite
        self.colorPalette = colorPalette
        self.elevation = elevation
        self.stencil = stencil
    }
    
    public override func execute() {
        
        do {
            
            let mesh = try kite.mesh(using: stencil,
                                     colorPalette: colorPalette,
                                     elevation: elevation)
            
            output = .success(mesh)
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
