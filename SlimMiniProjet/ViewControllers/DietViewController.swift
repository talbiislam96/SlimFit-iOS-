//
//  DietViewController.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 25/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DietViewController: UIViewController {
    
    @IBOutlet weak var breakfasttf: UITextView!
    
    @IBOutlet weak var dinnertf: UITextView!
    @IBOutlet weak var lunchtf: UITextView!
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()


        // Do any additional setup after loading the view.
    }
    

    func setBackground() {
          view.addSubview(backgroundImageView)
          backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
          backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
          backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          
          backgroundImageView.image = UIImage(named: "vg")
          view.sendSubviewToBack(backgroundImageView)
      }
    
    
    @IBAction func addBtn(_ sender: Any) {
                
                let serverUrl = "http://localhost:1337/diet/add"
                  
        //          let connectedUserId =  defaults.integer(forKey: "user_id")
                  
                  
                  guard let breakfast = breakfasttf.text, !breakfast.isEmpty else {return}
                  guard let lunch = lunchtf.text, !lunch.isEmpty else {return}
                  guard let dinner = dinnertf.text, !dinner.isEmpty else {return}
                
                  
                  
                  
                  let addFoodRequest = [
                      "breakfast" : breakfast,
                      "lunch" : lunch,
                      "dinner" : dinner,
                
                      
                      ] as [String : Any]
                  
                  print(addFoodRequest)
                  
                  
                  
                  Alamofire.request(serverUrl, method: .post, parameters: addFoodRequest, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
                      if responseObject.result.isSuccess {
                          let resJson = JSON(responseObject.result.value!)
                          print(resJson)
                          let myalert = UIAlertController(title: "SlimFit", message: "Votre food est ajouté avec succés", preferredStyle: UIAlertController.Style.alert)
                          myalert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                          })
                          self.present(myalert, animated: true)
                          
                      }
                      if responseObject.result.isFailure {
                          let error : Error = responseObject.result.error!
                          print(error)
                      }
                      
                      
                  }
    }
    
}
