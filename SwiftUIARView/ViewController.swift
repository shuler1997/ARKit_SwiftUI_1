

import UIKit
import SceneKit
import ARKit
import SwiftUI

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let geometrySize = CGSize(width: 0.8, height: 0.8)
    var ARNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)


    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

    // Run the view's session
    sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func initButton(_ sender: Any) {
        
        initARScene(baseNode: sceneView.scene.rootNode)
    }
    
    func initARScene(baseNode: SCNNode) {
        ARNode = createNode(size: geometrySize)
        ARNode.position = SCNVector3(0,0,-0.2)
        baseNode.addChildNode(ARNode)
    }
    
    func createNode(size:CGSize) -> SCNNode {
        let node = SCNNode()
        let plane = SCNPlane(width: size.height, height: size.height)
        let planeNode = SCNNode(geometry: plane)
        createHostingController(for: planeNode)
        node.addChildNode(planeNode)
        return node
    }
    
    func createHostingController(for node: SCNNode) {
        let arVC = UIHostingController(rootView: SwiftUIARCardView())
        DispatchQueue.main.async {
            arVC.willMove(toParent: self)
            self.addChild(arVC)
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.view.addSubview(arVC.view)
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<SwiftUIARCardView>, on node: SCNNode) {
        let material = SCNMaterial()
        hostingVC.view.isOpaque = false
        material.diffuse.contents = hostingVC.view
        material.isDoubleSided = true
        node.geometry?.materials = [material]
    }

    
}
