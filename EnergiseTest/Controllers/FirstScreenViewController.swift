//
//  FirstScreenViewController.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var stopwatchButton: UIButton!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    let stopwatch = StopwatchModel()
    let labelPulseAnimation = PulseAnimation()
    let buttonPulseAnimation = PulseAnimation()
    
    deinit {
        labelPulseAnimation.stop()
        buttonPulseAnimation.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        localize()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        buttonPulseAnimation.radius = 90
        buttonPulseAnimation.backgroundColor = Constants.buttonPulsatorBgColor.cgColor
        stopwatchButton.layer.superlayer?.insertSublayer(buttonPulseAnimation, below: stopwatchButton.layer)
        buttonPulseAnimation.start()
        
        labelPulseAnimation.manualFrameForAnimation = true
        labelPulseAnimation.backgroundColor = Constants.labelPulsatorBgColor.cgColor
        labelPulseAnimation.animationDuration = 1
        stopwatchLabel.layer.superlayer?.insertSublayer(labelPulseAnimation, below: stopwatchLabel.layer)
        
        stopwatchButton.layer.cornerRadius = stopwatchButton.frame.size.height / 2
        stopwatchButton.layer.borderWidth = 10
        stopwatchButton.layer.borderColor = Constants.stopwatchButtonBorderColor.cgColor
        stopwatchButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)
        stopwatchButton.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)
        
        stopwatchLabel.font = UIFont.monospacedSystemFont(ofSize: 48.0, weight: .semibold)
        stopwatchLabel.text = "00:00:00"
    }
    
    //MARK: - Localize
    private func localize() {
        title = "FirstScreen.Title".localized
    }

    //MARK: - ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        labelPulseAnimation.position = stopwatchLabel.center
        buttonPulseAnimation.position = stopwatchButton.center
        
        let manualAnimationFrame = CGRect(x: 0, y: 0, width: stopwatchLabel.frame.size.width + 10, height: stopwatchLabel.frame.size.height + 5)
        labelPulseAnimation.manualAnimationFrame = manualAnimationFrame
    }
    
    //MARK: - TraitCollectionDidChange
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        labelPulseAnimation.backgroundColor = Constants.labelPulsatorBgColor.cgColor
        buttonPulseAnimation.backgroundColor = Constants.buttonPulsatorBgColor.cgColor
    }
    
}
//MARK: - FirstScreenViewControllerExtension
extension FirstScreenViewController {
    
    @objc func timerButtonAction() {
        stopwatch.isRunning ? stopStopwatch() : startStopwatch()
    }
    
    func startStopwatch() {
        Timer.scheduledTimer(timeInterval: 0.01, target: self,
            selector: #selector(FirstScreenViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
        stopwatch.start()
        stopwatchButton.setImage(UIImage.init(systemName: "pause.fill"), for: .normal)
        buttonPulseAnimation.stop()
        labelPulseAnimation.start()
    }
    
    func stopStopwatch() {
        stopwatch.stop()
        stopwatchButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)
        buttonPulseAnimation.start()
        labelPulseAnimation.stop()
    }
    
    @objc func updateElapsedTimeLabel(_ timer: Timer) {
        if stopwatch.isRunning {
            stopwatchLabel.text = stopwatch.elapsedTimeAsString
        } else {
            stopwatchLabel.text = "00:00:00"
            timer.invalidate()
        }
    }
    
}
