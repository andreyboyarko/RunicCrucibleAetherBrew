import SpriteKit
import SwiftUI

final class RunicCrucibleAetherBrewLegacyVialNode: SKNode {
    let RunicCrucibleAetherBrewIndex: Int
    let RunicCrucibleAetherBrewGlassNode: SKShapeNode
    let RunicCrucibleAetherBrewLiquidContainer = SKNode()
    private let RunicCrucibleAetherBrewGlowNode: SKShapeNode
    private let RunicCrucibleAetherBrewWidth: CGFloat
    private let RunicCrucibleAetherBrewHeight: CGFloat
    private var RunicCrucibleAetherBrewBasePosition = CGPoint.zero
    private var RunicCrucibleAetherBrewIsFrozen = false

    init(RunicCrucibleAetherBrewIndex: Int, RunicCrucibleAetherBrewWidth: CGFloat, RunicCrucibleAetherBrewHeight: CGFloat) {
        self.RunicCrucibleAetherBrewIndex = RunicCrucibleAetherBrewIndex
        self.RunicCrucibleAetherBrewWidth = RunicCrucibleAetherBrewWidth
        self.RunicCrucibleAetherBrewHeight = RunicCrucibleAetherBrewHeight
        let RunicCrucibleAetherBrewRect = CGRect(x: -RunicCrucibleAetherBrewWidth / 2, y: -RunicCrucibleAetherBrewHeight / 2, width: RunicCrucibleAetherBrewWidth, height: RunicCrucibleAetherBrewHeight)
        RunicCrucibleAetherBrewGlowNode = SKShapeNode(rect: RunicCrucibleAetherBrewRect.insetBy(dx: -3, dy: -3), cornerRadius: 21)
        RunicCrucibleAetherBrewGlassNode = SKShapeNode(rect: RunicCrucibleAetherBrewRect, cornerRadius: 18)
        super.init()
        name = "RunicCrucibleAetherBrewVialNode"
        RunicCrucibleAetherBrewGlowNode.fillColor = .clear
        RunicCrucibleAetherBrewGlowNode.strokeColor = .clear
        RunicCrucibleAetherBrewGlowNode.glowWidth = 12
        RunicCrucibleAetherBrewGlowNode.zPosition = -1
        addChild(RunicCrucibleAetherBrewGlowNode)
        addChild(RunicCrucibleAetherBrewLiquidContainer)
        RunicCrucibleAetherBrewGlassNode.fillColor = UIColor.white.withAlphaComponent(0.05)
        RunicCrucibleAetherBrewGlassNode.strokeColor = UIColor.white.withAlphaComponent(0.75)
        RunicCrucibleAetherBrewGlassNode.lineWidth = 2
        RunicCrucibleAetherBrewGlassNode.name = "RunicCrucibleAetherBrewHitArea"
        RunicCrucibleAetherBrewGlassNode.userData = ["RunicCrucibleAetherBrewIndex": RunicCrucibleAetherBrewIndex]
        RunicCrucibleAetherBrewGlassNode.zPosition = 100
        addChild(RunicCrucibleAetherBrewGlassNode)
    }

    required init?(coder RunicCrucibleAetherBrewCoder: NSCoder) { fatalError("Storyboard loading is not supported.") }

    func RunicCrucibleAetherBrewSetBasePosition(_ RunicCrucibleAetherBrewPosition: CGPoint) {
        RunicCrucibleAetherBrewBasePosition = RunicCrucibleAetherBrewPosition
        position = RunicCrucibleAetherBrewPosition
    }

    func RunicCrucibleAetherBrewUpdate(_ RunicCrucibleAetherBrewVial: RunicCrucibleAetherBrewVial) {
        RunicCrucibleAetherBrewLiquidContainer.removeAllChildren()
        let RunicCrucibleAetherBrewLayerHeight = (RunicCrucibleAetherBrewHeight - 14) / CGFloat(RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewCapacity)
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
            let RunicCrucibleAetherBrewRect = CGRect(x: -RunicCrucibleAetherBrewWidth / 2 + 5, y: -RunicCrucibleAetherBrewHeight / 2 + 7 + CGFloat(RunicCrucibleAetherBrewLayerIndex) * RunicCrucibleAetherBrewLayerHeight, width: RunicCrucibleAetherBrewWidth - 10, height: RunicCrucibleAetherBrewLayerHeight * CGFloat(RunicCrucibleAetherBrewGroupCount))
            let RunicCrucibleAetherBrewLayerNode = SKShapeNode(rect: RunicCrucibleAetherBrewRect, cornerRadius: 4)
            RunicCrucibleAetherBrewLayerNode.fillColor = UIColor(RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewColor)
            RunicCrucibleAetherBrewLayerNode.strokeColor = .clear
            RunicCrucibleAetherBrewLayerNode.glowWidth = RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewIsEmpowered ? 8 : 1
            RunicCrucibleAetherBrewLiquidContainer.addChild(RunicCrucibleAetherBrewLayerNode)
            let RunicCrucibleAetherBrewEssenceLabel = SKLabelNode(text: RunicCrucibleAetherBrewLayer.RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewEmoji)
            RunicCrucibleAetherBrewEssenceLabel.fontSize = min(18, max(11, RunicCrucibleAetherBrewWidth * 0.28))
            RunicCrucibleAetherBrewEssenceLabel.verticalAlignmentMode = .center
            RunicCrucibleAetherBrewEssenceLabel.horizontalAlignmentMode = .center
            RunicCrucibleAetherBrewEssenceLabel.position = CGPoint(x: RunicCrucibleAetherBrewRect.midX, y: RunicCrucibleAetherBrewRect.midY)
            RunicCrucibleAetherBrewEssenceLabel.zPosition = 2
            RunicCrucibleAetherBrewLiquidContainer.addChild(RunicCrucibleAetherBrewEssenceLabel)
            RunicCrucibleAetherBrewLayerIndex = RunicCrucibleAetherBrewGroupEndIndex
        }
        RunicCrucibleAetherBrewIsFrozen = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewFrozenTurns > 0
        RunicCrucibleAetherBrewGlassNode.strokeColor = RunicCrucibleAetherBrewIsFrozen ? .cyan : UIColor.white.withAlphaComponent(0.75)
    }

    func RunicCrucibleAetherBrewSetSelected(_ RunicCrucibleAetherBrewSelected: Bool, RunicCrucibleAetherBrewAnimated: Bool = true) {
        removeAction(forKey: "RunicCrucibleAetherBrewSelection")
        RunicCrucibleAetherBrewGlowNode.removeAllActions()
        RunicCrucibleAetherBrewGlassNode.strokeColor = RunicCrucibleAetherBrewSelected ? .systemYellow : (RunicCrucibleAetherBrewIsFrozen ? .cyan : UIColor.white.withAlphaComponent(0.75))
        RunicCrucibleAetherBrewGlassNode.lineWidth = RunicCrucibleAetherBrewSelected ? 4 : 2
        RunicCrucibleAetherBrewGlowNode.strokeColor = RunicCrucibleAetherBrewSelected ? .systemYellow : .clear
        let RunicCrucibleAetherBrewTargetPosition = CGPoint(x: RunicCrucibleAetherBrewBasePosition.x, y: RunicCrucibleAetherBrewBasePosition.y + (RunicCrucibleAetherBrewSelected ? 12 : 0))
        let RunicCrucibleAetherBrewTargetScale: CGFloat = RunicCrucibleAetherBrewSelected ? 1.04 : 1
        if RunicCrucibleAetherBrewAnimated { run(.group([.move(to: RunicCrucibleAetherBrewTargetPosition, duration: 0.10), .scale(to: RunicCrucibleAetherBrewTargetScale, duration: 0.10)]), withKey: "RunicCrucibleAetherBrewSelection") } else { position = RunicCrucibleAetherBrewTargetPosition; setScale(RunicCrucibleAetherBrewTargetScale) }
        if RunicCrucibleAetherBrewSelected { RunicCrucibleAetherBrewGlowNode.run(.repeatForever(.sequence([.fadeAlpha(to: 0.45, duration: 0.35), .fadeAlpha(to: 1, duration: 0.35)]))) }
    }

    func RunicCrucibleAetherBrewShowError() {
        removeAction(forKey: "RunicCrucibleAetherBrewError")
        let RunicCrucibleAetherBrewOriginalX = position.x
        RunicCrucibleAetherBrewGlassNode.strokeColor = .systemRed
        let RunicCrucibleAetherBrewErrorLabel = SKLabelNode(text: "×")
        RunicCrucibleAetherBrewErrorLabel.fontName = "AvenirNext-Bold"
        RunicCrucibleAetherBrewErrorLabel.fontSize = 34
        RunicCrucibleAetherBrewErrorLabel.fontColor = .systemRed
        RunicCrucibleAetherBrewErrorLabel.position = CGPoint(x: 0, y: RunicCrucibleAetherBrewHeight / 2 + 12)
        RunicCrucibleAetherBrewErrorLabel.zPosition = 200
        addChild(RunicCrucibleAetherBrewErrorLabel)
        run(.sequence([.moveTo(x: RunicCrucibleAetherBrewOriginalX - 7, duration: 0.07), .moveTo(x: RunicCrucibleAetherBrewOriginalX + 7, duration: 0.07), .moveTo(x: RunicCrucibleAetherBrewOriginalX - 4, duration: 0.07), .moveTo(x: RunicCrucibleAetherBrewOriginalX, duration: 0.07)]), withKey: "RunicCrucibleAetherBrewError")
        RunicCrucibleAetherBrewErrorLabel.run(.sequence([.wait(forDuration: 0.28), .fadeOut(withDuration: 0.20), .removeFromParent()]))
        RunicCrucibleAetherBrewGlassNode.run(.sequence([.wait(forDuration: 0.28), .run { [weak self] in
            guard let self else { return }
            self.RunicCrucibleAetherBrewGlassNode.strokeColor = self.RunicCrucibleAetherBrewIsFrozen ? .cyan : UIColor.white.withAlphaComponent(0.75)
        }]))
    }
}

final class RunicCrucibleAetherBrewGameScene: SKScene {
    var RunicCrucibleAetherBrewInteraction: ((Int) -> RunicCrucibleAetherBrewInteractionResult)?
    var RunicCrucibleAetherBrewAnimationCompletion: (() -> Void)?
    private var RunicCrucibleAetherBrewVialNodes: [Int: RunicCrucibleAetherBrewVialNode] = [:]
    private var RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState?
    private var RunicCrucibleAetherBrewInputLocked = false

    override init(size RunicCrucibleAetherBrewSize: CGSize) { super.init(size: RunicCrucibleAetherBrewSize); scaleMode = .resizeFill; backgroundColor = .clear }
    required init?(coder RunicCrucibleAetherBrewCoder: NSCoder) { fatalError("Storyboard loading is not supported.") }

    override func didChangeSize(_ RunicCrucibleAetherBrewOldSize: CGSize) {
        super.didChangeSize(RunicCrucibleAetherBrewOldSize)
        guard abs(size.width - RunicCrucibleAetherBrewOldSize.width) > 1 || abs(size.height - RunicCrucibleAetherBrewOldSize.height) > 1,
              let RunicCrucibleAetherBrewState,
              !RunicCrucibleAetherBrewInputLocked else { return }
        RunicCrucibleAetherBrewLoad(RunicCrucibleAetherBrewState)
    }

    func RunicCrucibleAetherBrewLoad(_ RunicCrucibleAetherBrewState: RunicCrucibleAetherBrewGameState) {
        self.RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewState
        removeAllChildren()
        RunicCrucibleAetherBrewVialNodes.removeAll()
        let RunicCrucibleAetherBrewCount = RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.count
        let RunicCrucibleAetherBrewColumns: Int
        switch RunicCrucibleAetherBrewCount {
        case ...10: RunicCrucibleAetherBrewColumns = 5
        case 11...12: RunicCrucibleAetherBrewColumns = 4
        case 13...15: RunicCrucibleAetherBrewColumns = 5
        case 16: RunicCrucibleAetherBrewColumns = 4
        case 17...18: RunicCrucibleAetherBrewColumns = 6
        case 19...20: RunicCrucibleAetherBrewColumns = 5
        default: RunicCrucibleAetherBrewColumns = 6
        }
        let RunicCrucibleAetherBrewRows = Int(ceil(Double(RunicCrucibleAetherBrewCount) / Double(RunicCrucibleAetherBrewColumns)))
        let RunicCrucibleAetherBrewCellWidth = size.width / CGFloat(RunicCrucibleAetherBrewColumns)
        let RunicCrucibleAetherBrewCellHeight = size.height / CGFloat(max(1, RunicCrucibleAetherBrewRows))
        for (RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewVial) in RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.enumerated() {
            let RunicCrucibleAetherBrewNode = RunicCrucibleAetherBrewVialNode(
                RunicCrucibleAetherBrewIndex: RunicCrucibleAetherBrewIndex,
                RunicCrucibleAetherBrewWidth: max(44, min(58, RunicCrucibleAetherBrewCellWidth - 8)),
                RunicCrucibleAetherBrewHeight: max(72, min(160, RunicCrucibleAetherBrewCellHeight - 10)),
                RunicCrucibleAetherBrewDetail: .RunicCrucibleAetherBrewResolve(RunicCrucibleAetherBrewVialCount: RunicCrucibleAetherBrewCount)
            )
            let RunicCrucibleAetherBrewColumn = RunicCrucibleAetherBrewIndex % RunicCrucibleAetherBrewColumns
            let RunicCrucibleAetherBrewRow = RunicCrucibleAetherBrewIndex / RunicCrucibleAetherBrewColumns
            let RunicCrucibleAetherBrewFirstIndexInRow = RunicCrucibleAetherBrewRow * RunicCrucibleAetherBrewColumns
            let RunicCrucibleAetherBrewItemsInRow = min(RunicCrucibleAetherBrewColumns, RunicCrucibleAetherBrewCount - RunicCrucibleAetherBrewFirstIndexInRow)
            let RunicCrucibleAetherBrewRowOffset = CGFloat(RunicCrucibleAetherBrewColumns - RunicCrucibleAetherBrewItemsInRow) * RunicCrucibleAetherBrewCellWidth / 2
            RunicCrucibleAetherBrewNode.RunicCrucibleAetherBrewSetBasePosition(CGPoint(
                x: RunicCrucibleAetherBrewRowOffset + CGFloat(RunicCrucibleAetherBrewColumn) * RunicCrucibleAetherBrewCellWidth + RunicCrucibleAetherBrewCellWidth / 2,
                y: size.height - CGFloat(RunicCrucibleAetherBrewRow) * RunicCrucibleAetherBrewCellHeight - RunicCrucibleAetherBrewCellHeight / 2
            ))
            RunicCrucibleAetherBrewNode.RunicCrucibleAetherBrewUpdate(RunicCrucibleAetherBrewVial)
            addChild(RunicCrucibleAetherBrewNode)
            RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewIndex] = RunicCrucibleAetherBrewNode
        }
    }

    func RunicCrucibleAetherBrewShuffleLayout() {
        guard !RunicCrucibleAetherBrewInputLocked, RunicCrucibleAetherBrewVialNodes.count > 1 else { return }
        RunicCrucibleAetherBrewInputLocked = true
        let RunicCrucibleAetherBrewOrderedNodes = RunicCrucibleAetherBrewVialNodes.keys.sorted().compactMap { RunicCrucibleAetherBrewVialNodes[$0] }
        RunicCrucibleAetherBrewOrderedNodes.forEach { $0.RunicCrucibleAetherBrewRestoreBasePosition() }
        let RunicCrucibleAetherBrewOriginalPositions = RunicCrucibleAetherBrewOrderedNodes.map(\.position)
        var RunicCrucibleAetherBrewShuffledPositions = RunicCrucibleAetherBrewOriginalPositions.shuffled()
        if zip(RunicCrucibleAetherBrewOriginalPositions, RunicCrucibleAetherBrewShuffledPositions).allSatisfy({ RunicCrucibleAetherBrewPair in RunicCrucibleAetherBrewPair.0 == RunicCrucibleAetherBrewPair.1 }),
           let RunicCrucibleAetherBrewFirstPosition = RunicCrucibleAetherBrewShuffledPositions.first {
            RunicCrucibleAetherBrewShuffledPositions.removeFirst()
            RunicCrucibleAetherBrewShuffledPositions.append(RunicCrucibleAetherBrewFirstPosition)
        }
        for (RunicCrucibleAetherBrewNode, RunicCrucibleAetherBrewPosition) in zip(RunicCrucibleAetherBrewOrderedNodes, RunicCrucibleAetherBrewShuffledPositions) {
            RunicCrucibleAetherBrewNode.RunicCrucibleAetherBrewMoveToBasePosition(RunicCrucibleAetherBrewPosition)
        }
        run(.sequence([
            .wait(forDuration: UIAccessibility.isReduceMotionEnabled ? 0.09 : 0.25),
            .run { [weak self] in self?.RunicCrucibleAetherBrewInputLocked = false }
        ]))
    }

    override func touchesEnded(_ RunicCrucibleAetherBrewTouches: Set<UITouch>, with RunicCrucibleAetherBrewEvent: UIEvent?) {
        guard !RunicCrucibleAetherBrewInputLocked, let RunicCrucibleAetherBrewPoint = RunicCrucibleAetherBrewTouches.first?.location(in: self), let RunicCrucibleAetherBrewHitNode = nodes(at: RunicCrucibleAetherBrewPoint).first(where: { $0.name == "RunicCrucibleAetherBrewHitArea" }), let RunicCrucibleAetherBrewIndex = RunicCrucibleAetherBrewHitNode.userData?["RunicCrucibleAetherBrewIndex"] as? Int, let RunicCrucibleAetherBrewResult = RunicCrucibleAetherBrewInteraction?(RunicCrucibleAetherBrewIndex) else { return }
        switch RunicCrucibleAetherBrewResult {
        case .RunicCrucibleAetherBrewSelected(let RunicCrucibleAetherBrewIndex): RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewIndex]?.RunicCrucibleAetherBrewSetSelected(true)
        case .RunicCrucibleAetherBrewDeselected(let RunicCrucibleAetherBrewIndex): RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewIndex]?.RunicCrucibleAetherBrewSetSelected(false)
        case .RunicCrucibleAetherBrewInvalid(_, let RunicCrucibleAetherBrewDestination, _): RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewDestination]?.RunicCrucibleAetherBrewShowError()
        case .RunicCrucibleAetherBrewPour(let RunicCrucibleAetherBrewMove, let RunicCrucibleAetherBrewMoveResult): RunicCrucibleAetherBrewAnimatePour(RunicCrucibleAetherBrewMove: RunicCrucibleAetherBrewMove, RunicCrucibleAetherBrewResult: RunicCrucibleAetherBrewMoveResult)
        case .RunicCrucibleAetherBrewIgnored: break
        }
    }

    private func RunicCrucibleAetherBrewAnimatePour(RunicCrucibleAetherBrewMove: RunicCrucibleAetherBrewMove, RunicCrucibleAetherBrewResult: RunicCrucibleAetherBrewMoveResult) {
        guard let RunicCrucibleAetherBrewSourceNode = RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource], let RunicCrucibleAetherBrewDestinationNode = RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination], let RunicCrucibleAetherBrewOldState = RunicCrucibleAetherBrewState else { return }
        RunicCrucibleAetherBrewInputLocked = true
        RunicCrucibleAetherBrewSourceNode.RunicCrucibleAetherBrewSetSelected(false, RunicCrucibleAetherBrewAnimated: false)
        let RunicCrucibleAetherBrewTransferCount = RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewTransferPlan.RunicCrucibleAetherBrewCount
        let RunicCrucibleAetherBrewDuration = UIAccessibility.isReduceMotionEnabled ? 0.12 : min(0.50, 0.22 + 0.07 * Double(RunicCrucibleAetherBrewTransferCount))
        let RunicCrucibleAetherBrewColor = RunicCrucibleAetherBrewOldState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource].RunicCrucibleAetherBrewLayers.last.map { UIColor($0.RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewColor) } ?? .systemBlue
        let RunicCrucibleAetherBrewStreamPath = CGMutablePath()
        RunicCrucibleAetherBrewStreamPath.move(to: RunicCrucibleAetherBrewSourceNode.position)
        let RunicCrucibleAetherBrewMidPoint = CGPoint(x: (RunicCrucibleAetherBrewSourceNode.position.x + RunicCrucibleAetherBrewDestinationNode.position.x) / 2, y: max(RunicCrucibleAetherBrewSourceNode.position.y, RunicCrucibleAetherBrewDestinationNode.position.y) + 54)
        RunicCrucibleAetherBrewStreamPath.addQuadCurve(to: RunicCrucibleAetherBrewDestinationNode.position, control: RunicCrucibleAetherBrewMidPoint)
        let RunicCrucibleAetherBrewStreamNode = SKShapeNode(path: RunicCrucibleAetherBrewStreamPath)
        RunicCrucibleAetherBrewStreamNode.strokeColor = RunicCrucibleAetherBrewColor
        RunicCrucibleAetherBrewStreamNode.lineWidth = 5
        RunicCrucibleAetherBrewStreamNode.glowWidth = 6
        RunicCrucibleAetherBrewStreamNode.alpha = 0
        RunicCrucibleAetherBrewStreamNode.zPosition = 300
        addChild(RunicCrucibleAetherBrewStreamNode)
        if UIAccessibility.isReduceMotionEnabled { RunicCrucibleAetherBrewStreamNode.run(.sequence([.fadeIn(withDuration: 0.05), .fadeOut(withDuration: 0.07)])) } else {
            let RunicCrucibleAetherBrewDirection: CGFloat = RunicCrucibleAetherBrewDestinationNode.position.x >= RunicCrucibleAetherBrewSourceNode.position.x ? -1 : 1
            RunicCrucibleAetherBrewSourceNode.RunicCrucibleAetherBrewAnimatePour(RunicCrucibleAetherBrewDirection: RunicCrucibleAetherBrewDirection)
            RunicCrucibleAetherBrewStreamNode.run(.sequence([.fadeIn(withDuration: 0.08), .wait(forDuration: 0.15), .fadeOut(withDuration: 0.12)]))
            var RunicCrucibleAetherBrewIntermediateState = RunicCrucibleAetherBrewOldState
            for RunicCrucibleAetherBrewStep in 0..<RunicCrucibleAetherBrewTransferCount {
                guard let RunicCrucibleAetherBrewLayer = RunicCrucibleAetherBrewIntermediateState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource].RunicCrucibleAetherBrewLayers.popLast() else { break }
                RunicCrucibleAetherBrewIntermediateState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination].RunicCrucibleAetherBrewLayers.append(RunicCrucibleAetherBrewLayer)
                let RunicCrucibleAetherBrewStepState = RunicCrucibleAetherBrewIntermediateState
                run(.sequence([.wait(forDuration: 0.12 + 0.07 * Double(RunicCrucibleAetherBrewStep)), .run { [weak self] in
                    self?.RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource]?.RunicCrucibleAetherBrewUpdate(RunicCrucibleAetherBrewStepState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource])
                    self?.RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination]?.RunicCrucibleAetherBrewUpdate(RunicCrucibleAetherBrewStepState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination])
                }]))
            }
        }
        run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewDuration), .run { [weak self] in
            guard let self else { return }
            self.RunicCrucibleAetherBrewState = RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState
            self.RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource]?.RunicCrucibleAetherBrewUpdate(RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource])
            self.RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewSource]?.RunicCrucibleAetherBrewRestoreBasePosition()
            self.RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination]?.RunicCrucibleAetherBrewUpdate(RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials[RunicCrucibleAetherBrewMove.RunicCrucibleAetherBrewDestination])
            self.RunicCrucibleAetherBrewShowReactions(RunicCrucibleAetherBrewResult.RunicCrucibleAetherBrewReactions)
            RunicCrucibleAetherBrewStreamNode.removeFromParent()
            self.RunicCrucibleAetherBrewInputLocked = false
            self.RunicCrucibleAetherBrewAnimationCompletion?()
        }]))
    }

    func RunicCrucibleAetherBrewPlayFinalAscension(RunicCrucibleAetherBrewCompletion: @escaping () -> Void) {
        guard !RunicCrucibleAetherBrewInputLocked else { return }
        RunicCrucibleAetherBrewInputLocked = true
        childNode(withName: "RunicCrucibleAetherBrewFinaleRoot")?.removeFromParent()
        let RunicCrucibleAetherBrewReduceMotion = UIAccessibility.isReduceMotionEnabled
        let RunicCrucibleAetherBrewCenter = CGPoint(x: size.width / 2, y: size.height * 0.56)
        let RunicCrucibleAetherBrewFinaleRoot = SKNode()
        RunicCrucibleAetherBrewFinaleRoot.name = "RunicCrucibleAetherBrewFinaleRoot"
        RunicCrucibleAetherBrewFinaleRoot.zPosition = 500
        addChild(RunicCrucibleAetherBrewFinaleRoot)

        let RunicCrucibleAetherBrewOrderedVials = RunicCrucibleAetherBrewVialNodes.keys.sorted().compactMap { RunicCrucibleAetherBrewVialNodes[$0] }
        for (RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewVialNode) in RunicCrucibleAetherBrewOrderedVials.enumerated() {
            let RunicCrucibleAetherBrewDelay = RunicCrucibleAetherBrewReduceMotion ? Double(RunicCrucibleAetherBrewIndex) * 0.012 : Double(RunicCrucibleAetherBrewIndex) * 0.035
            let RunicCrucibleAetherBrewHalo = SKShapeNode(circleOfRadius: max(16, RunicCrucibleAetherBrewVialNode.frame.width * 0.38))
            RunicCrucibleAetherBrewHalo.position = RunicCrucibleAetherBrewVialNode.position
            RunicCrucibleAetherBrewHalo.fillColor = UIColor.systemYellow.withAlphaComponent(0.12)
            RunicCrucibleAetherBrewHalo.strokeColor = UIColor.systemYellow.withAlphaComponent(0.9)
            RunicCrucibleAetherBrewHalo.glowWidth = 12
            RunicCrucibleAetherBrewHalo.alpha = 0
            RunicCrucibleAetherBrewFinaleRoot.addChild(RunicCrucibleAetherBrewHalo)
            RunicCrucibleAetherBrewHalo.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewDelay), .fadeIn(withDuration: 0.12), .group([.scale(to: 1.6, duration: 0.38), .fadeOut(withDuration: 0.42)]), .removeFromParent()]))
            RunicCrucibleAetherBrewVialNode.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewDelay), .scale(to: 1.06, duration: 0.12), .scale(to: 1, duration: 0.25)]))
        }

        if !RunicCrucibleAetherBrewReduceMotion, let RunicCrucibleAetherBrewState {
            for (RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewVial) in RunicCrucibleAetherBrewState.RunicCrucibleAetherBrewVials.enumerated() where !RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers.isEmpty {
                guard let RunicCrucibleAetherBrewVialNode = RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewIndex], let RunicCrucibleAetherBrewType = RunicCrucibleAetherBrewVial.RunicCrucibleAetherBrewLayers.last?.RunicCrucibleAetherBrewType else { continue }
                let RunicCrucibleAetherBrewStream = SKShapeNode(circleOfRadius: 3.2)
                RunicCrucibleAetherBrewStream.fillColor = RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewVisualColor
                RunicCrucibleAetherBrewStream.strokeColor = .white
                RunicCrucibleAetherBrewStream.glowWidth = 9
                RunicCrucibleAetherBrewStream.position = RunicCrucibleAetherBrewVialNode.position
                RunicCrucibleAetherBrewStream.alpha = 0
                RunicCrucibleAetherBrewFinaleRoot.addChild(RunicCrucibleAetherBrewStream)
                let RunicCrucibleAetherBrewControl = CGPoint(x: (RunicCrucibleAetherBrewVialNode.position.x + RunicCrucibleAetherBrewCenter.x) / 2 + CGFloat.random(in: -36...36), y: max(RunicCrucibleAetherBrewVialNode.position.y, RunicCrucibleAetherBrewCenter.y) + 70)
                let RunicCrucibleAetherBrewPath = CGMutablePath()
                RunicCrucibleAetherBrewPath.move(to: RunicCrucibleAetherBrewVialNode.position)
                RunicCrucibleAetherBrewPath.addQuadCurve(to: RunicCrucibleAetherBrewCenter, control: RunicCrucibleAetherBrewControl)
                let RunicCrucibleAetherBrewDelay = 1.2 + Double(RunicCrucibleAetherBrewIndex % 8) * 0.045
                RunicCrucibleAetherBrewStream.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewDelay), .fadeIn(withDuration: 0.08), .follow(RunicCrucibleAetherBrewPath, asOffset: false, orientToPath: false, duration: 1.1), .fadeOut(withDuration: 0.18), .removeFromParent()]))
            }
        }

        let RunicCrucibleAetherBrewRuneRing = SKNode()
        RunicCrucibleAetherBrewRuneRing.position = RunicCrucibleAetherBrewCenter
        RunicCrucibleAetherBrewRuneRing.alpha = 0
        RunicCrucibleAetherBrewFinaleRoot.addChild(RunicCrucibleAetherBrewRuneRing)
        let RunicCrucibleAetherBrewRadius = min(size.width, size.height) * 0.22
        for (RunicCrucibleAetherBrewIndex, RunicCrucibleAetherBrewType) in RunicCrucibleAetherBrewLiquidType.allCases.enumerated() {
            let RunicCrucibleAetherBrewAngle = CGFloat(RunicCrucibleAetherBrewIndex) / CGFloat(RunicCrucibleAetherBrewLiquidType.allCases.count) * .pi * 2
            let RunicCrucibleAetherBrewRune = SKLabelNode(text: RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewEmoji)
            RunicCrucibleAetherBrewRune.fontSize = min(25, RunicCrucibleAetherBrewRadius * 0.25)
            RunicCrucibleAetherBrewRune.fontColor = RunicCrucibleAetherBrewType.RunicCrucibleAetherBrewVisualColor
            RunicCrucibleAetherBrewRune.verticalAlignmentMode = .center
            RunicCrucibleAetherBrewRune.position = CGPoint(x: cos(RunicCrucibleAetherBrewAngle) * RunicCrucibleAetherBrewRadius, y: sin(RunicCrucibleAetherBrewAngle) * RunicCrucibleAetherBrewRadius)
            RunicCrucibleAetherBrewRuneRing.addChild(RunicCrucibleAetherBrewRune)
        }
        let RunicCrucibleAetherBrewRingDelay = RunicCrucibleAetherBrewReduceMotion ? 0.55 : 2.75
        RunicCrucibleAetherBrewRuneRing.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewRingDelay), .fadeIn(withDuration: 0.28)]))
        if !RunicCrucibleAetherBrewReduceMotion { RunicCrucibleAetherBrewRuneRing.run(.sequence([.wait(forDuration: 2.8), .rotate(byAngle: .pi * 2, duration: 1.35)])) }

        let RunicCrucibleAetherBrewLogo = SKSpriteNode(imageNamed: "logoRunicCrucibleAetherBrew")
        let RunicCrucibleAetherBrewLogoSide = min(size.width, size.height) * 0.27
        RunicCrucibleAetherBrewLogo.size = CGSize(width: RunicCrucibleAetherBrewLogoSide, height: RunicCrucibleAetherBrewLogoSide)
        RunicCrucibleAetherBrewLogo.position = RunicCrucibleAetherBrewCenter
        RunicCrucibleAetherBrewLogo.alpha = 0
        RunicCrucibleAetherBrewLogo.setScale(0.25)
        RunicCrucibleAetherBrewLogo.blendMode = .alpha
        RunicCrucibleAetherBrewFinaleRoot.addChild(RunicCrucibleAetherBrewLogo)
        let RunicCrucibleAetherBrewLogoDelay = RunicCrucibleAetherBrewReduceMotion ? 0.85 : 4.0
        RunicCrucibleAetherBrewLogo.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewLogoDelay), .group([.fadeIn(withDuration: 0.35), .scale(to: 1, duration: RunicCrucibleAetherBrewReduceMotion ? 0.35 : 0.8)]), .repeat(.sequence([.scale(to: 1.05, duration: 0.35), .scale(to: 1, duration: 0.35)]), count: 2)]))

        let RunicCrucibleAetherBrewFlash = SKShapeNode(rectOf: CGSize(width: size.width * 1.5, height: size.height * 1.5))
        RunicCrucibleAetherBrewFlash.position = RunicCrucibleAetherBrewCenter
        RunicCrucibleAetherBrewFlash.fillColor = UIColor(red: 1, green: 0.72, blue: 0.20, alpha: 1)
        RunicCrucibleAetherBrewFlash.strokeColor = .clear
        RunicCrucibleAetherBrewFlash.alpha = 0
        RunicCrucibleAetherBrewFlash.zPosition = 900
        RunicCrucibleAetherBrewFinaleRoot.addChild(RunicCrucibleAetherBrewFlash)
        let RunicCrucibleAetherBrewFlashDelay = RunicCrucibleAetherBrewReduceMotion ? 1.35 : 4.8
        RunicCrucibleAetherBrewFlash.run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewFlashDelay), .fadeAlpha(to: 0.72, duration: 0.10), .fadeOut(withDuration: 0.48)]))

        let RunicCrucibleAetherBrewDuration = RunicCrucibleAetherBrewReduceMotion ? 2.0 : 5.8
        run(.sequence([.wait(forDuration: RunicCrucibleAetherBrewDuration), .run { [weak self] in
            self?.RunicCrucibleAetherBrewInputLocked = false
            RunicCrucibleAetherBrewFeedbackManager.RunicCrucibleAetherBrewFinale()
            RunicCrucibleAetherBrewCompletion()
        }]))
    }

    private func RunicCrucibleAetherBrewShowReactions(_ RunicCrucibleAetherBrewReactions: [RunicCrucibleAetherBrewReaction]) {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        for RunicCrucibleAetherBrewReaction in RunicCrucibleAetherBrewReactions.dropFirst() {
            guard let RunicCrucibleAetherBrewVialNode = RunicCrucibleAetherBrewVialNodes[RunicCrucibleAetherBrewReaction.RunicCrucibleAetherBrewVialIndex] else { continue }
            let RunicCrucibleAetherBrewReactionColor: UIColor
            switch RunicCrucibleAetherBrewReaction.RunicCrucibleAetherBrewKind {
            case .evaporated: RunicCrucibleAetherBrewReactionColor = .systemOrange
            case .frozen: RunicCrucibleAetherBrewReactionColor = .cyan
            case .thawed: RunicCrucibleAetherBrewReactionColor = .systemTeal
            case .empowered: RunicCrucibleAetherBrewReactionColor = .systemGreen
            case .copied: RunicCrucibleAetherBrewReactionColor = .systemPink
            case .absorbed: RunicCrucibleAetherBrewReactionColor = UIColor(red: 0.30, green: 0.02, blue: 0.48, alpha: 1)
            case .poured: RunicCrucibleAetherBrewReactionColor = RunicCrucibleAetherBrewReaction.RunicCrucibleAetherBrewType?.RunicCrucibleAetherBrewVisualColor ?? .systemPurple
            }
            let RunicCrucibleAetherBrewFlash = SKShapeNode(circleOfRadius: 24)
            RunicCrucibleAetherBrewFlash.fillColor = RunicCrucibleAetherBrewReactionColor.withAlphaComponent(0.36)
            RunicCrucibleAetherBrewFlash.strokeColor = RunicCrucibleAetherBrewReactionColor
            RunicCrucibleAetherBrewFlash.lineWidth = 2
            RunicCrucibleAetherBrewFlash.glowWidth = 12
            RunicCrucibleAetherBrewFlash.position = RunicCrucibleAetherBrewVialNode.position
            RunicCrucibleAetherBrewFlash.zPosition = 250
            addChild(RunicCrucibleAetherBrewFlash)
            RunicCrucibleAetherBrewFlash.run(.sequence([
                .group([.scale(to: 2.4, duration: 0.28), .fadeOut(withDuration: 0.28)]),
                .removeFromParent()
            ]))
        }
    }
}
