//
//  MainAppView.swift
//  TaskMaster
//
//  Created by sarah leventon on 2025-04-20.
//

import Foundation
import SwiftUI

struct MainAppView: View {
    @State private var isSplashFinished = false

    var body: some View {
        Group {
            if isSplashFinished {
                ContentView()
            } else {
                SplashScreen(isSplashFinished: $isSplashFinished)
            }
        }
    }
}
