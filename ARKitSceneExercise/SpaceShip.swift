//
//  SpaceShip.swift
//  ARKitSceneExercise
//
//  Created by Daniel Ku on 11/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import ARKit

class SpaceShip: SCNNode {
    func loadShip() {
        guard let virtualShipScene = SCNScene(named: "art.scnassets/ship.scn") else {
            return
        }
        
        let wrapperNode = SCNNode()
        
        for child in virtualShipScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
    }
}
