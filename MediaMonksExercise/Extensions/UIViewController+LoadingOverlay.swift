//
//  UIViewController+LoadingOverlay.swift
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

import Foundation
import UIKit

extension UIViewController { // + LoadingOverlay
    
    func showLoadingOverlayOnlyInView(){
        LoadingOverlay.shared.show(over: self.view)
    }
    
    func showLoadingOverlay(){
        showLoadingOverlayOnlyInView()
    }
    
    func showLoadingOverlay(coveringNavigationBar overNavigation: Bool){
        if overNavigation {
            if let navigationController = self.navigationController{
                LoadingOverlay.shared.show(over: navigationController.view)
            }else{
                showLoadingOverlayOnlyInView()
            }
        }else{
            showLoadingOverlayOnlyInView()
        }
    }
    
    func showLoadingOverlay(withTimeout timeout: Int){
        showLoadingOverlay()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeout), execute: {
            self.hideLoadingOverlay()
        })
    }
    
    func showLoadingOverlay(withTimeout timeout: Int, coveringNavigationBar overNavigation: Bool){
        showLoadingOverlay(coveringNavigationBar: overNavigation)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeout), execute: {
            self.hideLoadingOverlay()
        })
    }
    
    func toggleLoadingOverlay(_ enabled: Bool){
        if enabled{
            showLoadingOverlay()
        }else{
            hideLoadingOverlay()
        }
    }
    
    func toggleLoadingOverlay(_ enabled: Bool, coveringNavigationBar overNavigation: Bool){
        if enabled{
            if overNavigation {
                showLoadingOverlay(coveringNavigationBar: overNavigation)
            }else{
                showLoadingOverlay()
            }
            
        }else{
            hideLoadingOverlay()
        }
    }
    
    func hideLoadingOverlay(){
        LoadingOverlay.shared.hideOverlayView()
    }
}
