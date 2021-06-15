//
//  IntroduceViewController.swift
//  inviti
//
//  Created by Hannah.C on 11.06.21.
//

import UIKit
import Lottie

class IntroduceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImage()
        
        setUpAnimation(arrow: topLeftAarow, name: "53340-arrow-up")

        setUpAnimation(arrow: rightAarow, name: "53342-arrow-down")

        setUpAnimation(arrow: centerAarow, name: "53342-arrow-down")
    }

    func setupImage() {
    let url = "https://firebasestorage.googleapis.com/v0/b/inviti-4f671.appspot.com/o/invitiImage%2Finviti-hp-image.jpg?alt=media&token=9237708e-f045-49f5-aede-429cab173981"

    let imageUrl = URL(string: String(url))

        exampleImage.kf.setImage(with: imageUrl)

    }

    @IBAction func backToMain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var exampleImage: UIImageView!

    @IBOutlet weak var topLeftAarow: UIView!

    @IBOutlet weak var rightAarow: UIView!

    @IBOutlet weak var centerAarow: UIView!

    func setUpAnimation(arrow: UIView, name: String) {

        let animView = AnimationView()
        let anim = Animation.named(name, bundle: .main)
        animView.frame = arrow.bounds
        animView.contentMode = .scaleAspectFill
        animView.animation = anim
        animView.loopMode = .loop

        animView.play()

        animView.play(fromProgress: 0.1, toProgress: 1)

        animView.play(fromMarker: "begin", toMarker: "end")

        arrow.addSubview(animView)
    }

}
