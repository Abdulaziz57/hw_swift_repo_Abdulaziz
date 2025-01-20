//
//  ViewController.swift
//  Stopwatch
//
//  Created by Abdulaziz Al Mannai on 19/01/2025.
//

import UIKit

class ViewController: UIViewController {
    
    let stopwatch = Stopwatch()
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        stopwatch.start()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        stopwatch.stop()
    }
    
    @objc func updateElapsedTimeLabel(timer: Timer) {
        if stopwatch.isRunning {
            elapsedTimeLabel.text = stopwatch.elapsedTimeAsString
        } else {
            timer.invalidate()
        }
    }

}







