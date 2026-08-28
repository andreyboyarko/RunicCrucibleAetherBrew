import UIKit
import AudioToolbox

enum RunicCrucibleAetherBrewFeedbackManager {
    static func RunicCrucibleAetherBrewSelection() { guard UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewSound") as? Bool ?? true else { return }; AudioServicesPlaySystemSound(1104); if UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewHaptics") as? Bool ?? true { UISelectionFeedbackGenerator().selectionChanged() } }
    static func RunicCrucibleAetherBrewInvalid() { guard UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewSound") as? Bool ?? true else { return }; AudioServicesPlaySystemSound(1053); if UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewHaptics") as? Bool ?? true { UINotificationFeedbackGenerator().notificationOccurred(.warning) } }
    static func RunicCrucibleAetherBrewReaction() { guard UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewSound") as? Bool ?? true else { return }; AudioServicesPlaySystemSound(1111); if UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewHaptics") as? Bool ?? true { UIImpactFeedbackGenerator(style: .medium).impactOccurred() } }
    static func RunicCrucibleAetherBrewVictory() { guard UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewSound") as? Bool ?? true else { return }; AudioServicesPlaySystemSound(1025); if UserDefaults.standard.object(forKey: "RunicCrucibleAetherBrewHaptics") as? Bool ?? true { UINotificationFeedbackGenerator().notificationOccurred(.success) } }
}
