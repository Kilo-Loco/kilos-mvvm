//
//  kilos_mvvmApp.swift
//  kilos-mvvm
//
//  Created by Kilo Loco on 3/4/21.
//

import SwiftUI

@main
struct kilos_mvvmApp: App {
    
    @ObservedObject var dependencyManager = MyAppDependencyManager.shared
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
