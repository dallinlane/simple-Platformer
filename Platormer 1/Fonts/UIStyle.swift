import UIKit


struct UIStyle {
    
    
    static func configTitleLabel(label: UILabel, view: UIView){
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = Fonts().titleFont
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: width/5)
        ])
        
        label.sizeToFit() 
 
    }
    
    static func styleButtons(buttons: [UIButton], view: UIView,  textColor: [UIColor]) {
        guard !buttons.isEmpty else { return }
        
        
        
        for (index, button) in buttons.enumerated() {
            
            button.translatesAutoresizingMaskIntoConstraints = false

            button.titleLabel?.font = Fonts().buttonFont
            button.titleLabel?.numberOfLines = 1
            button.backgroundColor = UIColor.black
            button.setTitleColor(textColor[index], for: .normal)  // Correct way to set text color
            button.layer.cornerRadius = 10

            
            if let text = button.titleLabel?.text, let font = button.titleLabel?.font {
                let textSize = (text as NSString).size(withAttributes: [.font: font])
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: textSize.height + 20),
                    button.widthAnchor.constraint(equalToConstant:  textSize.width + 50)
                       ])
            }
            
            view.addSubview(button) // Ensure the button is added to the view
    
        }
        
        // Use a UIStackView to handle layout
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Center vertically
        ])
    }


    

}

