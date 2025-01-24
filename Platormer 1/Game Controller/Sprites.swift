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
        sprite.run(SKAction.repeatForever(walkAction), withKey: "walkingAnimation")
        
    }
    
    func spriteAdjustment(){
        for (key, value) in playerFloorLayout {
            Timer.scheduledTimer(withTimeInterval: key, repeats: false) { timer in
                self.playerSprite?.position.y = value - 37
            }
        }
        
        for (key, value) in monsterFloorLayout {
            Timer.scheduledTimer(withTimeInterval: key, repeats: false) { timer in
                self.monsterSprite?.position.y = value - 7
            }
        }
    }
    
    func moveSprites() {
        
        var distance = width * 0.85
        
        for sprite in [playerSprite, monsterSprite]{
            
            guard let sprite = sprite else { continue }

            let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 1.6)
            
            let count = Int(( distance - sprite.position.x) / 50)
            
            let sequence = SKAction.sequence([moveRight])
            
            let completionAction = SKAction.run {
                stopSprite(sprite)
            }
            
            let fullAction = SKAction.sequence([SKAction.repeat(sequence, count: count), completionAction])
            
            sprite.run(fullAction, withKey: "moveAction")
            
            distance = width * 0.5
            
        }

        
    }
    
    func stopSprite (_ sprite : SKSpriteNode)  {
        if sprite == playerSprite {
            playerSprite?.removeAction(forKey: "walkingAnimation")
            playerSprite?.texture = SKTexture(imageNamed: "player1")
        } else {
            monsterSprite?.removeAction(forKey: "walkingAnimation")
            monsterSprite?.texture = SKTexture(imageNamed: "monster3")
        }
    }

    
    

    

}
