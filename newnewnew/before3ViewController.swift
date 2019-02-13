
////  before3ViewController.swift
////  newnewnew
////
////  Created by Shitcunt on 5/26/18.
////  Copyright © 2018 test. All rights reserved.
//
//
//import UIKit
//
//class before3ViewController: UIViewController {
//override func viewDidLoad() {
//        super.viewDidLoad()
////        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
////            self.performSegue(withIdentifier: "final", sender: self)
////        })
//    
////        let file = "file1.txt"
////        let file2 = "file2.txt"
////
////
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////
////            let fileURL = dir.appendingPathComponent(file)
////            let file2URL = dir.appendingPathComponent(file2)
////            do {
////                let time = try String(contentsOf: fileURL, encoding: .utf8)
////                let distance = try String(contentsOf: file2URL, encoding: .utf8)
////                if (time == "" && distance == "") {
////                    self.performSegue(withIdentifier: "inputfail", sender: self)
////                }
////                else if(time != "" && distance != "") {
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
////                        self.performSegue(withIdentifier: "final", sender: self)
////                    })                }
////            }
////            catch {
////                print(error)
////            }
////        }
//    
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
//            self.performSegue(withIdentifier: "final", sender: self)
//        })
//    }
//    
//    
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let thirdController = segue.destination as! thirdViewController
//        
////        let file = "file1.txt"
////        let file2 = "file2.txt"
////
////
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////
////            let fileURL = dir.appendingPathComponent(file)
////            let file2URL = dir.appendingPathComponent(file2)
////            do {
////                let time = try String(contentsOf: fileURL, encoding: .utf8)
////                let distance = try String(contentsOf: file2URL, encoding: .utf8)
//                //print(time)
//                //print(distance)
//        let time = ""
//        let distance = ""
//                if (time != "" && distance != "") {
//                    
//                    if (time.contains("hour") == false && time.contains("hours") == false && time.contains("mins") == true && time.contains("day ") == false) {
//                        if let mins = time.components(separatedBy: " ").first {
//                            //let duration = "duration: \(mins) mins"
//                            //print(mins)
//                            thirdController.timebe = mins
//                            thirdController.distbe = distance
//                        
//                        }
//                    }
//                    
//                    if (time.contains("hour ") == true && time.contains("mins") == true && time.contains("day ") == false) {
//                        if let hour = time.components(separatedBy: " ").first {
//                            //print(hour)
//                            let a = (hour + " ")
//                            let e = Int(hour)! * 60
//                            //print(e)
//                            var f = time
//                            if let range = f.range(of: a) {
//                                f.removeSubrange(range)
//                                //print(f)
//                                
//                            }
//                            var g = f
//                            if let range = g.range(of: "hour ") {
//                                g.removeSubrange(range)
//                                //print(g)
//                                var d = g
//                                if let range1 = d.range(of : " mins") {
//                                    d.removeSubrange(range1)
//                                    //print(d)
//                                    let b = Int(d)! + e
//                                    //print(b)//print total time in mins
//                                    thirdController.timebeint = b
//                                    thirdController.distbe = distance
//                               }
//                            }
//                        }
//                    }
//                    if (time.contains("hour ") == true && time.contains("min ") == true && time.contains("day ") == false) {
//                        if let hour = time.components(separatedBy: " ").first {
//                            //print(hour)
//                            let a = (hour + " ")
//                            let e = Int(hour)! * 60
//                            //print(e)
//                            var f = time
//                            if let range = f.range(of: a) {
//                                f.removeSubrange(range)
//                                //print(f)
//                                
//                            }
//                            var g = f
//                            if let range = g.range(of: "hour ") {
//                                g.removeSubrange(range)
//                                //print(g)
//                                var d = g
//                                if let range1 = d.range(of : " min") {
//                                    d.removeSubrange(range1)
//                                    //print(d)
//                                    let b = Int(d)! + e
//                                    //print(b)// total time in mins
//                                    thirdController.timebeint = b
//                                    thirdController.distbe = distance
//                                }
//                            }
//                        }
//                    }
//                    if (time.contains("hours") == true && time.contains("mins") == true && time.contains("day ") == false) {
//                        if let hour = time.components(separatedBy: " ").first {
//                            //print(hour)
//                            let a = (hour + " ")
//                            let e = Int(hour)! * 60
//                            //print(e)
//                            var f = time
//                            if let range = f.range(of: a) {
//                                f.removeSubrange(range)
//                                //print(f)
//                                
//                            }
//                            var g = f
//                            if let range = g.range(of: "hours ") {
//                                g.removeSubrange(range)
//                                //print(g)
//                                var d = g
//                                if let range1 = d.range(of : " mins") {
//                                    d.removeSubrange(range1)
//                                    //print(d)
//                                    let b = Int(d)! + e
//                                    //print(b)// total time in mins
//                                    thirdController.timebeint = b
//                                    thirdController.distbe = distance
//                                }
//                            }
//                            
//                        }
//                    }
//                    
//                    let tottime = "time: \(time)"
//                    let totdist = "distance: \(distance) mi"
//                    
//                    thirdController.timefr = tottime
//                    thirdController.distfr = totdist
//
//                }
//            //}
////            catch {
////                print(error)
////            }
//        //}
//    }
//    
//
//
//}
