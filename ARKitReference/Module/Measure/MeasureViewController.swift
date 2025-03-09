//
//  MeasureViewController.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 09/03/25.
//

import UIKit
import ARKit

class MeasureViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    var sphereNodes: [SCNNode] = []
    var textNodes: [SCNNode] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchLocation = touches.first?.location(in: sceneView) else { return }
        
        guard let raycastQuery = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any) else { return }
        
        guard let raycastResult = sceneView.session.raycast(raycastQuery).first else { return }
        
        let transform = raycastResult.worldTransform
        
        let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        
        addPoint(position: position)
        
    }
    
    private func addPoint(position: SCNVector3) {
 
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        
        let sceneSphere = SCNSphere(radius: 0.005)
        sceneSphere.materials = [material]
        
        let sphereNode = SCNNode(geometry: sceneSphere)
        sphereNode.position = position
        
        checkNodeCount()
        sphereNodes.append(sphereNode)
        sceneView.scene.rootNode.addChildNode(sphereNode)
        measureDistance()
        
    }
    
    private func measureDistance() {
        
        if sphereNodes.count == 2 {
            
            let startPoint = sphereNodes.first!.position
            let endPoint = sphereNodes.last!.position
            
            let vectorStart = GLKVector3(v: (startPoint.x, startPoint.y, startPoint.z))
            let vectorEnd = GLKVector3(v: (endPoint.x, endPoint.y, endPoint.z))
            
            let distance = GLKVector3Distance(vectorStart, vectorEnd)
            showMeasureText(distance)
        }
        
    }
    
    private func checkNodeCount() {
        
        if sphereNodes.count >= 2 {
            for node in sphereNodes {
                node.removeFromParentNode()
            }
            for node in textNodes {
                node.removeFromParentNode()
            }
            sphereNodes.removeAll()
            textNodes.removeAll()
        }
        
    }
    
    private func showMeasureText(_ distance: Float) {
        
        let startPoint = sphereNodes.first!.position
        let endPoint = sphereNodes.last!.position
        
        let centerPoint = SCNVector3((startPoint.x + endPoint.x)/2, (startPoint.y + endPoint.y)/2, (startPoint.z + endPoint.z)/2)
        
        let textGeometry = SCNText(string: "\(distance)", extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = UIColor.green
        textGeometry.font = UIFont.systemFont(ofSize: 100)
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = centerPoint
        textNode.scale = SCNVector3(0.0005, 0.0005, 0.0005)
        
        textNodes.append(textNode)
        sceneView.scene.rootNode.addChildNode(textNode)
        
    }

}
