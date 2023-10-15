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
        
                viewer
            }
        #else
            viewer
        #endif
    }
    
    var viewer: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            sceneView
            
            Text("Polygons: [\(viewModel.profile.polygonCount)] Vertices: [\(viewModel.profile.vertexCount)]")
                .foregroundColor(.black)
                .padding()
        }
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
        
        Picker("Terrain Type",
               selection: $viewModel.terrainType) {
            
            ForEach(TerrainType.allCases, id: \.self) { terrainType in
                
                Text(terrainType.id.capitalized)
                    .id(terrainType)
            }
        }
        
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
