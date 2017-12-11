//
//  ImageViewVC.swift
//  DrawingApp
//
//  Created by Vandan Patel on 12/8/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class ImageViewVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pdfScrollView: UIScrollView!
    @IBOutlet weak var canvasImageView: CanvasImageView!
    let url = Bundle.main.url(forResource: "pdf-sample", withExtension: "pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasImageView.image = drawPDFfromURL(url: url!)
        pdfScrollView.minimumZoomScale = 1.0
        pdfScrollView.maximumZoomScale = 5.0
        setupScrollingForPDF()
    }
    
    func setupScrollingForPDF() {
        pdfScrollView.delegate = self
        pdfScrollView.alwaysBounceVertical = false
        pdfScrollView.alwaysBounceHorizontal = false
        pdfScrollView.showsVerticalScrollIndicator = true
        pdfScrollView.flashScrollIndicators()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.canvasImageView
    }
    
    @IBAction func didTapClear(_ sender: UIButton) {
        canvasImageView.clearCanvas()
    }
    
    @IBAction func didTapDraw(_ sender: UIButton) {
        canvasImageView.drawMode = !canvasImageView.drawMode
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if canvasImageView.drawMode {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }
    }
    
    @IBAction func didTapDone(_ sender: UIButton) {
        pdfScrollView.zoomScale =  1.0
    }
    
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            ctx.cgContext.drawPDFPage(page)
        }
        return img
    }
}

extension UIView {
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
