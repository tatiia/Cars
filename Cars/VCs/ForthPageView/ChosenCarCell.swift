//
//  ChosenCarCell.swift
//  Cars
//
//  Created by Tatia on 26.03.21.
//

import UIKit

class ChosenCarCell: UITableViewCell {

    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carAmount: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
