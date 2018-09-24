//
//  ViewController.swift
//  ARKitTutorial
//
//  Created by Pablo Blanco Peris on 24/9/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //default lighting
        sceneView.autoenablesDefaultLighting = true
        
/////////////////////////////////
        //First Scene
/////////////////////////////////

        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        
/////////////////////////////////
        //Second Scene
/////////////////////////////////

//        let geometry = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0)
//        let geometry = SCNSphere(radius: 0.35)
//        geometry.firstMaterial?.diffuse.contents = UIColor.red
//
//        let box = SCNNode(geometry: geometry)
//        box.position = SCNVector3(0, 0, -1)
//
//        sceneView.scene.rootNode.addChildNode(box)
//
//        let sphere = SCNNode(geometry: SCNSphere(radius:0.05))
//        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//
//        sphere.position = SCNVector3(0.5, 0, 0)
//        box.addChildNode(sphere)
        
/////////////////////////////////
        //Third Scene
/////////////////////////////////

        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.position = SCNVector3(0, 0, -2)
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun diffuse")
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -2)
        
        let moonParent = SCNNode()
        moonParent.position = SCNVector3(1.2, 0, 0)
        
        let earth = SCNNode(geometry: SCNSphere(radius: 0.2))
        earth.position = SCNVector3(1.2, 0, 0)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Earth Day")
        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth Emission")
        earth.geometry?.firstMaterial?.normal.contents = UIImage(named: "Earth Normal")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earth Specular")

        let moon = SCNNode(geometry: SCNSphere(radius: 0.05))
        moon.position = SCNVector3(0, 0, -0.3)
        moon.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Moon diffuse")
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        moonParent.addChildNode(moon)
        
        let sunRotation = rotation(time: 8)
        let earthParentRotation = rotation(time: 14)
        let earthRotation = rotation(time: 8)
        let moonParentRotation = rotation(time: 5)
        
        sun.runAction(sunRotation)
        earth.runAction(earthRotation)
        earthParent.runAction(earthParentRotation)
        moonParent.runAction(moonParentRotation)
        
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
    
    fileprivate func rotation(time:TimeInterval) -> SCNAction{
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(2 * CGFloat.pi), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
