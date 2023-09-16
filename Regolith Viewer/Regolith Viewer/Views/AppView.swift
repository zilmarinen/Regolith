//
//  AppView.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Bivouac
import SceneKit
import SwiftUI

struct AppView: View {
    
    @ObservedObject private var viewModel = AppViewModel()
    
    var body: some View {
        
        #if os(iOS)
            NavigationStack {
        
                sceneView
            }
        #else
            sceneView
        #endif
    }
    
    var sceneView: some View {
        
        SceneView(scene: viewModel.scene,
                  pointOfView: viewModel.scene.camera.pov,
                  options: [.allowsCameraControl,
                            .autoenablesDefaultLighting])
        .toolbar {
            
            ToolbarItemGroup {
                
                toolbar
            }
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        
        Picker("Kite",
               selection: $viewModel.kite) {
            
            ForEach(Grid.Triangle.Kite.allCases, id: \.self) { kite in
                
                Text(kite.id.capitalized)
                    .id(kite)
            }
        }
        
        Picker("Elevation",
               selection: $viewModel.elevation) {
            
            ForEach(Grid.Triangle.Kite.Elevation.allCases, id: \.self) { elevation in
                
                Text(elevation.id.capitalized)
                    .id(elevation)
            }
        }
    }
}
