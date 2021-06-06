////
////  File.swift
////  inviti
////
////  Created by Hannah.C on 03.06.21.
////
//
//import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseCore
//import FirebaseFirestore
//
//class SearchOwnerViewController: UIViewController {
//
//    @IBOutlet weak var searchField: UITextField! {
//        didSet {
//            self.searchField.delegate = self
//        }
//    }
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            self.tableView.delegate = self
//            self.tableView.dataSource = self
//        }
//    }
//    @IBOutlet weak var currentUserLabel: UILabel!
//    @IBOutlet weak var backButton: UIButton!
//    @IBAction func backButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func okButton(_ sender: Any) {
//
//        let selectedOwners: [UsersData] = filterOwnerData.compactMap({ owner in
//
//            if owner.isSelected {
//                return owner
//            } else {
//                return nil
//            }
//        })
//
//        selectHandler?(selectedOwners)
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    var indexRow = 0
//
//    var searchEmpty: Bool = true
//
//    var ownerData = [UsersData]() {
//
//        didSet {
//            if ownerData.isEmpty {
//                return
//            } else {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
//
//    var filterOwnerData = [UsersData]()
//
//    var selectHandler: (([UsersData]) -> Void)?
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        guard let currentUser = UserDefaults.standard.value(forKey: "userName") else {
//            return
//        }
//        currentUserLabel.text = "Hello, \(currentUser)!"
//
//        getOwnerData()
//        // Do any additional setup after loading the view.
//    }
//
//    func getOwnerData() {
//
//        Firestore.firestore().collection("users").getDocuments { (querySnapshot, error) in
//
//            if error == nil {
//                for document in querySnapshot!.documents {
//
//                    guard let userName = UserDefaults.standard.value(forKey: "userName") as? String else { return }
//
//                    guard let name = document.data()["name"] as? String,
//                        let image = document.data()["image"] as? String,
//                        let email = document.data()["email"] as? String,
//                        let id = document.data()["id"] as? String else { return }
//
//                    if name == userName {
//
//                        //break, return, continue
//                        continue
//
//                    } else {
//
//                        let usersData = UsersData(name: name, email: email, image: image, id: id)
//
//                        self.ownerData.append(usersData)
//                        self.filterOwnerData = self.ownerData
//
//                    }
//                }
//            }
//        }
//    }
//
//    func isSearchFieldEmpty() -> Bool {
//
//        return searchField.text?.isEmpty ?? true
//    }
//
//    func filterTextForSearchField(searchText: String) {
//
//        filterOwnerData = ownerData.filter({ (userData: UsersData) -> Bool in
//
//            if isSearchFieldEmpty() {
//
//                filterOwnerData = ownerData
//
//                return false
//
//            } else {
//
//                return true && userData.name.lowercased().contains(searchText.lowercased())
//            }
//        })
//
//        tableView.reloadData()
//    }
//}
//
//extension SearchOwnerViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        filterOwnerData[indexPath.row].isSelected = !filterOwnerData[indexPath.row].isSelected
//
//        let cell = tableView.cellForRow(at: indexPath)
//
//        cell?.backgroundColor = filterOwnerData[indexPath.row].isSelected ? .GY0 : .white
//    }
//}
//
//extension SearchOwnerViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return filterOwnerData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Owner Cell", for: indexPath) as? OwnerTableViewCell else {
//            return UITableViewCell()
//        }
//
//        cell.ownerImage.loadImage(filterOwnerData[indexPath.row].image, placeHolder: UIImage(named: "FurryLogo"))
//        cell.ownerName.text = filterOwnerData[indexPath.row].name
//
//        cell.backgroundColor = filterOwnerData[indexPath.row].isSelected ? .GY0 : .white
//
//        return cell
//    }
//}
//
//extension SearchOwnerViewController: UITextFieldDelegate {
//
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//        guard let text = searchField.text else {
//            return
//        }
//
//        filterTextForSearchField(searchText: text)
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        guard searchField.text != "" else {
//
//            filterOwnerData = ownerData
//
//            return tableView.reloadData()
//
//        }
//    }
//}
