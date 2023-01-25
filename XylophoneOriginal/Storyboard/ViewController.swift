//
//  ViewController.swift
//  XylophoneOriginal
//
//  Created by Нахид Гаджалиев on 25.01.2023.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func keyTapped(_ sender: UIButton) {
        guard let songName = sender.currentTitle else { return }
        playMusic(songName: songName)
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    private func playMusic(songName: String) {
        
        guard let path = Bundle.main.path(forResource: songName, ofType: "wav") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
