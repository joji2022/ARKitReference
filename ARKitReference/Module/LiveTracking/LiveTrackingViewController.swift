//
//  LiveTrackingViewController.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 10/03/25.
//

import UIKit
import ARKit

class LiveTrackingViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        let referenceImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        if let referenceImage {
            configuration.trackingImages = referenceImage
        }
        configuration.maximumNumberOfTrackedImages = 2
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
    }

}

extension LiveTrackingViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
        
        let node = SCNNode()
        
        let scenePlane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        scenePlane.materials = [material]
        let planeNode = SCNNode(geometry: scenePlane)
        planeNode.eulerAngles.x = -.pi/2
        planeNode.geometry = scenePlane
        add3DViewToNode(node)
        node.addChildNode(planeNode)
        
        return node
    }
    
    private func add3DViewToNode(_ node: SCNNode) {
        
        let scene = SCNScene(named: "art.scnassets/astronout.scn")
        if let scene {
            scene.rootNode.eulerAngles.y = -.pi/2
            node.addChildNode(scene.rootNode)
        }
    }
    
}
