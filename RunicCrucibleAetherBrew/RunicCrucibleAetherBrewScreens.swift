import SwiftUI
import SafariServices
import SpriteKit

struct RunicCrucibleAetherBrewHomeMapView: View {
    @State private var RunicCrucibleAetherBrewRefresh = UUID()
    private let RunicCrucibleAetherBrewLevels = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()
    var body: some View { ZStack { Image("backgroundMapRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea().overlay(Color.black.opacity(0.45)); ScrollView { VStack(spacing: 18) { Image("logoRunicCrucibleAetherBrew").resizable().scaledToFit().frame(width: 105, height: 105).clipShape(RoundedRectangle(cornerRadius: 24)); Text("AETHER VIALS").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewScreenTitleFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary); Text("ARCANE BREW").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewSectionTitleFont).tracking(4).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold); Button("Continue Level \(RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewLastLevel)") { RunicCrucibleAetherBrewOpen(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewLastLevel) }.font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont.weight(.semibold)).buttonStyle(.borderedProminent).tint(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple); ForEach(RunicCrucibleAetherBrewLevels) { RunicCrucibleAetherBrewLevel in RunicCrucibleAetherBrewLevelRow(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel) } }.padding() } }.navigationBarHidden(true).id(RunicCrucibleAetherBrewRefresh).onAppear { RunicCrucibleAetherBrewRefresh = UUID() } }
    private func RunicCrucibleAetherBrewLevelRow(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition) -> some View { Button { RunicCrucibleAetherBrewOpen(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel.id) } label: { HStack { ZStack { Circle().fill(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple).frame(width: 46, height: 46); Image(systemName: "seal.fill").foregroundColor(.white) }; VStack(alignment: .leading) { Text("Level \(RunicCrucibleAetherBrewLevel.id) · \(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTitle)").font(.headline); Text(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewRules.last?.rawValue.capitalized ?? "Standard").font(.caption).foregroundColor(.white.opacity(0.65)) }; Spacer(); if let RunicCrucibleAetherBrewBest = RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevel.id) { Text("\(RunicCrucibleAetherBrewBest)").font(.caption.bold()); Image(systemName: "checkmark.seal.fill").foregroundColor(.green) } }.foregroundColor(.white).RunicCrucibleAetherBrewCard() } }
    private func RunicCrucibleAetherBrewOpen(RunicCrucibleAetherBrewLevel: Int) { UserDefaults.standard.set(RunicCrucibleAetherBrewLevel, forKey: "RunicCrucibleAetherBrewLastLevel"); RunicCrucibleAetherBrewGameViewModel.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewLevelNumber: RunicCrucibleAetherBrewLevel); UIApplication.shared.RunicCrucibleAetherBrewKeyWindow?.rootViewController.flatMap { $0 as? UITabBarController }?.selectedIndex = 1 }
}

struct RunicCrucibleAetherBrewGrimoireView: View {
    var body: some View { ZStack { Image("backgroundGrimoireRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea().overlay(Color.black.opacity(0.38)); ScrollView { LazyVGrid(columns: [GridItem(.adaptive(minimum: 135))], spacing: 14) { ForEach(Array(RunicCrucibleAetherBrewLiquidType.allCases.enumerated()), id: \.element.id) { RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewLiquid in let RunicCrucibleAetherBrewIsOpen = RunicCrucibleAetherBrewIndex < max(2, (RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewUnlockedLevel + 3) / 4); VStack(spacing: 9) { Image(systemName: RunicCrucibleAetherBrewIsOpen ? RunicCrucibleAetherBrewLiquid.RunicCrucibleAetherBrewSymbol : "questionmark").font(.system(size: 34)).foregroundColor(RunicCrucibleAetherBrewIsOpen ? RunicCrucibleAetherBrewLiquid.RunicCrucibleAetherBrewColor : .gray); Text(RunicCrucibleAetherBrewIsOpen ? RunicCrucibleAetherBrewLiquid.RunicCrucibleAetherBrewName : "Unknown").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCardTitleFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary); Text(RunicCrucibleAetherBrewIsOpen ? RunicCrucibleAetherBrewLiquid.RunicCrucibleAetherBrewDescription : "Complete more levels to reveal this essence.").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCaptionFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary).multilineTextAlignment(.center).frame(height: 34) }.frame(maxWidth: .infinity).RunicCrucibleAetherBrewGrimoireCard() } }.padding() } }.navigationTitle("Grimoire") }
}

struct RunicCrucibleAetherBrewSettingsView: View {
    @AppStorage("RunicCrucibleAetherBrewSound") private var RunicCrucibleAetherBrewSound = true
    @AppStorage("RunicCrucibleAetherBrewMusic") private var RunicCrucibleAetherBrewMusic = true
    @AppStorage("RunicCrucibleAetherBrewHaptics") private var RunicCrucibleAetherBrewHaptics = true
    @State private var RunicCrucibleAetherBrewShowsPrivacy = false
    @State private var RunicCrucibleAetherBrewShowsReset = false
    var body: some View {
        ZStack {
            RunicCrucibleAetherBrewSettingsBackground
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Settings")
                        .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewScreenTitleFont)
                        .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary)
                    RunicCrucibleAetherBrewSection(RunicCrucibleAetherBrewTitle: "EXPERIENCE") {
                        VStack(spacing: 0) {
                            RunicCrucibleAetherBrewToggle(RunicCrucibleAetherBrewTitle: "Sound Effects", RunicCrucibleAetherBrewSymbol: "speaker.wave.2.fill", RunicCrucibleAetherBrewValue: $RunicCrucibleAetherBrewSound)
                            Divider().overlay(Color.white.opacity(0.10))
                            RunicCrucibleAetherBrewToggle(RunicCrucibleAetherBrewTitle: "Music", RunicCrucibleAetherBrewSymbol: "music.note", RunicCrucibleAetherBrewValue: $RunicCrucibleAetherBrewMusic)
                            Divider().overlay(Color.white.opacity(0.10))
                            RunicCrucibleAetherBrewToggle(RunicCrucibleAetherBrewTitle: "Haptics", RunicCrucibleAetherBrewSymbol: "iphone.radiowaves.left.and.right", RunicCrucibleAetherBrewValue: $RunicCrucibleAetherBrewHaptics)
                        }.RunicCrucibleAetherBrewGlassPanel()
                    }
                    RunicCrucibleAetherBrewSection(RunicCrucibleAetherBrewTitle: "GUIDE") {
                        Button { UserDefaults.standard.set(false, forKey: "RunicCrucibleAetherBrewOnboardingComplete"); RunicCrucibleAetherBrewAppDelegate.RunicCrucibleAetherBrewShared?.RunicCrucibleAetherBrewReplayOnboarding() } label: {
                            RunicCrucibleAetherBrewSettingsRow(RunicCrucibleAetherBrewTitle: "Show Onboarding Again", RunicCrucibleAetherBrewSymbol: "sparkles", RunicCrucibleAetherBrewShowsChevron: false)
                        }.buttonStyle(.plain).RunicCrucibleAetherBrewGlassPanel()
                    }
                    RunicCrucibleAetherBrewSection(RunicCrucibleAetherBrewTitle: "ABOUT") {
                        Button { RunicCrucibleAetherBrewShowsPrivacy = true } label: { RunicCrucibleAetherBrewSettingsRow(RunicCrucibleAetherBrewTitle: "Privacy Policy", RunicCrucibleAetherBrewSymbol: "hand.raised.fill", RunicCrucibleAetherBrewShowsChevron: false) }.buttonStyle(.plain).RunicCrucibleAetherBrewGlassPanel()
                    }
                    Button { RunicCrucibleAetherBrewShowsReset = true } label: {
                        HStack { Image(systemName: "trash.fill"); Text("Reset Progress") }.font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewDestructive).frame(maxWidth: .infinity)
                    }.buttonStyle(.plain).RunicCrucibleAetherBrewGlassPanel()
                }.padding(.horizontal, 18).padding(.vertical, 14)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $RunicCrucibleAetherBrewShowsPrivacy) { RunicCrucibleAetherBrewSafariView(RunicCrucibleAetherBrewURL: URL(string: "https://www.apple.com/legal/privacy/")!) }
        .alert("Reset all progress?", isPresented: $RunicCrucibleAetherBrewShowsReset) { Button("Cancel", role: .cancel) {}; Button("Reset", role: .destructive) { RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewReset() } } message: { Text("Completed levels, best results, and player statistics will be removed.") }
    }

    private var RunicCrucibleAetherBrewSettingsBackground: some View {
        Image("backgroundGrimoireRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea().overlay(Color.black.opacity(0.48))
    }

    private func RunicCrucibleAetherBrewSection<RunicCrucibleAetherBrewContent: View>(RunicCrucibleAetherBrewTitle: String, @ViewBuilder RunicCrucibleAetherBrewContent: () -> RunicCrucibleAetherBrewContent) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(RunicCrucibleAetherBrewTitle).font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewSectionTitleFont).tracking(1.5).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
            RunicCrucibleAetherBrewContent()
        }
    }

    private func RunicCrucibleAetherBrewToggle(RunicCrucibleAetherBrewTitle: String, RunicCrucibleAetherBrewSymbol: String, RunicCrucibleAetherBrewValue: Binding<Bool>) -> some View {
        Toggle(isOn: RunicCrucibleAetherBrewValue) { Label(RunicCrucibleAetherBrewTitle, systemImage: RunicCrucibleAetherBrewSymbol) }.font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary).tint(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold).padding(.vertical, 4)
    }

    private func RunicCrucibleAetherBrewSettingsRow(RunicCrucibleAetherBrewTitle: String, RunicCrucibleAetherBrewSymbol: String, RunicCrucibleAetherBrewShowsChevron: Bool = true) -> some View {
        HStack(spacing: 12) { Image(systemName: RunicCrucibleAetherBrewSymbol).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewLink).frame(width: 24); Text(RunicCrucibleAetherBrewTitle).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary); Spacer(); if RunicCrucibleAetherBrewShowsChevron { Image(systemName: "chevron.right").font(.caption.bold()).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary) } }.font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont).contentShape(Rectangle()).padding(.vertical, 4)
    }
}

struct RunicCrucibleAetherBrewStatisticsView: View {
    @State private var RunicCrucibleAetherBrewStatistics = RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewStatistics()
    @State private var RunicCrucibleAetherBrewShowsFinaleReplay = false
    private let RunicCrucibleAetherBrewColumns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        ZStack {
            Image("backgroundGrimoireRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea().overlay(Color.black.opacity(0.52))
            ScrollView {
                VStack(spacing: 18) {
                    RunicCrucibleAetherBrewFavoriteCard
                    LazyVGrid(columns: RunicCrucibleAetherBrewColumns, spacing: 12) {
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: "\(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewCompletedLevels)", RunicCrucibleAetherBrewTitle: "Completed Levels", RunicCrucibleAetherBrewSymbol: "checkmark.seal.fill")
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: "\(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewTotalPours)", RunicCrucibleAetherBrewTitle: "Total Pours", RunicCrucibleAetherBrewSymbol: "drop.fill")
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: "\(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewPerfectCompletions)", RunicCrucibleAetherBrewTitle: "Perfect Brews", RunicCrucibleAetherBrewSymbol: "star.fill")
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: "\(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewHintsUsed)", RunicCrucibleAetherBrewTitle: "Hints Used", RunicCrucibleAetherBrewSymbol: "lightbulb.fill")
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: "\(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewCurrentDailyStreak)", RunicCrucibleAetherBrewTitle: "Daily Streak", RunicCrucibleAetherBrewSymbol: "flame.fill")
                        RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: RunicCrucibleAetherBrewTimeText, RunicCrucibleAetherBrewTitle: "Laboratory Time", RunicCrucibleAetherBrewSymbol: "clock.fill")
                    }
                    if RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewIsFinaleUnlocked {
                        Button { RunicCrucibleAetherBrewShowsFinaleReplay = true } label: {
                            Label("Replay Finale", systemImage: "sparkles")
                                .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont.weight(.bold))
                                .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary)
                                .frame(maxWidth: .infinity, minHeight: 48)
                        }
                        .buttonStyle(.plain)
                        .RunicCrucibleAetherBrewGlassPanel()
                        .accessibilityIdentifier("RunicCrucibleAetherBrewReplayFinale")
                    }
                }.padding(18)
            }
        }
        .navigationTitle("Player Statistics")
        .navigationBarTitleDisplayMode(.large)
        .onAppear { RunicCrucibleAetherBrewStatistics = RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewStatistics() }
        .fullScreenCover(isPresented: $RunicCrucibleAetherBrewShowsFinaleReplay) { RunicCrucibleAetherBrewFinaleReplayView() }
    }

    private var RunicCrucibleAetherBrewFavoriteCard: some View {
        HStack(spacing: 18) {
            Image(systemName: RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewFavoriteEssence?.RunicCrucibleAetherBrewSymbol ?? "sparkles")
                .font(.system(size: 42)).foregroundColor(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewFavoriteEssence?.RunicCrucibleAetherBrewColor ?? RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary).frame(width: 64, height: 64).background(Color.black.opacity(0.24), in: Circle())
            VStack(alignment: .leading, spacing: 4) { Text("FAVORITE ESSENCE").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewSectionTitleFont).tracking(1.2).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold); Text(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewFavoriteEssence?.RunicCrucibleAetherBrewName ?? "No essence yet").font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCardTitleFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary) }
            Spacer()
        }.frame(maxWidth: .infinity).RunicCrucibleAetherBrewGlassPanel()
    }

    private func RunicCrucibleAetherBrewStatisticCard(RunicCrucibleAetherBrewValue: String, RunicCrucibleAetherBrewTitle: String, RunicCrucibleAetherBrewSymbol: String) -> some View {
        VStack(spacing: 8) { Image(systemName: RunicCrucibleAetherBrewSymbol).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold); Text(RunicCrucibleAetherBrewValue).font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewStatisticFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary).minimumScaleFactor(0.7).lineLimit(1); Text(RunicCrucibleAetherBrewTitle).font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCaptionFont).foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary).multilineTextAlignment(.center).frame(height: 32) }.frame(maxWidth: .infinity).RunicCrucibleAetherBrewGlassPanel()
    }

    private var RunicCrucibleAetherBrewTimeText: String {
        let RunicCrucibleAetherBrewMinutes = Int(RunicCrucibleAetherBrewStatistics.RunicCrucibleAetherBrewLaboratoryTime) / 60
        let RunicCrucibleAetherBrewHours = RunicCrucibleAetherBrewMinutes / 60
        return RunicCrucibleAetherBrewHours > 0 ? "\(RunicCrucibleAetherBrewHours)h \(RunicCrucibleAetherBrewMinutes % 60)m" : "\(RunicCrucibleAetherBrewMinutes)m"
    }
}

struct RunicCrucibleAetherBrewFinaleReplayView: View {
    @Environment(\.dismiss) private var RunicCrucibleAetherBrewDismiss
    @State private var RunicCrucibleAetherBrewScene = RunicCrucibleAetherBrewGameScene(size: CGSize(width: 390, height: 700))
    @State private var RunicCrucibleAetherBrewShowsCard = false

    var body: some View {
        ZStack {
            Image("backgroundLabRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea()
                .overlay(Color.black.opacity(0.34))
            SpriteView(scene: RunicCrucibleAetherBrewScene, options: [.allowsTransparency, .ignoresSiblingOrder]).ignoresSafeArea()
            if RunicCrucibleAetherBrewShowsCard {
                Color.black.opacity(0.58).ignoresSafeArea()
                RunicCrucibleAetherBrewFinaleView(
                    RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: 30) ?? 0,
                    RunicCrucibleAetherBrewIsPerfect: false,
                    RunicCrucibleAetherBrewReplayAction: RunicCrucibleAetherBrewReplay,
                    RunicCrucibleAetherBrewHomeAction: {
                        RunicCrucibleAetherBrewDismiss()
                        DispatchQueue.main.async { RunicCrucibleAetherBrewAppDelegate.RunicCrucibleAetherBrewShared?.RunicCrucibleAetherBrewSelectTab(.RunicCrucibleAetherBrewHome) }
                    },
                    RunicCrucibleAetherBrewStatisticsAction: { RunicCrucibleAetherBrewDismiss() }
                )
                .padding(22)
                .transition(.scale(scale: 0.88).combined(with: .opacity))
            }
        }
        .onAppear { RunicCrucibleAetherBrewReplay() }
    }

    private func RunicCrucibleAetherBrewReplay() {
        RunicCrucibleAetherBrewShowsCard = false
        RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewShowcaseState)
        RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewPlayFinalAscension {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.82)) { RunicCrucibleAetherBrewShowsCard = true }
        }
    }

    private var RunicCrucibleAetherBrewShowcaseState: RunicCrucibleAetherBrewGameState {
        let RunicCrucibleAetherBrewLevel = RunicCrucibleAetherBrewLevelCatalog.RunicCrucibleAetherBrewLoad()[29]
        let RunicCrucibleAetherBrewAllTypes = RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.flatMap { $0 }
        var RunicCrucibleAetherBrewVials: [RunicCrucibleAetherBrewVial] = []
        for RunicCrucibleAetherBrewType in RunicCrucibleAetherBrewLiquidType.allCases {
            var RunicCrucibleAetherBrewRemaining = RunicCrucibleAetherBrewAllTypes.filter { $0 == RunicCrucibleAetherBrewType }.count
            while RunicCrucibleAetherBrewRemaining > 0 {
                let RunicCrucibleAetherBrewCount = min(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity, RunicCrucibleAetherBrewRemaining)
                RunicCrucibleAetherBrewVials.append(.init(RunicCrucibleAetherBrewTypes: Array(repeating: RunicCrucibleAetherBrewType, count: RunicCrucibleAetherBrewCount), RunicCrucibleAetherBrewCapacity: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity))
                RunicCrucibleAetherBrewRemaining -= RunicCrucibleAetherBrewCount
            }
        }
        while RunicCrucibleAetherBrewVials.count < RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.count { RunicCrucibleAetherBrewVials.append(.init(RunicCrucibleAetherBrewTypes: [], RunicCrucibleAetherBrewCapacity: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewCapacity)) }
        return .init(RunicCrucibleAetherBrewVials: Array(RunicCrucibleAetherBrewVials.prefix(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewVials.count)), RunicCrucibleAetherBrewMoves: RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewBestMoves(RunicCrucibleAetherBrewLevel: 30) ?? 0, RunicCrucibleAetherBrewHintsUsed: 0, RunicCrucibleAetherBrewIsWon: true)
    }
}

struct RunicCrucibleAetherBrewSafariView: UIViewControllerRepresentable { let RunicCrucibleAetherBrewURL: URL; func makeUIViewController(context RunicCrucibleAetherBrewContext: Context) -> SFSafariViewController { SFSafariViewController(url: RunicCrucibleAetherBrewURL) }; func updateUIViewController(_ RunicCrucibleAetherBrewController: SFSafariViewController, context RunicCrucibleAetherBrewContext: Context) {} }
extension UIApplication { var RunicCrucibleAetherBrewKeyWindow: UIWindow? { connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows).first { $0.isKeyWindow } } }
