////
////  HomeViewController.swift
////  inviti
////
////  Created by Hannah.C on 11.05.21.
////
//
//import UIKit
//import Firebase
//import FirebaseFirestoreSwift
//import EasyRefresher
//
//class HomeViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//    let viewModel = MainViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.navigationController?.navigationBar.backgroundColor = UIColor.deepPurple
//        self.navigationItem.title = "Publisher"
//
//        // Do any additional setup after loading the view.
//        viewModel.refreshView = { [weak self] () in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//
//        viewModel.articleViewModels.bind { [weak self] articles in
////            self?.tableView.reloadData()
//            self?.viewModel.onRefresh()
//        }
//
//        viewModel.scrollToTop = { [weak self] () in
//
//            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//
//        viewModel.fetchData()
//
//        setupRefresher()
//    }
//
//    func setupRefresher() {
//        self.tableView.refresh.header = RefreshHeader(delegate: self)
//
//        tableView.refresh.header.addRefreshClosure { [weak self] in
//            self?.viewModel.fetchData()
//            self?.tableView.refresh.header.endRefreshing()
//        }
//    }
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//   // 還沒寫進去
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "navigateToPublish",
//           let publishViewController = segue.destination as? PublishViewController {
//
//            publishViewController.delegate = self
//
//        }
//        // 還沒寫進去的部分
//    }
//}
//
//extension HomeViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.viewModel.articleViewModels.value.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleViewCell.identifier, for: indexPath)
//
//        guard let articleViewCell = cell as? ArticleViewCell else {
//            return cell
//        }
//
//        let cellViewModel = self.viewModel.articleViewModels.value[indexPath.row]
//        cellViewModel.onDead = { [weak self] () in
//            print("onDead")
//            self?.viewModel.fetchData()
//        }
//        articleViewCell.setup(viewModel: cellViewModel)
//
//        return articleViewCell
//    }
//}
//
//extension HomeViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.viewModel.onTap(withIndex: indexPath.row)
//    }
//}
//
//extension HomeViewController: RefreshDelegate {
//    func refresherDidRefresh(_ refresher: Refresher) {
//        print("refresherDidRefresh")
//    }
//}
//
//// 還沒寫進去
//extension HomeViewController: PublishDelegate {
//    func onPublished() {
//        viewModel.fetchData()
//        viewModel.onScrollToTop()
//    }
//}
//
//protocol PublishDelegate: AnyObject {
//    func onPublished()
//}
//// 還沒寫進去的部分
