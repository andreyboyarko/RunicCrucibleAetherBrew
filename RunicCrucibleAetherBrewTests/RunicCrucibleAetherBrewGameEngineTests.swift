import XCTest
@testable import RunicCrucibleAetherBrew

final class RunicCrucibleAetherBrewGameEngineTests: XCTestCase {
    private func RunicCrucibleAetherBrewStatisticsStore() -> (RunicCrucibleAetherBrewProgressStore, UserDefaults) {
        let RunicCrucibleAetherBrewSuite = "RunicCrucibleAetherBrewTests.\(UUID().uuidString)"
        let RunicCrucibleAetherBrewDefaults = UserDefaults(suiteName: RunicCrucibleAetherBrewSuite)!
        RunicCrucibleAetherBrewDefaults.removePersistentDomain(forName: RunicCrucibleAetherBrewSuite)
        return (RunicCrucibleAetherBrewProgressStore(RunicCrucibleAetherBrewDefaults: RunicCrucibleAetherBrewDefaults), RunicCrucibleAetherBrewDefaults)
    }

    private func RunicCrucibleAetherBrewLevel(
        RunicCrucibleAetherBrewVials: [[RunicCrucibleAetherBrewLiquidType]],
        RunicCrucibleAetherBrewCapacity: Int = 4,
        RunicCrucibleAetherBrewRules: [RunicCrucibleAetherBrewRule] = [.standard]
    ) -> RunicCrucibleAetherBrewLevelDefinition {
        .init(id: 999, RunicCrucibleAetherBrewTitle: "Test Brew", RunicCrucibleAetherBrewTutorial: "Test", RunicCrucibleAetherBrewCapacity: RunicCrucibleAetherBrewCapacity, RunicCrucibleAetherBrewVials: RunicCrucibleAetherBrewVials, RunicCrucibleAetherBrewRules: RunicCrucibleAetherBrewRules, RunicCrucibleAetherBrewHintLimit: 3, RunicCrucibleAetherBrewGoal: .init(RunicCrucibleAetherBrewName: "Test", RunicCrucibleAetherBrewSymbol: "flask.fill"))
    }

    func testRunicCrucibleAetherBrewTransfersSingleLayer() {
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[.water], []]))
        let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
        XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, 1)
    }

    func testRunicCrucibleAetherBrewTransfersContinuousGroup() {
        for RunicCrucibleAetherBrewCount in 2...4 {
            var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [Array(repeating: .water, count: RunicCrucibleAetherBrewCount), []]))
            let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
            XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, RunicCrucibleAetherBrewCount)
            XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewMoves, 1)
        }
    }

    func testRunicCrucibleAetherBrewLimitsGroupByFreeSpace() {
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[.water, .water, .water], [.water, .water]]))
        let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
        XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, 2)
    }

    func testRunicCrucibleAetherBrewRejectsMismatchedEssence() {
        let RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[.water], [.fire]]))
        XCTAssertEqual(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewRejection(for: .init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1)), .RunicCrucibleAetherBrewEssenceMismatch)
    }

    func testRunicCrucibleAetherBrewUndoRestoresGroupedMove() {
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[.water, .water, .fire], []]))
        let RunicCrucibleAetherBrewInitial = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState
        _ = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
        XCTAssertEqual(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewUndo(), RunicCrucibleAetherBrewInitial)
    }

    func testRunicCrucibleAetherBrewSpecialReactionMovesOneLayer() {
        let RunicCrucibleAetherBrewCases: [(RunicCrucibleAetherBrewRule, [RunicCrucibleAetherBrewLiquidType], [RunicCrucibleAetherBrewLiquidType])] = [
            (.nature, [.nature, .nature], [.water]), (.aether, [.aether, .aether], [.water]), (.void, [.fire, .fire], [.void])
        ]
        for RunicCrucibleAetherBrewCase in RunicCrucibleAetherBrewCases {
            var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [RunicCrucibleAetherBrewCase.1, RunicCrucibleAetherBrewCase.2], RunicCrucibleAetherBrewRules: [.standard, RunicCrucibleAetherBrewCase.0]))
            XCTAssertEqual(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, 1)
        }
    }

    func testRunicCrucibleAetherBrewFireDoesNotEvaporateOtherEssences() {
        let RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(
            RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(
                RunicCrucibleAetherBrewVials: [[.fire, .fire], [.water], []],
                RunicCrucibleAetherBrewRules: [.standard, .fire]
            )
        )
        XCTAssertEqual(
            RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewRejection(
                for: .init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1)
            ),
            .RunicCrucibleAetherBrewEssenceMismatch
        )
        XCTAssertEqual(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[1].RunicCrucibleAetherBrewLayers.map(\.RunicCrucibleAetherBrewType), [.water])
    }

    func testRunicCrucibleAetherBrewIdenticalAetherAndVoidCombineNormally() {
        for RunicCrucibleAetherBrewType in [RunicCrucibleAetherBrewLiquidType.aether, .void] {
            var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[RunicCrucibleAetherBrewType, RunicCrucibleAetherBrewType], [RunicCrucibleAetherBrewType]], RunicCrucibleAetherBrewRules: [.standard, .aether, .void]))
            let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
            XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, 2)
            XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewReactions.map(\.RunicCrucibleAetherBrewKind), [.poured])
        }
    }

    func testRunicCrucibleAetherBrewIdenticalFrostCombinesWithoutFreezing() {
        var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[.frost, .frost], [.frost]], RunicCrucibleAetherBrewRules: [.standard, .frost]))
        let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(.init(RunicCrucibleAetherBrewSource: 0, RunicCrucibleAetherBrewDestination: 1))
        XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount, 2)
        XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewDestinationVial.RunicCrucibleAetherBrewFrozenTurns, 0)
        XCTAssertEqual(RunicCrucibleAetherBrewResult?.RunicCrucibleAetherBrewReactions.map(\.RunicCrucibleAetherBrewKind), [.poured])
    }

    func testRunicCrucibleAetherBrewDoesNotWinWithSameEssenceSplitAcrossVials() {
        let RunicCrucibleAetherBrewLevel = RunicCrucibleAetherBrewLevel(RunicCrucibleAetherBrewVials: [[], [], []], RunicCrucibleAetherBrewRules: [.standard, .frost])
        let RunicCrucibleAetherBrewSplitState = RunicCrucibleAetherBrewGameState(RunicCrucibleAetherBrewVials: [
            .init(RunicCrucibleAetherBrewTypes: [.water]),
            .init(RunicCrucibleAetherBrewTypes: [.water, .water]),
            .init(RunicCrucibleAetherBrewTypes: [.fire])
        ], RunicCrucibleAetherBrewMoves: 5, RunicCrucibleAetherBrewHintsUsed: 0, RunicCrucibleAetherBrewIsWon: false)
        let RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewSplitState)
        XCTAssertFalse(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewCheckWin())
    }

    func testRunicCrucibleAetherBrewCatalogHasThirtyValidUniqueLevels() {
        let RunicCrucibleAetherBrewLevels = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()
        XCTAssertEqual(RunicCrucibleAetherBrewLevels.count, 30)
        XCTAssertEqual(Set(RunicCrucibleAetherBrewLevels.map(\.id)).count, 30)
        XCTAssertTrue(RunicCrucibleAetherBrewLevels.allSatisfy { RunicCrucibleAetherBrewLevel in RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.allSatisfy { $0.count <= RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity } })
        XCTAssertEqual(RunicCrucibleAetherBrewLevels.first?.RunicCrucibleAetherBrewVials.count, 10)
        XCTAssertEqual(RunicCrucibleAetherBrewLevels.first(where: { $0.id == 28 })?.RunicCrucibleAetherBrewVials.count, 30)
        XCTAssertEqual(RunicCrucibleAetherBrewLevels.first(where: { $0.id == 28 })?.RunicCrucibleAetherBrewVials.filter { $0.isEmpty }.count, 4)
        XCTAssertEqual(RunicCrucibleAetherBrewLevels.last?.RunicCrucibleAetherBrewVials.count, 30)
        XCTAssertTrue(RunicCrucibleAetherBrewLevels.allSatisfy { RunicCrucibleAetherBrewLevel in
            RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.filter { !$0.isEmpty }.allSatisfy { Set($0).count > 1 }
        })
        XCTAssertTrue(RunicCrucibleAetherBrewLevels.dropFirst().allSatisfy { RunicCrucibleAetherBrewLevel in
            RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.filter { !$0.isEmpty }.allSatisfy { RunicCrucibleAetherBrewVial in
                zip(RunicCrucibleAetherBrewVial, RunicCrucibleAetherBrewVial.dropFirst()).allSatisfy(!=)
            }
        })
    }

    func testRunicCrucibleAetherBrewSolverFindsAndReplaysCatalogSolutions() throws {
        for RunicCrucibleAetherBrewLevel in RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad() {
            let RunicCrucibleAetherBrewSolution = RunicCrucibleAetherBrewSolver.RunicCrucibleAetherBrewSolve(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel, RunicCrucibleAetherBrewStateLimit: 250_000)
            XCTAssertNotNil(RunicCrucibleAetherBrewSolution, "Level \(RunicCrucibleAetherBrewLevel.id) has no solution")
            var RunicCrucibleAetherBrewEngine = RunicCrucibleAetherBrewGameEngine(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel)
            for RunicCrucibleAetherBrewMove in try XCTUnwrap(RunicCrucibleAetherBrewSolution).RunicCrucibleAetherBrewMoves {
                XCTAssertNotNil(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewApply(RunicCrucibleAetherBrewMove))
            }
            XCTAssertTrue(RunicCrucibleAetherBrewEngine.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon)
        }
    }

    func testRunicCrucibleAetherBrewRemixedLayersPreserveEssencesAndBreakPatterns() {
        for RunicCrucibleAetherBrewLevel in RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad().filter({ $0.id >= 10 }) {
            let RunicCrucibleAetherBrewRemixedVials = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewShuffledVials(for: RunicCrucibleAetherBrewLevel)
            XCTAssertEqual(RunicCrucibleAetherBrewRemixedVials.flatMap { $0 }.sorted(by: { $0.rawValue < $1.rawValue }), RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.flatMap { $0 }.sorted(by: { $0.rawValue < $1.rawValue }))
            XCTAssertEqual(RunicCrucibleAetherBrewRemixedVials.filter(\.isEmpty).count, RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.filter(\.isEmpty).count)
            XCTAssertNotEqual(RunicCrucibleAetherBrewRemixedVials, RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials)
        }
    }

    func testRunicCrucibleAetherBrewStatisticsRestoreCompletedLevelsAndTrackPours() {
        let (RunicCrucibleAetherBrewStore, RunicCrucibleAetherBrewDefaults) = RunicCrucibleAetherBrewStatisticsStore()
        RunicCrucibleAetherBrewDefaults.set(12, forKey: "RunicCrucibleAetherBrewBest_2")
        RunicCrucibleAetherBrewDefaults.set(18, forKey: "RunicCrucibleAetherBrewBest_7")
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewRecordPour(RunicCrucibleAetherBrewType: .water, RunicCrucibleAetherBrewLayerCount: 3)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewRecordPour(RunicCrucibleAetherBrewType: .fire, RunicCrucibleAetherBrewLayerCount: 1)
        let RunicCrucibleAetherBrewStatistics = RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics()
        XCTAssertEqual(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewCompletedLevels, 2)
        XCTAssertEqual(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewTotalPours, 2)
        XCTAssertEqual(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewFavoriteEssence, .water)
    }

    func testRunicCrucibleAetherBrewPerfectCompletionIsUniqueAndStreakUsesVictoryDays() {
        let (RunicCrucibleAetherBrewStore, _) = RunicCrucibleAetherBrewStatisticsStore()
        var RunicCrucibleAetherBrewCalendar = Calendar(identifier: .gregorian)
        RunicCrucibleAetherBrewCalendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let RunicCrucibleAetherBrewFirstDay = RunicCrucibleAetherBrewCalendar.date(from: DateComponents(year: 2026, month: 8, day: 20, hour: 12))!
        let RunicCrucibleAetherBrewSecondDay = RunicCrucibleAetherBrewCalendar.date(byAdding: .day, value: 1, to: RunicCrucibleAetherBrewFirstDay)!
        let RunicCrucibleAetherBrewFourthDay = RunicCrucibleAetherBrewCalendar.date(byAdding: .day, value: 3, to: RunicCrucibleAetherBrewFirstDay)!
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 1, RunicCrucibleAetherBrewMoves: 8, RunicCrucibleAetherBrewIsPerfect: true, RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewFirstDay, RunicCrucibleAetherBrewCalendar: RunicCrucibleAetherBrewCalendar)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 1, RunicCrucibleAetherBrewMoves: 7, RunicCrucibleAetherBrewIsPerfect: true, RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewFirstDay, RunicCrucibleAetherBrewCalendar: RunicCrucibleAetherBrewCalendar)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 2, RunicCrucibleAetherBrewMoves: 10, RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewSecondDay, RunicCrucibleAetherBrewCalendar: RunicCrucibleAetherBrewCalendar)
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics().RunicCrucibleAetherBrewPerfectCompletions, 1)
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics().RunicCrucibleAetherBrewCurrentDailyStreak, 2)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 3, RunicCrucibleAetherBrewMoves: 12, RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewFourthDay, RunicCrucibleAetherBrewCalendar: RunicCrucibleAetherBrewCalendar)
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics().RunicCrucibleAetherBrewCurrentDailyStreak, 1)
    }

    func testRunicCrucibleAetherBrewLaboratoryTimeOnlyCountsActiveSession() {
        let (RunicCrucibleAetherBrewStore, _) = RunicCrucibleAetherBrewStatisticsStore()
        let RunicCrucibleAetherBrewStart = Date(timeIntervalSince1970: 1_000)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStartLaboratorySession(RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewStart)
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics(RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewStart.addingTimeInterval(75)).RunicCrucibleAetherBrewLaboratoryTime, 75)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewPauseLaboratorySession(RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewStart.addingTimeInterval(90))
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics(RunicCrucibleAetherBrewDate: RunicCrucibleAetherBrewStart.addingTimeInterval(500)).RunicCrucibleAetherBrewLaboratoryTime, 90)
    }

    func testRunicCrucibleAetherBrewFinaleUnlocksOnceAndResetClearsIt() {
        let (RunicCrucibleAetherBrewStore, RunicCrucibleAetherBrewDefaults) = RunicCrucibleAetherBrewStatisticsStore()
        XCTAssertFalse(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewIsFinaleUnlocked)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewUnlockFinale()
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewUnlockFinale()
        XCTAssertTrue(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewIsFinaleUnlocked)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewReset()
        XCTAssertFalse(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewIsFinaleUnlocked)
        XCTAssertTrue(RunicCrucibleAetherBrewDefaults.bool(forKey: "RunicCrucibleAetherBrewOnboardingComplete"))
    }

    func testRunicCrucibleAetherBrewRepeatedLevelThirtyVictoryDoesNotDuplicateUniqueStatistics() {
        let (RunicCrucibleAetherBrewStore, _) = RunicCrucibleAetherBrewStatisticsStore()
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 30, RunicCrucibleAetherBrewMoves: 120, RunicCrucibleAetherBrewIsPerfect: true)
        RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: 30, RunicCrucibleAetherBrewMoves: 110, RunicCrucibleAetherBrewIsPerfect: true)
        let RunicCrucibleAetherBrewStatistics = RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewStatistics()
        XCTAssertEqual(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewCompletedLevels, 1)
        XCTAssertEqual(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewPerfectCompletions, 1)
        XCTAssertEqual(RunicCrucibleAetherBrewStore.RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: 30), 110)
    }
}
