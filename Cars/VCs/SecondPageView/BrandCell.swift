//
//  CarCell.swift
//  Cars
//
//  Created by Tatia on 23.03.21.
//

import UIKit


class BrandCell: UITableViewCell {

    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var carsAmount: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
