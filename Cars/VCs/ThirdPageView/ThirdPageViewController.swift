//
//  ThirdPageViewController.swift
//  Cars
//
//  Created by Tatia on 23.03.21.
//

import UIKit

protocol thirdPageDelegate: class {
    func update(manufacturer: CarManufacturer, indexPath: IndexPath)
}

class ThirdPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, carCellDelegate {
    
    
    weak var thirdDelegate: thirdPageDelegate!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var finishView: UIView!
    
    
    var manufacturer: CarManufacturer?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()

        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manufacturer?.cars.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        guard let car = manufacturer?.cars[indexPath.row] else { return .init() }
        brandName.text = manufacturer?.name
        cell.carImage.image = car.image
        cell.carName.text = "\(car.name)"
        cell.carPrice.text = "\(car.price)"
        cell.carAmount.text = "\(car.amount)"
        cell.helperView.layer.cornerRadius = 20
        cell.helperView.layer.borderColor = UIColor.darkGray.cgColor
        cell.helperView.backgroundColor = UIColor.white
        cell.helperView.layer.borderWidth = 2
        cell.remove.layer.cornerRadius = 10
        cell.add.layer.cornerRadius = 10
        cell.carDelegate = self
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    
    @IBAction func endBtn(_ sender: UIButton) {
        guard let manufacturer = self.manufacturer, let indexPath = self.selectedIndexPath else { return }
        thirdDelegate.update(manufacturer: manufacturer, indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    func addCar(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        self.manufacturer?.cars[indexPath.row].amount += 1
        
        tableView.reloadData()
    }
    
    func removeCar(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if self.manufacturer?.cars[indexPath.row].amount ?? 0 > 0 {
            self.manufacturer?.cars[indexPath.row].amount -= 1
        }
        
        tableView.reloadData()
    }
    
    func design() {
        finishView.layer.cornerRadius = 20
        finishView.backgroundColor = .white
        finishView.layer.borderWidth = 4
        finishView.layer.borderColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
    }
    
}
