//
//  thirdViewController.swift
//  newnewnew
//
//  Created by Shitcunt on 5/24/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {
    
    @IBOutlet weak var totaltime: UILabel!
    @IBOutlet weak var totaldistance: UILabel!
    @IBOutlet weak var uberxFare: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bgdrop: UIImageView!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var greyback: UIImageView!
    @IBOutlet weak var oritxt: UITextField!
    @IBOutlet weak var desttxt: UITextField!
    @IBOutlet weak var searchbut: UIButton!
    @IBOutlet weak var oribar: UIImageView!
    @IBOutlet weak var destbar: UIImageView!
    @IBOutlet weak var secondimage: UIImageView!
    
    var timebe = String()
    var distbe = String()
    
    var timebeint = Int()
    
    var timefr = String()
    var distfr = String()
    
    
    
    override func viewDidLoad() {
        
        totaltime.alpha = 0
        totaldistance.alpha = 0
        uberxFare.alpha = 0
        backbutton.alpha = 0
        image.alpha = 1
        greyback.alpha = 0
        oritxt.alpha = 0
        desttxt.alpha = 0
        searchbut.alpha = 0
        oribar.alpha = 0
        destbar.alpha = 0
        greyback.layer.cornerRadius = 7
//        image.transform = CGAffineTransform(translationX: 0, y:0 )
        bgdrop.transform = CGAffineTransform(translationX: 0, y:600 )
        bgdrop.layer.cornerRadius = 9
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            UIView.animate(withDuration: 0.7, animations: {
                self.image.transform = CGAffineTransform(translationX: 0, y: -235).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            })
//            , completion: {(finished: Bool) in
//                self.image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1, execute: {
            UIView.animate(withDuration: 0.5, animations: ({
                self.bgdrop.transform = CGAffineTransform(translationX: 0, y: 0)
            }))
        })
        

        DispatchQueue.main.asyncAfter(deadline:.now() + 2.6, execute: {
            UIView.animate(withDuration: 0.5, animations: ( {
            self.totaltime.alpha = 1
            self.totaldistance.alpha = 1
            self.uberxFare.alpha = 1
            self.backbutton.alpha = 1
            }))
        })
        
//        totaltime.text = timefr
//        totaldistance.text = distfr
        if(timebeint == 0) {
            //print(timebe)
            //print(distbe)
            
//            let a = (0.97 * (Double(distbe))!)
//            let b = (0.14 * (Double(timebe))!)
//            let c = a + b + 0.40 + 1.58 + 1
//            let d = Double(round(1*c)/1)
//            let e = Int(d)
//            let f = e + 2
//            uberxFare.text = "$\(e)-$\(f)"
        }
//        else if(timebeint != 0){
//            print(timebeint)
//            print(distbe)
//            let a = (0.97 * (Double(distbe))!)
//            let b = (0.14 * (Double(timebe))!)
//            let c = a + b + 0.40 + 1.58
//            uberxFare.text = "$\(c)"
//        }
        
        let file = "file1.txt"
        let file2 = "file2.txt"
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            let file2URL = dir.appendingPathComponent(file2)
            do {
                let time = try String(contentsOf: fileURL, encoding: .utf8)
                let distance = try String(contentsOf: file2URL, encoding: .utf8)
                
                if (time != "" && distance != "") {
                    
                    if (time.contains("hour") == false && time.contains("hours") == false && time.contains("mins") == true && time.contains("day ") == false) {
                        if let mins = time.components(separatedBy: " ").first {
                            //let duration = "duration: \(mins) mins"
                            //print(mins)
                           
                        }
                    }
                    
                    if (time.contains("hour ") == true && time.contains("mins") == true && time.contains("day ") == false) {
                        if let hour = time.components(separatedBy: " ").first {
                            //print(hour)
                            let a = (hour + " ")
                            let e = Int(hour)! * 60
                            //print(e)
                            var f = time
                            if let range = f.range(of: a) {
                                f.removeSubrange(range)
                                //print(f)
                                
                            }
                            var g = f
                            if let range = g.range(of: "hour ") {
                                g.removeSubrange(range)
                                //print(g)
                                var d = g
                                if let range1 = d.range(of : " mins") {
                                    d.removeSubrange(range1)
                                    //print(d)
                                    let b = Int(d)! + e
                                    //print(b)//print total time in mins
                                    
                                }
                            }
                        }
                    }
                    if (time.contains("hour ") == true && time.contains("min ") == true && time.contains("day ") == false) {
                        if let hour = time.components(separatedBy: " ").first {
                            //print(hour)
                            let a = (hour + " ")
                            let e = Int(hour)! * 60
                            //print(e)
                            var f = time
                            if let range = f.range(of: a) {
                                f.removeSubrange(range)
                                //print(f)
                                
                            }
                            var g = f
                            if let range = g.range(of: "hour ") {
                                g.removeSubrange(range)
                                //print(g)
                                var d = g
                                if let range1 = d.range(of : " min") {
                                    d.removeSubrange(range1)
                                    //print(d)
                                    let b = Int(d)! + e
                                    //print(b)// total time in mins
                                    
                                }
                            }
                        }
                    }
                    if (time.contains("hours") == true && time.contains("mins") == true && time.contains("day ") == false) {
                        if let hour = time.components(separatedBy: " ").first {
                            //print(hour)
                            let a = (hour + " ")
                            let e = Int(hour)! * 60
                            //print(e)
                            var f = time
                            if let range = f.range(of: a) {
                                f.removeSubrange(range)
                                //print(f)
                                
                            }
                            var g = f
                            if let range = g.range(of: "hours ") {
                                g.removeSubrange(range)
                                //print(g)
                                var d = g
                                if let range1 = d.range(of : " mins") {
                                    d.removeSubrange(range1)
                                    //print(d)
                                    let b = Int(d)! + e
                                    //print(b)// total time in mins
                                  
                                }
                            }
                            
                        }
                    }
                    
                     totaltime.text = "time: \(time)"
                     totaldistance.text = "distance: \(distance) mi"
                    
                    
                    
                }
                
            }
            catch {
                
            }
        }
        
    }
    
    
    @IBAction func back(_ sender: Any) {

        self.greyback.alpha = 1
        self.oritxt.alpha = 1
        self.desttxt.alpha = 1
        self.searchbut.alpha = 0.3
        self.oribar.alpha = 1
        self.destbar.alpha = 1
        
        UIView.animate(withDuration: 0, animations:  {
            self.totaltime.alpha = 0
            self.totaldistance.alpha = 0
            self.uberxFare.alpha = 0
            self.backbutton.alpha = 0
            self.image.alpha = 0 
            self.secondimage.alpha = 1
            self.secondimage.transform = CGAffineTransform(translationX: 0, y: -165)
        }){ (true) in
            UIView.animate(withDuration: 0.5, animations:  {
                self.bgdrop.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height + self.bgdrop.frame.size.height)
                
            }){ (true) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.performSegue(withIdentifier: "goback", sender: self)
                })
            }
        }
    }
    
}
extension Float {
    func string(fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
