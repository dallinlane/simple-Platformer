import UIKit

class NextLevelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let restartButton = UIButton(type: .system)
        restartButton.setTitle("Restart", for: .normal)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(restartButton)
        
        let quitButton = UIButton(type: .system)
        quitButton.setTitle("Quit", for: .normal)
        quitButton.addTarget(self, action: #selector(quitToMain), for: .touchUpInside)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quitButton)
        
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            quitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quitButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func restartGame() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc func quitToMain() {
        navigationController?.popToRootViewController(animated: true)
    }
}
