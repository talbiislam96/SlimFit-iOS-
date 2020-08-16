//
//  MyexpViewController.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 10/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyexpViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var descriptiontf: UITextView!
    @IBOutlet weak var weightf: UITextField!
    @IBOutlet weak var fintf: UITextField!
    @IBOutlet weak var debutf: UITextField!
    lazy var datePicker: UIDatePicker = {
          
          let picker = UIDatePicker()
          
          picker.datePickerMode = .date
          
          picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
          
          return picker
      }()
    lazy var datePicker2: UIDatePicker = {
          
          let picker = UIDatePicker()
          
          picker.datePickerMode = .date
          
          picker.addTarget(self, action: #selector(datePickerChanged2(_:)), for: .valueChanged)
          
          return picker
      }()
    lazy var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        
        formatter.timeStyle = .none
        
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        weightf.delegate = self
                   weightf.keyboardType = .numberPad
        debutf.inputView = datePicker
        fintf.inputView = datePicker2

        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharachters = "0123456789"
        let allowedCharachterSet = CharacterSet(charactersIn: allowedCharachters)
        let typedCharachterSet = CharacterSet(charactersIn: string)
        
        
        return allowedCharachterSet.isSuperset(of: typedCharachterSet)
        
    }
    @objc func datePickerChanged(_ sender: UIDatePicker) {
         
         debutf.text = dateFormatter.string(from: sender.date)

     }
    @objc func datePickerChanged2(_ sender: UIDatePicker) {
           
          fintf.text = dateFormatter.string(from: sender.date)

       }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
           view.endEditing(true)
       }
    
    @IBAction func add_btn(_ sender: Any) {
           let serverUrl = "http://localhost:1337/experience/add"
                
                guard let startdate = debutf.text, !startdate.isEmpty else {return}
                guard let endate = fintf.text, !endate.isEmpty else {return}
                guard let weight = weightf.text, !weight.isEmpty else {return}
                guard let description = descriptiontf.text, !description.isEmpty else {return}
               
        


        

                
                let addExpRequest = [
                    "datedebut" : startdate,
                    "datefin" : endate,
                    "weightlost" : weight,
                     "description" : description
              
                ]
                
                print(addExpRequest)
              
                
                
                      Alamofire.request(serverUrl, method: .post, parameters: addExpRequest, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
                            if responseObject.result.isSuccess {
                                let resJson = JSON(responseObject.result.value!)
                                print(resJson)
                         let myalert = UIAlertController(title: "SlimFIt", message: "Votre expèrience est ajouté avec succés", preferredStyle: UIAlertController.Style.alert)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
