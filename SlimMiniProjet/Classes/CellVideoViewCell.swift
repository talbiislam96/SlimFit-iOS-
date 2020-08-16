//
//  CellVideoViewCell.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 13/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class CellVideoViewCell: UITableViewCell {

    @IBOutlet weak var VideoImage: UIImageView!
    @IBOutlet weak var VideoTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
