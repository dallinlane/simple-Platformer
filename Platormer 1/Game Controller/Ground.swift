import UIKit
import SpriteKit

class Ground{
    var scene : SKScene!
    var skView: SKView!
    var numberOfRectangles = 0
    var floorHeight = height / 2.5
    let movementDuration = 1.6 // 1.6
    var currentFloorHeight = 0.0
    var addFloorConnector = false

    
    var spriteGenerator : Sprites

    init(scene: SKScene, skView: SKView) {
        self.scene = scene
        self.skView = skView
        
        spriteGenerator = Sprites(scene: scene)
        
        spriteGenerator.addSprite(name: "player", count: 6, y: 113, scale: 0.5)
        spriteGenerator.addSprite(name: "monster", count: 10, y: 142, scale: 1)
        
    }

 }

//MARK: - Creating The Ground

extension Ground {

    func createGround() {
    
        numberOfRectangles = Int(width * 2 / 50) + round * 5
        
        for i in 0..<numberOfRectangles {
            currentFloorHeight = floorHeight
            
            create_Fill_In_Block(i)
                       
            createSprite(xPosition: i, yPosition: height / -5.778, recHeight: currentFloorHeight, name: "ground")
            
        }
  
        spriteGenerator.spriteAdjustment()

    }
    
    func createSprite(xPosition: Int, yPosition: CGFloat, recHeight: CGFloat, name: String) {
        let numBricks = Int(recHeight / 50)
  
        for i in 0..<numBricks {
            
            let sprite = SKSpriteNode()
            sprite.texture = SKTexture(imageNamed: "ground" + String(Int.random(in: 2...15)))
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
            sprite.size = CGSize(width: 50, height: 50)

            let brickYPosition = yPosition + (CGFloat(i) * 50)
            sprite.position = CGPoint(x: CGFloat(xPosition * 50), y: brickYPosition)
            
            sprite.name = name

            scene.addChild(sprite)
            moveSprite(sprite, skView: skView, recHeight: recHeight)
        }
    }

    func moveSprite(_ node: SKSpriteNode, skView: SKView, recHeight: CGFloat) {
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: movementDuration)
        var moveCount = 0
          let moveAction = SKAction.run {
              moveCount += 1
          }
        
        let sequence = SKAction.sequence([moveLeft, moveAction])
        let count = numberOfRectangles - Int(width) / 50 - 1

        let completionAction = SKAction.run {
            self.spriteGenerator.moveSprites()
            }
        
            node.run(SKAction.sequence([SKAction.repeat(sequence, count: count), completionAction]), withKey: "moveAction")
    }
}

//MARK: - Create Floor Connectors

extension Ground {
    
    func create_Fill_In_Block(_ index: Int) {
    
        if index % 5 == 0 && index > 10{
                    addFloorConnector = true
                }
    
        if addFloorConnector && index < numberOfRectangles - 12 {
            if Bool.random() || index + 2 % 5 == 0 {
    
                        var name = "tile"
                        if floorHeight >= height / 1.6  {
                            floorHeight -= 50
                            currentFloorHeight -= 100
                        } else {
                            if Bool.random() {
                                currentFloorHeight -= 50
                            } else{
                                floorHeight += 50
                                name = "tile1"
                            }
                        }
    
                    Fill_In_Block_Sprite(xPosition: index, name: name)
    
                        let distance = CGFloat(50 * index)
                        let speedPerSecond =  CGFloat(50 / movementDuration)
                
                        playerFloorLayout[(distance - mainXPOS) / speedPerSecond] = floorHeight
                        monsterFloorLayout[(distance - monsterXPOS) / CGFloat(50 / movementDuration)] = floorHeight
    
                        addFloorConnector = false
                    }
                }
        }

    func Fill_In_Block_Sprite(xPosition: Int, name: String) {
    
        let texture = SKTexture(imageNamed: name == "tile" ? "ground1" : "stairs")
        let rotation = name == "tile" ? 0.0 : (.pi / 2) * CGFloat(Int.random(in: 0...3))
        
        let sprite = CustomSprite(texture: texture, color: UIColor.clear, baseYPosition: currentFloorHeight - 50, rotation: rotation)

        sprite.position = CGPoint(x: CGFloat(xPosition * 50), y: height - 79)
        
        sprite.name = name

        scene.addChild(sprite)
        moveSprite(sprite, skView: skView, recHeight: 50)
        
        addGestureRecognizers(to: sprite)
    }
    
    func addGestureRecognizers(to sprite: SKSpriteNode) {
         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeLeft.direction = .left
         skView.addGestureRecognizer(swipeLeft)
         
         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeRight.direction = .right
         skView.addGestureRecognizer(swipeRight)
         
         let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeDown.direction = .down
         skView.addGestureRecognizer(swipeDown)
     }

    @objc func handleTileSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let skView = gesture.view as? SKView else { return }
        let location = gesture.location(in: skView)
        let sceneLocation = scene.convertPoint(fromView: location)
        
        if let tile = scene.nodes(at: sceneLocation).first(where: { $0.name != "ground" }) as? CustomSprite {
            let rotationAngle: CGFloat = .pi / 2
            
            switch gesture.direction {
            case .left, .right:
                if tile.name == "tile1" && !tile.swipeDown {
                       let rotationAction = SKAction.rotate(byAngle: gesture.direction == .left ? -rotationAngle : rotationAngle, duration: 0.2)
                       tile.run(rotationAction)
                   }
            case .down:
                tile.run(SKAction.moveTo(y: tile.baseYPosition, duration: 0.2))
                tile.swipeDown = true
            default: break
            }
        }
    }
}

//MARK: - Class for the Floor Connector Sprite

class CustomSprite: SKSpriteNode {
    var baseYPosition: CGFloat
    var swipeDown = false
    
    init(texture: SKTexture?, color: UIColor, baseYPosition: CGFloat, rotation: CGFloat) {
        self.baseYPosition = baseYPosition

        super.init(texture: texture, color: color, size: CGSize(width: 50, height: 50))
        
        self.position = CGPoint(x: self.position.x, y: baseYPosition)
        self.zRotation = rotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
