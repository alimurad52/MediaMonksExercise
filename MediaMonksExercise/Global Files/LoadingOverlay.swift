//
//  LoadingOverlay.swift
//  Swift3-VCs-Loading-Overlay
//  https://gist.github.com/gsobrevilla/9e863b2c164c15ab304de0cc6f94d8e3
//
//  By Gastón Sobrevilla
//  Vortex Software (Tucumán, Argentina)
//  http://www.vortexsoftware.com.ar
//
//  Copyright (c) 2017 Vortex Software (http://www.vortexsoftware.com.ar)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Foundation

public class LoadingOverlay {
    
    // Configuración
    static var overlayBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static var activityIndicatorStyle = UIActivityIndicatorViewStyle.whiteLarge
    
    // Variables
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    // Singleton
    // ----------------------------------------------------------------------------------
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    // Métodos para mostrar y ocultar
    // ----------------------------------------------------------------------------------
    public func show(over view: UIView!){
        hide()
        
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = LoadingOverlay.overlayBackgroundColor
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: LoadingOverlay.activityIndicatorStyle)
        activityIndicator.center = overlayView.center
        
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hide(){
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    // Deprecados
    // ----------------------------------------------------------------------------------
    public func showOverlay(view: UIView!) { // Deprecated
        show(over: view)
    }
    
    public func hideOverlayView() { // Deprecated
        hide()
    }
}
