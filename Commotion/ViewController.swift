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
    
    @IBOutlet weak var activityLabel: UILabel!
    
    // MARK: class variables
    let activityManager = CMMotionActivityManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startActivityMonitoring()
    }

    
    func startActivityMonitoring(){
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: OperationQueue.main)
            {(activity:CMMotionActivity?)->Void in
                if let unwrappedActivity = activity {
                    print("%@",unwrappedActivity.description)
                    if(unwrappedActivity.walking){
                        self.activityLabel.text = "Walking"
                    }
                    else{
                        self.activityLabel.text = "Not Walking"
                    }
                }
            }
        }
        
    }


}

