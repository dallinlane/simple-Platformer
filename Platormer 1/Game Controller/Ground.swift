import UIKit
import SpriteKit

struct Ground {
    var scene : SKScene!
    var skView: SKView!
    var numberOfRectangles = 0
    var floorHeight = height / 2.5
    let movementDuration = 0.5 // 1.6
    
    var spriteGenerator : Sprites

 
    
    init(scene: SKScene, skView: SKView) {
        self.scene = scene
        self.skView = skView
        
        spriteGenerator = Sprites(scene: scene)
        
        spriteGenerator.addSprite(name: "player", count: 6, y: 120, scale: 0.5)
        spriteGenerator.addSprite(name: "monster", count: 10, y: 150, scale: 1)
    }


    mutating func createGround() {
        var createTile = false
    
        numberOfRectangles = Int(width * 2 / 50) + round * 5
        
        for i in 0..<numberOfRectangles {
            var currentFloor = floorHeight
            
            if i % 5 == 0 && i > 10 && i < numberOfRectangles - 20{
                createTile = true
            }
            
            if createTile {
                if Bool.random() || i + 2 % 5 == 0 {
                    
                    createRectangele(xPosition: i, yPosition: height / 3, recHeight: 50, skView: skView, scene: scene)
                    if floorHeight >= height / 1.6 {
                        floorHeight -= 50
                        currentFloor -= 100
                    } else {
                        if Bool.random() {
                            currentFloor -= 50
                        } else{
                            floorHeight += 50
                        }
                    }
                    let distance = CGFloat(50 * i)
                    let speedPerSecond =  CGFloat(50 / movementDuration)
                    playerFloorLayout[(distance - mainXPOS) / speedPerSecond] = floorHeight
                    monsterFloorLayout[(distance - monsterXPOS) / CGFloat(50 / movementDuration)] = floorHeight

                    createTile = false
                }
            }
                       
            createRectangele(xPosition: i, yPosition: -height / 1.5, recHeight: currentFloor, skView: skView, scene : scene)
            
        }
  
        spriteGenerator.spriteAdjustment()

    }
    
    func createRectangele(xPosition: Int, yPosition : CGFloat, recHeight : CGFloat, skView : SKView, scene : SKScene){
        let rectangle = CGRect(x: CGFloat(xPosition * 50), y: yPosition, width: 50, height: recHeight)
        let rectangleNode = SKShapeNode(rect: rectangle)
        
        rectangleNode.fillColor = .brown
        rectangleNode.lineWidth = 0
        
        rectangleNode.position = CGPoint(x: 0, y: skView.frame.midY)
        
        scene.addChild(rectangleNode)
        moveRectangle(rectangleNode, skView: skView, recHeight: recHeight)

    }
    
    
    func moveRectangle(_ node: SKShapeNode, skView: SKView, recHeight: CGFloat) {
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: movementDuration)
        var moveCount = 0
          let moveAction = SKAction.run {
              moveCount += 1
          }
        
     
        let sequence = SKAction.sequence([moveLeft, moveAction])
        let count = numberOfRectangles - Int(width) / 50 - 1

        let completionAction = SKAction.run {
            spriteGenerator.moveSprites()
            }
        
            node.run(SKAction.sequence([SKAction.repeat(sequence, count: count), completionAction]), withKey: "moveAction")
    }
    
    
}

