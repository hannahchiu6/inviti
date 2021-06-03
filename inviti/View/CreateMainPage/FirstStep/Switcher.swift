////
////  NotiCell.swift
////  inviti
////
////  Created by Hannah.C on 21.05.21.
////
//
//
//import UIKit
//
//class NotiCell: UITableViewCell {
//
//    @IBOutlet weak var notiSwitch: UISwitch!
//    @IBOutlet weak var dateText: UITextField!
//    @IBOutlet weak var notiText: UITextField!
//
//    var dateUpdateHandler: ( (String) -> Void )?
//
//    var contentUpdateHandler: ( (String) -> Void )?
//
//    var pickerData: [String] = []
//
//    lazy var datePicker: UIDatePicker = {
//
//        let picker = UIDatePicker()
//
//        picker.datePickerMode = .date
//
//        picker.locale = Locale(identifier: "zh_TW")
//
//        picker.addTarget(self, action: #selector(didSeletedDate(_:)), for: .valueChanged)
//
//        return picker
//    }()
//
//    var textFieldType: TextFieldType = .normal {
//
//        didSet {
//
//            switch textFieldType {
//
//            case .date(let dateString, let format):
//
//                dateText.inputView = datePicker
//
//                datePicker.date = dateFormatter.date(from: dateString) ?? Date()
//
//                dateFormatter.dateFormat = format
//
//                dateText.text = dateString
//
//            case .normal:
//
//                notiText.inputView = nil
//            }
//        }
//    }
//
//    lazy var dateFormatter = DateFormatter()
//
//    var pickerViewDatas: [String] = []
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        selectionStyle = .none
//
//        notiText.delegate = self
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
//    @objc func didSeletedDate(_ sender: UIDatePicker) {
//
//        dateText.text = dateFormatter.string(from: sender.date)
//
//        dateUpdateHandler?(dateText.text!)
//    }
//}
//
//extension NotiCell: UITextFieldDelegate {
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        guard let text = textField.text else {
//            return
//        }
//
//        contentUpdateHandler?(text)
//    }
//}
