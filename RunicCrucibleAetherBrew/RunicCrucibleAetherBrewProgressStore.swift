import Foundation

struct RunicCrucibleAetherBrewPlayerStatistics: Equatable {
    let RunicCrucibleAetherBrewCompletedLevels: Int
    let RunicCrucibleAetherBrewTotalPours: Int
    let RunicCrucibleAetherBrewPerfectCompletions: Int
    let RunicCrucibleAetherBrewHintsUsed: Int
    let RunicCrucibleAetherBrewFavoriteEssence: RunicCrucibleAetherBrewLiquidType?
    let RunicCrucibleAetherBrewCurrentDailyStreak: Int
    let RunicCrucibleAetherBrewLaboratoryTime: TimeInterval
}

final class RunicCrucibleAetherBrewProgressStore {
    static let RunicCrucibleAetherBrewShared = RunicCrucibleAetherBrewProgressStore()

    private enum RunicCrucibleAetherBrewKey {
        static let RunicCrucibleAetherBrewTotalPours = "RunicCrucibleAetherBrewStatisticsTotalPours"
        static let RunicCrucibleAetherBrewHintsUsed = "RunicCrucibleAetherBrewStatisticsHintsUsed"
        static let RunicCrucibleAetherBrewPerfectLevels = "RunicCrucibleAetherBrewStatisticsPerfectLevels"
        static let RunicCrucibleAetherBrewEssenceCounts = "RunicCrucibleAetherBrewStatisticsEssenceCounts"
        static let RunicCrucibleAetherBrewDailyStreak = "RunicCrucibleAetherBrewStatisticsDailyStreak"
        static let RunicCrucibleAetherBrewLastVictoryDay = "RunicCrucibleAetherBrewStatisticsLastVictoryDay"
        static let RunicCrucibleAetherBrewLaboratoryTime = "RunicCrucibleAetherBrewStatisticsLaboratoryTime"
    }

    private let RunicCrucibleAetherBrewDefaults: UserDefaults
    private var RunicCrucibleAetherBrewLaboratoryStartedAt: Date?

    init(RunicCrucibleAetherBrewDefaults: UserDefaults = .standard) {
        self.RunicCrucibleAetherBrewDefaults = RunicCrucibleAetherBrewDefaults
    }

    var RunicCrucibleAetherBrewUnlockedLevel: Int { max(1, min(30, RunicCrucibleAetherBrewDefaults.integer(forKey: "RunicCrucibleAetherBrewUnlockedLevel"))) }
    var RunicCrucibleAetherBrewLastLevel: Int { max(1, min(RunicCrucibleAetherBrewUnlockedLevel, RunicCrucibleAetherBrewDefaults.integer(forKey: "RunicCrucibleAetherBrewLastLevel"))) }

    func RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: Int) -> Int? {
        let RunicCrucibleAetherBrewValue = RunicCrucibleAetherBrewDefaults.integer(forKey: "RunicCrucibleAetherBrewBest_\(RunicCrucibleAetherBrewLevel)")
        return RunicCrucibleAetherBrewValue == 0 ? nil : RunicCrucibleAetherBrewValue
    }

    func RunicCrucibleAetherBrewComplete(RunicCrucibleAetherBrewLevel: Int, RunicCrucibleAetherBrewMoves: Int, RunicCrucibleAetherBrewIsPerfect: Bool = false, RunicCrucibleAetherBrewDate: Date = Date(), RunicCrucibleAetherBrewCalendar: Calendar = .current) {
        let RunicCrucibleAetherBrewPrevious = RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel)
        if RunicCrucibleAetherBrewPrevious == nil || RunicCrucibleAetherBrewMoves < RunicCrucibleAetherBrewPrevious! { RunicCrucibleAetherBrewDefaults.set(RunicCrucibleAetherBrewMoves, forKey: "RunicCrucibleAetherBrewBest_\(RunicCrucibleAetherBrewLevel)") }
        if RunicCrucibleAetherBrewIsPerfect {
            var RunicCrucibleAetherBrewPerfectLevels = Set(RunicCrucibleAetherBrewDefaults.array(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewPerfectLevels) as? [Int] ?? [])
            RunicCrucibleAetherBrewPerfectLevels.insert(RunicCrucibleAetherBrewLevel)
            RunicCrucibleAetherBrewDefaults.set(Array(RunicCrucibleAetherBrewPerfectLevels).sorted(), forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewPerfectLevels)
        }
        RunicCrucibleAetherBrewRecordVictoryDay(RunicCrucibleAetherBrewDate, RunicCrucibleAetherBrewCalendar: RunicCrucibleAetherBrewCalendar)
        RunicCrucibleAetherBrewDefaults.set(min(30, max(RunicCrucibleAetherBrewUnlockedLevel, RunicCrucibleAetherBrewLevel + 1)), forKey: "RunicCrucibleAetherBrewUnlockedLevel")
        RunicCrucibleAetherBrewDefaults.set(min(30, RunicCrucibleAetherBrewLevel + 1), forKey: "RunicCrucibleAetherBrewLastLevel")
    }

    func RunicCrucibleAetherBrewRecordPour(RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType, RunicCrucibleAetherBrewLayerCount: Int) {
        RunicCrucibleAetherBrewDefaults.set(max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewTotalPours)) + 1, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewTotalPours)
        var RunicCrucibleAetherBrewCounts = RunicCrucibleAetherBrewDefaults.dictionary(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewEssenceCounts) as? [String: Int] ?? [:]
        RunicCrucibleAetherBrewCounts[RunicCrucibleAetherBrewType.rawValue, default: 0] += max(0, RunicCrucibleAetherBrewLayerCount)
        RunicCrucibleAetherBrewDefaults.set(RunicCrucibleAetherBrewCounts, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewEssenceCounts)
    }

    func RunicCrucibleAetherBrewRecordHint() {
        RunicCrucibleAetherBrewDefaults.set(max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewHintsUsed)) + 1, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewHintsUsed)
    }

    func RunicCrucibleAetherBrewStartLaboratorySession(RunicCrucibleAetherBrewDate: Date = Date()) {
        guard RunicCrucibleAetherBrewLaboratoryStartedAt == nil else { return }
        RunicCrucibleAetherBrewLaboratoryStartedAt = RunicCrucibleAetherBrewDate
    }

    func RunicCrucibleAetherBrewPauseLaboratorySession(RunicCrucibleAetherBrewDate: Date = Date()) {
        guard let RunicCrucibleAetherBrewStartedAt = RunicCrucibleAetherBrewLaboratoryStartedAt else { return }
        let RunicCrucibleAetherBrewElapsed = max(0, RunicCrucibleAetherBrewDate.timeIntervalSince(RunicCrucibleAetherBrewStartedAt))
        let RunicCrucibleAetherBrewSaved = max(0, RunicCrucibleAetherBrewDefaults.double(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewLaboratoryTime))
        RunicCrucibleAetherBrewDefaults.set(RunicCrucibleAetherBrewSaved + RunicCrucibleAetherBrewElapsed, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewLaboratoryTime)
        RunicCrucibleAetherBrewLaboratoryStartedAt = nil
    }

    func RunicCrucibleAetherBrewStatistics(RunicCrucibleAetherBrewDate: Date = Date()) -> RunicCrucibleAetherBrewPlayerStatistics {
        let RunicCrucibleAetherBrewCompleted = (1...30).filter { RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: $0) != nil }.count
        let RunicCrucibleAetherBrewPerfect = Set(RunicCrucibleAetherBrewDefaults.array(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewPerfectLevels) as? [Int] ?? []).filter { (1...30).contains($0) }.count
        let RunicCrucibleAetherBrewCounts = RunicCrucibleAetherBrewDefaults.dictionary(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewEssenceCounts) as? [String: Int] ?? [:]
        let RunicCrucibleAetherBrewFavorite = RunicCrucibleAetherBrewLiquidType.allCases.max { RunicCrucibleAetherBrewCounts[$0.rawValue, default: 0] < RunicCrucibleAetherBrewCounts[$1.rawValue, default: 0] }.flatMap { RunicCrucibleAetherBrewCounts[$0.rawValue, default: 0] > 0 ? $0 : nil }
        let RunicCrucibleAetherBrewActiveTime = RunicCrucibleAetherBrewLaboratoryStartedAt.map { max(0, RunicCrucibleAetherBrewDate.timeIntervalSince($0)) } ?? 0
        return .init(RunicCrucibleAetherBrewCompletedLevels: RunicCrucibleAetherBrewCompleted, RunicCrucibleAetherBrewTotalPours: max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewTotalPours)), RunicCrucibleAetherBrewPerfectCompletions: RunicCrucibleAetherBrewPerfect, RunicCrucibleAetherBrewHintsUsed: max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewHintsUsed)), RunicCrucibleAetherBrewFavoriteEssence: RunicCrucibleAetherBrewFavorite, RunicCrucibleAetherBrewCurrentDailyStreak: max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewDailyStreak)), RunicCrucibleAetherBrewLaboratoryTime: max(0, RunicCrucibleAetherBrewDefaults.double(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewLaboratoryTime)) + RunicCrucibleAetherBrewActiveTime)
    }

    func RunicCrucibleAetherBrewReset() {
        RunicCrucibleAetherBrewLaboratoryStartedAt = nil
        for RunicCrucibleAetherBrewKey in RunicCrucibleAetherBrewDefaults.dictionaryRepresentation().keys where RunicCrucibleAetherBrewKey.hasPrefix("RunicCrucibleAetherBrew") { RunicCrucibleAetherBrewDefaults.removeObject(forKey: RunicCrucibleAetherBrewKey) }
        RunicCrucibleAetherBrewDefaults.set(true, forKey: "RunicCrucibleAetherBrewOnboardingComplete")
    }

    private func RunicCrucibleAetherBrewRecordVictoryDay(_ RunicCrucibleAetherBrewDate: Date, RunicCrucibleAetherBrewCalendar: Calendar) {
        let RunicCrucibleAetherBrewToday = RunicCrucibleAetherBrewCalendar.startOfDay(for: RunicCrucibleAetherBrewDate)
        let RunicCrucibleAetherBrewLastTimestamp = RunicCrucibleAetherBrewDefaults.double(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewLastVictoryDay)
        let RunicCrucibleAetherBrewLastDay = RunicCrucibleAetherBrewLastTimestamp > 0 ? RunicCrucibleAetherBrewCalendar.startOfDay(for: Date(timeIntervalSince1970: RunicCrucibleAetherBrewLastTimestamp)) : nil
        guard RunicCrucibleAetherBrewLastDay != RunicCrucibleAetherBrewToday else { return }
        let RunicCrucibleAetherBrewYesterday = RunicCrucibleAetherBrewCalendar.date(byAdding: .day, value: -1, to: RunicCrucibleAetherBrewToday)
        let RunicCrucibleAetherBrewPreviousStreak = max(0, RunicCrucibleAetherBrewDefaults.integer(forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewDailyStreak))
        RunicCrucibleAetherBrewDefaults.set(RunicCrucibleAetherBrewLastDay == RunicCrucibleAetherBrewYesterday ? RunicCrucibleAetherBrewPreviousStreak + 1 : 1, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewDailyStreak)
        RunicCrucibleAetherBrewDefaults.set(RunicCrucibleAetherBrewToday.timeIntervalSince1970, forKey: RunicCrucibleAetherBrewKey.RunicCrucibleAetherBrewLastVictoryDay)
    }
}
