import SwiftUI
import Combine

@MainActor
final class RunicCrucibleAetherBrewGameViewModel: ObservableObject {
    static let RunicCrucibleAetherBrewShared = RunicCrucibleAetherBrewGameViewModel()

    @Published private(set) var RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState
    @Published private(set) var RunicCrucibleAetherBrewMessage = "Choose a vial to begin."
    @Published private(set) var RunicCrucibleAetherBrewIsAnimating = false
    @Published private(set) var RunicCrucibleAetherBrewIsSolvingHint = false
    @Published var RunicCrucibleAetherBrewShowsRules = false

    private(set) var RunicCrucibleAetherBrewLevels = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()
    private(set) var RunicCrucibleAetherBrewLevelIndex: Int
    private var RunicCrucibleAetherBrewEngine: RunicCrucibleAetherBrewGameEngine
    private var RunicCrucibleAetherBrewSelectedIndex: Int?
    private var RunicCrucibleAetherBrewPendingResult: RunicCrucibleAetherBrewMoveResult?
    private var RunicCrucibleAetherBrewAttemptUsedHint = false
    private var RunicCrucibleAetherBrewAttemptUsedUndo = false

    var RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition {
        RunicCrucibleAetherBrewLevels[RunicCrucibleAetherBrewLevelIndex]
    }

    private init() {
        let RunicCrucibleAetherBrewIndex = max(0, RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewLastLevel - 1)
        RunicCrucibleAetherBrewLevelIndex = RunicCrucibleAetherBrewIndex
        RunicCrucibleAetherBrewEngine = .init(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevels[RunicCrucibleAetherBrewIndex])
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
    }

    func RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewLevelNumber: Int) {
        RunicCrucibleAetherBrewLevelIndex = min(29, max(0, RunicCrucibleAetherBrewLevelNumber - 1))
        RunicCrucibleAetherBrewEngine = .init(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel)
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
        RunicCrucibleAetherBrewSelectedIndex = nil
        RunicCrucibleAetherBrewAttemptUsedHint = false
        RunicCrucibleAetherBrewAttemptUsedUndo = false
        RunicCrucibleAetherBrewMessage = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTutorial
    }

    func RunicCrucibleAetherBrewHandleTap(RunicCrucibleAetherBrewIndex: Int) -> RunicCrucibleAetherBrewInteractionResult {
        guard !RunicCrucibleAetherBrewIsAnimating else { return .RunicCrucibleAetherBrewIgnored }
        guard let RunicCrucibleAetherBrewSource = RunicCrucibleAetherBrewSelectedIndex else {
            guard !RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewIndex].RunicCrucibleAetherBrewLayers.isEmpty else { return .RunicCrucibleAetherBrewIgnored }
            RunicCrucibleAetherBrewSelectedIndex = RunicCrucibleAetherBrewIndex
            RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewSelection()
            return .RunicCrucibleAetherBrewSelected(RunicCrucibleAetherBrewIndex: RunicCrucibleAetherBrewIndex)
        }
        if RunicCrucibleAetherBrewSource == RunicCrucibleAetherBrewIndex {
            RunicCrucibleAetherBrewSelectedIndex = nil
            return .RunicCrucibleAetherBrewDeselected(RunicCrucibleAetherBrewIndex: RunicCrucibleAetherBrewIndex)
        }
        let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewIndex)
        if let RunicCrucibleAetherBrewRejection = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewRejection(for: RunicCrucibleAetherBrewMove) {
            RunicCrucibleAetherBrewMessage = RunicCrucibleAetherBrewRejection.rawValue
            RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewInvalid()
            return .RunicCrucibleAetherBrewInvalid(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewReason: RunicCrucibleAetherBrewRejection.rawValue)
        }
        guard let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) else { return .RunicCrucibleAetherBrewIgnored }
        RunicCrucibleAetherBrewSelectedIndex = nil
        RunicCrucibleAetherBrewPendingResult = RunicCrucibleAetherBrewResult
        RunicCrucibleAetherBrewIsAnimating = true
        return .RunicCrucibleAetherBrewPour(RunicCrucibleAetherBrewMove: RunicCrucibleAetherBrewMove, RunicCrucibleAetherBrewResult: RunicCrucibleAetherBrewResult)
    }

    func RunicCrucibleAetherBrewAnimationDidFinish() {
        guard let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewPendingResult else { RunicCrucibleAetherBrewIsAnimating = false; return }
        RunicCrucibleAetherBrewPendingResult = nil
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState
        RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewRecordPour(
            RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewType,
            RunicCrucibleAetherBrewLayerCount: RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount
        )
        RunicCrucibleAetherBrewIsAnimating = false
        RunicCrucibleAetherBrewMessage = RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewReactions.count > 1 ? "Arcane reaction!" : "Essence transferred."
        RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewReactions.count > 1 ? RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewReaction() : RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewSelection()
        if RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon {
            RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewVictory()
            RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewComplete(
                RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel.id,
                RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewMoves,
                RunicCrucibleAetherBrewIsPerfect: !RunicCrucibleAetherBrewAttemptUsedHint && !RunicCrucibleAetherBrewAttemptUsedUndo
            )
        }
    }

    func RunicCrucibleAetherBrewUndo() -> RunicCrucibleAetherBrewGameState? {
        guard !RunicCrucibleAetherBrewIsAnimating, let RunicCrucibleAetherBrewPrevious = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewUndo() else { return nil }
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewPrevious
        RunicCrucibleAetherBrewSelectedIndex = nil
        RunicCrucibleAetherBrewAttemptUsedUndo = true
        RunicCrucibleAetherBrewMessage = "The last pour was reversed."
        return RunicCrucibleAetherBrewPrevious
    }

    func RunicCrucibleAetherBrewRestart() -> RunicCrucibleAetherBrewGameState {
        RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewRestart()
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
        RunicCrucibleAetherBrewSelectedIndex = nil
        RunicCrucibleAetherBrewAttemptUsedHint = false
        RunicCrucibleAetherBrewAttemptUsedUndo = false
        return RunicCrucibleAetherBrewState
    }

    func RunicCrucibleAetherBrewShuffle() -> RunicCrucibleAetherBrewGameState? {
        guard RunicCrucibleAetherBrewLevel.id >= 10, !RunicCrucibleAetherBrewIsAnimating else { return nil }
        let RunicCrucibleAetherBrewVials = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewShuffledVials(for: RunicCrucibleAetherBrewLevel)
        let RunicCrucibleAetherBrewShuffledLevel = RunicCrucibleAetherBrewLevelDefinition(
            id: RunicCrucibleAetherBrewLevel.id,
            RunicCrucibleAetherBrewTitle: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTitle,
            RunicCrucibleAetherBrewTutorial: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTutorial,
            RunicCrucibleAetherBrewCapacity: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity,
            RunicCrucibleAetherBrewVials: RunicCrucibleAetherBrewVials,
            RunicCrucibleAetherBrewRules: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewRules,
            RunicCrucibleAetherBrewHintLimit: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewHintLimit,
            RunicCrucibleAetherBrewGoal: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewGoal
        )
        RunicCrucibleAetherBrewEngine = .init(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewShuffledLevel)
        RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
        RunicCrucibleAetherBrewSelectedIndex = nil
        RunicCrucibleAetherBrewAttemptUsedHint = false
        RunicCrucibleAetherBrewAttemptUsedUndo = false
        RunicCrucibleAetherBrewMessage = "The essence layers have been remixed."
        RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewSelection()
        return RunicCrucibleAetherBrewState
    }

    func RunicCrucibleAetherBrewHint() {
        guard !RunicCrucibleAetherBrewIsSolvingHint, !RunicCrucibleAetherBrewIsAnimating else { return }
        RunicCrucibleAetherBrewIsSolvingHint = true
        RunicCrucibleAetherBrewMessage = "Reading the aether..."
        let RunicCrucibleAetherBrewLevelSnapshot = RunicCrucibleAetherBrewLevel
        let RunicCrucibleAetherBrewStateSnapshot = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
        Task {
            let RunicCrucibleAetherBrewSolution = await Task.detached(priority: .userInitiated) { RunicCrucibleAetherBrewSolver.RunicCrucibleAetherBrewSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelSnapshot, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewStateSnapshot, RunicCrucibleAetherBrewStateLimit: 25_000) }.value
            RunicCrucibleAetherBrewIsSolvingHint = false
            guard let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewSolution?.RunicCrucibleAetherBrewMoves.first else { RunicCrucibleAetherBrewMessage = "No safe hint was found."; return }
            RunicCrucibleAetherBrewAttemptUsedHint = true
            RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewRecordHint()
            RunicCrucibleAetherBrewMessage = "Try vial \(RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource + 1) → \(RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination + 1)."
        }
    }
}
