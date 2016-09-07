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

class GameScene: SKScene {

    
    // MARK: Raw Motion Functions
    let motion = CMMotionManager()
    func startMotionUpdates(){
        // some internal inconsistency here: we need to ask the device manager for device
        
        if self.motion.deviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.1
            self.motion.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: self.handleMotion)
        }
    }
    
    func handleMotion(motionData:CMDeviceMotion?, error:NSError?){
        if let gravity = motionData?.gravity {
            self.physicsWorld.gravity = CGVectorMake(CGFloat(9.8*gravity.x), CGFloat(9.8*gravity.y))
        }
    }
    
    // MARK: View Hierarchy Functions
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.whiteColor()
        
        // start motion for gravity
        self.startMotionUpdates()
        
        // make sides to the screen
        self.addSidesAndTop()
        
        // add some stationary blocks
        self.addStaticBlockAtPoint(CGPoint(x: size.width * 0.1, y: size.height * 0.25))
        self.addStaticBlockAtPoint(CGPoint(x: size.width * 0.9, y: size.height * 0.25))
        
        // add a spinning block
        self.addBlockAtPoint(CGPoint(x: size.width * 0.5, y: size.height * 0.35))
        
        self.addSprite()
    }
    
    // MARK: Create Sprites Functions
    func addSprite(){
        let spriteA = SKSpriteNode(imageNamed: "sprite") // this is literally a sprite bottle... 😎
        
        spriteA.size = CGSize(width:size.width*0.1,height:size.height * 0.1)
        
        spriteA.position = CGPoint(x: size.width * random(min: CGFloat(0.1), max: CGFloat(0.9)), y: size.height * 0.75)
        
        spriteA.physicsBody = SKPhysicsBody(rectangleOfSize:spriteA.size)
        spriteA.physicsBody?.restitution = random(min: CGFloat(1.0), max: CGFloat(1.5))
        spriteA.physicsBody?.dynamic = true
        
        self.addChild(spriteA)
    }
    
    func addBlockAtPoint(point:CGPoint){
        let 🔲 = SKSpriteNode()
        
        🔲.color = UIColor.redColor()
        🔲.size = CGSize(width:size.width*0.15,height:size.height * 0.05)
        🔲.position = point
        
        🔲.physicsBody = SKPhysicsBody(rectangleOfSize:🔲.size)
        🔲.physicsBody?.dynamic = true
        🔲.physicsBody?.pinned = true
        
        self.addChild(🔲)

    }
    
    func addStaticBlockAtPoint(point:CGPoint){
        let 🔲 = SKSpriteNode()
        
        🔲.color = UIColor.redColor()
        🔲.size = CGSize(width:size.width*0.1,height:size.height * 0.05)
        🔲.position = point
        
        🔲.physicsBody = SKPhysicsBody(rectangleOfSize:🔲.size)
        🔲.physicsBody?.dynamic = true
        🔲.physicsBody?.pinned = true
        🔲.physicsBody?.allowsRotation = false
        
        self.addChild(🔲)
        
    }
    
    func addSidesAndTop(){
        let left = SKSpriteNode()
        let right = SKSpriteNode()
        let top = SKSpriteNode()
        
        left.size = CGSize(width:size.width*0.1,height:size.height)
        left.position = CGPoint(x:0, y:size.height*0.5)
        
        right.size = CGSize(width:size.width*0.1,height:size.height)
        right.position = CGPoint(x:size.width, y:size.height*0.5)
        
        top.size = CGSize(width:size.width,height:size.height*0.1)
        top.position = CGPoint(x:size.width*0.5, y:size.height)
        
        for obj in [left,right,top]{
            obj.color = UIColor.redColor()
            obj.physicsBody = SKPhysicsBody(rectangleOfSize:obj.size)
            obj.physicsBody?.dynamic = true
            obj.physicsBody?.pinned = true
            obj.physicsBody?.allowsRotation = false
            self.addChild(obj)
        }
    }
    
    // MARK: UI Delegate Functions
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.addSprite()
    }
    
    // MARK: Utility Functions (thanks ray wenderlich!)
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
