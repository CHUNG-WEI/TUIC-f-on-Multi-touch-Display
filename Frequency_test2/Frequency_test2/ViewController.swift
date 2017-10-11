//
//  ViewController.swift
//  Frequency_test2
//
//  Created by CHUNG-WEI WANG on 2017/9/11.
//  Copyright © 2017年 CHUNG-WEI WANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let now = Date()
    var base: TimeInterval = NSDate.timeIntervalSinceReferenceDate
    var count = 0
    var timeAverage = 0.0
    var timeAverageTemp = 0.0
    var type = "computing"
    var timeRangeArray = [Double](repeating:0.0,count:5)
    
    
    var timeTotal = 0.0
    var timeBeginEndArrary = [Double](repeating:0.0,count:3)
    var timeTotalArrary = [Double](repeating:0.0,count:5)
    var timeTotalArraryCount = 0
    var timeTotalAverage = 0.0
    var timeTotalType = 0
    var timeErrorCount = 0
    var touchCheck = 0
    
    let stand = 40
    let range = 10
    let errorRange = 5
    
    @IBOutlet weak var touchType: UILabel!
    
    
    @IBAction func TouchBegin(_ sender: UIButton, forEvent event: UIEvent) {
        let time: TimeInterval = NSDate.timeIntervalSinceReferenceDate
        let timeRange = time - base
        
        timeTotal += timeRange
        //print("touchEndToBegin:   \(timeRange)")
        
        //print("\(timeRange)")
        timeBeginEndArrary[0] = timeRange
        
        base = time
        touchCheck = 1
    }
    
    
    @IBAction func TouchEnd(_ sender: UIButton, forEvent event: UIEvent) {
        let time: TimeInterval = NSDate.timeIntervalSinceReferenceDate
        let timeRange = time - base
        
        //guard let touch = event.allTouches?.first else { return }
        //let point = touch.location(in: sender)
        
        timeTotal += timeRange
        
        timeBeginEndArrary[1] = timeRange
        timeBeginEndArrary[2] = timeTotal
        
        /*
        if(aaa>0 && aaa<=100){
            print("\(timeBeginEndArrary[1]),\(timeBeginEndArrary[0]),\(timeBeginEndArrary[2])")
        }
        aaa += 1
        */
        
        //print("\(timeBeginEndArrary[1]),\(timeBeginEndArrary[0]),\(timeBeginEndArrary[2])")
        print("timeTotal: \(timeBeginEndArrary[2])")
        
        timeTotalArrary[timeTotalArraryCount] = timeTotal
        timeTotalArraryCount += 1
        
        if(timeTotal > 1){
            timeTotalArraryCount = 0
        }
        
        if(timeTotalArraryCount>4){
            for index in 0...4{
                timeTotalAverage += timeTotalArrary[index]
            }
            timeTotalAverage = timeTotalAverage/5
            for index in 0...4{
                if(timeTotalArrary[index] > timeTotalAverage * 1.5 && index < 4){
                    
                    for index2 in index...3{
                       swap(&timeTotalArrary[index2],&timeTotalArrary[index2+1])
                    }
                    timeTotalArraryCount -= 1
                    timeErrorCount += 1
                }
                else if(timeTotalArrary[index] > timeTotalAverage * 1.5 && index == 4){

                    timeTotalArraryCount -= 1
                    timeErrorCount += 1
                }
            }
            if(timeErrorCount>3){
                timeTotalArraryCount = 0
                timeErrorCount = 0
                print("no id")
                type = "no id"
            }
        }
        
        if(timeTotalArraryCount>4){
            timeTotalType = (Int)(timeTotalAverage*1000+0.5)
            
            timeErrorCount = 0
            //print("1:\(timeTotalType)")
            
            if(timeTotalType < stand + range*0 + errorRange && timeTotalType >= stand + range*0 - errorRange){
                timeTotalType = 1
            }
            else if(timeTotalType < stand + range*1 + errorRange && timeTotalType >= stand + range*1 - errorRange){
                timeTotalType = 2
            }
            else if(timeTotalType < stand + range*2 + errorRange && timeTotalType >= stand + range*2 - errorRange){
                timeTotalType = 3
            }
            else if(timeTotalType < stand + range*3 + errorRange && timeTotalType >= stand + range*3 - errorRange){
                timeTotalType = 4
            }
            else if(timeTotalType < stand + range*4 + errorRange && timeTotalType >= stand + range*4 - errorRange){
                timeTotalType = 5
            }
            else if(timeTotalType < stand + range*5 + errorRange && timeTotalType >= stand + range*5 - errorRange){
                timeTotalType = 6
            }
            else{
                timeTotalType = 0
                timeTotalArraryCount = 0
            }
            if(timeTotalType == 0){
                print("no id")
                type = "no id"
            }
            else{
                print("id: \(timeTotalType)")
                type = "id \(timeTotalType)"
            }
            
            for index in 0...3{
                swap(&timeTotalArrary[index],&timeTotalArrary[index+1])
            }
            if(timeTotalArraryCount != 0){
                timeTotalArraryCount -= 1
            }
        }
        
        //print("x:\(point.x) y:\(point.y)   timeTotalAverage:\(timeTotalAverage)")
        print("timeTotalAverage:\(timeTotalAverage)  timeTotalArraryCount:\(timeTotalArraryCount)")

        print()
        //touchType.frame.origin.x = sender.center.x - 100
        //touchType.frame.origin.y = sender.center.y + 150
        
        touchType.text = "\(type)"
        
        timeTotalAverage = 0.0
        timeTotal = 0.0
        base = time
        touchCheck = 0
    }
    
    
    @IBAction func TouchButton(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
 
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //0.3 := 0.0045(last id) * 3(lost data) * 2 = 0.270
        timer = Timer.scheduledTimer(timeInterval: 0.3,target:self,selector:#selector(ViewController.timeCheck),userInfo:nil,repeats:true)
    }

    func timeCheck()
    {
        let time: TimeInterval = NSDate.timeIntervalSinceReferenceDate
        let timeRange = time - base
        if(timeRange > 0.3){
            //print("no touch")
            timeTotalArraryCount = 0
            timeTotalAverage = 0.0
            timeTotal = 0.0
            if(touchCheck == 0){
                touchType.text = "no touch"
                type = "computing"
            }
            if(touchCheck == 1){
                touchType.text = "touch"
                type = "computing"
            }
        }
    }
}

