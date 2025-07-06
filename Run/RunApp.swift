import SwiftUI
import SwiftData
import Voyager

@main
struct RunApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        print(">>> start app")
        RateManager.shared.incrementCount()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MainView()
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    switch newPhase {
                    case .background:
                        print("ScenePhase: Background from \(oldPhase)")
                    case .inactive:
                        print("ScenePhase: Inactive from \(oldPhase)")
                    case .active:
                        print("ScenePhase: Active/Foreground from \(oldPhase)")
                    @unknown default:
                        print("ScenePhase: Unknown scene phase \(newPhase) from \(oldPhase)")
                    }
                }
        }
    }
}
