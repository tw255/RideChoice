//
//  firstViewController.swift
//  newnewnew
//
//  Created by Shitcunt on 5/23/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {

    
    @IBOutlet weak var Search: UIButton!
    @IBOutlet weak var originbar: UIImageView!
    @IBOutlet weak var destinatonbar: UIImageView!
    @IBOutlet weak var greyback: UIImageView!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var Origin: UITextField!
    @IBOutlet weak var firstimage: UIImageView!
    //@IBOutlet weak var locabutton: UIButton!

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
        //locabutton.alpha = 0 
        Origin.alpha = 0
        Destination.alpha = 0
        originbar.alpha = 0
        destinatonbar.alpha = 0
        Search.alpha = 0
        greyback.alpha = 0
        greyback.layer.cornerRadius = 7
//        DispatchQueue.main.asyncAfter(deadline:.now() + 4, execute: {
//            self.performSegue(withIdentifier:"1stseg",sender: self)
//        })
        
        
        
        
//        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
//        UIView.animate(withDuration: 1.0, animations:  {
//            self.firstimage.transform = CGAffineTransform(translationX: 0, y:-161 )
//        }){ (true) in
//            self.performSegue(withIdentifier:"1stseg",sender: self)
//
//            }
//        })
        
        
        
//        DispatchQueue.main.asyncAfter(deadline:.now() + 2.7, execute: {
//        UIView.animate(withDuration: 1, animations: ( {
//            self.greyback.alpha = 1
//        }))
//        })
//        DispatchQueue.main.asyncAfter(deadline:.now() + 3.3, execute: {
//            UIView.animate(withDuration: 0.3, animations: ( {
////                self.Origin.alpha = 1
////                self.Destination.alpha = 1
////                self.Search.alpha = 0.3
////                self.originbar.alpha = 1
////                self.destinatonbar.alpha = 1
//            }))
//        })
        firstimage.alpha = 0
        animateImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
            UIView.animate(withDuration: 1.0, animations:  {
                self.firstimage.transform = CGAffineTransform(translationX: 0, y:-161 )
            }){ (true) in
//                self.performSegue(withIdentifier:"1stseg",sender: self)
                DispatchQueue.main.async() {
                    [unowned self] in
                    self.performSegue(withIdentifier: "1stseg", sender: self)
                }
            }
        })
    }
    func animateImage() {
        UIView.animate(withDuration: 1.0, animations: {
            self.firstimage.alpha = 1.0
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

   

}
