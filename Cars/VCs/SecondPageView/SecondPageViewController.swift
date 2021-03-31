//
//  SecondPageViewController.swift
//  Cars
//
//  Created by Tatia on 23.03.21.
//

import UIKit




class SecondPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, thirdPageDelegate, PaymentViewDelegate {
    

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var pay: UIButton!
    
    var totalAmount = 0
    var totalPrice = 0
    
    
    var sections: [CarSection]?


    override func viewDidLoad() {
        super.viewDidLoad()
        updatePriceAndAmount()
        design()
        self.sections = self.generateDataSource()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        self.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sections?[section].manufacturers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCell", for: indexPath) as! BrandCell
        let manufacturer = self.sections?[indexPath.section].manufacturers[indexPath.row]
        cell.brandLogo.image = manufacturer?.image
        cell.brandName.text = manufacturer?.name
        cell.carsAmount.text = "\(manufacturer?.totalAmount ?? 0)"
        cell.helperView.layer.cornerRadius = 20
        cell.helperView.layer.borderColor = UIColor.darkGray.cgColor
        cell.helperView.backgroundColor = UIColor.white
        cell.helperView.layer.borderWidth = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)![0] as! HeaderView
        headerView.countryLbl.text = sections?[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdPageViewController") as! ThirdPageViewController
        vc.manufacturer = sections?[indexPath.section].manufacturers[indexPath.row]
        vc.thirdDelegate = self
        vc.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func update(manufacturer: CarManufacturer, indexPath: IndexPath) {
        self.sections?[indexPath.section].manufacturers[indexPath.row] = manufacturer
        updatePriceAndAmount()
        self.tableView.reloadData()
    }
    
    func updatePriceAndAmount() {
        totalAmount = 0
        for section in self.sections ?? [] {
            totalAmount += section.totalAmount
        }
        
        totalPrice = 0
        for section in self.sections ?? [] {
            totalPrice += section.totalPrice
        }
        
        amount.text = "\(totalAmount)"
        price.text = "\(totalPrice)"
        
        if totalAmount != 0 {
            cancel.isHidden = false
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        eraseData()
        self.tableView.reloadData()
    }
    
    func eraseData() {
        sections = self.generateDataSource()
        totalAmount = 0
        totalPrice = 0
        amount.text = "\(totalAmount)"
        price.text = "\(totalPrice)"
        cancel.isHidden = true
        self.tableView.reloadData()
        
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        let payVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForthPageViewController") as! ForthPageViewController
        payVC.car = selectedCars()
        payVC.payDelegate = self
        self.present(payVC, animated: true, completion: nil)
    }
    
    func design() {
        pay.layer.cornerRadius = 20
        cancel.layer.cornerRadius = 20
    }
    
    func selectedCars() -> [(String, [Car])] {
        var selectedCars: [(String, [Car])] = []
        for section in sections ?? [] where section.totalAmount > 0 {
            for manufacturer in section.manufacturers where manufacturer.totalAmount > 0 {
                var cars: [Car] = []
                
                for car in manufacturer.cars where car.amount > 0 {
                    cars.append(car)
                }

                selectedCars.append((manufacturer.name, cars))
            }
        }
        return selectedCars
    }

}

extension SecondPageViewController {
    private func generateDataSource() -> [CarSection] {
        
        let germanyManufacturers = [
            CarManufacturer(name: "BMW", cars: [
                Car(name: "BMW X5"),
                Car(name: "BMW M5"),
                Car(name: "BMW Z4")
            ]),
            CarManufacturer(name: "MERCEDES", cars: [
                Car(name: "Mercedes-Benz G-Class"),
                Car(name: "Mercedes-Benz E-Class"),
                Car(name: "Mercedes-Benz SLS AMG")
            ]),
            CarManufacturer(name: "PORSCHE", cars: [
                Car(name: "Porsche 911 GT"),
                Car(name: "Porsche Cayenn"),
                Car(name: "Porsche 911 SC")
            ])
        ]
        
        
        let italyManufacturers = [
             CarManufacturer(name: "FERRARI", cars: [
                Car(name: "Ferrari GTC4Lusso"),
                Car(name: "Ferrari Dino"),
                Car(name: "Ferrari F430")
             ]),
            CarManufacturer(name: "LAMBORGHINI", cars: [
               Car(name: "Lamborghini Aventador"),
               Car(name: "Lamborghini Gallardo"),
               Car(name: "Ferrari Aventador Coupe")
            ]),
            CarManufacturer(name: "FIAT", cars: [
               Car(name: "Fiat Tipo"),
               Car(name: "Fiat 500"),
               Car(name: "Fiat 500X")
            ])
        ]
        
        let japaneseManufacturers = [
            CarManufacturer(name: "HONDA", cars: [
               Car(name: "Honda Crosstour"),
               Car(name: "Honda Accord"),
               Car(name: "Honda CBR250R")
            ]),
           CarManufacturer(name: "MITSUBISHI", cars: [
              Car(name: "Mitsubishi Outlander"),
              Car(name: "Mitsubishi Outlander Sport"),
              Car(name: "Mitsubishi Pajero")
           ]),
           CarManufacturer(name: "TOYOTA", cars: [
              Car(name: "Toyota Land Cruiser"),
              Car(name: "Toyota Tacoma"),
              Car(name: "Toyota Prius")
           ])
        ]
        
        let sections = [
            CarSection(title: "გერმანია 🇩🇪", manufacturers: germanyManufacturers),
            CarSection(title: "იტალია 🇮🇹", manufacturers: italyManufacturers),
            CarSection(title: "იაპონია 🇯🇵", manufacturers: japaneseManufacturers)
        ]
        
        return sections
    }
}
