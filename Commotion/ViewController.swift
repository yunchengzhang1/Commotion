//
//  ViewController.swift
//  Commotion
//
//  Created by Eric Larson on 9/6/16.
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let activityManager = CMMotionActivityManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: {(activity: CMMotionActivity?) -> Void in
            print("\(String(describing: activity?.description))")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

