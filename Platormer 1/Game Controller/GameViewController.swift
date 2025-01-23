import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView: SKView!
    var scene : SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        scene  = SKScene(size: skView.frame.size)
        
        var groundGenerator = Ground(scene: scene, skView: skView)
        
        groundGenerator.createGround()

        skView.presentScene(scene)

    }

}

