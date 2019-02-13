//
//  ViewController.swift
//  newnewnew
//
//  Created by Shitcunt on 4/1/18.
//  Copyright © 2018 test. All rights reserved.

import UIKit
import Foundation
import CoreLocation
import GooglePlaces

struct whole:Decodable {
    let destination_addresses: [String]
    var origin_addresses: [String]
    let rows: [wow1]
    let status: String

struct wow1: Decodable {
    let elements: [wow2]
}
struct wow2: Decodable {
    let distance: wow3
    let duration: wow3
    //let status: String
}
struct wow3: Decodable {
    let text: String
    //let value: Int
}
}


struct Wow: Decodable {
    let baseFare: String
    let perMin: String
    let perMile: String
    let service: String
}

var originIsOpen = false
var destinationIsOpen = false

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayA = [String]()
    //var arrayA = ["jhon", "bill"]
    
    lazy var filter: GMSAutocompleteFilter = {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        return filter
    }()

    @IBOutlet weak var backgrnd: UIImageView!
    @IBOutlet weak var Origin: UITextField!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var Search: UIButton!
    @IBOutlet weak var secondimage: UIImageView!
    @IBOutlet weak var greyback: UIImageView!
    @IBOutlet weak var originbar: UIImageView!
    @IBOutlet weak var destinationbar: UIImageView!
    @IBOutlet weak var secondgreyback: UIImageView!
    @IBOutlet weak var cL: UIButton!
    @IBOutlet weak var cL2: UIButton!
    @IBOutlet weak var finalgreyback: UIView!
    @IBOutlet weak var bgdropdismiss: UIButton!
    @IBOutlet weak var tim: UILabel!
    @IBOutlet weak var dist: UILabel!
    @IBOutlet weak var GoogleLogo: UIImageView!
    @IBOutlet weak var smallLogo: UIImageView!
    @IBOutlet weak var smallPan: UIView!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var iconUber: UIView!
    @IBOutlet weak var iconLyft: UIView!
    @IBOutlet weak var blackMask: UIImageView!
    
    
    var time = String()
    var distance = String()
    var onlyTime = String()
    var locationManager = CLLocationManager()
    var rotated1 = false
    var rotated2 = true
    
    var state = String()
    var city = String()
    
    var count = 0
    
    var jsonError = false
    var sameTxtError = false
    
    var price = Float()
    
    var uberTapped = false
    var lyftTapped = false
    
    @IBAction func Search(_ sender: Any) {
        if Search.alpha == 1{
            jsonError = false
            originIsOpen = false
            destinationIsOpen = false
//            print(arrayA)
            
            if Origin.text == Destination.text {
                //sameTxtError = true
                shakeAnimate()
            }
            else {
            
//            let file = "file1.txt"
//            let file2 = "file2.txt"
//
//            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//                let fileURL = dir.appendingPathComponent(file)
//                let file2URL = dir.appendingPathComponent(file2)
//
//                let fileManager = FileManager()
//                do {
//                    try fileManager.removeItem(at: fileURL)
//                    try fileManager.removeItem(at: file2URL)
//                }
//                catch {
//
//                }
//            }
        dismissKeyboard()
        searchanimate()
        let text: String = Origin.text!
        let text1: String = Destination.text!
        let newString = text.replacingOccurrences(of: " ", with: "")
        let newString1 = text1.replacingOccurrences(of: " ", with: "")
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(newString)"
        let url1 = url + "&destinations=\(newString1)"
        let url2 = url1 + "&key=AIzaSyBzmy8WqLCubfJvyFcQh7gVV1fZJxG2518"
        
        guard let uurl = URL(string: url2)
            else{
                return
        }
        URLSession.shared.dataTask(with: uurl) {(data, response, err) in
            guard let data = data else{return}
            
            do {
                var element = try JSONDecoder().decode(whole.self, from: data)
                print(element.origin_addresses)
                //print(element.rows)
                var a = element.rows.description
                let ele = element.origin_addresses.remove(at: 0)
                //print(ele)
                
                var eleA = Array(ele.components(separatedBy: ", "))
                print(eleA)
                
                print(eleA.count)
                if eleA.count == 4 {
                    self.city = eleA.remove(at: 1)
                    print(self.city)
                    var stateWzip = eleA.remove(at: 1)
                    //print(stateWzip)
                    let preState1 = stateWzip.removeFirst()
                    let preState2 = stateWzip.removeFirst()
                    self.state = "\(preState1)\(preState2)"
                    print(self.state)
                    self.jsonRCapi()
                }
                else if eleA.count == 3 {
                    self.city = eleA.remove(at: 0)
                    print(self.city)
                    
                    var stateWposZip = eleA.remove(at: 0)
                    
                    if stateWposZip.count > 2 {
                        
                        let preState1 = stateWposZip.removeFirst()
                        let preState2 = stateWposZip.removeFirst()
                        self.state = "\(preState1)\(preState2)"
                        print(self.state)
                    }
                    else if stateWposZip.count == 2 {
                        self.state = stateWposZip
                        print(self.state)
                    }
                    self.jsonRCapi()
                }
                
                let wordToRemove = "[newnewnew.whole.wow1(elements: [newnewnew.whole.wow2(distance: newnewnew.whole.wow3(text: \""
                if let range = a.range(of: wordToRemove) {
                    a.removeSubrange(range)
                }
                //print(a)
                
                
                let wordToRemove1 = "mi\"), duration: newnewnew.whole.wow3(text: \""
                if let range = a.range(of: wordToRemove1) {
                    a.removeSubrange(range)
                }
                //print(a)
                
                let wordToRemove2 = "\"))])]"
                if let range = a.range(of: wordToRemove2) {
                    a.removeSubrange(range)
                }

                self.distance = a.components(separatedBy: " ").first!
                
                let milez = "\(self.distance)" + " "

                if let range = a.range(of: milez) {
                    a.removeSubrange(range)
                }
                self.time = a
                self.onlyTime = self.time.components(separatedBy: " ").first!
                
                print(self.time)
                print(self.distance)
            }
                
            catch let jsonErr {
                print("Error Serializing json:", jsonErr)
                self.jsonError = true
            }
            }.resume()
            }
        }
    }
    
    func jsonRCapi() {
        let jsonUrlString2 = "https://honest-lionfish-73.localtunnel.me/locations/\(self.state)"
        guard let url5 = URL(string: jsonUrlString2)
            else {
                return
        }
        URLSession.shared.dataTask(with: url5) {(data, response, err) in
            
            guard let data = data
                else{
                    return
                    
            }
            do {
                let distWOcom = self.distance.replacingOccurrences(of: ",", with: "")
                
                let wow = try JSONDecoder().decode(Wow.self, from: data)
                print(wow.baseFare, wow.perMile, wow.perMin, wow.service)
                let baseF = Float(wow.baseFare)!
                let priceMil = Float(wow.perMile)! * Float(distWOcom)!
                let priceMin = Float(wow.perMin)! * Float(self.onlyTime)!
                let serFee = Float(wow.service)!
                
                self.price = baseF + priceMil + priceMin + serFee
                print(self.price)
                
            }
            catch let jsonErr {
                print("Err", jsonErr)
            }
            
            }.resume()
    }
    
    func searchanimate() {
        finalgreyback.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        bgdropdismiss.frame = CGRect(x: view.frame.size.width/2 - 17.5, y: view.frame.size.height + 10, width: 35, height: 22)
        //smallPan.alpha = 1

        finalgreyback.alpha = 1
        smallPan.frame.origin.y = finalgreyback.frame.origin.y
        finalgreyback.layer.cornerRadius = 10
        bgdropdismiss.alpha = 0.5
        
        tim.frame.origin.y = finalgreyback.frame.origin.y + 36
        dist.frame.origin.y = finalgreyback.frame.origin.y + 36
        bgdropdismiss.frame.origin.y = finalgreyback.frame.origin.y + 10
        priceLBL.frame.origin.y = finalgreyback.frame.origin.y + 70
        iconUber.frame.origin.y = finalgreyback.frame.origin.y + 150
        iconUber.alpha = 1
        iconUber.layer.cornerRadius = 10
        iconLyft.frame.origin.y = finalgreyback.frame.origin.y + 70
        iconLyft.alpha = 1
        iconLyft.layer.cornerRadius = 10
        
        smallPan.layer.cornerRadius = 10
//        if #available(iOS 11.0, *) {
//            smallPan.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        } else {
//            // Fallback on earlier versions
//        }
        
        UIView.animate(withDuration: 0.3, animations:  {
            self.Origin.alpha = 0
            self.Destination.alpha = 0
            self.Search.alpha = 0
            self.originbar.alpha = 0
            self.destinationbar.alpha = 0
            self.cL.alpha = 0
            self.cL2.alpha = 0
        }){(true) in
            self.secondimage.alpha = 1
            UIView.animate(withDuration: 0.7, animations: ( {
                self.secondimage.transform = CGAffineTransform(translationX: 0, y:  0 )
            }))
            UIView.animate(withDuration: 0.6, animations: ( {
                self.secondgreyback.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height + self.secondgreyback.frame.size.height)
            }))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.tim.text = self.time
            self.tim.sizeToFit()
            
            let dista = "\(self.distance) mi"
            self.dist.text = dista
            self.dist.sizeToFit()
            print(self.jsonError)
            
            if self.sameTxtError == true {
                self.alertError(title: "Error", message: "Both entries cannot be the same")
                self.sameTxtError = false
            }
            else {
                if self.jsonError == false {
                    self.smallLogo.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
                    self.smallLogo.alpha = 1
                    
                    //self.bgdropdismiss.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
                    self.bgdropdismiss.alpha = 0.5
                    
                    self.tim.alpha = 1
                    self.tim.frame = CGRect(x: self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: 36, width: self.tim.frame.size.width, height: 21)
                    self.tim.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
                    
                    self.dist.alpha = 1
                    self.dist.frame = CGRect(x: self.bgdropdismiss.center.x + 15, y: 36, width: self.dist.frame.size.width, height: 21)
                    self.dist.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
                    
                    
                    self.priceLBL.frame.origin.y = self.finalgreyback.frame.origin.y + 70
                    self.priceLBL.alpha = 1

                UIView.animate(withDuration: 0.5, animations: {
                    self.finalgreyback.frame.origin.y = 64
                    self.bgdropdismiss.frame.origin.y = self.finalgreyback.frame.origin.y + 10
                    self.tim.frame.origin.y = self.finalgreyback.frame.origin.y + 36
                    self.dist.frame.origin.y = self.finalgreyback.frame.origin.y + 36
                    self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
                    self.smallPan.frame.origin.y = 64
                    self.smallPan.frame.size.height = self.tim.frame.size.height + 50
                    self.priceLBL.frame.origin.y = self.finalgreyback.frame.origin.y + 100

//                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
//                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150
//
                }){(true) in
                    self.smallPan.alpha = 1
                    self.priceLBL.text = String(self.price)
                    self.priceLBL.alpha = 1
                }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        UIView.animate(withDuration: 0.4, animations: {
                            self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                            self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                        })
                    })
                }
                else {
                    self.alertError(title: "Error", message: "Location not found")
                }
            }
        })
        
    }
    
    //Begin Handle Errors
    
    func jsonFailAnimate() {
        UIView.animate(withDuration: 0.7, animations: {
            self.Origin.transform = CGAffineTransform(translationX: 0, y: -350)
            self.originbar.transform = CGAffineTransform(translationX: 0, y: -350)
            self.Destination.transform = CGAffineTransform(translationX: 0, y: -350)
            self.destinationbar.transform = CGAffineTransform(translationX: 0, y: -350)
            self.greyback.transform = CGAffineTransform(translationX: 0, y: -350)
            self.secondimage.transform = CGAffineTransform(translationX: 0, y: -350)
            self.Search.transform = CGAffineTransform(translationX: 0, y: -350)
        }){ (true) in
            self.secondimage.alpha = 0
            self.greyback.alpha = 0
            self.secondgreyback.alpha = 1
            UIView.animate(withDuration: 0.2, animations: {
                self.secondgreyback.transform = CGAffineTransform(scaleX: 1.152, y: 1)
                self.cL.alpha = 1
                self.cL2.alpha = 1
            }){ (true) in
                self.Origin.alpha = 1
                self.originbar.alpha = 1
                self.Destination.alpha = 1
                self.destinationbar.alpha = 1
                self.Search.alpha = 1
            }
        }
    }
    
    func shakeAnimate() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: Origin.center.x - 10, y: Origin.center.y ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: Origin.center.x + 10, y: Origin.center.y))
        
        Origin.layer.add(animation, forKey: "position")
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: Destination.center.x - 10, y: Destination.center.y ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: Destination.center.x + 10, y: Destination.center.y))
        
        Destination.layer.add(animation, forKey: "position")
    }
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
        jsonFailAnimate()
        
    }
    
    //End Handle Errors
    
    @objc func finalgbup(){
        bgdropdismiss.alpha = 0.5
        UIView.animate(withDuration: 0.5, animations: {
            self.finalgreyback.frame.origin.y = 64
            self.bgdropdismiss.frame.origin.y = self.finalgreyback.frame.origin.y + 10
            self.tim.frame.origin.y = self.finalgreyback.frame.origin.y + 36
            self.dist.frame.origin.y = self.finalgreyback.frame.origin.y + 36
            self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
            self.smallPan.frame.origin.y = 64
            self.priceLBL.frame.origin.y = self.finalgreyback.frame.origin.y + 100
            self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)
//            self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
//            self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.4, animations: {
                self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150
            })
        })
       
    }


    @objc func finalgbdown() {
        bgdropdismiss.alpha = 0.501
        secondimage.transform = CGAffineTransform(translationX: 0, y: -165)
        greyback.alpha = 1
        Origin.alpha = 1
        Destination.alpha = 1
        originbar.alpha = 1
        destinationbar.alpha = 1
        Search.alpha = 0
        greyback.transform = CGAffineTransform(translationX: 0, y: 0)
        Origin.transform = CGAffineTransform(translationX: 0, y: 0)
        originbar.transform = CGAffineTransform(translationX: 0, y: 0)
        Destination.transform = CGAffineTransform(translationX: 0, y: 0)
        destinationbar.transform = CGAffineTransform(translationX: 0, y: 0)
        Search.transform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            self.finalgreyback.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 64 )
            self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: self.view.frame.height - 54)
            self.tim.frame.origin = CGPoint(x:self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: self.view.frame.size.height)
            self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: self.view.frame.size.height)
            self.smallLogo.frame.origin.y = (2 * self.view.frame.height) - self.smallLogo.frame.size.height
            
            self.smallPan.frame.origin.y = self.view.frame.height - 64
            
            self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)
            
            self.priceLBL.frame.origin.y = self.view.frame.height + 100
            
            self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
            self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

        })
    }

    var finalgbOrigin: CGPoint!
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            
            
            
            smallPan.center = CGPoint(x: fileView.center.x, y: fileView.center.y + translation.y)
            
//            let realView = view.frame.origin.y + 64
//            let realgbView = finalgreyback.frame.origin.y + 64
//            let percent = realgbView / realView
//            print(percent/10)
//            let thisMuch = CGFloat.pi * (percent/10)
//            print("\(thisMuch) %")
//            sender.setTranslation(CGPoint.zero, in: view)

//            let percent1 = 1 / percent
//
//            tim.alpha = 1 * percent1
//            bgdropdismiss.alpha = 1 * percent1
//            dist.alpha = 1 * percent1
            
            secondimage.transform = CGAffineTransform(translationX: 0, y: -165)
            greyback.alpha = 1
            Origin.alpha = 1
            Destination.alpha = 1
            originbar.alpha = 1
            destinationbar.alpha = 1
            Search.alpha = 0
            greyback.transform = CGAffineTransform(translationX: 0, y: 0)
            Origin.transform = CGAffineTransform(translationX: 0, y: 0)
            originbar.transform = CGAffineTransform(translationX: 0, y: 0)
            Destination.transform = CGAffineTransform(translationX: 0, y: 0)
            destinationbar.transform = CGAffineTransform(translationX: 0, y: 0)
            Search.transform = CGAffineTransform(translationX: 0, y: 0)

            sender.setTranslation(CGPoint.zero, in: view)
            
            bgdropdismiss.frame.origin.y = smallPan.frame.origin.y + 10
            tim.frame.origin.y = smallPan.frame.origin.y + 36
            dist.frame.origin.y = smallPan.frame.origin.y + 36
            finalgreyback.frame.origin.y = smallPan.frame.origin.y
            priceLBL.frame.origin.y = smallPan.frame.origin.y + 100
            iconUber.frame.origin.y = finalgreyback.frame.origin.y + 150
            iconLyft.frame.origin.y = finalgreyback.frame.origin.y + 150

//            smallLogo.frame.origin.y = smallLogo.frame.origin.y + translation.y
            
//            if finalgreyback.frame.origin.y < 55 {
////                self.finalgreyback.frame.origin = CGPoint(x: 0 , y: 64)
////                self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: 74)
////                self.tim.frame.origin = CGPoint(x: self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: 100)
////                self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: 100)
////                self.smallPan.frame.origin = CGPoint(x: 0 , y: 64)
////                self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
//
//                //self.finalgreyback.frame.origin.y = self.view.frame.origin.y
//                self.bgdropdismiss.frame.origin.y = 10
//                self.tim.frame.orizgin.y = 36
//                self.dist.frame.origin.y = 36
//                self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
//                self.smallPan.frame.origin.y = self.view.frame.origin.y
////                self.smallPan.frame.size.height = self.tim.frame.size.height + 50
//
//            }
            print(finalgreyback.frame.origin.y)
//            if finalgreyback.frame.origin.y > view.frame.size.height - 55 {
//                self.finalgreyback.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 64 )
//                self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: self.view.bounds.height - 64)
//                self.tim.frame.origin = CGPoint(x:self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: self.view.frame.size.height)
//                self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: self.view.frame.size.height)
//                self.smallPan.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 64 )
//                self.smallLogo.frame.origin.y = (2 * self.view.frame.height) - self.smallLogo.frame.size.height
//
//                self.bgdropdismiss.alpha = 0
//                self.tim.alpha = 0
//                self.dist.alpha = 0
//            }
            if finalgreyback.frame.origin.y < 55 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.finalgreyback.frame.origin = CGPoint(x: 0 , y: 64)
                    self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: 74)
                    self.tim.frame.origin = CGPoint(x: self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: 100)
                    self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: 100)
                    self.smallPan.frame.origin = CGPoint(x: 0 , y: 64)
                    self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
                    self.priceLBL.frame.origin.y = self.finalgreyback.frame.origin.y + 100
                    
                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                    
                    self.tim.alpha = 1
                    self.bgdropdismiss.alpha = 0.5
                    self.dist.alpha = 1
                })
            }
            
        case .ended:
            
            
            let velocity = sender.velocity(in: view).y
            
            if velocity > 1400 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.finalgreyback.frame.origin = CGPoint(x: 0, y: self.view.frame.height )
                    self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: self.view.bounds.height - 64)
                    self.tim.frame.origin = CGPoint(x:self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: self.view.frame.size.height)
                    self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: self.view.frame.size.height)
                    self.smallPan.frame.origin.y = self.finalgreyback.frame.origin.y
                    self.smallLogo.frame.origin.y = (2 * self.view.frame.height) - self.smallLogo.frame.size.height
                    
                   // self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                    
                    self.tim.alpha = 1
                    self.bgdropdismiss.alpha = 0.501
                    self.dist.alpha = 1
                })
                if rotated1 == false {
                    self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)
                    
                    rotated1 = true
                    rotated2 = false
                }
            }
            
            else if velocity < -1400 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.finalgreyback.frame.origin = CGPoint(x: 0 , y: 64)
                    self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: 74)
                    self.tim.frame.origin = CGPoint(x: self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: 100)
                    self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: 100)
                    self.smallPan.frame.origin = CGPoint(x: 0 , y: 64)
                    self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
                    
//                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
//                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                    
                    self.tim.alpha = 1
                    self.bgdropdismiss.alpha = 0.5
                    self.dist.alpha = 1
                })
                UIView.animate(withDuration: 0.25, animations: {
                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                })
                if rotated2 == false {
                    self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)
                    
                    rotated2 = true
                    rotated1 = false
                }
            }
            
            
            
            if finalgreyback.frame.origin.y < view.center.y {
                UIView.animate(withDuration: 0.2, animations: {
                    self.finalgreyback.frame.origin = CGPoint(x: 0 , y: 64)
                    self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: 74)
                    self.tim.frame.origin = CGPoint(x: self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: 100)
                    self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: 100)
                    self.smallPan.frame.origin = CGPoint(x: 0 , y: 64)
                    self.smallLogo.frame.origin.y = self.view.frame.height - self.smallLogo.frame.size.height
                    self.priceLBL.frame.origin.y = self.finalgreyback.frame.origin.y + 100
                    
//                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                    
                    self.tim.alpha = 1
                    self.bgdropdismiss.alpha = 0.5
                    self.dist.alpha = 1
                })
                UIView.animate(withDuration: 0.25, animations: {
                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                })
                if rotated2 == false {
                    self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)

                    rotated2 = true
                    rotated1 = false
                }
            }
            else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.finalgreyback.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 64 )
                    self.bgdropdismiss.frame.origin = CGPoint(x: self.view.frame.size.width/2 - 17.5, y: self.finalgreyback.frame.origin.y)
                    self.tim.frame.origin = CGPoint(x:self.bgdropdismiss.center.x - self.tim.frame.size.width - 15, y: self.view.frame.size.height)
                    self.dist.frame.origin = CGPoint(x: self.bgdropdismiss.center.x + 15, y: self.view.frame.size.height)
                    self.smallPan.frame.origin.y = self.view.frame.height - 64
                    self.smallLogo.frame.origin.y = (2 * self.view.frame.height) - self.smallLogo.frame.size.height
                    self.priceLBL.frame.origin.y = self.view.frame.height + 100
                    
//                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
//                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150

                    
                    self.tim.alpha = 1
                    self.bgdropdismiss.alpha = 0.501
                    self.dist.alpha = 1
                })
                UIView.animate(withDuration: 0.2, animations: {
                    self.iconUber.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                    self.iconLyft.frame.origin.y = self.finalgreyback.frame.origin.y + 150
                })
                if rotated1 == false {
                    self.bgdropdismiss.transform = self.bgdropdismiss.transform.rotated(by: .pi)
                    
                    rotated1 = true
                    rotated2 = false
                }
            }

        default:
            break
        }
        
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        bgdropdismiss.alpha = 0
//        }
    
    

    @IBAction func bgdropdismiss(_ sender: Any) {
        if bgdropdismiss.alpha == 0.5 {
            finalgbdown()
            rotated1 = true
            rotated2 = false
        }
        else {
            finalgbup()
            rotated1 = false
            rotated2 = true
        }
    }
    
    
    @objc func tableViewTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in:self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                let tappedCell = self.tableView.cellForRow(at: tapIndexPath)?.textLabel?.text
                if originIsOpen == true{
                    self.Origin.text = tappedCell
                    tableView.alpha = 0
                    GoogleLogo.alpha = 0
                }else if destinationIsOpen == true{
                    self.Destination.text = tappedCell
                    tableView.alpha = 0
                    GoogleLogo.alpha = 0
                }
                print(tappedCell)

            }
        }
    }
    
    @objc func uberPressed() {
        uberTapped = true
        lyftTapped = false
        UIView.animate(withDuration: 0.2, animations: {
            self.iconUber.transform = CGAffineTransform(scaleX: 2.5, y: 2.9).concatenating(CGAffineTransform(translationX: self.view.center.x / 2, y: 40))
            self.blackMask.alpha = 0.5
        })
    }
    
    @objc func lyftPressed() {
        lyftTapped = true
        uberTapped = false
        UIView.animate(withDuration: 0.2, animations: {
            self.iconLyft.transform = CGAffineTransform(scaleX: 2.5, y: 2.9).concatenating(CGAffineTransform(translationX: -self.view.center.x / 2, y: 40))
            self.blackMask.alpha = 0.5
            })
    }
    
    @objc func finalgbPressed() {
        if uberTapped == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.iconUber.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.blackMask.alpha = 0
            })
        }
        else if lyftTapped == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.iconLyft.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.blackMask.alpha = 0
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (Origin.text != nil) && Destination.text != ""{
            Origin.resignFirstResponder()
            Destination.resignFirstResponder()
            //Search((Any).self)
            Search(self)
            tableView.alpha = 0
            GoogleLogo.alpha = 0
        }
        return true
    }
    struct AppUtility {
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            
            self.lockOrientation(orientation)
            
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
        
    }

    override func viewDidLoad() {

        AppUtility.lockOrientation(.portrait)
        
        super.viewDidLoad()
        originIsOpen = false
        destinationIsOpen = false
        tableView.frame.size.width = Origin.frame.size.width
        tableView.frame.size.height = 35
        tableView.alpha = 0
        GoogleLogo.frame.size.width = Origin.frame.size.width
        GoogleLogo.alpha = 0
        GoogleLogo.layer.cornerRadius = 7
        
        Origin.attributedPlaceholder = NSAttributedString(string: "Origin", attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        Destination.attributedPlaceholder = NSAttributedString(string: "Destination", attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])

        
        Origin.delegate = self
        Origin.returnKeyType = UIReturnKeyType.search
        Destination.delegate = self
        Destination.returnKeyType = UIReturnKeyType.search
        
        let tapUber: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.uberPressed))
        iconUber.addGestureRecognizer(tapUber)
        
        let tapLyft: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.lyftPressed))
        iconLyft.addGestureRecognizer(tapLyft)
        
        let tapFinalgb: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.finalgbPressed))
        blackMask.addGestureRecognizer(tapFinalgb)
        
        let tapTableCell: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tableViewTap))
        tableView.addGestureRecognizer(tapTableCell)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        backgrnd.addGestureRecognizer(tap)
        
        //addPanGesture(view: finalgreyback)
        addPanGesture(view: smallPan)
            
        finalgbOrigin = finalgreyback.frame.origin
        //smallPan.frame.origin = finalgreyback.frame.origin
        //smallPan.frame.origin = view.frame.origin
        smallPan.alpha = 0
        smallPan.frame.size.width = finalgreyback.frame.size.width
        
//        iconUber.frame.origin.y = finalgreyback.frame.origin.y + 150
        iconUber.center.x = view.frame.size.width / 4
        iconUber.alpha = 0
        
        iconLyft.center.x = 3 * view.frame.size.width / 4
        iconLyft.alpha = 0
        
        tim.frame.origin.y = finalgreyback.frame.origin.y + 36
        dist.frame.origin.y = finalgreyback.frame.origin.y + 36
        bgdropdismiss.frame.origin.y = finalgreyback.frame.origin.y + 10
        priceLBL.frame.origin.y = finalgreyback.frame.origin.y + 70
        
        
        setupAddTargetIsNotEmptyTextFields()
        Origin.alpha = 1
        Destination.alpha = 1
        greyback.alpha = 1
        originbar.alpha = 1
        destinationbar.alpha = 1
        Search.alpha = 0.3
        secondimage.alpha = 1
        secondgreyback.alpha = 0
        greyback.layer.cornerRadius = 7
        secondgreyback.layer.cornerRadius = 7
        Search.layer.cornerRadius = 7
        cL.alpha = 0
        cL2.alpha = 0
        bgdropdismiss.alpha = 0
        tim.alpha = 0
        dist.alpha = 0
        GoogleLogo.alpha = 0
        finalgreyback.alpha = 0
        smallLogo.alpha = 0
        priceLBL.alpha = 0
        secondimage.transform = CGAffineTransform(translationX: 0, y:-165 )
    }
    
    func bgdropclose() {
        //smallPan.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height + view.frame.size.height)
        finalgreyback.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height + view.frame.size.height)
        smallPan.frame.origin = finalgreyback.frame.origin
        //smallPan.frame.origin.y = view.frame.height
        bgdropdismiss.frame = CGRect(x: view.frame.size.width/2 - 17.5, y: 74, width: 35, height: 22)
        bgdropdismiss.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height + view.frame.size.height)
        secondgreyback.transform = CGAffineTransform(translationX: 0, y: 0)
        smallPan.alpha = 0
        secondgreyback.alpha = 0
        tim.transform = CGAffineTransform(translationX: 0, y: 0)
        tim.alpha = 0
        dist.transform = CGAffineTransform(translationX: 0, y: 0)
        dist.alpha = 0
        bgdropdismiss.alpha = 0
        finalgreyback.alpha = 0

        rotated1 = false
        rotated2 = true
    }
  
    @IBAction func opentxtori(_ sender: Any) {
        arrayA.removeAll()
        tableView.reloadData()
        originIsOpen = true
        destinationIsOpen = false
        tableView.frame.origin.x = Origin.frame.origin.x
        GoogleLogo.frame.origin.x = Origin.frame.origin.x
        tableView.frame.origin.y = Origin.frame.maxY
        GoogleLogo.frame.origin.y = Origin.frame.maxY
        if secondimage.alpha == 0 {
            return
        }
        else {
            UIView.animate(withDuration: 0.7, animations: {
                self.Origin.transform = CGAffineTransform(translationX: 0, y: -350)
                self.originbar.transform = CGAffineTransform(translationX: 0, y: -350)
                self.Destination.transform = CGAffineTransform(translationX: 0, y: -350)
                self.destinationbar.transform = CGAffineTransform(translationX: 0, y: -350)
                self.greyback.transform = CGAffineTransform(translationX: 0, y: -350)
                self.secondimage.transform = CGAffineTransform(translationX: 0, y: -350)
                self.Search.transform = CGAffineTransform(translationX: 0, y: -350)
            }){ (true) in
                self.secondimage.alpha = 0
                self.greyback.alpha = 0
                self.secondgreyback.alpha = 1
                UIView.animate(withDuration: 0.2, animations: {
                    self.secondgreyback.transform = CGAffineTransform(scaleX: 1.152, y: 1)
                    self.cL.alpha = 1
                    self.cL2.alpha = 1
                })
            }
        }
        if Origin.text != "" {
            bgdropclose()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                self.Search.alpha = 1
            })
            
        }
    }

    @IBAction func opentxtdest(_ sender: Any) {
        arrayA.removeAll()
        tableView.reloadData()
        originIsOpen = false
        destinationIsOpen = true
        tableView.alpha = 0
        tableView.frame.origin.x = Destination.frame.origin.x
        GoogleLogo.frame.origin.x = Destination.frame.origin.x
        tableView.frame.origin.y = Destination.frame.maxY
        GoogleLogo.frame.origin.y = Destination.frame.maxY
        if secondimage.alpha == 0 {
            return
        }
        else {
            UIView.animate(withDuration: 0.7, animations: {
                self.Origin.transform = CGAffineTransform(translationX: 0, y: -350)
                self.originbar.transform = CGAffineTransform(translationX: 0, y: -350)
                self.Destination.transform = CGAffineTransform(translationX: 0, y: -350)
                self.destinationbar.transform = CGAffineTransform(translationX: 0, y: -350)
                self.greyback.transform = CGAffineTransform(translationX: 0, y: -350)
                self.secondimage.transform = CGAffineTransform(translationX: 0, y: -350)
                self.Search.transform = CGAffineTransform(translationX: 0, y: -350)
                self.secondimage.alpha = 0
            }){ (true) in
                self.greyback.alpha = 0
                self.secondgreyback.alpha = 1
                UIView.animate(withDuration: 0.2, animations: {
                    self.secondgreyback.transform = CGAffineTransform(scaleX: 1.152, y: 1)
                    self.cL.alpha = 1
                    self.cL2.alpha = 1

                })
            }
        }
        if Destination.text != "" {
            bgdropclose()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                self.Search.alpha = 1
            })
        }
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        Search.alpha = 0.3
        Origin.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        Destination.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        guard
            let name = Origin.text, !name.isEmpty,
            let email = Destination.text, !email.isEmpty
        
            else {
            self.Search.alpha = 0.3
            return
        }
        Search.alpha = 1
        
    }
    
    @IBAction func getCL(_ sender: Any) {
        //let userLocation = mapView.userLocation
        //let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 1000, 1000 )
        //mapView.setRegion(region, animated: true
        let longitude :CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
        let latitude :CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                
                print("failed")
                return
                
            }

            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as! CLPlacemark!
                
                //                var address = (pm!.subThoroughfare) + " " + (pm!.thoroughfare) + (pm!.locality) + "," + (pm!.administrativeArea) + " " + (pm!.postalCode) + " " + (pm!.isoCountryCode)
                let address = (pm!.thoroughfare)! + " " +  (pm!.locality)! + ", " + (pm!.administrativeArea)!
                print(address)
                self.Origin.text! = address
            }
            else{
                print("error")
            }

            
            
        })
    }
    
    @IBAction func getCL2(_ sender: Any) {
        let longitude :CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
        let latitude :CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                
                print("failed")
                return
                
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as! CLPlacemark!
                //                var address = (pm!.subThoroughfare) + " " + (pm!.thoroughfare) + (pm!.locality) + "," + (pm!.administrativeArea) + " " + (pm!.postalCode) + " " + (pm!.isoCountryCode)
                let address = (pm!.thoroughfare)! + " " +  (pm!.locality)! + ", " + (pm!.administrativeArea)!
                print(address)
                self.Destination.text! = address
            }
            else{
                print("error")
            }
            
            
            })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        tableView.alpha = 0
        GoogleLogo.alpha = 0
        
    }
    
    func placeAutocomplete() {
        tableView.alpha = 1
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        if originIsOpen == true {
            tableView.frame.origin.y = Origin.frame.maxY
//            GoogleLogo.frame.origin.y = tableView.frame.maxY
            if Origin.text == "" {
                self.tableView.alpha = 0
                self.GoogleLogo.alpha = 0
            }
            else {
                GMSPlacesClient.shared().autocompleteQuery(Origin.text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
                    if let error = error {
                        print("Autocomplete error \(error)")
                        return
                        
                    }
                    self.arrayA.removeAll()
                    for result in results! {
                        if let result = result as? GMSAutocompletePrediction {
                            
                            self.arrayA.append(result.attributedFullText.string)
                        }
                    }
                    self.tableView.reloadData()
                    
                })
                
            }
        }else if destinationIsOpen == true {
            tableView.frame.origin.y = Destination.frame.maxY
//            GoogleLogo.frame.origin.y = tableView.frame.maxY

            if Destination.text == "" {
                self.tableView.alpha = 0
                self.GoogleLogo.alpha = 0
            }
            else {
                GMSPlacesClient.shared().autocompleteQuery(Destination.text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
                    if let error = error {
                        print("Autocomplete error \(error)")
                        return
                        
                    }
                    self.arrayA.removeAll()
                    for result in results! {
                        if let result = result as? GMSAutocompletePrediction {
                            
                            self.arrayA.append(result.attributedFullText.string)
                        }
                    }
                    self.tableView.reloadData()

                })
                
            }
        }
        
    }
    
    @IBAction func originTxtChange(_ sender: Any) {
        placeAutocomplete()
    }
    
    @IBAction func destinationTxtChange(_ sender: Any) {
        placeAutocomplete()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //GoogleLogo.frame.origin.y = tableView.frame.maxY - 5
            if arrayA.count == 0 {
                self.tableView.alpha = 1
                self.GoogleLogo.alpha = 0
                self.tableView.frame.size.height = 35 * CGFloat(0)
                
            }
            else if arrayA.count == 1 {
                self.tableView.alpha = 1
                self.GoogleLogo.alpha = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.tableView.frame.size.height = 35 * CGFloat(1)
                    self.GoogleLogo.frame.origin.y = self.tableView.frame.maxY - 5

                })
            }
            else if arrayA.count == 2 {
                self.tableView.alpha = 1
                self.GoogleLogo.alpha = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.tableView.frame.size.height = 35 * CGFloat(2)
                    self.GoogleLogo.frame.origin.y = self.tableView.frame.maxY - 5

                })
            }
            else if arrayA.count > 3 {
                self.tableView.alpha = 1
                self.GoogleLogo.alpha = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.tableView.frame.size.height = 35 * CGFloat(3)
                    self.GoogleLogo.frame.origin.y = self.tableView.frame.maxY - 5

                })
            }
            return(arrayA.count)

        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            cell?.textLabel?.text = arrayA[indexPath.row]
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return(cell)!
        }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var path = 0
        path = indexPath.row
        print(path)
    }
}



