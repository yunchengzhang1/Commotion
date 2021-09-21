//
//  ViewController.swift
//  Commotion
//
//  Created by Eric Larson.
//  Copyright Eric Larson. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    
    // MARK: ======Class Variables======
    let activityManager = CMMotionActivityManager()

    // MARK: ======UI Lifecycle Methods======
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityMonitoring()
    }

    // MARK: ======Motion Methods======
    func startActivityMonitoring(){
        // if active, let's start processing
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: OperationQueue.main)
            {(activity:CMMotionActivity?)->Void in
                if let unwrappedActivity = activity {
                    print("%@",unwrappedActivity.description)
                    if(unwrappedActivity.walking){
                        self.activityLabel.text = "Walking"
                    }
                    else if(unwrappedActivity.running){
                        self.activityLabel.text = "Running"
                    }
                    else{
                        self.activityLabel.text = "Not Walking or Running"
                    }
                }
            }
        }
        
    }


}

