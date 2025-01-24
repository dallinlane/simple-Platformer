import UIKit
import SpriteKit

class Ground {
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
        
        spriteGenerator.addSprite(name: "player", count: 6, y: 113, scale: 0.5)
        spriteGenerator.addSprite(name: "monster", count: 10, y: 142, scale: 1)
        
    }


    func createGround() {
        var createTile = false
    
        numberOfRectangles = Int(width * 2 / 50) + round * 5
        
        for i in 0..<numberOfRectangles {
            var currentFloor = floorHeight
            
            if i % 5 == 0 && i > 10{
                createTile = true
            }
            
            if createTile && i < numberOfRectangles - 12 {
                if Bool.random() || i + 2 % 5 == 0 {
                    
                    var name = "tile"
                    if floorHeight >= height / 1.6  {
                        floorHeight -= 50
                        currentFloor -= 100
                    } else {
                        if Bool.random() {
                            currentFloor -= 50
                            name = "tile"
                        } else{
                            floorHeight += 50
                            name = "tile1"
                        }
                    }
                    
                    
                    createSprite(xPosition: i, yPosition: height - 40, recHeight: 50, skView: skView, scene: scene, name: name)

                    
                    let distance = CGFloat(50 * i)
                    let speedPerSecond =  CGFloat(50 / movementDuration)
                    playerFloorLayout[(distance - mainXPOS) / speedPerSecond] = floorHeight
                    monsterFloorLayout[(distance - monsterXPOS) / CGFloat(50 / movementDuration)] = floorHeight

                    createTile = false
                }
            }
                       
            createSprite(xPosition: i, yPosition: height / -5.778, recHeight: currentFloor, skView: skView, scene : scene, name: "ground")
            
        }
  
        spriteGenerator.spriteAdjustment()

    }
    
    
    func createSprite(xPosition: Int, yPosition: CGFloat, recHeight: CGFloat, skView: SKView, scene: SKScene, name: String) {
        let brickHeight: CGFloat = 50
        let numBricks = Int(recHeight / brickHeight)
  
        for i in 0..<numBricks {
            
            let sprite = SKSpriteNode()
            var anchorpoint = CGPoint(x: 0.5, y: 0.5)
            
            if name == "ground"{
                sprite.texture = SKTexture(imageNamed: "ground" + String(Int.random(in: 2...15)))
                anchorpoint = CGPoint(x: 0.5, y: 0)
            }
            else if name == "tile" {
                sprite.texture = SKTexture(imageNamed: "ground1")
            }
            else {
                sprite.texture = SKTexture(imageNamed: "stairs")
                let rotations = [0.5, -2 , 1, 2]
                if let rotation = rotations.randomElement(){
                    sprite.zRotation = .pi / rotation
                }
            }
            
            sprite.anchorPoint = anchorpoint
            
            sprite.size = CGSize(width: 50, height: brickHeight)

            let brickYPosition = yPosition + (CGFloat(i) * brickHeight)
            sprite.position = CGPoint(x: CGFloat(xPosition * 50), y: brickYPosition)
            
            sprite.name = name

            scene.addChild(sprite)
            moveSprite(sprite, skView: skView, recHeight: recHeight)
            
            if name != "ground" {
                addGestureRecognizers(to: sprite, skView: skView)
            }
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

    func addGestureRecognizers(to sprite: SKSpriteNode, skView: SKView) {
        // Attach a unique gesture recognizer to this sprite
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
        swipeLeft.direction = .left
        skView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
        swipeRight.direction = .right
        skView.addGestureRecognizer(swipeRight)
        

    }

    @objc func handleTileSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let skView = gesture.view as? SKView else { return }
        let location = gesture.location(in: skView)

        // Convert the location to the scene's coordinate space
        let sceneLocation = scene.convertPoint(fromView: location)

        // Identify the tile at the swipe location
        if let tile = scene.nodes(at: sceneLocation).first as? SKSpriteNode {
            let rotationAngle: CGFloat = .pi / 2
            let rotationAction = gesture.direction == .left
                ? SKAction.rotate(byAngle: -rotationAngle, duration: 0.2)
                : SKAction.rotate(byAngle: rotationAngle, duration: 0.2)

            tile.run(rotationAction)
        }
    }
}

