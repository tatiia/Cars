//
//  ForthPageViewController.swift
//  Cars
//
//  Created by Tatia on 25.03.21.
//

import UIKit

protocol PaymentViewDelegate: class {
    func eraseData()
}


class ForthPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var payment: UIButton!
    var car: [(String, [Car])]?
    var sumPrice = 0
    weak var payDelegate: PaymentViewDelegate?
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        car?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        car?[section].1.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChosenCarCell", for: indexPath) as! ChosenCarCell
        guard let car = car?[indexPath.section] else { return .init()}
        cell.brandImage.image = UIImage(named: car.0)
        cell.carName.text = car.1[indexPath.row].name
        cell.carAmount.text = "\(car.1[indexPath.row].amount)"
        cell.carPrice.text = "\(car.1[indexPath.row].price * car.1[indexPath.row].amount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        calculatePrice()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func paymentBtn(_ sender: UIButton) {
        helperView.isHidden = false
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.indicator.stopAnimating()
            let payView: Payment!
            payView = Bundle.main.loadNibNamed("Payment", owner: nil, options: nil)![0] as? Payment
            if self.sumPrice > 200000 {
                payView.paymentStatus.text = "წარუმატებელი გადახდა"
                payView.paymentStatus.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                payView.imageView.image = UIImage(named: "carumatebeliGadaxda")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.dismiss(animated: true, completion: nil)
                    
                }
            } else {
                payView.paymentStatus.text = "წარმატებული გადახდა"
                payView.paymentStatus.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                payView.imageView.image = UIImage(named: "carmatebuliGadaxda")
                self.payDelegate!.eraseData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            self.view.addSubview(payView)
        }
        
    }
    
    func design() {
        paymentView.layer.cornerRadius = 20
        
    }
    
    func calculatePrice() {
        for item in car ?? [] {
            for car in item.1 {
                sumPrice += car.amount * car.price
            }
        }
        
        payment.setTitle("გადახდა \(sumPrice)", for: .normal)
    }
    
    

}
