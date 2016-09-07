//
//  GameScene.swift
//  Commotion
//
//  Created by Eric Larson on 9/6/16.
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class GameScene: SKScene,SKPhysicsContactDelegate {

    let motion = CMMotionManager()
    // MARK: Raw Motion Functions
    func startMotionUpdates(){
        // some internal inconsistency here: we need to ask the device manager for device
        
        if self.motion.deviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.1
            self.motion.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: self.handleMotion)
        }
    }
    
    func handleMotion(motionData:CMDeviceMotion?, error:NSError?){
        if let gravity = motionData?.gravity {
            physicsWorld.gravity = CGVectorMake(CGFloat(9.8*gravity.x), CGFloat(9.8*gravity.y))
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.whiteColor()
        
        physicsWorld.contactDelegate = self
        startMotionUpdates()
        
        addBlockAtPoint(CGPoint(x: size.width * 0.1, y: size.height * 0.25))
        addBlockAtPoint(CGPoint(x: size.width * 0.5, y: size.height * 0.35))
        addBlockAtPoint(CGPoint(x: size.width * 0.9, y: size.height * 0.25))
        
        addSprite()
    }
    
    func addSprite(){
        let spriteA = SKSpriteNode(imageNamed: "sprite")
        
        spriteA.size = CGSize(width:size.width*0.1,height:size.height * 0.1)
        
        spriteA.position = CGPoint(x: size.width * random(min: CGFloat(0.0), max: CGFloat(1.0)), y: size.height * 0.75)
        
        spriteA.physicsBody = SKPhysicsBody(rectangleOfSize:spriteA.size)
        spriteA.physicsBody?.restitution = 1.1
        spriteA.physicsBody?.dynamic = true
        
        addChild(spriteA)
    }
    
    func addBlockAtPoint(point:CGPoint){
        let block = SKSpriteNode()
        
        block.color = UIColor.redColor()
        block.size = CGSize(width:size.width*0.1,height:size.height * 0.05)
        block.position = point
        
        block.physicsBody = SKPhysicsBody(rectangleOfSize:block.size)
        block.physicsBody?.dynamic = true
        block.physicsBody?.pinned = true
        
        addChild(block)

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        addSprite()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
