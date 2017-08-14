//
//  CustomTableViewCell.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var partLable: UILabel!
  
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var goodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
