import UIKit
import SpriteKit

struct Sprites{
    var scene : SKScene!
    var playerSprite: SKSpriteNode?  // Variable to store the player sprite
    var monsterSprite: SKSpriteNode?
    
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    
    mutating func addSprite(name: String, count: Int, y: CGFloat, scale : CGFloat) {
        let sprite = SKSpriteNode(imageNamed : "1")
        
        var walkFrames: [SKTexture] = []
        for i in 1...count {
            walkFrames.append(SKTexture(imageNamed: name + "\(i)"))
        }
        
        
        sprite.position = CGPoint(x: name == "player" ? mainXPOS : monsterXPOS , y: y)
        scene.addChild(sprite)
        
        sprite.xScale = scale
        sprite.yScale = scale
        
        if name == "player" {
            playerSprite = sprite
        } else {
            monsterSprite = sprite
        }
        
        
        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.14)
        sprite.run(SKAction.repeatForever(walkAction))
        
    }
    
    func spriteAdjustment(){
        for (key, value) in playerFloorLayout {
            Timer.scheduledTimer(withTimeInterval: key, repeats: false) { timer in
                self.playerSprite?.position.y = value - 41
            }
        }
        
        for (key, value) in monsterFloorLayout {
            Timer.scheduledTimer(withTimeInterval: key, repeats: false) { timer in
                self.monsterSprite?.position.y = value - 11
            }
        }
    }
    

}
