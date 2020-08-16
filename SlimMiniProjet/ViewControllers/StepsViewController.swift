//
//  StepsViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 05/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StepsViewController: UIViewController {
//    let healthManager = HealthManager()
     let defaults = UserDefaults.standard
    private let authorizeHealthKitSection = 2
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var profile: UIButton!
    
 
    
    
    @IBAction func profilebtn(_ sender: Any) {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Me", image:UIImage(named: "mee"), tag: 3)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        fname.text = defaults.object(forKey: "user_name") as? String
        lname.text = defaults.object(forKey: "user_mail") as? String
        
        
        guard let nom = fname.text, !nom.isEmpty else {return}
        guard let mail = lname.text, !mail.isEmpty else {return}
        
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func updatebtn(_ sender: Any) {
//        let indexpath = IndexPath
//
//
//        if indexPath.section == authorizeHealthKitSection {
                 authorizeHealthKit()
             

         
        
     }
         
     }

  private func authorizeHealthKit() {
    HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
        
        guard authorized else {
            
            let baseMessage = "HealthKit Authorization Failed"
            
            if let error = error {
                print("\(baseMessage). Reason: \(error.localizedDescription)")
            } else {
                print(baseMessage)
            }
            
            return
        }
        
        print("HealthKit Successfully Authorized.")
    }
  }


