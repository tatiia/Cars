//
//  CarCell.swift
//  Cars
//
//  Created by Tatia on 23.03.21.
//

import UIKit
protocol carCellDelegate: class {
    func addCar(cell: UITableViewCell)
    func removeCar(cell: UITableViewCell)
}

class CarCell: UITableViewCell {

    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carAmount: UILabel!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var add: UIButton!
    
    weak var carDelegate: carCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeBtn(_ sender: UIButton) {
        carDelegate.removeCar(cell: self)
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        carDelegate.addCar(cell: self)
    }
    
}
