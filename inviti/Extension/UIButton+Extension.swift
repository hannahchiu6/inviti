//
//  UIButton+Extension.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

class DropBox: UIView, UITableViewDelegate, UITableViewDataSource {


    open var count: Int = 0

    open var itemForRowAt: ((Int) -> (String, UIImage?))!

    open var didSelectedAt: ((Int, String, DropBox) -> Void)?

    open var maxHeight: CGFloat = CGFloat(Int.max)

    open var willDrop: Bool {
        get { return _willDrop }
        set {
            if (newValue == _willDrop) { return }
            if (newValue) {
                dropDwon()
            } else {
                drawUp()
            }
            _willDrop = newValue
        }
    }

    open var itemHeight: CGFloat = 45 {
        didSet {
            tableView.reloadData()
        }
    }

    open var duration: TimeInterval = 0.3

    open var text: String? {
        get {
            return dropButton.titleLabel?.text
        }
    }

    private var _willDrop: Bool = false {
        didSet {
            if (_willDrop) {
                UIView.animate(withDuration: duration) { [weak self] () in
                    let transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
                    self?.button.transform = transform
                }
            } else {
                UIView.animate(withDuration: duration) { [weak self] () in
                    let transform = CGAffineTransform.init(rotationAngle: CGFloat(0))
                    self?.button.transform = transform
                }
            }
        }
    }

    private var tableView: UITableView!

//    private var textField: UITextField!

    private var dropButton: UIButton!

    private var button: UIImageView!

    init(frame: CGRect, custom: UIButton) {
        super.init(frame: frame)
        commonInit(aButton: custom)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit(aButton: UIButton) {

        button = UIImageView(image: UIImage(named: "NotificationBell"))
        button.contentMode = .center;
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(MyDropBoxCell.classForCoder(), forCellReuseIdentifier: "dropBoxCell")
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tableView.layer.shadowRadius = 3
        tableView.layer.shadowOpacity = 0.8

        button.frame = CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
        aButton.frame = CGRect(x: 0, y: 0, width: bounds.width - button.frame.width - 10, height: bounds.height)
        tableView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)

        addSubview(aButton)
        addSubview(tableView)
        addSubview(button)
    }

    @objc private func tapAction() {
        willDrop = !willDrop
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropBoxCell", for: indexPath) as! MyDropBoxCell
        cell.setModel( text: itemForRowAt(indexPath.row).0, img: itemForRowAt(indexPath.row).1)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.itemHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.titleLabel?.text = itemForRowAt(indexPath.row).0
        didSelectedAt?(indexPath.row, itemForRowAt(indexPath.row).0, self)
    }


    open func dropDwon() {
        if(_willDrop) {
            return
        }
        _willDrop = true

        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            var hhhh = CGFloat(weakSelf.count) * weakSelf.itemHeight
            if( hhhh > weakSelf.maxHeight) {
                weakSelf.tableView.isScrollEnabled = true
                hhhh = weakSelf.maxHeight
            } else {
                weakSelf.tableView.isScrollEnabled = false
            }
            weakSelf.tableView.frame.size.height = hhhh
            weakSelf.frame.size.height += hhhh
        })

        superview?.bringSubviewToFront(self)
    }

    open func drawUp() {
        if(!_willDrop) {
            return
        }
        _willDrop = false

        UIView.animate(withDuration: duration / 2, animations: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            let hhhh = weakSelf.tableView.frame.size.height
            weakSelf.frame.size.height += hhhh
            weakSelf.tableView.frame.size.height = 0.0
        })
    }

}


private class MyDropBoxCell: UITableViewCell {

    private var imgView: UIImageView!
    private var label: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1

        let selectedView = UIImageView(image: UIImage(systemName: "checkmark"))
        selectedView.contentMode = .right
        selectedBackgroundView = selectedView

        imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        self.addSubview(imgView)

        label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
    }

    func setModel(text: String, img: UIImage?) {
        imgView.image = img
        label.text = text
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = CGRect(x: 10, y: 12, width: 20, height: 20)
        if (imgView.image == nil) {
            imgView.frame = .zero
        }
        label.frame = CGRect(x: imgView.frame.maxX + 10, y: 0, width: self.frame.width - 80, height: 44)
        selectedBackgroundView?.frame = CGRect(x: 0, y: 0, width: frame.width - 10, height: 44)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckBoxButton: UIButton {

    override func awakeFromNib() {
        self.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)
        self.setImage(UIImage(systemName: "poweroff"), for: .normal)
        self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked(_:)), for: .touchUpInside)
    }

    @objc func buttonClicked(_ sender: UIButton) {
        self.isSelected = !self.isSelected
    }

}
