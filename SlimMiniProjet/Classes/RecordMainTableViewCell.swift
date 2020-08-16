//
//  RecordMainTableViewCell.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 31/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Charts

class RecordMainTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var titleRecord: UILabel!
    @IBOutlet weak var dateRecord: UILabel!
    @IBOutlet weak var imageRecord: UIImageView!
    @IBOutlet weak var barChartView: BarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
