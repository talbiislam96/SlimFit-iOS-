//
//  ViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 23/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var logintf: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    let defaults = UserDefaults.standard

    
    @IBAction func signin(_ sender: Any) {
        
        
        let serverUrl = "http://localhost:1337/login"
        
        
        
     let email = logintf.text
         let password = pass.text
        
        
        
        
        
        let loginRequest  = [
            
            "email" : email,
            
            "password" : password
            
        ]
        
        print(loginRequest)
        if (logintf.text!.isEmpty) || (pass.text!.isEmpty) {
            let myalert = UIAlertController(title: "SlimFit", message: "Fill credentials", preferredStyle: UIAlertController.Style.alert)
                       
                       
                       
                       myalert.addAction(UIAlertAction(title: "Réessayez", style: .default) { (action:UIAlertAction!) in
                           
                           print("retry")
                           
                        
                           
                           
                           
                       })
                       
                       self.present(myalert, animated: true)
            
        }
        else {
            Alamofire.request(serverUrl, method: .post, parameters: loginRequest as Parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (responseObject) -> Void in

            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                
                print(resJson)
                
                if (resJson != "Wrong Password") && (resJson != "user not exists!!") {
                    
                    let myresult = try? JSON(data: responseObject.data!)

                                     let resultArray = myresult!["user"]
                                     
                                              for i in resultArray.arrayValue {
                                                             let user_id = i["id"].stringValue
                                                 self.defaults.set(user_id, forKey: "user_id")

                                                 print(user_id)
                                                             let user_name = i["name"].stringValue
                                                 self.defaults.set(user_name, forKey: "user_name")

                                                 print(user_name)

                                              

                                                 let user_mail = i["email"].stringValue
                                                 
                                                 self.defaults.set(user_mail, forKey: "user_mail")
                                             



                                                 print(user_mail)

                                                         }
//                    self.performSegue(withIdentifier: "tab", sender: nil)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as UIViewController
                    self.navigationController?.pushViewController(vc, animated: true)

                    // Safe Push VC
                    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? UITabBarController {
                        if let navigator = self.navigationController {
                            navigator.pushViewController(viewController, animated: true)
                        }
                    }
                    
                }
                
               else if (resJson == "Wrong Password") {
                    
                    let myalert = UIAlertController(title: " SlimFit", message: "Vérifiez votre mot de passe", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    myalert.addAction(UIAlertAction(title: "Réessayez", style: .default) { (action:UIAlertAction!) in
                        
                        print("retry")
                        
                    })
                    
                    self.present(myalert, animated: true)
                    
                }
                
              else   {
                    
                    let myalert = UIAlertController(title: "SlimFit", message: "Utilisateur introuvable", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    myalert.addAction(UIAlertAction(title: "Inscrivez vous", style: .default) { (action:UIAlertAction!) in
                        
                        print("retry")
                        
                     
                        
                        
                        
                    })
                    
                    self.present(myalert, animated: true)
                    
                    
                    
                }
                
            }
            
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                
                print(error)
                
            }
            
            
            
        }}
           }
    
    @IBAction func signup(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.bg(colorone: .blue, colorTwo: .red)
        // Do any additional setup after loading the view.
        setBackground()
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
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }

}

