//
//  SCNBoxViewController.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 08/03/25.
//

import UIKit
import ARKit

class SCNGeometryViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let node = SCNNode()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
    }
    
    
    @IBAction func cubeBtnTapped(_ sender: UIButton) {
        
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        cube.materials = [material]
        
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = cube
        
    }
    
    @IBAction func sphereBtnTapped(_ sender: UIButton) {
        
        let sphere = SCNSphere(radius: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/earth_night_map.jpg")
        sphere.materials = [material]
        
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = sphere
        
    }
    

}
