import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let numberOfRectangles = Int(height * 1.25 / 50) + round * 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGround()
    }
    
    func createGround() {
        let skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        
        let scene = SKScene(size: skView.frame.size)
  
        var createTile = false
        var floorHeight = width / 2.5

        for i in 0..<numberOfRectangles {
            var currentFloor = floorHeight
            if i % 5 == 0 && i != 0 && i < numberOfRectangles - 6{
                createTile = true
            }
            
            if createTile {
                if Bool.random() || i + 1 % 5 == 0 {
                    
                    createRectangele(xPosition: i, yPosition: width / 3, recHeight: 50, skView: skView, scene: scene)
                    
                    if Bool.random() {
                        currentFloor -= 50
                    } else{
                        floorHeight += 50
                    }
                    createTile = false
                }
            }else {
                if floorHeight >= width / 1.6 {
                    floorHeight -= 50
                }
            }
                       
            createRectangele(xPosition: i, yPosition: -width / 1.5, recHeight: currentFloor, skView: skView, scene : scene)
            
        }
    
        skView.presentScene(scene)
    }
    
    func createRectangele(xPosition: Int, yPosition : CGFloat, recHeight : CGFloat, skView : SKView, scene : SKScene){
        let rectangle = CGRect(x: CGFloat(xPosition * 50), y: yPosition, width: 50, height: recHeight)
        let rectangleNode = SKShapeNode(rect: rectangle)
        
        rectangleNode.fillColor = .brown
        rectangleNode.lineWidth = 0
        
        rectangleNode.position = CGPoint(x: 0, y: skView.frame.midY)
        
        scene.addChild(rectangleNode)
        moveRectangle(rectangleNode, skView: skView)

    }
    
    
    func moveRectangle(_ node: SKShapeNode, skView: SKView) {
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 1.5)
        var moveCount = 0
          let moveAction = SKAction.run {
              moveCount += 1
              print("Rectangle has moved \(moveCount) times.")
          }
          let sequence = SKAction.sequence([moveLeft, moveAction])
        let count = numberOfRectangles - Int(height) / 50

          node.run(SKAction.repeat(sequence, count: count), withKey: "moveAction")
    }
}

