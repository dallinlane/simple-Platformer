import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView: SKView!
    var scene : SKScene!

  // Variable to store the player sprite
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        scene  = SKScene(size: skView.frame.size)
        
        var groundGenerator = Ground(scene: scene, skView: skView)
        var spriteGenerator = Sprites(scene: scene)
        
        groundGenerator.createGround()

        
        spriteGenerator.addSprite(name: "player", count: 6, y: 131, scale: 0.5)
        spriteGenerator.addSprite(name: "monster", count: 10, y: 161, scale: 1)
        spriteGenerator.spriteAdjustment()
     
        skView.presentScene(scene)

    }

}

