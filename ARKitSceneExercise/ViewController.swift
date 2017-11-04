//
//  ViewController.swift
//  ARKitSceneExercise
//
//  Created by Daniel Ku on 11/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    var counterLabel = UILabel()
    
    var counter: Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
            self.counterLabel.isHidden = false

            let delay = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.counterLabel.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel = UILabel(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.bounds.width, height: self.view.bounds.height))
        counterLabel.center = self.view.center
        counterLabel.text = "0"
        counterLabel.textAlignment = .center
        counterLabel.font = counterLabel.font.withSize(30)
        counterLabel.textColor = .red
        self.view.addSubview(counterLabel)
        
        counterLabel.isHidden = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        addShip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "ArShip" {
                    counter += 1
                    node.removeFromParentNode()
                    addShip()
                }
            }
        }
        
    }
    
    func addShip() {
        let ship = SpaceShip()
        ship.loadShip()
        
        let xPos = randomPosition(lower: -1.5, upper: 1.5)
        let yPos = randomPosition(lower: -1.5, upper: 1.5)

        ship.position = SCNVector3(xPos, yPos, -2)
        
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    func randomPosition(lower: Float, upper: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
