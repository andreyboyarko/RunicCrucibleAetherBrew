import Foundation

enum RunicCrucibleAetherBrewLevelValidator {
    static func RunicCrucibleAetherBrewValidate(_ RunicCrucibleAetherBrewLevels: [RunicCrucibleAetherBrewLevelDefinition]) -> [String] {
        var RunicCrucibleAetherBrewErrors: [String] = []
        if RunicCrucibleAetherBrewLevels.count != 30 { RunicCrucibleAetherBrewErrors.append("The catalog must contain exactly 30 levels.") }
        if Set(RunicCrucibleAetherBrewLevels.map(\.id)).count != RunicCrucibleAetherBrewLevels.count { RunicCrucibleAetherBrewErrors.append("Level identifiers must be unique.") }
        for RunicCrucibleAetherBrewLevel in RunicCrucibleAetherBrewLevels {
            if !(10...30).contains(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.count) { RunicCrucibleAetherBrewErrors.append("Level \(RunicCrucibleAetherBrewLevel.id) must use 10...30 vials.") }
            if RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity < 2 { RunicCrucibleAetherBrewErrors.append("Level \(RunicCrucibleAetherBrewLevel.id) has invalid capacity.") }
            if RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.contains(where: { $0.count > RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity }) { RunicCrucibleAetherBrewErrors.append("Level \(RunicCrucibleAetherBrewLevel.id) overfills a vial.") }
            if !RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewRules.contains(.standard) { RunicCrucibleAetherBrewErrors.append("Level \(RunicCrucibleAetherBrewLevel.id) is missing the standard rule.") }
        }
        return RunicCrucibleAetherBrewErrors
    }
}
