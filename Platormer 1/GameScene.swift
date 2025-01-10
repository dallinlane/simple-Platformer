import SpriteKit

class GameScene: SKScene {
    var mainCharacter: SKSpriteNode!
    var tRex: SKSpriteNode!
    var lives: Int = 3
    var livesIndicator: SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        setupMainCharacter()
        setupTRex()
        setupLivesIndicator()
    }
    
    func setupMainCharacter() {
        mainCharacter = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        mainCharacter.position = CGPoint(x: size.width * 0.2, y: size.height * 0.5)
        addChild(mainCharacter)
        
        let moveAction = SKAction.moveBy(x: size.width, y: 0, duration: 5)
        mainCharacter.run(moveAction)
    }
    
    func setupTRex() {
        tRex = SKSpriteNode(color: .red, size: CGSize(width: 70, height: 70))
        tRex.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(tRex)
        
        let chaseAction = SKAction.moveBy(x: size.width * 0.8, y: 0, duration: 7)
        tRex.run(chaseAction)
    }
    
    func setupLivesIndicator() {
        livesIndicator = SKLabelNode(text: "Lives: \(lives)")
        livesIndicator.fontSize = 24
        livesIndicator.fontColor = .black
        livesIndicator.position = CGPoint(x: size.width * 0.8, y: size.height * 0.9)
        addChild(livesIndicator)
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkCollision()
    }
    
    func checkCollision() {
        if mainCharacter.frame.intersects(tRex.frame) {
            lives -= 1
            livesIndicator.text = "Lives: \(lives)"
            
            if lives == 0 {
                gameOver()
            } else {
                resetCheckpoint()
            }
        }
    }
    
    func resetCheckpoint() {
        mainCharacter.position = CGPoint(x: size.width * 0.2, y: size.height * 0.5)
    }
    
    func gameOver() {
        let gameOverVC = GameOverViewController()
        view?.window?.rootViewController?.present(gameOverVC, animated: true, completion: nil)
    }
}
