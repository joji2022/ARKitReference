//
//  RollDiceViewController.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 08/03/25.
//

import UIKit
import ARKit

class RollDiceViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
    }
    
    private func placeDice(node: SCNNode, position: SCNVector3) {
        let scene = SCNScene(named: "art.scnassets/dice.scn")
        let diceNode = scene?.rootNode.childNode(withName: "dice", recursively: true)
        diceNode?.position = position
        diceNode?.position.y += (diceNode?.boundingSphere.radius)!
        if let diceNode {
            node.addChildNode(diceNode)
        }
        let randomX = Int.random(in: 0...3) * 5
        let randomZ = Int.random(in: 0...3) * 5
        let randomY = Int.random(in: 0...3) * 5
        diceNode?.runAction(SCNAction.rotateBy(x: CGFloat(randomX) * .pi/2, y: CGFloat(randomY) * .pi/2, z: CGFloat(randomZ) * .pi/2, duration: 0.5))
    }
    

}

extension RollDiceViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        plane.materials = [material]
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        planeNode.eulerAngles.x = -.pi/2
        
        node.addChildNode(planeNode)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: sceneView) else { return }
        
        if let raycastQuery = sceneView.raycastQuery(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .any) {
            let results: [ARRaycastResult] = sceneView.session.raycast(raycastQuery)
            
            if let raycastResult = results.first {
                let transform = raycastResult.worldTransform
                let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
                placeDice(node: sceneView.scene.rootNode, position: position)
            }
        }
        
    }
    
}
