//
//  AppView.swift
//
//  Created by Zack Brown on 27/08/2023.
//

import Deltille
import Regolith
import SceneKit
import SwiftUI

internal struct AppView: View {
    
    @ObservedObject private var viewModel = AppViewModel()
    
    internal var body: some View {
        
        #if os(iOS)
            NavigationStack {
        
                viewer
            }
        #else
            viewer
        #endif
    }
    
    private var viewer: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            sceneView
        }
    }
    
    private var sceneView: some View {
        
        SceneView(scene: viewModel.scene,
                  options: [.allowsCameraControl,
                            .autoenablesDefaultLighting])
        .toolbar {
            
            ToolbarItemGroup {
                
                toolbar
            }
        }
    }
    
    @ViewBuilder
    private var toolbar: some View {
        
        Picker("Kite",
               selection: $viewModel.kite) {
            
            ForEach(Triangle.Kite.allCases, id: \.self) { kite in
                
                Text(kite.id)
                    .id(kite)
            }
        }
    }
}
