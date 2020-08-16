//
//  RegesterViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 23/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire


import SwiftyJSON


class RegisterViewController: UIViewController {
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.bg(colorone: .blue, colorTwo: .red)
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
         setBackground()
    }
    
    
    @IBAction func register_btn(_ sender: Any) {
        
        let serverUrl = "http://localhost:1337/register"
              
              guard let email = emailtf.text, !email.isEmpty else {return}
              guard let password = passwordtf.text, !password.isEmpty else {return}
              guard let name = nametf.text, !name.isEmpty else {return}
            
              
              let registerRequest = [
                  "name" : name,
                  "email" : email,
                  "password" : password
              ]
              
              print(registerRequest)
            
                  
              
              
                    Alamofire.request(serverUrl, method: .post, parameters: registerRequest, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
                          if responseObject.result.isSuccess {
                              let resJson = JSON(responseObject.result.value!)
                              print(resJson)
                       

                            
                          }
                          if responseObject.result.isFailure {
                              let error : Error = responseObject.result.error!
                              print(error)
                          }
                         

                 }
        
    }
    

    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }

}
