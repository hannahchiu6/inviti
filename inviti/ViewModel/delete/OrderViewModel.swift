////
////  TrolleyViewController.swift
////  STYLiSH
////
////  Created by WU CHIH WEI on 2019/2/28.
////  Copyright © 2019 WU CHIH WEI. All rights reserved.
////
//
//import UIKit
//
//class TrolleyViewController: STBaseViewController {
//
//    private struct Segue {
//
//        static let checkout = "SegueCheckout"
//    }
//
//    @IBOutlet weak var tableView: UITableView! {
//
//        didSet {
//
//            tableView.delegate = self
//
//            tableView.dataSource = self
//        }
//    }
//
//    @IBOutlet weak var emptyView: UIView!
//
//    @IBOutlet weak var checkoutBtn: UIButton!
//
//    var orders: [LSOrder] = [] {
//
//        didSet {
//
//            tableView.reloadData()
//
//            if orders.count == 0 {
//
//                tableView.isHidden = true
//
//                checkoutBtn.isEnabled = false
//
//                checkoutBtn.backgroundColor = UIColor.B4
//
//            } else {
//
//                tableView.isHidden = false
//
//                checkoutBtn.isEnabled = true
//
//                checkoutBtn.backgroundColor = UIColor.B1
//            }
//        }
//    }
//
//    var observation: NSKeyValueObservation?
//
//    // MARK: - View Life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.lk_registerCellWithNib(identifier: String(describing: TrolleyTableViewCell.self), bundle: nil)
//
//        fetchData()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        StorageManager.shared.save()
//    }
//
//    // MARK: - Action
//
//    func fetchData() {
//
//        observation = StorageManager.shared.observe(
//            \.orders,
//            options: [.initial, .new],
//            changeHandler: { [weak self] (_, value) in
//
//                guard let datas = value.newValue else { return }
//
//                self?.orders = datas
//        })
//    }
//
//    func deleteData(at index: Int) {
//
//        StorageManager.shared.deleteOrder(
//            orders[index],
//            completion: { result in
//
//                switch result {
//
//                case .success: break
//
//                case .failure: LKProgressHUD.showFailure(text: "刪除資料失敗！")
//
//                }
//        })
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == Segue.checkout {
//
//            guard let checkoutVC = segue.destination as? CheckoutViewController else { return }
//
//            let orderProvider = OrderProvider(order: Order(products: orders))
//
//            checkoutVC.orderProvider = orderProvider
//        }
//    }
//}
//
//extension TrolleyViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return orders.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: String(describing: TrolleyTableViewCell.self),
//            for: indexPath
//        )
//
//        guard let trolleyCell = cell as? TrolleyTableViewCell else { return cell }
//
//        trolleyCell.layoutView(order: orders[indexPath.row])
//
//        trolleyCell.touchHandler = { [weak self] in
//
//            self?.deleteData(at: indexPath.row)
//        }
//
//        trolleyCell.valueChangeHandler = { [weak self] value in
//
//            self?.orders[indexPath.row].amount = value.int64()
//        }
//
//        return trolleyCell
//    }
//}
//
//extension TrolleyViewController: UITableViewDelegate {
//
//}
