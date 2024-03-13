//
//  BiometricDemoApp.swift
//  Dynamic Styling POC
//

import BiometricAuthenticationFeature
import Common
import CommonUI
import SwiftUI

@main
struct BiometricDemoApp: App {
    let registrationNavigator: UINavigationController
    let authenticationNavigator: UINavigationController
    let registrationFlow: FlowCoordinator
    let authenticationFlow: FlowCoordinator
    let authenticationRouter: NavigationRouter!
    let registrationRouter: NavigationRouter!

    init() {
        registrationNavigator = UINavigationController()
        authenticationNavigator = UINavigationController()
        authenticationRouter = LiveNavigationRouter()
        registrationRouter = LiveNavigationRouter()
        registrationFlow = BiometricAuthenticationFeatureFactory.makeBiometricAuthenticationFlowCoordinator(
            workMode: .registration,
            navigator: registrationNavigator,
            parentFlow: nil
        )
        authenticationFlow = BiometricAuthenticationFeatureFactory.makeBiometricAuthenticationFlowCoordinator(
            workMode: .authentication,
            navigator: authenticationNavigator,
            parentFlow: nil
        )
        initializeDependencies()
        authenticationRouter.start(initialFlow: authenticationFlow, animated: false)
        registrationRouter.start(initialFlow: registrationFlow, animated: false)
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                ZStack {
                    authenticationNavigator.swiftUIView
                }
                .tabItem { TabLabel(imageName: "key.fill", label: "Authenticate") }

                ZStack {
                    registrationNavigator.swiftUIView
                }
                .tabItem { TabLabel(imageName: "record.circle.fill", label: "Record") }

                VStack {
                    Form {
                        Section(header: Text("Keychain")) {
                            HStack {
                                Text("Keychain")
                                Spacer()
                                Button("Clear") {
                                    clearKeychain()
                                }
                            }
                            HStack {
                                Text("InMemoryStorage")
                                Spacer()
                                Button("Clear") {
                                    clearInMemoryStorage()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .tabItem { TabLabel(imageName: "gear.circle", label: "Settings") }
            }
        }
    }
}

extension BiometricDemoApp {
    func initializeDependencies() {
        let dependencyManager = LiveDependencyManager.shared as? DependencyManager
        let storage = UserDefaults(suiteName: "OnboardingDemoApp") ?? .standard
        let inMemoryStorage = LiveInMemoryStorage()
        inMemoryStorage.setValue("token", forKey: .refreshToken)
        let biometricStorage = LiveBiometricStorage()
        let biometricAccessProvider = LiveBiometricAccessProvider()
        let userStatusProvider = LiveUserStatusProvider(storage: storage, inMemoryStorage: inMemoryStorage)
        let networkModule = NetworkingFactory.makeNetworkModule(baseURL: URL(string: "https://whg.com")!)
        let appStyleProvider = LiveAppStyleProvider(
            appStyleSynchroniser: LiveAppStyleSynchroniser(networkModule: networkModule),
            initialAppStyle: AppStyle(initialDesignSystem: .default, intialComponents: .default)
        )
        dependencyManager?.register(biometricAccessProvider, for: BiometricAccessProvider.self)
        dependencyManager?.register(storage, for: LocalStorage.self)
        dependencyManager?.register(inMemoryStorage, for: InMemoryStorage.self)
        dependencyManager?.register(biometricStorage, for: BiometricStorage.self)
        dependencyManager?.register(networkModule, for: NetworkModule.self)
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependencyManager?.register(appStyleProvider, for: AppStyleProvider.self)
        dependencyManager?.register(userStatusProvider, for: UserStatusProvider.self)
    }

    func clearKeychain() {
        Task {
            let storage: BiometricStorage = LiveDependencyManager.shared.resolve()
            try? await storage.clear(itemAt: .refreshToken)
        }
    }

    func clearInMemoryStorage() {
        let storage: InMemoryStorage = LiveDependencyManager.shared.resolve()
        storage.removeValue(forKey: .refreshToken)
    }

    struct TabLabel: View {
        let imageName: String
        let label: String

        var body: some View {
            VStack {
                Image(systemName: imageName)
                Text(label)
            }
        }
    }
}
