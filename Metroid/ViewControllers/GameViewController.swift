//
//  GameViewController.swift
//  Metroid
//
//  Created by jonathan thornburg on 11/26/17.
//  Copyright © 2017 jon-thornburg. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var stackView: UIStackView!
    
    var scene: SKScene?
    var isInBattle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            configureButtons()
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            let tapGr = UITapGestureRecognizer(target: self, action: #selector(self.showStack))
            view.addGestureRecognizer(tapGr)
            backButton.isHidden = true
        }
        stackView.isHidden = true
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    func presentScene(view: SKView) {
        scene = SKScene(fileNamed: "GameScene")
        scene!.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene!)
    }
    
    func resetViewController() {
        scene?.removeFromParent()
        stackView.isHidden = true
    }
    
    func configureButtons() {
        for button in buttons {
            button.layer.cornerRadius = 5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.7
        }
    }
    
    @objc func showStack() {
        if !isInBattle {
            stackView.isHidden = false
        }
    }
    
    func showHide(isTheQuestion: Bool) {
        titleLabel.isHidden = isTheQuestion
        imageView.isHidden = isTheQuestion
        startLabel.isHidden = isTheQuestion
        stackView.isHidden = isTheQuestion
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // IBActions
    @IBAction func didTapShop(_ sender: Any) {
        resetViewController()
    }
    @IBAction func didTapMap(_ sender: Any) {
    }
    @IBAction func didTapBattle(_ sender: Any) {
        if let view = self.view as? SKView {
            isInBattle = true
            backButton.isHidden = false
            showHide(isTheQuestion: true)
            presentScene(view: view)
        }
    }
    @IBAction func didTapUpgrade(_ sender: Any) {
        let vc = UpgradeVC(nibName: "UpgradeVC", bundle: nil)
        let navController = UINavigationController()
        navController.viewControllers = [vc]
        present(navController, animated: true, completion: nil)
    }
    @IBAction func didTapBack(_ sender: Any) {
        if let view = self.view as? SKView {
            view.presentScene(nil)
        }
        backButton.isHidden = true
    }
    
}
