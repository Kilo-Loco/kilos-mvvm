//
//  ContentView.swift
//  kilos-mvvm
//
//  Created by Kilo Loco on 3/4/21.
//

import Combine
import SwiftUI

protocol DataService {
    func getUser()
}

class AmplifyDataService: DataService {
    func getUser() {
        // Amplify.DataStore.query
    }
}

protocol StorageService {
    func listFiles()
}

class AmplifyStorageService: StorageService {
    func listFiles() {
        // Amplify.Storage.list
    }
}

protocol AuthService {
    func checkIsSignedIn() -> Bool
}

class AmplifyAuthService: AuthService {
    
    init() {
        checkIsSignedIn()
    }
    
    func checkIsSignedIn() -> Bool {
        return true
    }
    
    func getCurrentUser() -> Any {
        // Amplify.Auth.fetchCurrentSession
        // Amplify.DataStore.query(User.self, byId: fetchedUserId)
        return "user"
    }
}

protocol DependencyManager {
    var dataService: DataService { get }
    var storageService: StorageService { get }
    var authService: AuthService { get }
}

class MyAppDependencyManager: DependencyManager, ObservableObject {
    private init() {}
    static let shared = MyAppDependencyManager()
    let dataService: DataService = AmplifyDataService()
    let storageService: StorageService = AmplifyStorageService()
    let authService: AuthService = AmplifyAuthService()
}

struct UserProfileView: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = ViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button("Hello, world!", action: viewModel.getCurrentUser)
            .padding()
    }
}

extension UserProfileView {
    class ViewModel: ObservableObject {
        @Published var user: Any?
        
        private let dataService: DataService
        private let storageService: StorageService
        
        init(manager: DependencyManager = MyAppDependencyManager.shared) {
            self.dataService = manager.dataService
            self.storageService = manager.storageService
        }
        
        func getCurrentUser() {
            dataService.getUser()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserProfileView.ViewModel()
        viewModel.user = "Kilo Loco"
        return UserProfileView(viewModel: viewModel)
    }
}
