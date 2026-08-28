import Foundation

struct RunicCrucibleAetherBrewSolverResult {
    let RunicCrucibleAetherBrewMoves: [RunicCrucibleAetherBrewMove]
    let RunicCrucibleAetherBrewVisitedStates: Int
}

enum RunicCrucibleAetherBrewSolver {
    private struct RunicCrucibleAetherBrewQueueItem {
        let RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState
        let RunicCrucibleAetherBrewPath: [RunicCrucibleAetherBrewMove]
    }

    static func RunicCrucibleAetherBrewSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewGameState? = nil, RunicCrucibleAetherBrewStateLimit: Int = 250_000) -> RunicCrucibleAetherBrewSolverResult? {
        let RunicCrucibleAetherBrewInitialEngine = RunicCrucibleAetherBrewInitialState.map { RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: $0) } ?? RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel)
        if RunicCrucibleAetherBrewLevel.id >= 2, let RunicCrucibleAetherBrewChaoticResult = RunicCrucibleAetherBrewChaoticConstructiveSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewInitialEngine.RunicCrucibleAetherBrewState) { return RunicCrucibleAetherBrewChaoticResult }
        if let RunicCrucibleAetherBrewConstructiveResult = RunicCrucibleAetherBrewConstructiveSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewInitialEngine.RunicCrucibleAetherBrewState) { return RunicCrucibleAetherBrewConstructiveResult }
        if let RunicCrucibleAetherBrewFastResult = RunicCrucibleAetherBrewDepthFirstSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewInitialEngine.RunicCrucibleAetherBrewState, RunicCrucibleAetherBrewStateLimit: RunicCrucibleAetherBrewStateLimit) { return RunicCrucibleAetherBrewFastResult }
        var RunicCrucibleAetherBrewQueue = [RunicCrucibleAetherBrewQueueItem(RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewInitialEngine.RunicCrucibleAetherBrewState, RunicCrucibleAetherBrewPath: [])]
        var RunicCrucibleAetherBrewQueueIndex = 0
        var RunicCrucibleAetherBrewVisited: Set<String> = [RunicCrucibleAetherBrewKey(RunicCrucibleAetherBrewInitialEngine.RunicCrucibleAetherBrewState)]
        while RunicCrucibleAetherBrewQueueIndex < RunicCrucibleAetherBrewQueue.count, RunicCrucibleAetherBrewVisited.count < RunicCrucibleAetherBrewStateLimit {
            let RunicCrucibleAetherBrewItem = RunicCrucibleAetherBrewQueue[RunicCrucibleAetherBrewQueueIndex]
            RunicCrucibleAetherBrewQueueIndex += 1
            for RunicCrucibleAetherBrewSource in RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.indices {
                for RunicCrucibleAetherBrewDestination in RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.indices where RunicCrucibleAetherBrewSource != RunicCrucibleAetherBrewDestination {
                    let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewDestination)
                    var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState)
                    guard let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) else { continue }
                    let RunicCrucibleAetherBrewPath = RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewPath + [RunicCrucibleAetherBrewMove]
                    if RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon { return .init(RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewPath, RunicCrucibleAetherBrewVisitedStates: RunicCrucibleAetherBrewVisited.count) }
                    let RunicCrucibleAetherBrewStateKey = RunicCrucibleAetherBrewKey(RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState)
                    if RunicCrucibleAetherBrewVisited.insert(RunicCrucibleAetherBrewStateKey).inserted { RunicCrucibleAetherBrewQueue.append(.init(RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState, RunicCrucibleAetherBrewPath: RunicCrucibleAetherBrewPath)) }
                }
            }
        }
        return nil
    }

    private static func RunicCrucibleAetherBrewChaoticConstructiveSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewGameState) -> RunicCrucibleAetherBrewSolverResult? {
        let RunicCrucibleAetherBrewFilledCount = RunicCrucibleAetherBrewInitialState.RunicCrucibleAetherBrewVials.prefix { !$0.RunicCrucibleAetherBrewLayers.isEmpty }.count
        guard RunicCrucibleAetherBrewFilledCount >= 4,
              RunicCrucibleAetherBrewInitialState.RunicCrucibleAetherBrewVials.count - RunicCrucibleAetherBrewFilledCount >= 2,
              RunicCrucibleAetherBrewInitialState.RunicCrucibleAetherBrewVials.dropFirst(RunicCrucibleAetherBrewFilledCount).allSatisfy({ $0.RunicCrucibleAetherBrewLayers.isEmpty }) else { return nil }
        let RunicCrucibleAetherBrewBlockMoves = [(0, 4), (3, 0), (2, 3), (1, 2), (1, 4), (0, 1), (3, 0), (2, 3), (2, 4), (1, 2), (0, 1), (3, 0), (3, 4)]
        let RunicCrucibleAetherBrewPairMoves = [(0, 2), (1, 0), (1, 2), (0, 1), (0, 2), (1, 0), (1, 2)]
        var RunicCrucibleAetherBrewWorkspaceIndex = RunicCrucibleAetherBrewFilledCount
        let RunicCrucibleAetherBrewSecondWorkspaceIndex = RunicCrucibleAetherBrewFilledCount + 1
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewInitialState)
        var RunicCrucibleAetherBrewMoves: [RunicCrucibleAetherBrewMove] = []
        let RunicCrucibleAetherBrewBlockCount = RunicCrucibleAetherBrewFilledCount / 4
        for RunicCrucibleAetherBrewBlockIndex in 0..<RunicCrucibleAetherBrewBlockCount {
            let RunicCrucibleAetherBrewBlockStart = RunicCrucibleAetherBrewBlockIndex * 4
            for (RunicCrucibleAetherBrewLocalSource, RunicCrucibleAetherBrewLocalDestination) in RunicCrucibleAetherBrewBlockMoves {
                let RunicCrucibleAetherBrewSource = RunicCrucibleAetherBrewLocalSource == 4 ? RunicCrucibleAetherBrewWorkspaceIndex : (RunicCrucibleAetherBrewLocalSource == 5 ? RunicCrucibleAetherBrewSecondWorkspaceIndex : RunicCrucibleAetherBrewBlockStart + RunicCrucibleAetherBrewLocalSource)
                let RunicCrucibleAetherBrewDestination = RunicCrucibleAetherBrewLocalDestination == 4 ? RunicCrucibleAetherBrewWorkspaceIndex : (RunicCrucibleAetherBrewLocalDestination == 5 ? RunicCrucibleAetherBrewSecondWorkspaceIndex : RunicCrucibleAetherBrewBlockStart + RunicCrucibleAetherBrewLocalDestination)
                let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewDestination)
                guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) != nil else { return nil }
                RunicCrucibleAetherBrewMoves.append(RunicCrucibleAetherBrewMove)
            }
            RunicCrucibleAetherBrewWorkspaceIndex = RunicCrucibleAetherBrewBlockStart + 3
        }
        if RunicCrucibleAetherBrewFilledCount.isMultiple(of: 4) == false {
            let RunicCrucibleAetherBrewPairStart = RunicCrucibleAetherBrewBlockCount * 4
            for (RunicCrucibleAetherBrewLocalSource, RunicCrucibleAetherBrewLocalDestination) in RunicCrucibleAetherBrewPairMoves {
                let RunicCrucibleAetherBrewSource = RunicCrucibleAetherBrewLocalSource == 2 ? RunicCrucibleAetherBrewWorkspaceIndex : (RunicCrucibleAetherBrewLocalSource == 3 ? RunicCrucibleAetherBrewSecondWorkspaceIndex : RunicCrucibleAetherBrewPairStart + RunicCrucibleAetherBrewLocalSource)
                let RunicCrucibleAetherBrewDestination = RunicCrucibleAetherBrewLocalDestination == 2 ? RunicCrucibleAetherBrewWorkspaceIndex : (RunicCrucibleAetherBrewLocalDestination == 3 ? RunicCrucibleAetherBrewSecondWorkspaceIndex : RunicCrucibleAetherBrewPairStart + RunicCrucibleAetherBrewLocalDestination)
                let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewDestination)
                guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) != nil else { return nil }
                RunicCrucibleAetherBrewMoves.append(RunicCrucibleAetherBrewMove)
            }
        }
        guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon else { return nil }
        return .init(RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewMoves, RunicCrucibleAetherBrewVisitedStates: RunicCrucibleAetherBrewMoves.count + 1)
    }

    private static func RunicCrucibleAetherBrewConstructiveSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewGameState) -> RunicCrucibleAetherBrewSolverResult? {
        let RunicCrucibleAetherBrewVials = RunicCrucibleAetherBrewInitialState.RunicCrucibleAetherBrewVials
        let RunicCrucibleAetherBrewFilledCount = RunicCrucibleAetherBrewVials.prefix { !$0.RunicCrucibleAetherBrewLayers.isEmpty }.count
        guard RunicCrucibleAetherBrewVials.count >= 4,
              RunicCrucibleAetherBrewVials.count - RunicCrucibleAetherBrewFilledCount >= 2,
              RunicCrucibleAetherBrewVials.dropFirst(RunicCrucibleAetherBrewFilledCount).allSatisfy({ $0.RunicCrucibleAetherBrewLayers.isEmpty }) else { return nil }
        guard RunicCrucibleAetherBrewFilledCount.isMultiple(of: 2) else { return nil }
        let RunicCrucibleAetherBrewWorkspaceIndex = RunicCrucibleAetherBrewFilledCount
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewInitialState)
        var RunicCrucibleAetherBrewMoves: [RunicCrucibleAetherBrewMove] = []
        for RunicCrucibleAetherBrewFirstIndex in stride(from: 0, to: RunicCrucibleAetherBrewFilledCount, by: 2) {
            let RunicCrucibleAetherBrewSecondIndex = RunicCrucibleAetherBrewFirstIndex + 1
            let RunicCrucibleAetherBrewFirstLayers = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewFirstIndex].RunicCrucibleAetherBrewLayers
            let RunicCrucibleAetherBrewSecondLayers = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewSecondIndex].RunicCrucibleAetherBrewLayers
            guard RunicCrucibleAetherBrewFirstLayers.count == 4, RunicCrucibleAetherBrewSecondLayers.count == 4,
                  Set(RunicCrucibleAetherBrewFirstLayers.prefix(3).map(\.RunicCrucibleAetherBrewType)).count == 1,
                  Set(RunicCrucibleAetherBrewSecondLayers.prefix(3).map(\.RunicCrucibleAetherBrewType)).count == 1,
                  RunicCrucibleAetherBrewFirstLayers.first?.RunicCrucibleAetherBrewType == RunicCrucibleAetherBrewSecondLayers.last?.RunicCrucibleAetherBrewType,
                  RunicCrucibleAetherBrewSecondLayers.first?.RunicCrucibleAetherBrewType == RunicCrucibleAetherBrewFirstLayers.last?.RunicCrucibleAetherBrewType else { return nil }
            let RunicCrucibleAetherBrewPairMoves = [
                RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSecondIndex, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewWorkspaceIndex),
                RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewFirstIndex, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewSecondIndex),
                RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewWorkspaceIndex, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewFirstIndex)
            ]
            for RunicCrucibleAetherBrewMove in RunicCrucibleAetherBrewPairMoves {
                guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) != nil else { return nil }
                RunicCrucibleAetherBrewMoves.append(RunicCrucibleAetherBrewMove)
            }
        }
        guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon else { return nil }
        return .init(RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewMoves, RunicCrucibleAetherBrewVisitedStates: RunicCrucibleAetherBrewMoves.count + 1)
    }

    private static func RunicCrucibleAetherBrewDepthFirstSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition, RunicCrucibleAetherBrewInitialState: RunicCrucibleAetherBrewGameState, RunicCrucibleAetherBrewStateLimit: Int) -> RunicCrucibleAetherBrewSolverResult? {
        var RunicCrucibleAetherBrewStack = [RunicCrucibleAetherBrewQueueItem(RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewInitialState, RunicCrucibleAetherBrewPath: [])]
        var RunicCrucibleAetherBrewVisited: Set<String> = [RunicCrucibleAetherBrewKey(RunicCrucibleAetherBrewInitialState)]
        while let RunicCrucibleAetherBrewItem = RunicCrucibleAetherBrewStack.popLast(), RunicCrucibleAetherBrewVisited.count < RunicCrucibleAetherBrewStateLimit {
            if RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewPath.count >= 120 { continue }
            var RunicCrucibleAetherBrewCandidates: [(Int, RunicCrucibleAetherBrewMove)] = []
            for RunicCrucibleAetherBrewSource in RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.indices {
                let RunicCrucibleAetherBrewSourceVial = RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewSource]
                guard let RunicCrucibleAetherBrewTop = RunicCrucibleAetherBrewSourceVial.RunicCrucibleAetherBrewLayers.last else { continue }
                var RunicCrucibleAetherBrewUsedEmptyDestination = false
                for RunicCrucibleAetherBrewDestination in RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.indices where RunicCrucibleAetherBrewSource != RunicCrucibleAetherBrewDestination {
                    let RunicCrucibleAetherBrewDestinationVial = RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewDestination]
                    if RunicCrucibleAetherBrewDestinationVial.RunicCrucibleAetherBrewLayers.isEmpty {
                        if RunicCrucibleAetherBrewUsedEmptyDestination { continue }
                        RunicCrucibleAetherBrewUsedEmptyDestination = true
                    }
                    let RunicCrucibleAetherBrewMove = RunicCrucibleAetherBrewMove(RunicCrucibleAetherBrewSource: RunicCrucibleAetherBrewSource, RunicCrucibleAetherBrewDestination: RunicCrucibleAetherBrewDestination)
                    let RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState)
                    guard RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewCanMove(RunicCrucibleAetherBrewMove) else { continue }
                    let RunicCrucibleAetherBrewPriority = RunicCrucibleAetherBrewDestinationVial.RunicCrucibleAetherBrewLayers.last?.RunicCrucibleAetherBrewType == RunicCrucibleAetherBrewTop.RunicCrucibleAetherBrewType ? 0 : 1
                    RunicCrucibleAetherBrewCandidates.append((RunicCrucibleAetherBrewPriority, RunicCrucibleAetherBrewMove))
                }
            }
            for (_, RunicCrucibleAetherBrewMove) in RunicCrucibleAetherBrewCandidates.sorted(by: { $0.0 > $1.0 }) {
                var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewState)
                guard let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove) else { continue }
                let RunicCrucibleAetherBrewPath = RunicCrucibleAetherBrewItem.RunicCrucibleAetherBrewPath + [RunicCrucibleAetherBrewMove]
                if RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon { return .init(RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewPath, RunicCrucibleAetherBrewVisitedStates: RunicCrucibleAetherBrewVisited.count) }
                let RunicCrucibleAetherBrewKey = RunicCrucibleAetherBrewKey(RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState)
                if RunicCrucibleAetherBrewVisited.insert(RunicCrucibleAetherBrewKey).inserted { RunicCrucibleAetherBrewStack.append(.init(RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState, RunicCrucibleAetherBrewPath: RunicCrucibleAetherBrewPath)) }
            }
        }
        return nil
    }

    private static func RunicCrucibleAetherBrewKey(_ RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState) -> String {
        RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.map { RunicCrucibleAetherBrewVial in
            let RunicCrucibleAetherBrewLayers = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers.map { "\($0.RunicCrucibleAetherBrewType.rawValue):\($0.RunicCrucibleAetherBrewIsEmpowered ? 1 : 0)" }.joined(separator: ",")
            return "\(RunicCrucibleAetherBrewLayers)#\(RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewFrozenTurns)#\(RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewVoidIsSpent ? 1 : 0)"
        }.sorted().joined(separator: "|")
    }
}
