import SwiftUI
import SpriteKit

struct RunicCrucibleAetherBrewGameView: View {
    @ObservedObject private var RunicCrucibleAetherBrewViewModel = RunicCrucibleAetherBrewGameViewModel.RunicCrucibleAetherBrewShared
    @State private var RunicCrucibleAetherBrewScene = RunicCrucibleAetherBrewGameScene(size: CGSize(width: 390, height: 360))
    @Environment(\.scenePhase) private var RunicCrucibleAetherBrewScenePhase

    var body: some View {
        ZStack {
            Image("backgroundLabRunicCrucibleAetherBrew")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    LinearGradient(
                        colors: [.black.opacity(0.18), .black.opacity(0.48), .black.opacity(0.24)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            VStack(spacing: 4) {
                SpriteView(scene: RunicCrucibleAetherBrewScene, options: [.allowsTransparency, .ignoresSiblingOrder])
                    .frame(maxHeight: .infinity)
                    .background(Color.black.opacity(0.07))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold.opacity(0.12)))
                Text(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewMessage)
                    .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCaptionFont.weight(.semibold))
                    .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary.opacity(0.88))
                    .lineLimit(2)
                    .frame(minHeight: 15)
                RunicCrucibleAetherBrewControls
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 0) {
                    Text("LEVEL \(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLevel.id)")
                        .font(.caption2.bold())
                        .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
                    Text(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTitle)
                        .font(.system(.caption, design: .serif).weight(.bold))
                        .lineLimit(1)
                        .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary)
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                VStack(spacing: 0) {
                    Text("MOVES").font(.system(size: 8, weight: .bold))
                    Text("\(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewMoves)").font(.caption.bold())
                }
                .foregroundColor(.white)
                Button { RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewShowsRules = true } label: {
                    Image(systemName: "book.closed.fill")
                        .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
                }
                    .accessibilityLabel("Level Rules")
            }
        }
        .sheet(isPresented: $RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewShowsRules) { RunicCrucibleAetherBrewRulesView(RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLevel) }
        .alert("Potion Complete!", isPresented: Binding(get: { RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewIsWon }, set: { _ in })) {
            Button("Next Level") {
                RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewLevelNumber: min(30, RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLevel.id + 1))
                RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewState)
            }
        } message: { Text("Completed in \(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewMoves) moves.") }
        .onAppear {
            RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewInteraction = { RunicCrucibleAetherBrewIndex in RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewHandleTap(RunicCrucibleAetherBrewIndex: RunicCrucibleAetherBrewIndex) }
            RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewAnimationCompletion = { RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewAnimationDidFinish() }
            RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewState)
            RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewStartLaboratorySession()
        }
        .onDisappear { RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewPauseLaboratorySession() }
        .onChange(of: RunicCrucibleAetherBrewScenePhase) { RunicCrucibleAetherBrewPhase in
            if RunicCrucibleAetherBrewPhase == .active { RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewStartLaboratorySession() }
            else { RunicCrucibleAetherBrewProgressStore.RunicCrucibleAetherBrewShared.RunicCrucibleAetherBrewPauseLaboratorySession() }
        }
    }

    private var RunicCrucibleAetherBrewControls: some View {
        HStack(spacing: 6) {
            RunicCrucibleAetherBrewControl(RunicCrucibleAetherBrewTitle: "Undo", RunicCrucibleAetherBrewSymbol: "arrow.uturn.backward") { if let RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewUndo() { RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewState) } }
            RunicCrucibleAetherBrewControl(RunicCrucibleAetherBrewTitle: "Restart", RunicCrucibleAetherBrewSymbol: "arrow.clockwise") { RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewRestart()) }
            if RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewLevel.id >= 10 {
                RunicCrucibleAetherBrewControl(RunicCrucibleAetherBrewTitle: "Shuffle", RunicCrucibleAetherBrewSymbol: "shuffle") {
                    if let RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewShuffle() {
                        RunicCrucibleAetherBrewScene.RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewState)
                    }
                }
            }
            RunicCrucibleAetherBrewControl(RunicCrucibleAetherBrewTitle: RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewIsSolvingHint ? "Reading" : "Hint", RunicCrucibleAetherBrewSymbol: RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewIsSolvingHint ? "hourglass" : "lightbulb.fill") { RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewHint() }
        }
    }

    private func RunicCrucibleAetherBrewControl(RunicCrucibleAetherBrewTitle: String, RunicCrucibleAetherBrewSymbol: String, RunicCrucibleAetherBrewAction: @escaping () -> Void) -> some View {
        Button(action: RunicCrucibleAetherBrewAction) {
            Image(systemName: RunicCrucibleAetherBrewSymbol)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 54, height: 34)
                .background(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple)
                .clipShape(Capsule())
                .frame(minWidth: 54, minHeight: 44)
                .contentShape(Rectangle())
        }
            .buttonStyle(.plain)
            .accessibilityLabel(RunicCrucibleAetherBrewTitle)
            .disabled(RunicCrucibleAetherBrewViewModel.RunicCrucibleAetherBrewIsAnimating)
    }
}

struct RunicCrucibleAetherBrewRulesView: View {
    let RunicCrucibleAetherBrewLevel: RunicCrucibleAetherBrewLevelDefinition
    @Environment(\.dismiss) private var RunicCrucibleAetherBrewDismiss

    var body: some View {
        NavigationView {
            ZStack {
                RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBackground.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("Your Goal", systemImage: RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewGoal.RunicCrucibleAetherBrewSymbol)
                                .font(.headline)
                                .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
                            Text(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewTutorial)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.86))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .RunicCrucibleAetherBrewCard()

                        Text("HOW MAGIC WORKS")
                            .font(.caption.bold())
                            .tracking(1.5)
                            .foregroundColor(.white.opacity(0.65))

                        ForEach(RunicCrucibleAetherBrewLevel.RunicCrucibleAetherBrewRules, id: \.rawValue) { RunicCrucibleAetherBrewRule in
                            HStack(alignment: .top, spacing: 13) {
                                Image(systemName: RunicCrucibleAetherBrewRule.RunicCrucibleAetherBrewSymbol)
                                    .font(.title3)
                                    .foregroundColor(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCyan)
                                    .frame(width: 28)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(RunicCrucibleAetherBrewRule.RunicCrucibleAetherBrewTitle).font(.headline).foregroundColor(.white)
                                    Text(RunicCrucibleAetherBrewRule.RunicCrucibleAetherBrewExplanation).font(.subheadline).foregroundColor(.white.opacity(0.72))
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .RunicCrucibleAetherBrewCard()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Level Rules")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { RunicCrucibleAetherBrewDismiss() } } }
        }
    }
}
