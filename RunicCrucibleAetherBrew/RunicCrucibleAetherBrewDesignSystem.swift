import SwiftUI

enum RunicCrucibleAetherBrewDesignSystem {
    static let RunicCrucibleAetherBrewBackground = Color(red: 0.035, green: 0.035, blue: 0.09)
    static let RunicCrucibleAetherBrewSurface = Color(red: 0.10, green: 0.08, blue: 0.18)
    static let RunicCrucibleAetherBrewPurple = Color(red: 0.48, green: 0.22, blue: 0.86)
    static let RunicCrucibleAetherBrewCyan = Color(red: 0.10, green: 0.78, blue: 0.94)
    static let RunicCrucibleAetherBrewGold = Color(red: 0.95, green: 0.69, blue: 0.25)
    static let RunicCrucibleAetherBrewTextPrimary = Color(red: 0.96, green: 0.92, blue: 0.82)
    static let RunicCrucibleAetherBrewTextSecondary = Color(red: 0.73, green: 0.69, blue: 0.64)
    static let RunicCrucibleAetherBrewLink = Color(red: 0.24, green: 0.78, blue: 0.92)
    static let RunicCrucibleAetherBrewDestructive = Color(red: 0.94, green: 0.30, blue: 0.28)
    static let RunicCrucibleAetherBrewScreenTitleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let RunicCrucibleAetherBrewSectionTitleFont = Font.system(.caption, design: .rounded).weight(.bold)
    static let RunicCrucibleAetherBrewCardTitleFont = Font.system(.headline, design: .serif).weight(.semibold)
    static let RunicCrucibleAetherBrewBodyFont = Font.system(.body, design: .rounded)
    static let RunicCrucibleAetherBrewCaptionFont = Font.system(.caption, design: .rounded)
    static let RunicCrucibleAetherBrewStatisticFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let RunicCrucibleAetherBrewRadius: CGFloat = 18
}

struct RunicCrucibleAetherBrewBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewBackground, Color(red: 0.10, green: 0.04, blue: 0.18)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct RunicCrucibleAetherBrewCardModifier: ViewModifier {
    func body(content RunicCrucibleAetherBrewContent: Content) -> some View {
        RunicCrucibleAetherBrewContent
            .padding()
            .background(
                RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius)
                    .fill(Color.black.opacity(0.24))
            )
            .clipShape(RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius))
            .overlay(RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius).stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold.opacity(0.35)))
    }
}

struct RunicCrucibleAetherBrewGrimoireCardModifier: ViewModifier {
    func body(content RunicCrucibleAetherBrewContent: Content) -> some View {
        RunicCrucibleAetherBrewContent
            .padding()
            .background(
                RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius)
                    .fill(Color.black.opacity(0.22))
            )
            .clipShape(RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius))
            .overlay(
                RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius)
                    .stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold.opacity(0.34), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.14), radius: 9, y: 4)
    }
}

struct RunicCrucibleAetherBrewGlassPanelModifier: ViewModifier {
    func body(content RunicCrucibleAetherBrewContent: Content) -> some View {
        RunicCrucibleAetherBrewContent
            .padding(16)
            .background(RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius).fill(Color.black.opacity(0.20)))
            .overlay(RoundedRectangle(cornerRadius: RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewRadius).stroke(RunicCrucibleAetherBrewDesignSystem.RunicCrucibleAetherBrewGold.opacity(0.24)))
    }
}

extension View {
    func RunicCrucibleAetherBrewCard() -> some View {
        modifier(RunicCrucibleAetherBrewCardModifier())
    }

    func RunicCrucibleAetherBrewGrimoireCard() -> some View {
        modifier(RunicCrucibleAetherBrewGrimoireCardModifier())
    }


    func RunicCrucibleAetherBrewGlassPanel() -> some View {
        modifier(RunicCrucibleAetherBrewGlassPanelModifier())
    }
}
