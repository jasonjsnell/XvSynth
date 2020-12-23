//
//  XvEnveloperAR.swift
//  XvSynth
//
//  Created by Jason Snell on 9/30/20.
//

import Foundation
import XvDataMapping

//envelope with attack and release
// init with maximum values (for example, AR maximums could be 1.0, or 128, or 255 depending on the system

public class XvEnvelopeAR {
    
    let resistor:XvClosedResistor
    
    
    public init(maxValue:Double){
        
        resistor = XvClosedResistor(tolerance: maxValue, resistance: 0.0)
    }
    
    public var attack:Double {
        get { resistor.upwardsResistance }
        set { resistor.upwardsResistance = newValue }
    }
    
    public var release:Double {
        get { resistor.downwardsResistance }
        set { resistor.downwardsResistance = newValue }
    }
    
    public func applyEnvelope(toSignal:Double) -> Double {
        
        return resistor.applyResistance(toCurrent: toSignal)
    }
    
}
