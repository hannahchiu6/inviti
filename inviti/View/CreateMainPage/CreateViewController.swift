//
//  CreateViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class CreateViewController: UIViewController {


    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        setupCollectionView()


    }

    private var months = ["January", "March", "March", "May", "October"]
    private var days = ["11", "3", "15", "17", "22"]
    private var week = ["Monday", "Friday", "Tuesday", "Thursday", "Sunday"]
    private var events: [String] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
}

extension CreateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionCollectionViewCell.self), for: indexPath) as! OptionCollectionViewCell

        cell.monthLabel.text = months[indexPath.row]
        cell.dayLabel.text = days[indexPath.row]
        cell.weekLabel.text = week[indexPath.row]

        return cell

    }
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.white

        collectionView.do_registerCellWithNib(
            identifier: String(describing: OptionCollectionViewCell.self),
            bundle: nil
        )

        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {

        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.scrollDirection = .horizontal

        let viewWidth = view.bounds.width

        let size = CGSize( width: Int(146.0 / 375.0 * viewWidth),
                           height: Int(164.0 / 375.0 * viewWidth * 308.0 / 164.0))
        print(size)

        flowLayout.itemSize = size

        flowLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)

        flowLayout.minimumInteritemSpacing = 0

        flowLayout.minimumLineSpacing = 10.0

        collectionView.collectionViewLayout = flowLayout
    }
}

extension CreateViewController: UICollectionViewDelegate {

}

