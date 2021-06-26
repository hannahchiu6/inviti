//
//  UpdateProfileVC.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class UpdateProfileVC: UIViewController {
    
    var viewModel = SettingsViewModel()
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            self.nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var imageBackground: UIView!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.delegate = self
        }
    }
    
    @IBOutlet weak var sendBtnView: UIButton!
    
    @IBAction func sendAction(_ sender: Any) {
        
        viewModel.updateUserProfile()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var imageBtnView: UIButton!
    
    @IBAction func uploadImageAction(_ sender: Any) {
        showUploadMenu()
    }
    
    @IBAction func returnToMain(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        imagePicker.delegate = self
        
        placeHolderText()
        
        viewModel.refreshView = { [weak self] () in
            
            DispatchQueue.main.async {
                self?.view.reloadInputViews()
            }
        }
        
        viewModel.userViewModels.bind { [weak self] users in
            self?.viewModel.onRefresh()
        }
        
    }
    
    func shadow() {
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowRadius = 3
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.masksToBounds = false
    }
    
}

extension UpdateProfileVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let emailText = emailTextField.text else { return }

        if !emailText.isEmpty {
            viewModel.onEmailChanged(text: emailText)
        }
        
        guard let nameText = nameTextField.text else { return }

        if !nameText.isEmpty {
            viewModel.onNameChanged(text: nameText)
            
        }
    }
    
    func placeHolderText() {

        if !viewModel.userViewModels.value.isEmpty {

            let user = viewModel.userViewModels.value[0]

            if let oldName = user.name,
               let oldEmail = user.email {

                nameTextField.placeholder = oldName
                emailTextField.placeholder = oldEmail
            }

        }
    }
}

extension UpdateProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            selectedImageFromPicker = pickedImage
            
            viewModel.uploadImage(with: pickedImage)
        }
        
        if selectedImageFromPicker != nil {
            
            imageBtnView.setImage(UIImage(systemName: "checkmark"), for: .normal)
            
            imageBtnView.setTitle("uploaded-success".localized, for: .normal)
            
            imageBtnView.setTitleColor(UIColor.white, for: .normal)

            imageBtnView.tintColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

            imageBtnView.backgroundColor = UIColor.clear

            imageBackground.backgroundColor = UIColor(red: 1, green: 0.8353, blue: 0.7882, alpha: 1.0)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showUploadMenu() {
        let controller = UIAlertController(title: "Upload an image", message: nil, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Pick from Album", style: .default) { _ in
            
            self.openAlbum()
        }
        
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        controller.addAction(libraryAction)
        controller.addAction(cancleAction)
        
        present(controller, animated: true)
        
    }
    
    func openAlbum() {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true)
    }
}
