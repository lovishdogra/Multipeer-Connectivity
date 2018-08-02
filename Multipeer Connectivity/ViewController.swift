//
//  ViewController.swift
//  Multipeer Connectivity
//
//  Created by Lovish Dogra on 2018-06-18.
//  Copyright © 2018 Lovish Dogra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorService = ColorServiceManager()
    
    //MARK: IBActions and IBOutlets
    @IBOutlet weak var connection: UILabel!
    
    @IBAction func btnRed(_ sender: Any) {
        self.change(color: .red)
        colorService.send(colorName: "red")
    }
    
    @IBAction func btnYellow(_ sender: Any) {
        self.change(color: .yellow)
        colorService.send(colorName: "yellow")
    }
    
    //MARK: Custom methods
    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
    //MARK: View load methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self as? ColorServiceManagerDelegate
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: Extension colorServiceManagerDelegate

extension ViewController : ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connection.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

}










































