//
//  ProgrammaticallyViewController.swift
//  XylophoneOriginal
//
//  Created by Нахид Гаджалиев on 25.01.2023.
//

import UIKit
import AVFoundation

class ProgrammaticallyViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    lazy var cButton: UIButton = buttonCreator(title: "C", backColor: .systemRed)
    lazy var dButton: UIButton = buttonCreator(title: "D", backColor: .systemOrange)
    lazy var eButton: UIButton = buttonCreator(title: "E", backColor: .systemYellow)
    lazy var fButton: UIButton = buttonCreator(title: "F", backColor: .systemGreen)
    lazy var gButton: UIButton = buttonCreator(title: "G", backColor: .systemIndigo)
    lazy var aButton: UIButton = buttonCreator(title: "A", backColor: .systemBlue)
    lazy var bButton: UIButton = buttonCreator(title: "B", backColor: .systemPurple)
    
    lazy var cView: UIView = viewCreator(addButton: cButton)
    lazy var dView: UIView = viewCreator(addButton: dButton)
    lazy var eView: UIView = viewCreator(addButton: eButton)
    lazy var fView: UIView = viewCreator(addButton: fButton)
    lazy var gView: UIView = viewCreator(addButton: gButton)
    lazy var aView: UIView = viewCreator(addButton: aButton)
    lazy var bView: UIView = viewCreator(addButton: bButton)
    
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cView, dView,
                                                   eView, fView,
                                                   gView, aView,
                                                   bView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainStack)
        setupConstraints()
    }
    
    @objc private func playSound(sender: UIButton) {
        guard let path = Bundle.main.path(forResource: sender.currentTitle, ofType: "wav") else { return }
        let url = URL(filePath: path)
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch let error {
            let _ = error.localizedDescription
        }
    }
    
    private func buttonsConstraints(button: UIButton, toView: UIView, anchorSize: CGFloat) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: toView.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: 0),
            button.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: anchorSize),
            button.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -anchorSize),
        ])
    }
    
    private func setupConstraints() {
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsConstraints(button: cButton, toView: cView, anchorSize: 5)
        buttonsConstraints(button: dButton, toView: dView, anchorSize: 10)
        buttonsConstraints(button: eButton, toView: eView, anchorSize: 15)
        buttonsConstraints(button: fButton, toView: fView, anchorSize: 20)
        buttonsConstraints(button: gButton, toView: gView, anchorSize: 25)
        buttonsConstraints(button: aButton, toView: aView, anchorSize: 30)
        buttonsConstraints(button: bButton, toView: bView, anchorSize: 35)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
    }
    
    private func viewCreator(addButton: UIButton) -> UIView {
        let view = UIView()
        view.addSubview(addButton)
        
        return view
    }
    
    private func buttonCreator(title: String, backColor: UIColor) -> UIButton {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(playSound(sender: )), for: .touchUpInside)
        
        return button
    }
    
}
