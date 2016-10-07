//
//  UIButton+BGColorForState.swift
//
//  Created by Tarun Tyagi on 07/10/16.
//  Copyright © 2016 Cacao Solutions. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

extension UIButton {
    
    private enum StateKey : String {
        case normal       = "cc_StateNormal"
        case highlighted  = "cc_StateHighlighted"
        case disabled     = "cc_StateDisabled"
        case selected     = "cc_StateSelected"
        case application  = "cc_StateApplication"
        case reserved     = "cc_StateReserved"
    }
    
    
    // MARK:- Convenience
    // Need to assign different backgroundColor(s) state-wise to a UIButton ?
    // Just associate the color to the UIButton for a specific state and later use when needed
    open func backgroundColor(for state:UIControlState) -> UIColor? {
        
        var key: StateKey = self.stateKey(for: state)
        
        return objc_getAssociatedObject(self, &key) as? UIColor
    }
    
    open func setBackgroundColor(_ color: UIColor?, for state:UIControlState) {
        
        var key: StateKey = self.stateKey(for: state)
        
        objc_setAssociatedObject(self, &key, nil,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        objc_setAssociatedObject(self, &key, color,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    // MARK:- UIResponder Hooks
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with:event)
        self.observeState()
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with:event)
        self.observeState()
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with:event)
        self.observeState()
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with:event)
        self.observeState()
    }
    
    
    // MARK:- State Tracking
    private func observeState() {
        self.backgroundColor = self.backgroundColor(forState:self.state)
    }
    
    
    // MARK:- Utility
    private func stateKey(for controlState:UIControlState) -> StateKey {
        
        if(state.rawValue == UIControlState.normal.rawValue) {
            return StateKey.normal
        }
        
        else if(state.rawValue == UIControlState.highlighted.rawValue) {
            return StateKey.highlighted
        }
        
        else if(state.rawValue ==  UIControlState.disabled.rawValue) {
            return StateKey.disabled
        }
        
        else if(state.rawValue ==  UIControlState.selected.rawValue) {
            return StateKey.selected
        }
        
        else if(state.rawValue ==  UIControlState.application.rawValue) {
            return StateKey.application
        }
        
        else if(state.rawValue ==  UIControlState.reserved.rawValue) {
            return StateKey.reserved
        }
        
        else {
            return StateKey.normal
        }
    }
    
}
