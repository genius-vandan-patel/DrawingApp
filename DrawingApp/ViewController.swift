//
//  ViewController.swift
//  DrawingApp
//
//  Created by Vandan Patel on 12/3/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapClear(_ sender: UIButton) {
        canvasView.clearCanvas()
    }
}

