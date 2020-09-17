//
//  GameViewController.swift
//  Accelerometer
//
//  Created by esaki yuki on 2020/09/15.
//  Copyright © 2020 esaki yuKki. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    @IBOutlet private weak var awaimageView: UIImageView!
    let motionManager = CMMotionManager()
    var accelerationX: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加速度計が使用できるかの判定
        if motionManager.isAccelerometerAvailable {
            //加速度の距離間隔を設定
            motionManager.accelerometerUpdateInterval = 0.01
            //加速度計が更新された時に呼ばれる関数
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
                //現在の加速度を取得
                self.accelerationX = (data?.acceleration.x)!
                //取得した加速度にawaimageViewの座標を更新する
                self.awaimageView.center.x = self.awaimageView.center.x - CGFloat(self.accelerationX!*20)
                //acceletionXが水平器からはみ出さないように限界値を設定
                if self.awaimageView.frame.origin.x < 40 {
                    self.awaimageView.frame.origin.x = 40
                }
                if self.awaimageView.frame.origin.x < 260 {
                    self.awaimageView.frame.origin.x = 260
                }
            })
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
