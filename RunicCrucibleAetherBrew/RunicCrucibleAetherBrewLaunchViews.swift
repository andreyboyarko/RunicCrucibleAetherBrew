import SwiftUI

struct RunicCrucibleAetherBrewLoadingView: View {
    @Environment(\.accessibilityReduceMotion) private var RunicCrucibleAetherBrewReduceMotion
    @State private var RunicCrucibleAetherBrewAwake = false
    @State private var RunicCrucibleAetherBrewRotation = 0.0
    @State private var RunicCrucibleAetherBrewReverseRotation = 0.0
    @State private var RunicCrucibleAetherBrewLiquidRise: CGFloat = 0
    @State private var RunicCrucibleAetherBrewReaction = false
    @State private var RunicCrucibleAetherBrewShineOffset: CGFloat = -180

    var body: some View {
        ZStack {
            Image("backgroundLaunchRunicCrucibleAetherBrew")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(RunicCrucibleAetherBrewAwake ? 0.40 : 0.82))
                .animation(.easeOut(duration: 0.55), value: RunicCrucibleAetherBrewAwake)

            VStack(spacing: 8) {
                Spacer()
                RunicCrucibleAetherBrewRitual
                RunicCrucibleAetherBrewTitle
                Spacer()
                RunicCrucibleAetherBrewBrewingIndicator.padding(.bottom, 38)
            }
        }
        .task {
            await RunicCrucibleAetherBrewAnimateRitual()
        }
    }

    private var RunicCrucibleAetherBrewRitual: some View {
        ZStack {
            Circle()
                .fill(RadialGradient(colors: [RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple.opacity(0.48), .clear], center: .center, startRadius: 4, endRadius: 112))
                .frame(width: 230, height: 230)
                .scaleEffect(RunicCrucibleAetherBrewReaction ? 1.16 : 0.78)
                .opacity(RunicCrucibleAetherBrewAwake ? 1 : 0)

            RunicCrucibleAetherBrewRuneRing(RunicCrucibleAetherBrewRadius: 104, RunicCrucibleAetherBrewCount: 16)
                .rotationEffect(.degrees(RunicCrucibleAetherBrewRotation))
                .opacity(RunicCrucibleAetherBrewAwake ? 0.78 : 0)

            RunicCrucibleAetherBrewRuneRing(RunicCrucibleAetherBrewRadius: 86, RunicCrucibleAetherBrewCount: 10)
                .scaleEffect(x: -1, y: 1)
                .rotationEffect(.degrees(RunicCrucibleAetherBrewReverseRotation))
                .opacity(RunicCrucibleAetherBrewAwake ? 0.60 : 0)

            ForEach(Array(RunicCrucibleAetherBrewLiquidType.allCases.enumerated()), id: \.element.id) { RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewType in
                Circle()
                    .fill(RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewColor)
                    .frame(width: RunicCrucibleAetherBrewIndex.isMultiple(of: 2) ? 7 : 5, height: RunicCrucibleAetherBrewIndex.isMultiple(of: 2) ? 7 : 5)
                    .shadow(color: RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewColor, radius: 7)
                    .offset(y: -112)
                    .rotationEffect(.degrees(Double(RunicCrucibleAetherBrewIndex) * 45 + RunicCrucibleAetherBrewRotation * 0.72))
                    .opacity(RunicCrucibleAetherBrewAwake ? 0.92 : 0)
            }

            ZStack(alignment: .bottom) {
                Circle().fill(Color.black.opacity(0.34))
                LinearGradient(colors: [RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCyan, RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple, RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold], startPoint: .bottom, endPoint: .top)
                    .frame(height: 172 * RunicCrucibleAetherBrewLiquidRise)
                    .blur(radius: 8)
            }
            .frame(width: 172, height: 172)
            .clipShape(RoundedRectangle(cornerRadius: 38))

            Image("logoRunicCrucibleAetherBrew")
                .resizable()
                .scaledToFit()
                .frame(width: 172, height: 172)
                .clipShape(RoundedRectangle(cornerRadius: 38))
                .overlay(
                    LinearGradient(colors: [.clear, .white.opacity(0.72), .clear], startPoint: .top, endPoint: .bottom)
                        .frame(width: 34)
                        .rotationEffect(.degrees(18))
                        .offset(x: RunicCrucibleAetherBrewShineOffset)
                        .blendMode(.screen)
                        .clipShape(RoundedRectangle(cornerRadius: 38))
                )
                .scaleEffect(RunicCrucibleAetherBrewReaction ? 1.04 : (RunicCrucibleAetherBrewAwake ? 1 : 0.72))
                .opacity(RunicCrucibleAetherBrewAwake ? 1 : 0)
                .shadow(color: RunicCrucibleAetherBrewReaction ? RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold : RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple, radius: RunicCrucibleAetherBrewReaction ? 34 : 20)
        }
        .frame(width: 250, height: 250)
    }

    private var RunicCrucibleAetherBrewTitle: some View {
        VStack(spacing: 5) {
            Text("AETHER VIALS")
                .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewScreenTitleFont)
                .foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary)
            Text("ARCANE BREW")
                .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewSectionTitleFont)
                .tracking(4)
                .foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
        }
        .opacity(RunicCrucibleAetherBrewAwake ? 1 : 0)
        .offset(y: RunicCrucibleAetherBrewAwake ? 0 : 12)
    }

    private var RunicCrucibleAetherBrewBrewingIndicator: some View {
        TimelineView(.animation(minimumInterval: 0.22)) { RunicCrucibleAetherBrewTimeline in
            let RunicCrucibleAetherBrewStep = Int(RunicCrucibleAetherBrewTimeline.date.timeIntervalSinceReferenceDate * 4) % 4
            VStack(spacing: 10) {
                Text("Brewing the aether")
                    .font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCaptionFont.weight(.semibold))
                    .tracking(0.6)
                HStack(spacing: 9) {
                    ForEach(0..<4, id: \.self) { RunicCrucibleAetherBrewIndex in
                        Image(systemName: "drop.fill")
                            .font(.system(size: 9))
                            .foregroundColor(RunicCrucibleAetherBrewIndex <= RunicCrucibleAetherBrewStep ? RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold : RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary.opacity(0.34))
                            .scaleEffect(RunicCrucibleAetherBrewIndex == RunicCrucibleAetherBrewStep ? 1.28 : 1)
                    }
                }
            }
            .foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary)
        }
    }

    private func RunicCrucibleAetherBrewRuneRing(RunicCrucibleAetherBrewRadius: CGFloat, RunicCrucibleAetherBrewCount: Int) -> some View {
        ZStack {
            Circle().stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold.opacity(0.44), lineWidth: 1)
            Circle().stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple.opacity(0.52), style: StrokeStyle(lineWidth: 2, dash: [2, 9]))
            ForEach(0..<RunicCrucibleAetherBrewCount, id: \.self) { RunicCrucibleAetherBrewIndex in
                Capsule()
                    .fill(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold)
                    .frame(width: RunicCrucibleAetherBrewIndex.isMultiple(of: 4) ? 3 : 2, height: RunicCrucibleAetherBrewIndex.isMultiple(of: 4) ? 12 : 7)
                    .offset(y: -RunicCrucibleAetherBrewRadius)
                    .rotationEffect(.degrees(Double(RunicCrucibleAetherBrewIndex) * 360 / Double(RunicCrucibleAetherBrewCount)))
            }
        }
        .frame(width: RunicCrucibleAetherBrewRadius * 2, height: RunicCrucibleAetherBrewRadius * 2)
    }

    @MainActor
    private func RunicCrucibleAetherBrewAnimateRitual() async {
        withAnimation(.easeOut(duration: 0.42)) { RunicCrucibleAetherBrewAwake = true }
        if !RunicCrucibleAetherBrewReduceMotion {
            withAnimation(.linear(duration: 5.2).repeatForever(autoreverses: false)) { RunicCrucibleAetherBrewRotation = 360 }
            withAnimation(.linear(duration: 4.1).repeatForever(autoreverses: false)) { RunicCrucibleAetherBrewReverseRotation = -360 }
        }
        withAnimation(.easeInOut(duration: 1.05)) { RunicCrucibleAetherBrewLiquidRise = 1 }
        try? await Task.sleep(nanoseconds: 820_000_000)
        guard !Task.isCancelled else { return }
        withAnimation(.spring(response: 0.34, dampingFraction: 0.52)) { RunicCrucibleAetherBrewReaction = true }
        withAnimation(.easeInOut(duration: 0.72)) { RunicCrucibleAetherBrewShineOffset = 180 }
    }
}

struct RunicCrucibleAetherBrewOnboardingPage {
    let RunicCrucibleAetherBrewSymbol: String
    let RunicCrucibleAetherBrewTitle: String
    let RunicCrucibleAetherBrewText: String
}

struct RunicCrucibleAetherBrewOnboardingView: View {
    let RunicCrucibleAetherBrewCompletion: () -> Void
    @State private var RunicCrucibleAetherBrewPage = 0
    private let RunicCrucibleAetherBrewPages = [
        RunicCrucibleAetherBrewOnboardingPage(RunicCrucibleAetherBrewSymbol: "flask.fill", RunicCrucibleAetherBrewTitle: "Welcome, Alchemist", RunicCrucibleAetherBrewText: "Pour matching essences together and create pure magical vials."),
        RunicCrucibleAetherBrewOnboardingPage(RunicCrucibleAetherBrewSymbol: "hand.tap.fill", RunicCrucibleAetherBrewTitle: "Master the Pour", RunicCrucibleAetherBrewText: "Select a source vial, then tap a valid destination vial."),
        RunicCrucibleAetherBrewOnboardingPage(RunicCrucibleAetherBrewSymbol: "sparkles", RunicCrucibleAetherBrewTitle: "Unlock the Grimoire", RunicCrucibleAetherBrewText: "Complete levels to discover new essences and arcane brews.")
    ]
    var body: some View {
        ZStack {
            Image("backgroundLaunchRunicCrucibleAetherBrew").resizable().scaledToFill().ignoresSafeArea().overlay(Color.black.opacity(0.45))
            VStack(spacing: 28) {
                Spacer()
                Image(systemName: RunicCrucibleAetherBrewPages[RunicCrucibleAetherBrewPage].RunicCrucibleAetherBrewSymbol).font(.system(size: 82)).foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewCyan)
                Text(RunicCrucibleAetherBrewPages[RunicCrucibleAetherBrewPage].RunicCrucibleAetherBrewTitle).font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewScreenTitleFont).foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextPrimary).multilineTextAlignment(.center)
                Text(RunicCrucibleAetherBrewPages[RunicCrucibleAetherBrewPage].RunicCrucibleAetherBrewText).font(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBodyFont).foregroundStyle(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewTextSecondary).multilineTextAlignment(.center)
                Spacer()
                Button(RunicCrucibleAetherBrewPage == RunicCrucibleAetherBrewPages.count - 1 ? "Begin Brewing" : "Continue") { RunicCrucibleAetherBrewAdvance() }.buttonStyle(.borderedProminent).tint(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewPurple).controlSize(.large)
            }.padding(30)
        }
    }
    private func RunicCrucibleAetherBrewAdvance() {
        if RunicCrucibleAetherBrewPage < RunicCrucibleAetherBrewPages.count - 1 { withAnimation { RunicCrucibleAetherBrewPage += 1 } }
        else { UserDefaults.standard.set(true, forKey: "RunicCrucibleAetherBrewOnboardingComplete"); RunicCrucibleAetherBrewCompletion() }
    }
}
