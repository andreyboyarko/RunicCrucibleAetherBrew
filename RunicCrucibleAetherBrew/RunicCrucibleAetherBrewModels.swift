import Foundation
import SwiftUI

enum RunicCrucibleAetherBrewLiquidType: String, Codable, CaseIterable, Identifiable, Hashable {
    case fire, frost, nature, aether, light, shadow, void, water
    var id: String { rawValue }
    var RunicCrucibleAetherBrewName: String { rawValue.capitalized }
    var RunicCrucibleAetherBrewSymbol: String { switch self { case .fire: return "flame.fill"; case .frost: return "snowflake"; case .nature: return "leaf.fill"; case .aether: return "sparkles"; case .light: return "sun.max.fill"; case .shadow: return "moon.fill"; case .void: return "circle.hexagongrid.fill"; case .water: return "drop.fill" } }
    var RunicCrucibleAetherBrewEmoji: String { switch self { case .fire: return "🔥"; case .frost: return "❄️"; case .nature: return "🌿"; case .aether: return "✨"; case .light: return "☀️"; case .shadow: return "🌙"; case .void: return "🕳️"; case .water: return "💧" } }
    var RunicCrucibleAetherBrewColor: Color { switch self { case .fire: return .orange; case .frost: return .cyan; case .nature: return .green; case .aether: return Color(red: 0.92, green: 0.20, blue: 0.82); case .light: return .yellow; case .shadow: return Color(red: 0.30, green: 0.28, blue: 0.78); case .void: return Color(red: 0.10, green: 0.02, blue: 0.16); case .water: return .blue } }
    var RunicCrucibleAetherBrewDescription: String { switch self { case .fire: return "A bright essence sorted like any other."; case .frost: return "Seals a vial for one turn."; case .nature: return "Blooms when joined with Water."; case .aether: return "Copies nearby magic."; case .light: return "Cannot touch Shadow."; case .shadow: return "Cannot touch Light."; case .void: return "Absorbs one essence, then rests."; case .water: return "A calm base for many brews." } }
}

struct RunicCrucibleAetherBrewLiquidLayer: Codable, Equatable, Hashable, Identifiable {
    let id: UUID
    var RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType
    var RunicCrucibleAetherBrewIsEmpowered: Bool
    init(RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType, RunicCrucibleAetherBrewIsEmpowered: Bool = false) { id = UUID(); self.RunicCrucibleAetherBrewType = RunicCrucibleAetherBrewType; self.RunicCrucibleAetherBrewIsEmpowered = RunicCrucibleAetherBrewIsEmpowered }
}

struct RunicCrucibleAetherBrewVial: Codable, Equatable, Identifiable {
    let id: UUID
    var RunicCrucibleAetherBrewLayers: [RunicCrucibleAetherBrewLiquidLayer]
    var RunicCrucibleAetherBrewCapacity: Int
    var RunicCrucibleAetherBrewFrozenTurns: Int
    var RunicCrucibleAetherBrewVoidIsSpent: Bool
    init(RunicCrucibleAetherBrewTypes: [RunicCrucibleAetherBrewLiquidType], RunicCrucibleAetherBrewCapacity: Int = 4) { id = UUID(); RunicCrucibleAetherBrewLayers = RunicCrucibleAetherBrewTypes.map { .init(RunicCrucibleAetherBrewType: $0) }; self.RunicCrucibleAetherBrewCapacity = RunicCrucibleAetherBrewCapacity; RunicCrucibleAetherBrewFrozenTurns = 0; RunicCrucibleAetherBrewVoidIsSpent = false }
}

struct RunicCrucibleAetherBrewMove: Codable, Equatable { let RunicCrucibleAetherBrewSource: Int; let RunicCrucibleAetherBrewDestination: Int }
struct RunicCrucibleAetherBrewTransferPlan: Codable, Equatable {
    let RunicCrucibleAetherBrewSource: Int
    let RunicCrucibleAetherBrewDestination: Int
    let RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType
    let RunicCrucibleAetherBrewCount: Int
}
enum RunicCrucibleAetherBrewRule: String, Codable, CaseIterable { case standard, fire, frost, nature, polarity, aether, void }
extension RunicCrucibleAetherBrewRule {
    var RunicCrucibleAetherBrewTitle: String { rawValue.capitalized }
    var RunicCrucibleAetherBrewSymbol: String { switch self { case .standard: return "arrow.left.arrow.right"; case .fire: return "flame.fill"; case .frost: return "snowflake"; case .nature: return "leaf.fill"; case .polarity: return "circle.lefthalf.filled"; case .aether: return "sparkles"; case .void: return "circle.hexagongrid.fill" } }
    var RunicCrucibleAetherBrewExplanation: String { switch self { case .standard: return "Pour only into an empty vial or onto the same essence."; case .fire: return "Fire remains stable and is sorted with matching Fire."; case .frost: return "Frost seals its vial for one turn."; case .nature: return "Nature and Water bloom into empowered Nature."; case .polarity: return "Light and Shadow cannot touch."; case .aether: return "Aether copies a different essence beneath it."; case .void: return "Void absorbs one different essence, then becomes inert." } }
}
enum RunicCrucibleAetherBrewReactionKind: String, Codable { case poured, evaporated, frozen, thawed, empowered, copied, absorbed }
struct RunicCrucibleAetherBrewReaction: Codable, Equatable { let RunicCrucibleAetherBrewKind: RunicCrucibleAetherBrewReactionKind; let RunicCrucibleAetherBrewVialIndex: Int; let RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType? }
struct RunicCrucibleAetherBrewPotionGoal: Codable, Equatable { let RunicCrucibleAetherBrewName: String; let RunicCrucibleAetherBrewSymbol: String }
struct RunicCrucibleAetherBrewLevelDefinition: Codable, Identifiable { let id: Int; let RunicCrucibleAetherBrewTitle: String; let RunicCrucibleAetherBrewTutorial: String; let RunicCrucibleAetherBrewCapacity: Int; let RunicCrucibleAetherBrewVials: [[RunicCrucibleAetherBrewLiquidType]]; let RunicCrucibleAetherBrewRules: [RunicCrucibleAetherBrewRule]; let RunicCrucibleAetherBrewHintLimit: Int; let RunicCrucibleAetherBrewGoal: RunicCrucibleAetherBrewPotionGoal }
struct RunicCrucibleAetherBrewGameState: Codable, Equatable { var RunicCrucibleAetherBrewVials: [RunicCrucibleAetherBrewVial]; var RunicCrucibleAetherBrewMoves: Int; var RunicCrucibleAetherBrewHintsUsed: Int; var RunicCrucibleAetherBrewIsWon: Bool }
struct RunicCrucibleAetherBrewMoveResult {
    let RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState
    let RunicCrucibleAetherBrewReactions: [RunicCrucibleAetherBrewReaction]
    let RunicCrucibleAetherBrewTransferPlan: RunicCrucibleAetherBrewTransferPlan
    let RunicCrucibleAetherBrewSourceVial: RunicCrucibleAetherBrewVial
    let RunicCrucibleAetherBrewDestinationVial: RunicCrucibleAetherBrewVial
}

enum RunicCrucibleAetherBrewMoveRejection: String {
    case RunicCrucibleAetherBrewSameVial = "Choose another vial"
    case RunicCrucibleAetherBrewEmptySource = "Source vial is empty"
    case RunicCrucibleAetherBrewFullDestination = "Vial is full"
    case RunicCrucibleAetherBrewFrozen = "Vial is frozen — make another move to thaw it"
    case RunicCrucibleAetherBrewPolarity = "Light cannot touch Shadow"
    case RunicCrucibleAetherBrewEssenceMismatch = "Essences do not match"
}

enum RunicCrucibleAetherBrewInteractionResult {
    case RunicCrucibleAetherBrewSelected(RunicCrucibleAetherBrewIndex: Int)
    case RunicCrucibleAetherBrewDeselected(RunicCrucibleAetherBrewIndex: Int)
    case RunicCrucibleAetherBrewInvalid(RunicCrucibleAetherBrewSource: Int, RunicCrucibleAetherBrewDestination: Int, RunicCrucibleAetherBrewReason: String)
    case RunicCrucibleAetherBrewPour(RunicCrucibleAetherBrewMove: RunicCrucibleAetherBrewMove, RunicCrucibleAetherBrewResult: RunicCrucibleAetherBrewMoveResult)
    case RunicCrucibleAetherBrewIgnored
}

enum RunicCrucibleAetherBrewLevelCatalog {
    static func RunicCrucibleAetherBrewShuffledVials(for RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition) -> [[RunicCrucibleAetherBrewLiquidType]] {
        let RunicCrucibleAetherBrewFilledVialCount = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.filter { !$0.isEmpty }.count
        let RunicCrucibleAetherBrewEmptyVialCount = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.count - RunicCrucibleAetherBrewFilledVialCount
        let RunicCrucibleAetherBrewCapacity = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity
        let RunicCrucibleAetherBrewAllLayers = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.flatMap { $0 }
        var RunicCrucibleAetherBrewBestVials = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials
        var RunicCrucibleAetherBrewBestPatternScore = Int.max

        // Sample the whole level rather than rotating small fixed groups. Keeping the
        // least patterned candidate makes horizontal, vertical and diagonal staircases
        // extremely unlikely while preserving every individual essence layer.
        for _ in 0..<512 {
            let RunicCrucibleAetherBrewLayers = RunicCrucibleAetherBrewAllLayers.shuffled()
            var RunicCrucibleAetherBrewCandidate: [[RunicCrucibleAetherBrewLiquidType]] = stride(from: 0, to: RunicCrucibleAetherBrewLayers.count, by: RunicCrucibleAetherBrewCapacity).map {
                Array(RunicCrucibleAetherBrewLayers[$0..<min($0 + RunicCrucibleAetherBrewCapacity, RunicCrucibleAetherBrewLayers.count)])
            }
            guard RunicCrucibleAetherBrewCandidate.count == RunicCrucibleAetherBrewFilledVialCount else { continue }
            var RunicCrucibleAetherBrewPatternScore = 0
            for RunicCrucibleAetherBrewVial in RunicCrucibleAetherBrewCandidate {
                RunicCrucibleAetherBrewPatternScore += zip(RunicCrucibleAetherBrewVial, RunicCrucibleAetherBrewVial.dropFirst()).filter(==).count * 20
            }
            for RunicCrucibleAetherBrewVialIndex in 1..<RunicCrucibleAetherBrewCandidate.count {
                let RunicCrucibleAetherBrewPrevious = RunicCrucibleAetherBrewCandidate[RunicCrucibleAetherBrewVialIndex - 1]
                let RunicCrucibleAetherBrewCurrent = RunicCrucibleAetherBrewCandidate[RunicCrucibleAetherBrewVialIndex]
                for RunicCrucibleAetherBrewLayerIndex in 0..<min(RunicCrucibleAetherBrewPrevious.count, RunicCrucibleAetherBrewCurrent.count) {
                    if RunicCrucibleAetherBrewPrevious[RunicCrucibleAetherBrewLayerIndex] == RunicCrucibleAetherBrewCurrent[RunicCrucibleAetherBrewLayerIndex] { RunicCrucibleAetherBrewPatternScore += 3 }
                    if RunicCrucibleAetherBrewLayerIndex > 0, RunicCrucibleAetherBrewPrevious[RunicCrucibleAetherBrewLayerIndex - 1] == RunicCrucibleAetherBrewCurrent[RunicCrucibleAetherBrewLayerIndex] { RunicCrucibleAetherBrewPatternScore += 1 }
                }
            }
            guard RunicCrucibleAetherBrewCandidate != Array(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.prefix(RunicCrucibleAetherBrewFilledVialCount)) else { continue }
            RunicCrucibleAetherBrewCandidate.append(contentsOf: Array(repeating: [], count: RunicCrucibleAetherBrewEmptyVialCount))
            if RunicCrucibleAetherBrewPatternScore < RunicCrucibleAetherBrewBestPatternScore {
                RunicCrucibleAetherBrewBestPatternScore = RunicCrucibleAetherBrewPatternScore
                RunicCrucibleAetherBrewBestVials = RunicCrucibleAetherBrewCandidate
                if RunicCrucibleAetherBrewPatternScore == 0 { break }
            }
        }
        return RunicCrucibleAetherBrewBestVials
    }

    static func RunicCrucibleAetherBrewLoad() -> [RunicCrucibleAetherBrewLevelDefinition] {
        guard let RunicCrucibleAetherBrewURL = Bundle.main.url(forResource: "RunicCrucibleAetherBrewLevels", withExtension: "json"), let RunicCrucibleAetherBrewData = try? Data(contentsOf: RunicCrucibleAetherBrewURL), let RunicCrucibleAetherBrewLevels = try? JSONDecoder().decode([RunicCrucibleAetherBrewLevelDefinition].self, from: RunicCrucibleAetherBrewData), RunicCrucibleAetherBrewLevels.count == 30 else { return RunicCrucibleAetherBrewFallbackLevels().map(RunicCrucibleAetherBrewExpanded) }
        return RunicCrucibleAetherBrewLevels.map(RunicCrucibleAetherBrewExpanded)
    }
    private static func RunicCrucibleAetherBrewExpanded(_ RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition) -> RunicCrucibleAetherBrewLevelDefinition {
        let RunicCrucibleAetherBrewTypes = RunicCrucibleAetherBrewLiquidType.allCases
        let RunicCrucibleAetherBrewShift = (RunicCrucibleAetherBrewLevel.id - 1) % RunicCrucibleAetherBrewTypes.count
        let RunicCrucibleAetherBrewTotalVialCount: Int
        switch RunicCrucibleAetherBrewLevel.id {
        case 1...3: RunicCrucibleAetherBrewTotalVialCount = 10
        case 4...6: RunicCrucibleAetherBrewTotalVialCount = 12
        case 7...9: RunicCrucibleAetherBrewTotalVialCount = 14
        case 10...12: RunicCrucibleAetherBrewTotalVialCount = 16
        case 13...15: RunicCrucibleAetherBrewTotalVialCount = 18
        case 16...18: RunicCrucibleAetherBrewTotalVialCount = 20
        case 19...21: RunicCrucibleAetherBrewTotalVialCount = 22
        case 22...24: RunicCrucibleAetherBrewTotalVialCount = 24
        case 25...27: RunicCrucibleAetherBrewTotalVialCount = 26
        case 28...29: RunicCrucibleAetherBrewTotalVialCount = 30
        default: RunicCrucibleAetherBrewTotalVialCount = 30
        }
        let RunicCrucibleAetherBrewEmptyVialCount = (28...29).contains(RunicCrucibleAetherBrewLevel.id) ? 4 : 2
        let RunicCrucibleAetherBrewFilledVialCount = RunicCrucibleAetherBrewTotalVialCount - RunicCrucibleAetherBrewEmptyVialCount
        var RunicCrucibleAetherBrewVials: [[RunicCrucibleAetherBrewLiquidType]] = []
        if RunicCrucibleAetherBrewLevel.id >= 2 {
            let RunicCrucibleAetherBrewBlockCount = RunicCrucibleAetherBrewFilledVialCount / 4
            for RunicCrucibleAetherBrewBlockIndex in 0..<RunicCrucibleAetherBrewBlockCount {
                let RunicCrucibleAetherBrewBlockTypes = (0..<4).map { RunicCrucibleAetherBrewOffset in
                    RunicCrucibleAetherBrewTypes[(RunicCrucibleAetherBrewShift + RunicCrucibleAetherBrewBlockIndex * 3 + RunicCrucibleAetherBrewOffset) % RunicCrucibleAetherBrewTypes.count]
                }
                for RunicCrucibleAetherBrewVialOffset in 0..<4 {
                    RunicCrucibleAetherBrewVials.append((0..<4).map { RunicCrucibleAetherBrewLayerOffset in
                        RunicCrucibleAetherBrewBlockTypes[(RunicCrucibleAetherBrewVialOffset + RunicCrucibleAetherBrewLayerOffset) % 4]
                    })
                }
            }
            if RunicCrucibleAetherBrewFilledVialCount.isMultiple(of: 4) == false {
                let RunicCrucibleAetherBrewFirstType = RunicCrucibleAetherBrewTypes[(RunicCrucibleAetherBrewShift + RunicCrucibleAetherBrewBlockCount * 3) % RunicCrucibleAetherBrewTypes.count]
                let RunicCrucibleAetherBrewSecondType = RunicCrucibleAetherBrewTypes[(RunicCrucibleAetherBrewShift + RunicCrucibleAetherBrewBlockCount * 3 + 1) % RunicCrucibleAetherBrewTypes.count]
                RunicCrucibleAetherBrewVials.append([RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewSecondType])
                RunicCrucibleAetherBrewVials.append([RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewFirstType])
            }
        } else {
            for RunicCrucibleAetherBrewPairIndex in 0..<(RunicCrucibleAetherBrewFilledVialCount / 2) {
                let RunicCrucibleAetherBrewFirstTypeIndex = (RunicCrucibleAetherBrewPairIndex * 2 + RunicCrucibleAetherBrewShift) % RunicCrucibleAetherBrewTypes.count
                let RunicCrucibleAetherBrewSecondTypeIndex = (RunicCrucibleAetherBrewFirstTypeIndex + 1) % RunicCrucibleAetherBrewTypes.count
                let RunicCrucibleAetherBrewFirstType = RunicCrucibleAetherBrewTypes[RunicCrucibleAetherBrewFirstTypeIndex]
                let RunicCrucibleAetherBrewSecondType = RunicCrucibleAetherBrewTypes[RunicCrucibleAetherBrewSecondTypeIndex]
                RunicCrucibleAetherBrewVials.append([RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewFirstType, RunicCrucibleAetherBrewSecondType])
                RunicCrucibleAetherBrewVials.append([RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewSecondType, RunicCrucibleAetherBrewFirstType])
            }
        }
        RunicCrucibleAetherBrewVials.append(contentsOf: Array(repeating: [], count: RunicCrucibleAetherBrewEmptyVialCount))
        return .init(
            id: RunicCrucibleAetherBrewLevel.id,
            RunicCrucibleAetherBrewTitle: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTitle,
            RunicCrucibleAetherBrewTutorial: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTutorial,
            RunicCrucibleAetherBrewCapacity: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity,
            RunicCrucibleAetherBrewVials: RunicCrucibleAetherBrewVials,
            RunicCrucibleAetherBrewRules: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewRules,
            RunicCrucibleAetherBrewHintLimit: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewHintLimit,
            RunicCrucibleAetherBrewGoal: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewGoal
        )
    }
    static func RunicCrucibleAetherBrewFallbackLevels() -> [RunicCrucibleAetherBrewLevelDefinition] {
        (1...30).map { RunicCrucibleAetherBrewID in .init(id: RunicCrucibleAetherBrewID, RunicCrucibleAetherBrewTitle: "Arcane Trial \(RunicCrucibleAetherBrewID)", RunicCrucibleAetherBrewTutorial: "Sort each essence into a pure vial.", RunicCrucibleAetherBrewCapacity: 4, RunicCrucibleAetherBrewVials: [[.water, .fire, .water, .fire], [.fire, .water, .fire, .water], [], []], RunicCrucibleAetherBrewRules: [.standard], RunicCrucibleAetherBrewHintLimit: 3, RunicCrucibleAetherBrewGoal: .init(RunicCrucibleAetherBrewName: "Pure Essence", RunicCrucibleAetherBrewSymbol: "flask.fill")) }
    }
}
