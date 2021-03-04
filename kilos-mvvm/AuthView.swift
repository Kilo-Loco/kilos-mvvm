//
//  AuthView.swift
//  kilos-mvvm
//
//  Created by Kilo Loco on 3/4/21.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isSignedIn {
            sessionView()
//                .alert(isPresented: viewModel.currentError, content: {
//                         Text(error.reason)
//                })
        } else {
            webSignInView()
        }
    }
    
    func webSignInView() -> some View {
        Button("sign in", action: {})
    }
    
    func sessionView() -> some View {
        Text("hello username")
    }
}

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    @Published var currentError: Error?
    
    private let authService: AuthService
    
    init(manager: DependencyManager = MyAppDependencyManager.shared) {
        self.authService = manager.authService
        attemptAutoSignIn()
    }
    
    func attemptAutoSignIn() {
        isSignedIn = authService.checkIsSignedIn()
        // sink { self.currentError = completion.error
        // sink { isSigned in
    }
    
    func observeCurrentUser() {
        // authService.user
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
