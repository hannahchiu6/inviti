////
////  PublishViewController.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//
//import UIKit
//
//class PublishViewController: UIViewController {
//
//    @IBOutlet weak var titleTextField: UITextField!
//
//    @IBOutlet weak var categoryTextField: UITextField!
//
//    @IBOutlet weak var contentTextView: UITextView!
//
//    weak var delegate: PublishDelegate?
//
//    let viewModel = PublishViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        contentTextView.delegate = self
//
//        viewModel.onPublished = { [weak self] () in
//            self?.delegate?.onPublished()
//            self?.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        if touches.first?.view == self.view {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    @IBAction func onTitleChanged(_ sender: UITextField) {
//        guard let title = sender.text else {
//            return
//        }
//
//        viewModel.onTitleChanged(text: title)
//    }
//
//    @IBAction func onCategoryChanged(_ sender: UITextField) {
//        guard let category = sender.text else {
//            return
//        }
//
//        viewModel.onCategoryChanged(text: category)
//    }
//
//    @IBAction func onTapPublish(_ sender: Any) {
//        viewModel.onTapPublish()
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension PublishViewController: UITextViewDelegate {
//
//    func textViewDidChange(_ textView: UITextView) {
//        guard let content = textView.text else {
//            return
//        }
//
//        viewModel.onContentChanged(text: content)
//    }
//}
//
