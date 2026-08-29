import UIKit
import SwiftUI

enum RunicCrucibleAetherBrewTab: Int {
    case RunicCrucibleAetherBrewHome
    case RunicCrucibleAetherBrewBrew
    case RunicCrucibleAetherBrewGrimoire
    case RunicCrucibleAetherBrewStatistics
    case RunicCrucibleAetherBrewSettings
}

@main
final class RunicCrucibleAetherBrewAppDelegate: UIResponder, UIApplicationDelegate {
    static weak var RunicCrucibleAetherBrewShared: RunicCrucibleAetherBrewAppDelegate?
    var RunicCrucibleAetherBrewWindow: UIWindow?

    func application(_ RunicCrucibleAetherBrewApplication: UIApplication, didFinishLaunchingWithOptions RunicCrucibleAetherBrewLaunchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        RunicCrucibleAetherBrewAppDelegate.RunicCrucibleAetherBrewShared = self
#if DEBUG
        assert(RunicCrucibleAetherBrewLevelValidator.RunicCrucibleAetherBrewValidate(RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()).isEmpty)
        let RunicCrucibleAetherBrewFirstLevel = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()[0]
        let RunicCrucibleAetherBrewFirstEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewFirstLevel)
        assert(RunicCrucibleAetherBrewFirstEngine.RunicCrucibleAetherBrewCanMove(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 8)))
#endif
        let RunicCrucibleAetherBrewWindow = UIWindow(frame: UIScreen.main.bounds)
        self.RunicCrucibleAetherBrewWindow = RunicCrucibleAetherBrewWindow
        RunicCrucibleAetherBrewWindow.rootViewController = UIHostingController(rootView: RunicCrucibleAetherBrewLoadingView())
        RunicCrucibleAetherBrewWindow.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [weak self] in self?.RunicCrucibleAetherBrewPresentInitialFlow() }
        return true
    }

    private func RunicCrucibleAetherBrewPresentInitialFlow() {
        guard UserDefaults.standard.bool(forKey: "RunicCrucibleAetherBrewOnboardingComplete") else {
            RunicCrucibleAetherBrewWindow?.rootViewController = UIHostingController(rootView: RunicCrucibleAetherBrewOnboardingView(RunicCrucibleAetherBrewCompletion: { [weak self] in self?.RunicCrucibleAetherBrewShowTabs() }))
            return
        }
        RunicCrucibleAetherBrewShowTabs()
    }

    func RunicCrucibleAetherBrewShowTabs() {
        let RunicCrucibleAetherBrewTabBar = UITabBarController()
        RunicCrucibleAetherBrewTabBar.viewControllers = [
            RunicCrucibleAetherBrewMakeTab(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewHomeMapView(), RunicCrucibleAetherBrewTitle: "Home", RunicCrucibleAetherBrewSymbol: "map.fill"),
            RunicCrucibleAetherBrewMakeTab(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewGameView(), RunicCrucibleAetherBrewTitle: "Brew", RunicCrucibleAetherBrewSymbol: "flask.fill"),
            RunicCrucibleAetherBrewMakeTab(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewGrimoireView(), RunicCrucibleAetherBrewTitle: "Grimoire", RunicCrucibleAetherBrewSymbol: "books.vertical.fill"),
            RunicCrucibleAetherBrewMakeTab(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewStatisticsView(), RunicCrucibleAetherBrewTitle: "Stats", RunicCrucibleAetherBrewSymbol: "chart.bar.fill"),
            RunicCrucibleAetherBrewMakeTab(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewSettingsView(), RunicCrucibleAetherBrewTitle: "Settings", RunicCrucibleAetherBrewSymbol: "gearshape.fill")
        ]
        RunicCrucibleAetherBrewTabBar.tabBar.tintColor = UIColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
        RunicCrucibleAetherBrewTabBar.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.55)
        RunicCrucibleAetherBrewTabBar.tabBar.isTranslucent = true
        let RunicCrucibleAetherBrewTabAppearance = UITabBarAppearance()
        RunicCrucibleAetherBrewTabAppearance.configureWithTransparentBackground()
        RunicCrucibleAetherBrewTabAppearance.backgroundEffect = nil
        RunicCrucibleAetherBrewTabAppearance.backgroundColor = UIColor(
            red: 0.025,
            green: 0.018,
            blue: 0.065,
            alpha: 0.70
        )
        RunicCrucibleAetherBrewTabAppearance.shadowColor = UIColor.white.withAlphaComponent(0.08)
        RunicCrucibleAetherBrewTabBar.tabBar.standardAppearance = RunicCrucibleAetherBrewTabAppearance
        if #available(iOS 15.0, *) {
            RunicCrucibleAetherBrewTabBar.tabBar.scrollEdgeAppearance = RunicCrucibleAetherBrewTabAppearance
        }
        RunicCrucibleAetherBrewTabBar.selectedIndex = 0
        RunicCrucibleAetherBrewWindow?.rootViewController = RunicCrucibleAetherBrewTabBar
    }

    func RunicCrucibleAetherBrewReplayOnboarding() {
        RunicCrucibleAetherBrewWindow?.rootViewController = UIHostingController(rootView: RunicCrucibleAetherBrewOnboardingView(RunicCrucibleAetherBrewCompletion: { [weak self] in self?.RunicCrucibleAetherBrewShowTabs() }))
    }

    func RunicCrucibleAetherBrewSelectTab(_ RunicCrucibleAetherBrewTab: RunicCrucibleAetherBrewTab) {
        guard let RunicCrucibleAetherBrewController = RunicCrucibleAetherBrewWindow?.rootViewController as? UITabBarController else { return }
        RunicCrucibleAetherBrewController.selectedIndex = RunicCrucibleAetherBrewTab.rawValue
    }

    func RunicCrucibleAetherBrewSetTabInteractionEnabled(_ RunicCrucibleAetherBrewIsEnabled: Bool) {
        (RunicCrucibleAetherBrewWindow?.rootViewController as? UITabBarController)?.tabBar.isUserInteractionEnabled = RunicCrucibleAetherBrewIsEnabled
    }

    private func RunicCrucibleAetherBrewMakeTab<RunicCrucibleAetherBrewContent: View>(RunicCrucibleAetherBrewView: RunicCrucibleAetherBrewContent, RunicCrucibleAetherBrewTitle: String, RunicCrucibleAetherBrewSymbol: String) -> UIViewController {
        let RunicCrucibleAetherBrewController = UIHostingController(rootView: NavigationView { RunicCrucibleAetherBrewView }.navigationViewStyle(.stack))
        RunicCrucibleAetherBrewController.tabBarItem = UITabBarItem(title: RunicCrucibleAetherBrewTitle, image: UIImage(systemName: RunicCrucibleAetherBrewSymbol), selectedImage: nil)
        return RunicCrucibleAetherBrewController
    }
}
