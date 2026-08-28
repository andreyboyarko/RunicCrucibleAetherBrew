import SpriteKit
import SwiftUI

enum RunicCrucibleAetherBrewVialVisualDetail {
    case RunicCrucibleAetherBrewFull
    case RunicCrucibleAetherBrewMedium
    case RunicCrucibleAetherBrewCompact

    static func RunicCrucibleAetherBrewResolve(RunicCrucibleAetherBrewVialCount: Int) -> Self {
        switch RunicCrucibleAetherBrewVialCount {
        case ...15: return .RunicCrucibleAetherBrewFull
        case 16...23: return .RunicCrucibleAetherBrewMedium
        default: return .RunicCrucibleAetherBrewCompact
        }
    }
}

extension RunicCrucibleAetherBrewLiquidType {
    var RunicCrucibleAetherBrewRune: String {
        switch self {
        case .fire: return "ᚠ"
        case .frost: return "✣"
        case .nature: return "ᛉ"
        case .aether: return "✦"
        case .light: return "☼"
        case .shadow: return "◐"
        case .void: return "◉"
        case .water: return "ᛜ"
        }
    }

    var RunicCrucibleAetherBrewVisualColor: UIColor {
        switch self {
        case .fire: return UIColor(red: 0.98, green: 0.16, blue: 0.03, alpha: 1)
        case .frost: return UIColor(red: 0.18, green: 0.82, blue: 1.00, alpha: 1)
        case .nature: return UIColor(red: 0.16, green: 0.78, blue: 0.25, alpha: 1)
        case .aether: return UIColor(red: 0.95, green: 0.08, blue: 0.78, alpha: 1)
        case .light: return UIColor(red: 1.00, green: 0.72, blue: 0.05, alpha: 1)
        case .shadow: return UIColor(red: 0.25, green: 0.12, blue: 0.62, alpha: 1)
        case .void: return UIColor(red: 0.24, green: 0.045, blue: 0.38, alpha: 1)
        case .water: return UIColor(red: 0.02, green: 0.43, blue: 1.00, alpha: 1)
        }
    }
}

final class RunicCrucibleAetherBrewVialNode: SKNode {
    let RunicCrucibleAetherBrewIndex: Int
    let RunicCrucibleAetherBrewGlassNode: SKShapeNode
    let RunicCrucibleAetherBrewLiquidContainer = SKNode()

    private let RunicCrucibleAetherBrewGlowNode: SKShapeNode
    private let RunicCrucibleAetherBrewGlassSprite: SKSpriteNode
    private let RunicCrucibleAetherBrewReflectionNode: SKShapeNode
    private let RunicCrucibleAetherBrewLiquidCropNode = SKCropNode()
    private let RunicCrucibleAetherBrewFrozenNode: SKShapeNode
    private let RunicCrucibleAetherBrewWidth: CGFloat
    private let RunicCrucibleAetherBrewHeight: CGFloat
    private let RunicCrucibleAetherBrewDetail: RunicCrucibleAetherBrewVialVisualDetail
    private var RunicCrucibleAetherBrewBasePosition = CGPoint.zero
    private var RunicCrucibleAetherBrewIsFrozen = false
    private var RunicCrucibleAetherBrewIsSelected = false

    init(
        RunicCrucibleAetherBrewIndex: Int,
        RunicCrucibleAetherBrewWidth: CGFloat,
        RunicCrucibleAetherBrewHeight: CGFloat,
        RunicCrucibleAetherBrewDetail: RunicCrucibleAetherBrewVialVisualDetail = .RunicCrucibleAetherBrewFull
    ) {
        self.RunicCrucibleAetherBrewIndex = RunicCrucibleAetherBrewIndex
        self.RunicCrucibleAetherBrewWidth = RunicCrucibleAetherBrewWidth
        self.RunicCrucibleAetherBrewHeight = RunicCrucibleAetherBrewHeight
        self.RunicCrucibleAetherBrewDetail = RunicCrucibleAetherBrewDetail

        let RunicCrucibleAetherBrewCornerRadius = max(8, RunicCrucibleAetherBrewWidth * 0.22)
        let RunicCrucibleAetherBrewRect = CGRect(
            x: -RunicCrucibleAetherBrewWidth / 2,
            y: -RunicCrucibleAetherBrewHeight / 2,
            width: RunicCrucibleAetherBrewWidth,
            height: RunicCrucibleAetherBrewHeight
        )
        let RunicCrucibleAetherBrewBodyHalfWidth = RunicCrucibleAetherBrewWidth * 0.34
        let RunicCrucibleAetherBrewNeckHalfWidth = RunicCrucibleAetherBrewWidth * 0.17
        let RunicCrucibleAetherBrewTopY = RunicCrucibleAetherBrewHeight * 0.49
        let RunicCrucibleAetherBrewNeckBaseY = RunicCrucibleAetherBrewHeight * 0.34
        let RunicCrucibleAetherBrewShoulderY = RunicCrucibleAetherBrewHeight * 0.25
        let RunicCrucibleAetherBrewBottomY = -RunicCrucibleAetherBrewHeight * 0.48
        let RunicCrucibleAetherBrewBodyRadius = max(4, RunicCrucibleAetherBrewWidth * 0.10)
        let RunicCrucibleAetherBrewBottlePath = CGMutablePath()
        RunicCrucibleAetherBrewBottlePath.move(to: CGPoint(x: -RunicCrucibleAetherBrewNeckHalfWidth, y: RunicCrucibleAetherBrewTopY))
        RunicCrucibleAetherBrewBottlePath.addLine(to: CGPoint(x: RunicCrucibleAetherBrewNeckHalfWidth, y: RunicCrucibleAetherBrewTopY))
        RunicCrucibleAetherBrewBottlePath.addLine(to: CGPoint(x: RunicCrucibleAetherBrewNeckHalfWidth, y: RunicCrucibleAetherBrewNeckBaseY))
        RunicCrucibleAetherBrewBottlePath.addQuadCurve(to: CGPoint(x: RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewShoulderY), control: CGPoint(x: RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewNeckBaseY))
        RunicCrucibleAetherBrewBottlePath.addLine(to: CGPoint(x: RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewBottomY + RunicCrucibleAetherBrewBodyRadius))
        RunicCrucibleAetherBrewBottlePath.addQuadCurve(to: CGPoint(x: RunicCrucibleAetherBrewBodyHalfWidth - RunicCrucibleAetherBrewBodyRadius, y: RunicCrucibleAetherBrewBottomY), control: CGPoint(x: RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewBottomY))
        RunicCrucibleAetherBrewBottlePath.addLine(to: CGPoint(x: -RunicCrucibleAetherBrewBodyHalfWidth + RunicCrucibleAetherBrewBodyRadius, y: RunicCrucibleAetherBrewBottomY))
        RunicCrucibleAetherBrewBottlePath.addQuadCurve(to: CGPoint(x: -RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewBottomY + RunicCrucibleAetherBrewBodyRadius), control: CGPoint(x: -RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewBottomY))
        RunicCrucibleAetherBrewBottlePath.addLine(to: CGPoint(x: -RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewShoulderY))
        RunicCrucibleAetherBrewBottlePath.addQuadCurve(to: CGPoint(x: -RunicCrucibleAetherBrewNeckHalfWidth, y: RunicCrucibleAetherBrewNeckBaseY), control: CGPoint(x: -RunicCrucibleAetherBrewBodyHalfWidth, y: RunicCrucibleAetherBrewNeckBaseY))
        RunicCrucibleAetherBrewBottlePath.closeSubpath()
        RunicCrucibleAetherBrewGlowNode = SKShapeNode(path: RunicCrucibleAetherBrewBottlePath)
        RunicCrucibleAetherBrewGlassNode = SKShapeNode(rect: RunicCrucibleAetherBrewRect, cornerRadius: RunicCrucibleAetherBrewCornerRadius)
        RunicCrucibleAetherBrewGlassSprite = SKSpriteNode(imageNamed: "RunicCrucibleAetherBrewVialGlass")
        RunicCrucibleAetherBrewReflectionNode = SKShapeNode(rectOf: CGSize(width: max(2, RunicCrucibleAetherBrewWidth * 0.07), height: RunicCrucibleAetherBrewHeight * 0.60), cornerRadius: 2)
        RunicCrucibleAetherBrewFrozenNode = SKShapeNode(rect: RunicCrucibleAetherBrewRect.insetBy(dx: 3, dy: 3), cornerRadius: RunicCrucibleAetherBrewCornerRadius - 2)
        super.init()

        name = "RunicCrucibleAetherBrewVialNode"

        let RunicCrucibleAetherBrewShadowNode = SKShapeNode(ellipseOf: CGSize(width: RunicCrucibleAetherBrewWidth * 0.90, height: max(5, RunicCrucibleAetherBrewWidth * 0.16)))
        RunicCrucibleAetherBrewShadowNode.fillColor = UIColor.black.withAlphaComponent(0.58)
        RunicCrucibleAetherBrewShadowNode.strokeColor = .clear
        RunicCrucibleAetherBrewShadowNode.position.y = -RunicCrucibleAetherBrewHeight / 2 - 3
        RunicCrucibleAetherBrewShadowNode.zPosition = -3
        addChild(RunicCrucibleAetherBrewShadowNode)

        RunicCrucibleAetherBrewGlowNode.fillColor = .clear
        RunicCrucibleAetherBrewGlowNode.strokeColor = .clear
        RunicCrucibleAetherBrewGlowNode.lineWidth = RunicCrucibleAetherBrewDetail == .RunicCrucibleAetherBrewCompact ? 2 : 2.8
        RunicCrucibleAetherBrewGlowNode.glowWidth = RunicCrucibleAetherBrewDetail == .RunicCrucibleAetherBrewCompact ? 5 : 9
        RunicCrucibleAetherBrewGlowNode.zPosition = -2
        addChild(RunicCrucibleAetherBrewGlowNode)

        let RunicCrucibleAetherBrewMaskRect = CGRect(
            x: -RunicCrucibleAetherBrewWidth * 0.285,
            y: -RunicCrucibleAetherBrewHeight * 0.42,
            width: RunicCrucibleAetherBrewWidth * 0.57,
            height: RunicCrucibleAetherBrewHeight * 0.73
        )
        let RunicCrucibleAetherBrewMaskNode = SKShapeNode(rect: RunicCrucibleAetherBrewMaskRect, cornerRadius: max(4, RunicCrucibleAetherBrewWidth * 0.11))
        RunicCrucibleAetherBrewMaskNode.fillColor = .white
        RunicCrucibleAetherBrewMaskNode.strokeColor = .clear
        RunicCrucibleAetherBrewLiquidCropNode.maskNode = RunicCrucibleAetherBrewMaskNode
        RunicCrucibleAetherBrewLiquidCropNode.addChild(RunicCrucibleAetherBrewLiquidContainer)
        RunicCrucibleAetherBrewLiquidCropNode.zPosition = 1
        addChild(RunicCrucibleAetherBrewLiquidCropNode)

        RunicCrucibleAetherBrewGlassSprite.size = CGSize(width: RunicCrucibleAetherBrewWidth * 1.18, height: RunicCrucibleAetherBrewHeight * 1.10)
        RunicCrucibleAetherBrewGlassSprite.alpha = RunicCrucibleAetherBrewDetail == .RunicCrucibleAetherBrewCompact ? 0.80 : 0.92
        RunicCrucibleAetherBrewGlassSprite.zPosition = 20
        addChild(RunicCrucibleAetherBrewGlassSprite)

        RunicCrucibleAetherBrewReflectionNode.fillColor = UIColor.white.withAlphaComponent(RunicCrucibleAetherBrewDetail == .RunicCrucibleAetherBrewCompact ? 0.13 : 0.24)
        RunicCrucibleAetherBrewReflectionNode.strokeColor = .clear
        RunicCrucibleAetherBrewReflectionNode.position = CGPoint(x: -RunicCrucibleAetherBrewWidth * 0.28, y: RunicCrucibleAetherBrewHeight * 0.03)
        RunicCrucibleAetherBrewReflectionNode.zPosition = 21
        addChild(RunicCrucibleAetherBrewReflectionNode)

        RunicCrucibleAetherBrewFrozenNode.fillColor = UIColor.cyan.withAlphaComponent(0.13)
        RunicCrucibleAetherBrewFrozenNode.strokeColor = UIColor.cyan.withAlphaComponent(0.9)
        RunicCrucibleAetherBrewFrozenNode.lineWidth = 2
        RunicCrucibleAetherBrewFrozenNode.glowWidth = 8
        RunicCrucibleAetherBrewFrozenNode.isHidden = true
        RunicCrucibleAetherBrewFrozenNode.zPosition = 40
        addChild(RunicCrucibleAetherBrewFrozenNode)

        RunicCrucibleAetherBrewGlassNode.fillColor = UIColor.clear
        RunicCrucibleAetherBrewGlassNode.strokeColor = .clear
        RunicCrucibleAetherBrewGlassNode.lineWidth = 0
        RunicCrucibleAetherBrewGlassNode.name = "RunicCrucibleAetherBrewHitArea"
        RunicCrucibleAetherBrewGlassNode.userData = ["RunicCrucibleAetherBrewIndex": RunicCrucibleAetherBrewIndex]
        RunicCrucibleAetherBrewGlassNode.zPosition = 100
        addChild(RunicCrucibleAetherBrewGlassNode)
    }

    required init?(coder RunicCrucibleAetherBrewCoder: NSCoder) {
        fatalError("Storyboard loading is not supported.")
    }

    func RunicCrucibleAetherBrewSetBasePosition(_ RunicCrucibleAetherBrewPosition: CGPoint) {
        RunicCrucibleAetherBrewBasePosition = RunicCrucibleAetherBrewPosition
        position = RunicCrucibleAetherBrewPosition
    }

    func RunicCrucibleAetherBrewMoveToBasePosition(_ RunicCrucibleAetherBrewPosition: CGPoint) {
        removeAction(forKey: "RunicCrucibleAetherBrewSelection")
        removeAction(forKey: "RunicCrucibleAetherBrewPour")
        RunicCrucibleAetherBrewIsSelected = false
        RunicCrucibleAetherBrewGlowNode.removeAllActions()
        RunicCrucibleAetherBrewGlowNode.strokeColor = .clear
        RunicCrucibleAetherBrewBasePosition = RunicCrucibleAetherBrewPosition
        zRotation = 0
        setScale(1)
        RunicCrucibleAetherBrewRefreshOutline()
        run(.move(to: RunicCrucibleAetherBrewPosition, duration: UIAccessibility.isReduceMotionEnabled ? 0.08 : 0.24), withKey: "RunicCrucibleAetherBrewShuffle")
    }

    func RunicCrucibleAetherBrewUpdate(_ RunicCrucibleAetherBrewVial: RunicCrucibleAetherBrewVial) {
        RunicCrucibleAetherBrewLiquidContainer.removeAllChildren()
        let RunicCrucibleAetherBrewInteriorWidth = RunicCrucibleAetherBrewWidth * 0.57
        let RunicCrucibleAetherBrewInteriorHeight = RunicCrucibleAetherBrewHeight * 0.73
        let RunicCrucibleAetherBrewInteriorCenterY = -RunicCrucibleAetherBrewHeight * 0.055
        let RunicCrucibleAetherBrewLayerHeight = RunicCrucibleAetherBrewInteriorHeight / CGFloat(RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewCapacity)
        var RunicCrucibleAetherBrewLayerIndex = 0

        while RunicCrucibleAetherBrewLayerIndex < RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers.count {
            let RunicCrucibleAetherBrewLayer = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers[RunicCrucibleAetherBrewLayerIndex]
            var RunicCrucibleAetherBrewGroupEndIndex = RunicCrucibleAetherBrewLayerIndex + 1
            while RunicCrucibleAetherBrewGroupEndIndex < RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers.count {
                let RunicCrucibleAetherBrewNextLayer = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers[RunicCrucibleAetherBrewGroupEndIndex]
                guard RunicCrucibleAetherBrewNextLayer.RunicCrucibleAetherBrewType == RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewType,
                      RunicCrucibleAetherBrewNextLayer.RunicCrucibleAetherBrewIsEmpowered == RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewIsEmpowered else { break }
                RunicCrucibleAetherBrewGroupEndIndex += 1
            }

            let RunicCrucibleAetherBrewGroupCount = RunicCrucibleAetherBrewGroupEndIndex - RunicCrucibleAetherBrewLayerIndex
            let RunicCrucibleAetherBrewGroupHeight = RunicCrucibleAetherBrewLayerHeight * CGFloat(RunicCrucibleAetherBrewGroupCount)
            let RunicCrucibleAetherBrewGroupY = RunicCrucibleAetherBrewInteriorCenterY - RunicCrucibleAetherBrewInteriorHeight / 2 + CGFloat(RunicCrucibleAetherBrewLayerIndex) * RunicCrucibleAetherBrewLayerHeight
            let RunicCrucibleAetherBrewLiquidNode = RunicCrucibleAetherBrewMakeLiquidNode(
                RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewType,
                RunicCrucibleAetherBrewSize: CGSize(width: RunicCrucibleAetherBrewInteriorWidth, height: RunicCrucibleAetherBrewGroupHeight),
                RunicCrucibleAetherBrewEmpowered: RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewIsEmpowered
            )
            RunicCrucibleAetherBrewLiquidNode.position = CGPoint(x: 0, y: RunicCrucibleAetherBrewGroupY + RunicCrucibleAetherBrewGroupHeight / 2)
            RunicCrucibleAetherBrewLiquidContainer.addChild(RunicCrucibleAetherBrewLiquidNode)
            RunicCrucibleAetherBrewLayerIndex = RunicCrucibleAetherBrewGroupEndIndex
        }

        RunicCrucibleAetherBrewIsFrozen = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewFrozenTurns > 0
        RunicCrucibleAetherBrewFrozenNode.isHidden = !RunicCrucibleAetherBrewIsFrozen
        RunicCrucibleAetherBrewRefreshOutline()
    }

    private func RunicCrucibleAetherBrewMakeLiquidNode(
        RunicCrucibleAetherBrewType: RunicCrucibleAetherBrewLiquidType,
        RunicCrucibleAetherBrewSize: CGSize,
        RunicCrucibleAetherBrewEmpowered: Bool
    ) -> SKNode {
        let RunicCrucibleAetherBrewNode = SKNode()
        let RunicCrucibleAetherBrewBaseColor = RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewVisualColor
        let RunicCrucibleAetherBrewBodyNode = SKShapeNode(rectOf: CGSize(width: RunicCrucibleAetherBrewSize.width, height: RunicCrucibleAetherBrewSize.height + 0.8), cornerRadius: 1.2)
        RunicCrucibleAetherBrewBodyNode.fillColor = RunicCrucibleAetherBrewBaseColor.withAlphaComponent(0.82)
        RunicCrucibleAetherBrewBodyNode.strokeColor = RunicCrucibleAetherBrewType == .void
            ? UIColor(red: 0.78, green: 0.22, blue: 1.00, alpha: 0.95)
            : RunicCrucibleAetherBrewBaseColor.withAlphaComponent(0.95)
        RunicCrucibleAetherBrewBodyNode.lineWidth = RunicCrucibleAetherBrewType == .void ? 1.8 : 1
        RunicCrucibleAetherBrewBodyNode.glowWidth = RunicCrucibleAetherBrewType == .void ? 5 : (RunicCrucibleAetherBrewEmpowered ? 7 : 1.5)
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewBodyNode)

        let RunicCrucibleAetherBrewShadeNode = SKShapeNode(rectOf: CGSize(width: RunicCrucibleAetherBrewSize.width * 0.38, height: RunicCrucibleAetherBrewSize.height + 1), cornerRadius: 1)
        RunicCrucibleAetherBrewShadeNode.fillColor = UIColor.black.withAlphaComponent(0.26)
        RunicCrucibleAetherBrewShadeNode.strokeColor = .clear
        RunicCrucibleAetherBrewShadeNode.position.x = RunicCrucibleAetherBrewSize.width * 0.30
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewShadeNode)

        let RunicCrucibleAetherBrewInnerLightNode = SKShapeNode(rectOf: CGSize(width: RunicCrucibleAetherBrewSize.width * 0.22, height: max(2, RunicCrucibleAetherBrewSize.height - 2)), cornerRadius: 2)
        RunicCrucibleAetherBrewInnerLightNode.fillColor = RunicCrucibleAetherBrewType == .void
            ? UIColor(red: 0.76, green: 0.32, blue: 1.00, alpha: 0.24)
            : UIColor.white.withAlphaComponent(0.16)
        RunicCrucibleAetherBrewInnerLightNode.strokeColor = .clear
        RunicCrucibleAetherBrewInnerLightNode.position.x = -RunicCrucibleAetherBrewSize.width * 0.19
        RunicCrucibleAetherBrewInnerLightNode.zPosition = 2
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewInnerLightNode)

        let RunicCrucibleAetherBrewBottomDepthNode = SKShapeNode(rectOf: CGSize(width: RunicCrucibleAetherBrewSize.width * 0.94, height: min(5, RunicCrucibleAetherBrewSize.height * 0.16)), cornerRadius: 2)
        RunicCrucibleAetherBrewBottomDepthNode.fillColor = UIColor.black.withAlphaComponent(0.16)
        RunicCrucibleAetherBrewBottomDepthNode.strokeColor = .clear
        RunicCrucibleAetherBrewBottomDepthNode.position.y = -RunicCrucibleAetherBrewSize.height / 2 + RunicCrucibleAetherBrewBottomDepthNode.frame.height / 2
        RunicCrucibleAetherBrewBottomDepthNode.zPosition = 2
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewBottomDepthNode)

        let RunicCrucibleAetherBrewSurfaceNode = SKShapeNode(ellipseOf: CGSize(width: RunicCrucibleAetherBrewSize.width * 0.96, height: max(2.5, min(7, RunicCrucibleAetherBrewSize.height * 0.12))))
        RunicCrucibleAetherBrewSurfaceNode.fillColor = RunicCrucibleAetherBrewBaseColor.RunicCrucibleAetherBrewLightened.withAlphaComponent(0.94)
        RunicCrucibleAetherBrewSurfaceNode.strokeColor = UIColor.white.withAlphaComponent(0.52)
        RunicCrucibleAetherBrewSurfaceNode.lineWidth = 0.7
        RunicCrucibleAetherBrewSurfaceNode.position.y = RunicCrucibleAetherBrewSize.height / 2 - 1
        RunicCrucibleAetherBrewSurfaceNode.zPosition = 3
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewSurfaceNode)

        let RunicCrucibleAetherBrewRuneNode = SKLabelNode(text: RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewRune)
        RunicCrucibleAetherBrewRuneNode.fontName = "AvenirNext-DemiBold"
        RunicCrucibleAetherBrewRuneNode.fontSize = min(RunicCrucibleAetherBrewSize.width * 0.52, RunicCrucibleAetherBrewSize.height * 0.48)
        RunicCrucibleAetherBrewRuneNode.fontColor = RunicCrucibleAetherBrewType == .void
            ? UIColor(red: 0.92, green: 0.72, blue: 1.00, alpha: 0.96)
            : UIColor.white.withAlphaComponent(0.76)
        RunicCrucibleAetherBrewRuneNode.verticalAlignmentMode = .center
        RunicCrucibleAetherBrewRuneNode.horizontalAlignmentMode = .center
        RunicCrucibleAetherBrewRuneNode.zPosition = 4
        RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewRuneNode)

        if RunicCrucibleAetherBrewDetail != .RunicCrucibleAetherBrewCompact && !UIAccessibility.isReduceMotionEnabled {
            let RunicCrucibleAetherBrewParticleCount = RunicCrucibleAetherBrewDetail == .RunicCrucibleAetherBrewFull ? 3 : 1
            for RunicCrucibleAetherBrewParticleIndex in 0..<RunicCrucibleAetherBrewParticleCount {
                let RunicCrucibleAetherBrewParticleNode = SKShapeNode(circleOfRadius: RunicCrucibleAetherBrewParticleIndex == 0 ? 1.8 : 1.2)
                RunicCrucibleAetherBrewParticleNode.fillColor = UIColor.white.withAlphaComponent(0.72)
                RunicCrucibleAetherBrewParticleNode.strokeColor = .clear
                RunicCrucibleAetherBrewParticleNode.position = CGPoint(
                    x: CGFloat(RunicCrucibleAetherBrewParticleIndex - 1) * RunicCrucibleAetherBrewSize.width * 0.19,
                    y: -RunicCrucibleAetherBrewSize.height * 0.30
                )
                RunicCrucibleAetherBrewParticleNode.zPosition = 3
                RunicCrucibleAetherBrewParticleNode.run(.repeatForever(.sequence([
                    .moveBy(x: 0, y: RunicCrucibleAetherBrewSize.height * 0.55, duration: 1.8 + Double(RunicCrucibleAetherBrewParticleIndex) * 0.35),
                    .fadeOut(withDuration: 0.22),
                    .moveBy(x: 0, y: -RunicCrucibleAetherBrewSize.height * 0.55, duration: 0),
                    .fadeIn(withDuration: 0.12)
                ])))
                RunicCrucibleAetherBrewNode.addChild(RunicCrucibleAetherBrewParticleNode)
            }
            RunicCrucibleAetherBrewSurfaceNode.run(.repeatForever(.sequence([
                .scaleX(to: 0.92, duration: 1.2),
                .scaleX(to: 1.0, duration: 1.2)
            ])))
        }
        return RunicCrucibleAetherBrewNode
    }

    func RunicCrucibleAetherBrewSetSelected(_ RunicCrucibleAetherBrewSelected: Bool, RunicCrucibleAetherBrewAnimated: Bool = true) {
        RunicCrucibleAetherBrewIsSelected = RunicCrucibleAetherBrewSelected
        removeAction(forKey: "RunicCrucibleAetherBrewSelection")
        RunicCrucibleAetherBrewGlowNode.removeAllActions()
        RunicCrucibleAetherBrewRefreshOutline()
        RunicCrucibleAetherBrewGlowNode.strokeColor = RunicCrucibleAetherBrewSelected ? UIColor(red: 1, green: 0.72, blue: 0.14, alpha: 1) : .clear
        let RunicCrucibleAetherBrewTargetScale: CGFloat = RunicCrucibleAetherBrewSelected ? 1.045 : 1
        let RunicCrucibleAetherBrewSelectionLift = RunicCrucibleAetherBrewSelected ? RunicCrucibleAetherBrewSafeVerticalLift(RunicCrucibleAetherBrewDesiredLift: 10, RunicCrucibleAetherBrewScale: RunicCrucibleAetherBrewTargetScale) : 0
        let RunicCrucibleAetherBrewTargetPosition = CGPoint(x: RunicCrucibleAetherBrewBasePosition.x, y: RunicCrucibleAetherBrewBasePosition.y + RunicCrucibleAetherBrewSelectionLift)
        if RunicCrucibleAetherBrewAnimated {
            run(.group([
                .move(to: RunicCrucibleAetherBrewTargetPosition, duration: 0.10),
                .scale(to: RunicCrucibleAetherBrewTargetScale, duration: 0.10)
            ]), withKey: "RunicCrucibleAetherBrewSelection")
            RunicCrucibleAetherBrewLiquidContainer.run(.sequence([.scaleY(to: 0.96, duration: 0.08), .scaleY(to: 1, duration: 0.13)]))
        } else {
            position = RunicCrucibleAetherBrewTargetPosition
            setScale(RunicCrucibleAetherBrewTargetScale)
        }
        if RunicCrucibleAetherBrewSelected {
            RunicCrucibleAetherBrewGlowNode.run(.repeatForever(.sequence([.fadeAlpha(to: 0.42, duration: 0.42), .fadeAlpha(to: 1, duration: 0.42)])))
        }
    }

    func RunicCrucibleAetherBrewAnimatePour(RunicCrucibleAetherBrewDirection: CGFloat) {
        removeAction(forKey: "RunicCrucibleAetherBrewSelection")
        removeAction(forKey: "RunicCrucibleAetherBrewPour")
        RunicCrucibleAetherBrewIsSelected = false
        RunicCrucibleAetherBrewGlowNode.removeAllActions()
        RunicCrucibleAetherBrewGlowNode.strokeColor = .clear
        RunicCrucibleAetherBrewRefreshOutline()
        setScale(1)
        position = RunicCrucibleAetherBrewBasePosition

        let RunicCrucibleAetherBrewPourLift = RunicCrucibleAetherBrewSafeVerticalLift(RunicCrucibleAetherBrewDesiredLift: 10, RunicCrucibleAetherBrewScale: 1)
        let RunicCrucibleAetherBrewLiftedPosition = CGPoint(
            x: RunicCrucibleAetherBrewBasePosition.x,
            y: RunicCrucibleAetherBrewBasePosition.y + RunicCrucibleAetherBrewPourLift
        )
        run(.sequence([
            .group([
                .rotate(toAngle: RunicCrucibleAetherBrewDirection * 0.28, duration: 0.10),
                .move(to: RunicCrucibleAetherBrewLiftedPosition, duration: 0.10)
            ]),
            .wait(forDuration: 0.14),
            .group([
                .rotate(toAngle: 0, duration: 0.11),
                .move(to: RunicCrucibleAetherBrewBasePosition, duration: 0.11)
            ]),
            .run { [weak self] in
                guard let self else { return }
                self.position = self.RunicCrucibleAetherBrewBasePosition
                self.zRotation = 0
                self.setScale(1)
            }
        ]), withKey: "RunicCrucibleAetherBrewPour")
    }

    func RunicCrucibleAetherBrewRestoreBasePosition() {
        removeAction(forKey: "RunicCrucibleAetherBrewSelection")
        removeAction(forKey: "RunicCrucibleAetherBrewPour")
        position = RunicCrucibleAetherBrewBasePosition
        zRotation = 0
        setScale(1)
    }

    private func RunicCrucibleAetherBrewSafeVerticalLift(RunicCrucibleAetherBrewDesiredLift: CGFloat, RunicCrucibleAetherBrewScale: CGFloat) -> CGFloat {
        guard let RunicCrucibleAetherBrewSceneHeight = scene?.size.height else { return RunicCrucibleAetherBrewDesiredLift }
        let RunicCrucibleAetherBrewVisualTop = RunicCrucibleAetherBrewBasePosition.y + RunicCrucibleAetherBrewHeight * 0.55 * RunicCrucibleAetherBrewScale
        let RunicCrucibleAetherBrewAvailableLift = RunicCrucibleAetherBrewSceneHeight - 3 - RunicCrucibleAetherBrewVisualTop
        return min(RunicCrucibleAetherBrewDesiredLift, RunicCrucibleAetherBrewAvailableLift)
    }

    private func RunicCrucibleAetherBrewRefreshOutline() {
        if RunicCrucibleAetherBrewIsSelected {
            RunicCrucibleAetherBrewGlassNode.strokeColor = .clear
            RunicCrucibleAetherBrewGlassNode.lineWidth = 0
        } else if RunicCrucibleAetherBrewIsFrozen {
            RunicCrucibleAetherBrewGlassNode.strokeColor = UIColor.cyan.withAlphaComponent(0.9)
            RunicCrucibleAetherBrewGlassNode.lineWidth = 2
        } else {
            RunicCrucibleAetherBrewGlassNode.strokeColor = .clear
            RunicCrucibleAetherBrewGlassNode.lineWidth = 0
        }
    }

    func RunicCrucibleAetherBrewShowError() {
        removeAction(forKey: "RunicCrucibleAetherBrewError")
        let RunicCrucibleAetherBrewOriginalX = position.x
        RunicCrucibleAetherBrewGlassNode.strokeColor = UIColor(red: 1, green: 0.12, blue: 0.10, alpha: 1)
        RunicCrucibleAetherBrewGlassNode.lineWidth = 3
        RunicCrucibleAetherBrewGlassNode.glowWidth = 9
        let RunicCrucibleAetherBrewErrorLabel = SKLabelNode(text: "×")
        RunicCrucibleAetherBrewErrorLabel.fontName = "AvenirNext-Bold"
        RunicCrucibleAetherBrewErrorLabel.fontSize = min(32, RunicCrucibleAetherBrewWidth * 0.65)
        RunicCrucibleAetherBrewErrorLabel.fontColor = .systemRed
        RunicCrucibleAetherBrewErrorLabel.position = CGPoint(x: 0, y: RunicCrucibleAetherBrewHeight / 2 + 7)
        RunicCrucibleAetherBrewErrorLabel.zPosition = 200
        addChild(RunicCrucibleAetherBrewErrorLabel)
        run(.sequence([
            .moveTo(x: RunicCrucibleAetherBrewOriginalX - 6, duration: 0.06),
            .moveTo(x: RunicCrucibleAetherBrewOriginalX + 6, duration: 0.06),
            .moveTo(x: RunicCrucibleAetherBrewOriginalX - 3, duration: 0.06),
            .moveTo(x: RunicCrucibleAetherBrewOriginalX, duration: 0.06)
        ]), withKey: "RunicCrucibleAetherBrewError")
        RunicCrucibleAetherBrewErrorLabel.run(.sequence([.wait(forDuration: 0.25), .fadeOut(withDuration: 0.18), .removeFromParent()]))
        RunicCrucibleAetherBrewGlassNode.run(.sequence([.wait(forDuration: 0.30), .run { [weak self] in
            self?.RunicCrucibleAetherBrewGlassNode.glowWidth = 0
            self?.RunicCrucibleAetherBrewRefreshOutline()
        }]))
    }
}

private extension UIColor {
    var RunicCrucibleAetherBrewLightened: UIColor {
        var RunicCrucibleAetherBrewHue: CGFloat = 0
        var RunicCrucibleAetherBrewSaturation: CGFloat = 0
        var RunicCrucibleAetherBrewBrightness: CGFloat = 0
        var RunicCrucibleAetherBrewAlpha: CGFloat = 0
        getHue(&RunicCrucibleAetherBrewHue, saturation: &RunicCrucibleAetherBrewSaturation, brightness: &RunicCrucibleAetherBrewBrightness, alpha: &RunicCrucibleAetherBrewAlpha)
        return UIColor(
            hue: RunicCrucibleAetherBrewHue,
            saturation: max(0, RunicCrucibleAetherBrewSaturation * 0.78),
            brightness: min(1, RunicCrucibleAetherBrewBrightness * 1.30),
            alpha: RunicCrucibleAetherBrewAlpha
        )
    }
}
