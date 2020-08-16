//
//  DietDetailsViewController.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 25/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DietDetailsViewController: UIViewController {
     let backgroundImageView = UIImageView()
    var arr_diet_id = [String]()

    var arr_diet_breakfast = [String]()
    var arr_diet_lunch = [String]()
    var arr_diet_dinner = [String]()

    
    @IBOutlet weak var breakfastlbl: UITextView!
    @IBOutlet weak var lunchlbl: UITextView!
    
    @IBOutlet weak var dinnerlbl: UITextView!
    //    var dietFocus: DietFocus!
    var dietName: String = ""
    var calorieGoal: String = ""
    var isVegetarian: Bool = false
    var isVegan: Bool = false
    var isGlutenFree: Bool = false
    var isDairyFree: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        let myapiurl = "http://localhost:1337/diet/show"
             Alamofire.request(myapiurl, method: .get).responseJSON { (myresponse) in
                 switch myresponse.result{
                 case .success:
                     print(myresponse.result)
                     let myresult = try? JSON(data: myresponse.data!)
                     print(myresult!["diets"])
                     
                     let resultArray = myresult!["diets"]
                     self.arr_diet_id.removeAll()

                     self.arr_diet_breakfast.removeAll()
                     self.arr_diet_lunch.removeAll()
                     self.arr_diet_dinner.removeAll()
                 
                     
                     
                     
                     
                     
                     for i in resultArray.arrayValue {
                         //                    print(i)
                         let diet_id = i["id"].stringValue
                         self.arr_diet_id.append(diet_id)
                        
                         let diet_breakfast = i["breakfast"].stringValue
                         self.arr_diet_breakfast.append(diet_breakfast)
                        self.breakfastlbl.text = diet_breakfast
                         let diet_lunch = i["lunch"].stringValue
                         self.arr_diet_lunch.append(diet_lunch)
                        self.lunchlbl.text = diet_lunch

                         let diet_dinner = i["dinner"].stringValue
                         self.arr_diet_dinner.append(diet_dinner)
                        self.dinnerlbl.text = diet_dinner

                     
                     }
                     
                     break
                     
                 case .failure:
                     print(myresponse.error!)
                     break
                 }
             }

        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as! DietViewController
//        controller.dietName = dietName
//        controller.calorieGoal = calorieGoal
//        controller.isVegetarian = isVegetarian
//        controller.isVegan = isVegan
//        controller.isGlutenFree = isGlutenFree
//        controller.isDairyFree = isDairyFree
//        controller.breakfastFoodsRawString = BreakfastFoodsTextView.text
//        controller.lunchFoodsRawString = LunchFoodsTextView.text
//        controller.dinnerFoodsRawString = DinnerFoodsTextView.text
//    }
//
    

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
    
}
